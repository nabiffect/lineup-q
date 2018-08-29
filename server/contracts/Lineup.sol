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
  	address panel;
  	mapping (address => address) matches;
  }

  mapping (address => UserInfo) public users;
  mapping (address => address) public likes;
  
  address[] panels;
  mapping (address => Bet) public bets;
  mapping (address => uint256) public balanceOfUsers;
  uint public fundingGoal = 600;
  uint public amountRaised;
  bool public depositClosed = false;  

  //events
  event FundingGoalReached(uint amountRaisedValue);
  event GameStartEvent();
  event GameEndEvent();
  event BetCompleteEvent();
  

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

  

  function distribution() {
    for(uint i=0; i<panels.length; i++) {
      
    }
  }

}