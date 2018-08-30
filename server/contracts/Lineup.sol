pragma solidity ^0.4.11;

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

  mapping (address => UserInfo) public userinfos;
  mapping (address => uint256) public likes_forman;
  mapping (address => uint256) public likes_forwoman;
  
  address[] public users;
  address[] public panels;
  mapping (address => Bet) public bets;
  mapping (address => uint256) public balanceOfUsers;
  uint public fundingGoal = 600;
  uint public amountRaised;
  bool public depositClosed = false;  

  address[] public winners;
  address[] public winpanels;

  uint public gameStartTime;
  uint public gameEndTime;
  bool public isGameStart;

  //events
  event FundingGoalReached(uint amountRaisedValue);
  event GameStartEvent();
  event BettedComplete(address bettor, address man, address woman);
  event GameEndEvent();
  event DeterminedFinalList(address wm, address ww);
  event DistributionComplete();
  
  function() public { //falback
  	revert();
  }

  function depositFunds(bytes32 name, bool isMale) payable public {
  	require(!depositClosed);
    require(msg.value >= 300);
 
    //register to userinfo
    UserType utype = UserType.MALE;
    if(!isMale){
      utype = UserType.FEMALE;
    }
    userinfos[msg.sender] = UserInfo(name, utype);
    users.push(msg.sender);


    uint amount = msg.value;
    balanceOfUsers[msg.sender] += amount;
    amountRaised += amount;
  }

  function joinPanel() external {
    require(!isGameStart);

    panels.push(msg.sender);
  }

  function checkFundsReady() external {
  	if(amountRaised >= fundingGoal){  	  
  	  depositClosed = true;
  	  emit FundingGoalReached(amountRaised);

      gameStart();
  	}
  }

  function gameStart() internal {
    gameStartTime = now;
    gameEndTime = gameStartTime + 10 minutes;
    isGameStart = true;
    emit GameStartEvent();
  }
  
  function likeAtPartner(address _to) public {    
    require(_to != address(0));
    // require(_to != msg.sender);
    
    UserType utype = userinfos[msg.sender].utype;
    if(utype == UserType.MALE) {
      likes_forman[_to] += 1;
    } else if(utype == UserType.FEMALE){
      likes_forwoman[_to] += 1;
    }
  }
  
  function betMatch(address man, address woman) public {
    require(man != address(0));
    require(woman != address(0));
    // require(man != woman);

    bets[msg.sender] = Bet(man, woman);
    emit BettedComplete(msg.sender, man, woman);
  }


  function checkFinalList() external {
    uint num_like_man = 0;
    address winner_man;      

    uint num_like_woman = 0;
    address winner_woman;

    for(uint i=0; i<users.length; i++) {
      address user_addr = users[i];
      UserType utype = userinfos[user_addr].utype;      
      if(utype == UserType.MALE){
        if(likes_forman[user_addr]>num_like_man){
          num_like_man = likes_forman[user_addr];
          winner_man = user_addr;
        }
      } else if(utype == UserType.FEMALE){
        if(likes_forwoman[user_addr]>num_like_woman){
          num_like_woman = likes_forwoman[user_addr];
          winner_woman = user_addr;
        }
      }      
    }

    winners.push(winner_man);
    winners.push(winner_woman);

    for(uint j=0; j<panels.length; j++) {
      address panel_addr = panels[j];
      if(bets[panel_addr].winner_man==winner_man && bets[panel_addr].winner_woman==winner_woman){
        winpanels.push(panel_addr);
      }
    }

    emit DeterminedFinalList(winner_man, winner_woman);
  }
  

  function distribution() external{
    // require(now > gameEndTime);
    if(winners.length==0) revert();

    for(uint j=0; j<winners.length; j++) {
      winners[i].transfer(150);
    }

    //should be changed
    if(winpanels.length>0){
      uint amountForPanel = 300;
      uint dividents = amountForPanel.div(winpanels.length);
      for(uint i=0; i<winpanels.length; i++) {
        winpanels[i].transfer(dividents);
      }
    }    

    emit DistributionComplete();
  }


  function kill() public onlyOwner {
    selfdestruct(msg.sender);
  }

}