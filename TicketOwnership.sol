pragma solidity >=0.5.0 <0.6.0;

/**
 * @title TicketOwnership
 * @dev various methods of transfering ownership of a concert ticket between addresses using ERC721 smart contract framework from OpenZeppelin
 */

import "./LiveTickets.sol";
import "./erc721.sol";
import "./safemath.sol";

contract TicketOwnership is Ticket, ERC721 {
    
    
    mapping (uint => address) ticketApprovals;
    
    using SafeMath for uint256;
    
    function balanceOf(address _concertAttendee) external view returns (uint256) {   // returns number of tickets _concertAttendee address contains
        return ownerToTicket[_concertAttendee];
    }

    function ownerOf(uint256 _ticketId) external view returns (address) {           // returns the owner of a specific ticketId
        return ticketToOwner[_ticketId];
    }

    function _transfer(address _from, address _to, uint256 _ticketId) private {    // transfer a ticket from one address to another address
        ownerToTicket[_to] = ownerToTicket[_to].add(1);
        ownerToTicket[msg.sender] = ownerToTicket[msg.sender].sub(1);
        ticketToOwner[_ticketId] = _to;
        emit Transfer(_from, _to, _ticketId);
    }

    function transferFrom(address _from, address _to, uint256 _ticketId) external payable {             // transfer of _ticketId requiring that you are either the owner of the ticketId or you are approved by the owner of ticketId to recieve.
        require (ticketToOwner[_ticketId] == msg.sender || ticketApprovals[_ticketId] == msg.sender);
        _transfer(_from, _to, _ticketId);
    }

    function approve(address _approved, uint256 _ticketId) external payable onlyOwnerOf(_ticketId) {    // _approved address recieves _ticketId 
        ticketApprovals[_ticketId] = _approved;
        emit Approval(msg.sender, _approved, _ticketId);
    }
    
}
