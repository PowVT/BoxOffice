pragma solidity >=0.4.2 <0.9.0;
//SPDX-License-Identifier: 0BSD

/**
 * @title LiveTickets
 * @dev Contract used to buy tickets for specific events/concerts.
*/

import "./ownable.sol";

contract LiveTickets is ownable {

  uint public value;
  address payable public seller;
  address payable public buyer;
  uint nonce;
    
  //event TicketCreated(uint ticketId);
    
  struct LiveEvent {
    string venue;                   // Where the event takes place.
    uint startTime;                 // Time event starts.
    uint venueCapacity;             // Total count of all tickets available for the show. 
  }

  struct Ticket {
    uint ticketId;              // Keeps track of number in array. 
    uint ticketPrice;           // Price of a single ticket for specific concertId.
    bool sold;                  // If 'true' the ticket is sold. 
  }



  address[] public eventAddresses;           // Wallet address for specific venue.

  mapping (address => LiveEvent) internal events;     // Stores a venue string for each possible address.
 // mapping (string => address) public eventToAddresses;    // Stores a address for each venue string. 

  Ticket[] internal tickets;                                // Dynamic array of all ticket structs.

  mapping (uint => address) public ticketToOwner;        // Mapping of ticketId number and the address is was bought by. 
  mapping (address => Ticket) public ownerToTicket;               // Mapping of all owner addresses and the number of tickets they bought.

  //-------------------------------------------------------------------------------------------------------------------------------//
    
  constructor() payable {
    seller = payable(msg.sender);
    value = msg.value;
  }

  //-----------------------------------------------------------------------------------------------------------------------------------//

  /*
  * @dev function used to set the Venue wallet address. 
  */   
  function setVenueWalletAddress(address _newVenueWalletAddress) public onlyOwner() returns(address[] memory){
    eventAddresses.push(_newVenueWalletAddress);
    return eventAddresses;
  }

  /*
  * @dev function used to get the venue event is located at. 
  */   
  function getVenue(address _eventAddress) public view returns (string memory) {
    LiveEvent storage e = events[_eventAddress];
    return e.venue;
  }

  /*
  * @dev function used to get the venue event is located at. 
  */   
  function getStartTime(address _eventAddress) public view returns(uint) {
    LiveEvent storage e = events[_eventAddress];
    return e.startTime;
  }

  /*
  * @dev function used to get the event ticket price. 
  */   
  function getTicketPrice(address _eventAddress) public view returns(uint) {
    Ticket storage t = ownerToTicket[_eventAddress];
    return t.ticketPrice;
  }

  /*
  * @dev function used to get the venue capacity. 
  */   
  function getVenueCapacity(address _eventAddress) public view returns(uint) {
    LiveEvent storage e = events[_eventAddress];
    return e.venueCapacity;
  }

  //-----------------------------------------------------------------------------------------------------------//

  /*
  * @dev function used to set the Venue location. 
  */   
  function setEvent(address _eventAddress, string memory _venueName, uint startTIME, uint _cap, uint price) public onlyOwner() {
    eventAddresses.push(_eventAddress);
    LiveEvent storage e = events[_eventAddress];
    Ticket storage t = ownerToTicket[_eventAddress];
    e.venue = _venueName;
    e.startTime = startTIME;
    e.venueCapacity = _cap;
    t.ticketPrice = price;
  }


  /*
  * @dev function used to pay for ticket purchase. 
  */   
  function _buyTicket(address _eventAddress) public payable returns(uint, uint) {     // Pay for Ticket in dollars
    LiveEvent storage e = events[_eventAddress];
    Ticket storage t = ownerToTicket[_eventAddress];
    t.ticketId++;
    ticketToOwner[t.ticketId] = msg.sender;
    nonce++;
    require(msg.value == t.ticketPrice);            // Require payment to be equal to ticket price in dollars.
    require(e.venueCapacity > tickets.length);      // Require capacity to be greater than tickets sold.
    TicketCreated(t.ticketId);                      // Emit event for front-end. 
    return(nonce, t.ticketId);                      // Show ticketId/ nonce
  }

  /**
  * @dev Uses _ticketId to validate the caller is the owner. Throws if called by any account other than the owner.
  */
  function TicketCreated(uint ticketId) public pure returns(uint) {
    return ticketId;
  }
    
  /**
  * @dev Uses _ticketId to validate the caller is the owner. Throws if called by any account other than the owner.
  */
  modifier onlyOwnerOf(uint _ticketId) {
    require(msg.sender == ticketToOwner[_ticketId]);
    _;
  }
    
}