pragma solidity >=0.6.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
//import "@openzeppelin/contracts/access/Ownable.sol"; //https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract Tickets {

  event ticketCreate(address sender, uint TicketId);

  uint public NumberOfTicketsBought;

  constructor() {
    // what should we do on deploy?
  }

  function buyTicket(address _eventAddress, uint numTicketsToPurchase) public {
    NumberOfTicketsBought = numTicketsToPurchase;
    console.log(msg.sender,"Wants to buy",numTicketsToPurchase,"tickets");
    emit ticketCreate(msg.sender, numTicketsToPurchase);
  }

}