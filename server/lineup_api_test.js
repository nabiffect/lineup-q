module.exports = function(app, key) {
  
  const { Qtum } = require("qtumjs")
  const repoData = require("./contracts/solar.development.json")
  const Web3 = require('web3')
  const web3 = new Web3()

  const qtum = new Qtum("http://qtum:test@localhost:4889", repoData)

  const lineup = qtum.contract('Lineup.sol')
  
  async function depositFunds() {    
    const hexName = web3.utils.fromAscii("tester")
    const amount = 100
    const tx = await lineup.send("depositFunds", [hexName, true], {
      amount
    })
    const result = await tx.confirm(1)
    console.log(result);
  }

  async function joinPanel() {
  	const tx = await lineup.send("joinPanel")  	
  	const result = await tx.confirm(1)
  	console.log(result)
  }

  async function checkFundsReady() {
  	const tx = await lineup.send("checkFundsReady")
  	const result = await tx.confirm(1)
  	console.log(result);
  }

  async function likeAtPartner() {
  	const hexaddr = "f0582142e996b10b6be1fd215371f2329f948e64"
  	const tx = await lineup.send("likeAtPartner", [hexaddr])
  	const result = await tx.confirm(1)
  	console.log(result)
  }


  async function betMatch() {
    const hexaddr = "f0582142e996b10b6be1fd215371f2329f948e64"
    const tx = await lineup.send("betMatch", [hexaddr, hexaddr])
    const result = await tx.confirm(1)
    console.log(result)
  }

  async function checkFinalList() {
  	const tx = await lineup.send("checkFinalList")
  	const result = await tx.confirm(1)
  	console.log(result)
  }

  async function distribution() {
  	const tx = await lineup.send("distribution")
  	const result = await tx.confirm(1)
  	console.log(result)
  }

  async function getInfo() {
  	const hexaddr = "f0582142e996b10b6be1fd215371f2329f948e64"

    let result = await lineup.call("amountRaised")
    console.log("amountRaised", result.outputs[0].toNumber())

    result = await lineup.call("getUserInfo", [hexaddr])
    console.log("getUserInfo", web3.utils.toAscii('0x'+result.outputs[0]) + "/" +result.outputs[1])
    
  	result = await lineup.call("getUsers")
  	console.log("getUsers", result.outputs[0])

  	result = await lineup.call("getPanels")
  	console.log("getPanels", result.outputs[0])

  	result = await lineup.call("getWinners")
  	console.log("getWinners", result.outputs[0])

  	result = await lineup.call("getWinpanels")
  	console.log("getWinpanels", result.outputs[0])

  	getLikesForman()
  	getLikesForwoman()
  	getBet()
  }

  async function getLikesForman() {
  	const hexaddr = "f0582142e996b10b6be1fd215371f2329f948e64"

  	const result = await lineup.call("getLikesForman", [hexaddr])
  	console.log("getLikesForman", result.outputs[0])
  }

  async function getLikesForwoman() {
  	const hexaddr = "f0582142e996b10b6be1fd215371f2329f948e64"

  	const result = await lineup.call("getLikesForwoman", [hexaddr])
  	console.log("getLikesForwoman", result.outputs[0])
  }

  async function getBet() {
  	const hexaddr = "f0582142e996b10b6be1fd215371f2329f948e64"

  	const result = await lineup.call("getBet", [hexaddr])
  	console.log("getBet", result.outputs[0] +"/"+result.outputs[1])
  }

  async function getBalanceOfUser() {
    const hexaddr = "f0582142e996b10b6be1fd215371f2329f948e64"

    const result = await lineup.call("getBalanceOfUser", [hexaddr])
    console.log("getBalance", result.outputs[0])
  }

  async function streamEvents() {
    console.log("Subscribed to contract events")    

    lineup.onLog((entry) => {
      console.log(entry)
    }, { minconf: 1 })
  }

  //event logs
  // streamEvents()

  // depositFunds()
  // joinPanel()
  // checkFundsReady()
  // likeAtPartner()
  // betMatch()
  // checkFinalList()
  // distribution()

  getInfo()
}