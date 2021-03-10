pragma solidity >=0.4.2 <0.9.0;
//SPDX-License-Identifier: 0BSD

/**
 * @title ConcertTicket
 * @dev Contract used to buy tickets for specific events/concerts.
 */

import "./LiveTickets.sol";

abstract contract ConcertTicket is LiveTickets {
    struct concert {
        string concertId;            // Contains the date, time, physical location, band playing, ... etc.
    }
}