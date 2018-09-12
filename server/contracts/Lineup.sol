pragma solidity ^0.4.17;

import "./Ownable.sol";
import "./SafeMath.sol";

contract Lineup is Ownable{
  using SafeMath for uint;
  enum UserType {MALE, FEMALE, PANEL}

  struct UserInfo {
    bytes32 name;
    UserType utype;
  }

  struct Bet {  	
  	address winner_man;
    address winner_woman;
  }

  struct Room {
    uint32 index;
    mapping (address => address) lov_arrows;  
    mapping (address => uint256) likes_forman;
    mapping (address => uint256) likes_forwoman;
    address[] users;
    address[] panels;
    mapping (address => Bet) bets;
    mapping (address => uint256) balanceOfUsers;
    uint fundingGoal;
    uint amountRaised;
    address[] winners;
    address[] winpanels;
    uint gameStartTime;
    uint gameEndTime;
    bool isGameStart;
    bool isGameEnd;
    bool depositClosed;
  }


  mapping (address => UserInfo) public userinfos;  
  mapping (uint => Room) public rooms;
  uint public numRooms = 1;
  uint public roomId = 1;

  //events
  event FundingGoalReached(uint amountRaisedValue);
  event GameStartEvent();
  event BettedComplete(address bettor, address man, address woman);
  event GameEndEvent();
  event DeterminedFinalList(address wm, address ww);
  event DistributionComplete();
  
  function() public { //fallback
  	revert();
  }

  function newRoom() public onlyOwner returns (uint roomId) {
    roomId = numRooms;

    Room memory room;
    room.fundingGoal = 60000000000;
    rooms[roomId] = room;
    return roomId;
  } 

  function depositFunds(bytes32 name, bool isMale) payable public {
  	require(!rooms[roomId].depositClosed);
    // require(msg.value >= 10000000000);
 
    //register to userinfo
    UserType utype = UserType.MALE;
    if(!isMale){
      utype = UserType.FEMALE;
    }
    userinfos[msg.sender] = UserInfo(name, utype);
    rooms[roomId].users.push(msg.sender);


    uint amount = msg.value;
    rooms[roomId].balanceOfUsers[msg.sender] += amount;
    rooms[roomId].amountRaised += amount;
  }

  function joinPanel() external {
    require(!rooms[roomId].isGameStart);

    rooms[roomId].panels.push(msg.sender);
  }

  function checkFundsReady() external {
  	if(rooms[roomId].amountRaised >= rooms[roomId].fundingGoal){  	  
  	  rooms[roomId].depositClosed = true;
  	  emit FundingGoalReached(rooms[roomId].amountRaised);

      gameStart();
  	}
  }

  function gameStart() internal {
    rooms[roomId].gameStartTime = now;
    rooms[roomId].gameEndTime = rooms[roomId].gameStartTime + 10 minutes;
    rooms[roomId].isGameStart = true;
    emit GameStartEvent();
  }
  
  function likeAtPartner(address _to) public {    
    require(_to != address(0));
    // require(_to != msg.sender);
    // require(lov_arrows[msg.sender] == address(0));
    
    UserType utype = userinfos[_to].utype;
    if(utype == UserType.MALE) {
      rooms[roomId].likes_forman[_to] += 1;
    } else if(utype == UserType.FEMALE){
      rooms[roomId].likes_forwoman[_to] += 1;
    }

    rooms[roomId].lov_arrows[msg.sender] = _to;
  }
  
  function betMatch(address man, address woman) public {
    require(man != address(0));
    require(woman != address(0));
    // require(man != woman);

    rooms[roomId].bets[msg.sender] = Bet(man, woman);
    emit BettedComplete(msg.sender, man, woman);
  }


  function checkFinalList() external {
    uint num_like_man = 0;
    address winner_man;      

    uint num_like_woman = 0;
    address winner_woman;

    for(uint i=0; i<rooms[roomId].users.length; i++) {
      address user_addr = rooms[roomId].users[i];
      UserType utype = userinfos[user_addr].utype;      
      if(utype == UserType.MALE){
        if(rooms[roomId].likes_forman[user_addr]>num_like_man){
          num_like_man = rooms[roomId].likes_forman[user_addr];
          winner_man = user_addr;
        }
      } else if(utype == UserType.FEMALE){
        if(rooms[roomId].likes_forwoman[user_addr]>num_like_woman){
          num_like_woman = rooms[roomId].likes_forwoman[user_addr];
          winner_woman = user_addr;
        }
      }      
    }

    if((winner_man != address(0))&&(winner_woman != address(0))){
      rooms[roomId].winners.push(winner_man);
      rooms[roomId].winners.push(winner_woman);  
    }    

    for(uint j=0; j<rooms[roomId].panels.length; j++) {
      address panel_addr = rooms[roomId].panels[j];
      if(rooms[roomId].bets[panel_addr].winner_man==winner_man && rooms[roomId].bets[panel_addr].winner_woman==winner_woman){
        rooms[roomId].winpanels.push(panel_addr);
      }
    }

    emit DeterminedFinalList(winner_man, winner_woman);
  }
  

  function distribution() external{
    // require(now > gameEndTime);
    if(rooms[roomId].winners.length==0) revert();

    for(uint j=0; j<rooms[roomId].winners.length; j++) {
      rooms[roomId].winners[i].transfer(15000000000);
      rooms[roomId].amountRaised-=15000000000;
    }

    //should be changed
    if(rooms[roomId].winpanels.length>0){
      uint amountForPanel = 30000000000;
      uint dividents = amountForPanel.div(rooms[roomId].winpanels.length);
      for(uint i=0; i<rooms[roomId].winpanels.length; i++) {
        rooms[roomId].winpanels[i].transfer(dividents);
        rooms[roomId].amountRaised-=dividents;
      }
    }

    rooms[roomId].isGameEnd = true;

    emit DistributionComplete();
  }  

  function withdrawOwner() public onlyOwner {
    msg.sender.transfer(rooms[roomId].amountRaised);
  }

  function withdraw() external {
    require(rooms[roomId].isGameEnd);
    // require(now > gameEndTime);

    uint balance = rooms[roomId].balanceOfUsers[msg.sender];
    msg.sender.transfer(balance);
    rooms[roomId].balanceOfUsers[msg.sender] = 0;
  }

  function kill() public onlyOwner {
    selfdestruct(msg.sender);
  }


  //getter functions
  function getUserInfo(address addr) public view returns(bytes32, UserType) {
    return (userinfos[addr].name, userinfos[addr].utype);
  }

  function getUsers(uint rid) view public returns(address[] addrs) {
    return rooms[rid].users;
  }

  function getPanels(uint rid) view public returns(address[] addrs){
    return rooms[rid].panels;
  }

  function getWinners(uint rid) view public returns(address[] addrs){
    return rooms[rid].winners;
  }  

  function getWinpanels(uint rid) view public returns(address[] addrs){
    return rooms[rid].winpanels;
  }

  function getLikesForman(uint rid, address addr) view public returns(uint256 numlikes) {
    return rooms[rid].likes_forman[addr];
  }

  function getLikesForwoman(uint rid, address addr) view public returns(uint256 numlikes) {
    return rooms[rid].likes_forwoman[addr];
  }

  function getBet(uint rid, address addr) view public returns(address, address) {
    return (rooms[rid].bets[addr].winner_man, rooms[rid].bets[addr].winner_woman);
  }

  function getBalanceOfUser(uint rid, address addr) view public returns(uint256 balance){
    return rooms[rid].balanceOfUsers[addr];
  }

  function getAmountRaised(uint rid) view public returns(uint256 amount){
    return rooms[rid].amountRaised;
  }
}
