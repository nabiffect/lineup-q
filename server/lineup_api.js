module.exports = function(app, key) {
  
  const { Qtum } = require("qtumjs")
  const repoData = require("./contracts/solar.development.json")
  const Web3 = require('web3')
  const web3 = new Web3()
  const roomId = 1;

  const qtum = new Qtum("http://qtum:test@localhost:4889", repoData)

  const lineup = qtum.contract('Lineup.sol')
  
  function getHexAddres(address) {
    const bs58check = require('bs58check')
    const decoded = bs58check.decode(address)
    // console.log(decoded.toString('hex').slice(2))
    return decoded.toString('hex').slice(2);
  }

  app.post('/api/lineup/depositFunds', async (req, res) => {  
    const uname = req.body.uname;
    const amount = req.body.amount; // 100
    if(!uname || amount < 100) return;

    const hexName = web3.utils.fromAscii(uname)
    const tx = await lineup.send("depositFunds", [hexName, true], {
      amount
    })
    const result = await tx.confirm(1)
    console.log(result);
    res.json({
      'result': result
    })
  });

  app.post('/api/lineup/joinPanel', async (req, res) => {
  	const tx = await lineup.send("joinPanel")
  	const result = await tx.confirm(1)
    console.log(result);
  	res.json({
      'result': result
    })
  });


  app.post('/api/lineup/checkFundsReady', async (req, res) => {
  	const tx = await lineup.send("checkFundsReady")
  	const result = await tx.confirm(1)
  	console.log(result);
    res.json({
      'result': result
    })
  });

  app.post('/api/lineup/likeAtPartner', async(req, res) => {
  	const address = req.body.address
    if(!address) return;

    const hexaddr = getHexAddres(address)
  	const tx = await lineup.send("likeAtPartner", [hexaddr])
  	const result = await tx.confirm(1)
  	console.log(result)
    res.json({
      'result': result
    })
  });

  app.post('/api/lineup/betMatch', async(req, res) => {
    const address = req.body.address
    if(!address) return;

    const hexaddr = getHexAddres(address)
    const tx = await lineup.send("betMatch", [hexaddr, hexaddr])
    const result = await tx.confirm(1)
    console.log(result)
    res.json({
      'result':result
    })
  });

  app.post('/api/lineup/checkFinalList', async(req, res) => {
  	const tx = await lineup.send("checkFinalList")
  	const result = await tx.confirm(1)
  	console.log(result)
    res.json({
      'result':result
    })
  });

  app.post('/api/lineup/distribution', async(req, res) => {
  	const tx = await lineup.send("distribution")
  	const result = await tx.confirm(1)
  	console.log(result)
    res.json({
      'result':result
    })
  });

  app.post('/api/lineup/balanceOf', async (req, res) => {
    const address = req.body.address
    if(!address) return;

    const hexaddr = getHexAddres(address)

    const result = await lineup.call("getBalanceOfUser", [roomId, hexaddr])
    console.log("getBalance", result.outputs[0].toNumber())
    res.json({
      'balance':result.outputs[0].toNumber()
    })
  });

  app.post('/api/lineup/getinfo', async (req, res) => {

  	const address = req.body.address
    if(!address) return;

    const hexaddr = getHexAddres(address)

    let jobj = {}
    let result = await lineup.call("getAmountRaised", [roomId])
    jobj.amountRaised = result.outputs[0].toNumber()

    result = await lineup.call("getUserInfo", [hexaddr])
    jobj.getUserInfo = web3.utils.toAscii('0x'+result.outputs[0]) + "/" +result.outputs[1]
    
  	result = await lineup.call("getUsers", [roomId])
  	jobj.getUsers = result.outputs[0]

  	result = await lineup.call("getPanels", [roomId])
  	jobj.getPanels = result.outputs[0]

  	result = await lineup.call("getWinners", [roomId])
  	jobj.getWinners = result.outputs[0]

  	result = await lineup.call("getWinpanels", [roomId])
  	jobj.getWinpanels = result.outputs[0]
  	
    result = await lineup.call("getLikesForman", [roomId, hexaddr])
    jobj.getLikesForman = result.outputs[0]

  	result = await lineup.call("getLikesForwoman", [roomId, hexaddr])
    jobj.getLikesForwoman = result.outputs[0]

  	result = await lineup.call("getBet", [roomId, hexaddr])
    jobj.getBet = result.outputs[0] +"/"+result.outputs[1]

    res.json(jobj)
  });
  

  async function streamEvents() {
    console.log("Subscribed to contract events")    

    lineup.onLog((entry) => {
      console.log(entry)
    }, { minconf: 1 })
  }

  //event logs
  streamEvents()

  // depositFunds()
  // joinPanel()
  // checkFundsReady()
  // likeAtPartner()
  // betMatch()
  // checkFinalList()
  // distribution()
 
}