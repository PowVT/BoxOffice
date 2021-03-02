pragma solidity >=0.5.0 <0.6.0;

/**
 * @title Concert
 * @dev Various concert data can be derived from 'Ticket' contract here. 
 */

import "./LiveTickets.sol";

contract Concert is Ticket {
    
    function totalTicketsSold(string memory concertId) external view {        // returns total tickets sold to specific concertId
        return ticketsSold;
    }
    
    function totalTicketSales(uint ticketsSold, uint ticketPrice) external view returns(uint) {
        return ticketsSold*ticketPrice;
    }
    
}
