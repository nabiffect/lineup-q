pragma solidity ^0.4.11;

import "./Ownable.sol";
import "./SafeMath.sol";

contract Lineup is Ownable{

  enum UserType {MALE, FEMALE, PANEL}

  struct UserInfo {
    bytes32 name;
    UserType type;
  }

  struct Bet {  	
  	address winner_man;
    address winner_woman;
  }

  // struct Like {
  //   address partner;    
  //   uint numlikes;
  // }


  mapping (address => UserInfo) public userinfos;
  mapping (address => uint256) public likes_forman;
  mapping (address => uint256) public likes_forwoman;
  
  address[] users;
  address[] panels;
  mapping (address => Bet) public bets;
  mapping (address => uint256) public balanceOfUsers;
  uint public fundingGoal = 600;
  uint public amountRaised;
  bool public depositClosed = false;  

  address[] winners;
  address[] winpanels;


  //events
  event FundingGoalReached(uint amountRaisedValue);
  event GameStartEvent();
  event BettedEvent();
  event GameEndEvent();
  event DeterminedFinalList(address wm, address ww);
  event DistributionComplete();
  

  function() public { //falback
  	revert();
  }

  function depositFunds() payable public {
  	require(!depositClosed);
    uint amount = msg.value;
    balanceOfUsers[msg.sender] += amount;
    amountRaised += amount;
  }

  function checkFundsReady() external {
  	if(amount >= fundingGoal){  	  
  	  depositClosed = true;
  	  FundingGoalReached(amountRaised);
  	}
  }

  //TODO
  //like action
  //bet action

  function checkFinalList() external {
    uint num_like_man = 0;
    address winner_man;      

    uint num_like_woman = 0;
    address winner_woman;

    for(uint i=0; i<users.length; i++) {
      address user_addr = users[i];
      UserType type = userinfos[user_addr].type;      
      if(type == UserType.MALE){
        if(likes_forman[user_addr] && likes_forman[user_addr]>num_like_man){
          num_like_man = likes_forman[user_addr];
          winner_man = user_addr;
        }
      } else if(type == UserType.FEMALE){
        if(likes_forwoman[user_addr] && likes_forwoman[user_addr]>num_like_woman){
          num_like_woman = likes_forwoman[user_addr];
          winner_woman = user_addr;
        }
      }      
    }

    winners.push(winner_man);
    winners.push(winner_woman);

    for(uint j=0; j<panels.length; j++) {
      address panel_addr = panels[j];
      if(bets[panel_addr] && bets[panel_addr].winner_man==winner_man && bets[panel_addr].winner_woman==winner_woman){
        winpanels.push(panel_addr);
      }
    }

    DeterminedFinalList(winner_man, winner_woman);
  }
  

  function distribution() external{
    if(winners.length==0) throw;

    for(uint j=0; j<winners.length; j++) {
      winners[i].send(150);
    }

    uint dividents = 300.div(winpanels.length);
    for(uint i=0; i<winpanels.length; i++) {
      winpanels[i].send(dividents);
    }

    DistributionComplete();
  }


  function kill() public onlyOwner {
    selfdestruct(msg.sender);
  }

}