pragma solidity >=0.5.0 <0.6.0;

/**
 * @title LiveTickets
 * @dev Contract used to buy tickets for specific events/concerts.
 */

import "./ownable.sol";

contract Ticket is Ownable {
    
    event concertTicket(string indexed concertId, address indexed concertAttendee, uint ticketsSold, uint ticketPrice, uint ticketCount);
    
    struct Concert {
        string concertId;            // Contains the date, time, physical location, band playing, ... etc.
        address payable concertIdAddress;    // Smart contract address where funds are stored for selling tickets.
        address concertAttendee;     // Address of the wallet buying the ticket to concert.
        uint ticketCount;            // Total count of all tickets available for the show. 
        uint ticketPrice;            // Price of a single ticket for specific concertId.
        uint ticketsSold;             // Total number of tickets sold for specific concertId.
        uint nonce;                  // Protects against spam/replay attacks. Event identifier.
    }
    
    Concert[] public tickets;        // Dynamic array of all tickets
    
    mapping (uint => address) public ticketToOwner;     // Mapping of ticket number and the address is was bought by. 
    mapping (address => uint) ownerToTicket;            // Mapping of all owner addresses and the number of tickets they bought.
    
    /**
  * @dev function used to pay for ticket purchase. 
  */
    
    function _payForTicket(uint _ticketPrice) public payable {            // Pay for Ticket in dollars
        _ticketPrice = _ticketPrice * (10**18);                           // Convert dollars to Wei
        require(msg.value == _ticketPrice);                               // Require payment to be equal to ticket price in Wei.
    }
    
    /**
  * @dev Main method of purchaing a ticket to a specific _concertId. Also, calls function to have ticket paid for. Increases nonce to eliminate multiple calls. Gives ticket to owner once paid for.
  */
    
    function _buyTicket(string memory _concertId, address payable _concertIdAddress, address _concertAttendee, uint _ticketCount, uint _ticketPrice, uint _ticketsSold, uint _nonce) public payable {
        uint ticketId = tickets.push(Concert(_concertId, _concertIdAddress, _concertAttendee, _ticketsSold, _ticketCount, _ticketPrice, 1)) - 1;      // Add concert attendee to the tickets array.
        _payForTicket( _ticketPrice);
        ticketToOwner[ticketId] = msg.sender;
        ownerToTicket[msg.sender]++;
        _nonce++;
        _ticketsSold++;
        emit concertTicket(_concertId, _concertAttendee, _ticketsSold, _ticketPrice, _ticketCount);
    }
    
    /**
   * @dev Uses _ticketId to validate the caller is the owner. Throws if called by any account other than the owner.
   */
    modifier onlyOwnerOf(uint _ticketId) {
       require(msg.sender == ticketToOwner[_ticketId]);
       _;
    }
    
}
