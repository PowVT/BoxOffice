pragma solidity >=0.4.2 <0.9.0;
//SPDX-License-Identifier: 0BSD

/** 
 * @title EventSetup
 * @dev Contract used initialize an event object.
*/

import "./Ownable.sol";

contract EventSetup is Ownable {

    struct LiveEvent {
        string venue;                   // Where the event takes place.
        uint startTime;                 // Time event starts.
        uint venueCapacity;             // Total count of all tickets available for the show.
    }

    event SetEvent(address sender, address _eventAddress, string _venue, uint _startTime, uint _venueCapacity);

    string public mostRecentEvent;

    mapping (address => LiveEvent) public events;
    
    function setEvent(address _eventAddress, string memory _venue, uint _startTime, uint _venueCapacity) public onlyOwner() {
        mostRecentEvent = _venue;
        LiveEvent storage e = events[_eventAddress];
        e.venue = _venue;
        e.startTime = _startTime;
        e.venueCapacity = _venueCapacity;
        emit SetEvent(msg.sender, _eventAddress, _venue, _startTime, _venueCapacity);
    }
    
    function getVenue(address _eventAddress) public view returns (string memory) {
        return events[_eventAddress].venue;
    }

    function changeVenue(address _eventAddress, string memory _venue) private onlyOwner(){
        LiveEvent storage e = events[_eventAddress];
        e.venue = _venue;
    }

    function getStartTime(address _eventAddress) public view returns (uint) {
        return events[_eventAddress].startTime;
    }

    function changeStartTime(address _eventAddress, uint _startTime) private onlyOwner(){
        LiveEvent storage e = events[_eventAddress];
        e.startTime = _startTime;
    }

    function getVenueCapacity(address _eventAddress) public view returns (uint) {
        return events[_eventAddress].venueCapacity;
    }

    function changeVenueCapacity(address _eventAddress, uint _venueCapacity) private onlyOwner(){
        LiveEvent storage e = events[_eventAddress];
        e.venueCapacity = _venueCapacity;
    }

    

}