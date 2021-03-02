pragma solidity >=0.5.0 <0.6.0;

/**
 * @title Concert
 * @dev Various concert data can be derived from 'Ticket' contract here. 
 */

import "./LiveTickets.sol";

contract Concert is Ticket {
    
    function totalTicketsSold() public view returns(uint) {        // returns total tickets sold to specific concertId
        return tickets.length;
    }
    
    function totalTicketSales(uint ticketsSold, uint ticketPrice) external pure returns(uint) {
        uint totalSales = ticketsSold * ticketPrice;
        return totalSales;
    }
    
}
