module.exports = function(app, key) {
		
	const { Qtum } = require("qtumjs")
	const repoData = require("./contracts/solar.development.json")

	const qtum = new Qtum("http://qtum:test@localhost:4889", repoData)	

	const leashToken = qtum.contract('LeashToken.sol')

	const decimals = 8
	function tokenAmount(bnumber) {
	  const nstr = bnumber.toString()
	  const amountUnit = nstr.substring(0, nstr.length - decimals)
	  const amountDecimals = nstr.substring(nstr.length - decimals)

	  return `${amountUnit === "" ? 0 : amountUnit}.${amountDecimals}`
	}

	function getHexAddres(address) {
	  const bs58check = require('bs58check')
	  const decoded = bs58check.decode(address)
	  // console.log(decoded.toString('hex').slice(2))
	  return decoded.toString('hex').slice(2);
	}

	app.get('/api/showInfo', async (req, res) => {
	  const totalSupply = await leashToken.return("totalSupply")
	  const saleAmount = await leashToken.return("saleAmount")
	  const tokensSold = await leashToken.return("tokensSold")

	  const tokenTotalSupply = (await leashToken.call("tokenTotalSupply")).outputs[0]

	  console.log("supply cap:", tokenAmount(tokenTotalSupply))
	  console.log("sales cap:", tokenAmount(saleAmount))
	  console.log("current token supply:", tokenAmount(totalSupply))
	  console.log("tokens sold:", tokenAmount(tokensSold))

	  res.json({
	  	"supplyCap": tokenAmount(tokenTotalSupply), 
	  	"salesCap": tokenAmount(saleAmount),
	  	"totalSupply": tokenAmount(totalSupply),
	  	"tokensSold": tokenAmount(tokensSold)
	  })
	});	

	app.post('/api/buytokens', async (req, res) => {
	  const beneficiary = req.body.beneficiary
	  const amount = 100

	  const hexaddress = getHexAddres(beneficiary)

	  const tx = await leashToken.send("buyTokens", [hexaddress], {
	  	amount,
	  })

	  const result = await tx.confirm(1)
	  res.json({
	  	'result': result
	  })
	});

	app.post('/api/balanceof', async (req, res) => {
	  const address = req.body.address
	  if(!address) return;

	  const hexaddress = getHexAddres(address)

	  const balance = await leashToken.return("balanceOf", [hexaddress])
	  res.json({
	  	"balance": tokenAmount(balance)
	  })
	});

	app.post('/api/mintReserved', async (req, res) => {
	  const amount = 100
	  const tx = await leashToken.send("mintReservedTokens", [amount])	
	  const result = await tx.confirm(1)	  
	  res.json({
	  	'result': result
	  })
	});

	app.post('/api/mintTokens', async (req, res) => {
	  const toAddress = req.body.toaddr
	  if(!toAddress) return;
	  const amount = 100
	  const tx = await leashToken.send("mint", [toAddress, amount])
	  console.log("mint tx:", tx.txid)

	  const result = await tx.confirm(1)	  
	  res.json({
	  	'result': result
	  })
	});	

	app.post('/api/transfer', async (req, res) => {
	  const fromAddress = req.body.fromaddr
	  const toAddress = req.body.toaddr
	  const amount = 100
	  if(!fromAddress || !toAddress) return;
	
	  const hexFromAddr = getHexAddres(fromAddress)
	  const hexToAddr = getHexAddres(toAddress)
	  const tx = await leashToken.send("transfer", [hexToAddr, amount],{
	  	senderAddress: hexFromAddr,
	  })

	  console.log("transfer tx:", tx.txid)
	  const result = await tx.confirm(1)	  
	  res.json({
	  	'result': result
	  })
	});


}