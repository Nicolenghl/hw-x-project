// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MovieTicketBooking {
    // State Variables
    string public movieName;
    uint public ticketPrice;
    uint public totalSeats;
    uint public availableSeats;
    mapping(address => uint) public ticketsBought;

    // Event declaration
    event TicketPurchased(address buyer, uint numberOfTickets);

    // Constructor
    constructor(string memory _movieName, uint _ticketPrice, uint _totalSeats) {
        movieName = _movieName;
        ticketPrice = _ticketPrice;
        totalSeats = _totalSeats;
        availableSeats = _totalSeats;
    }

    // Functions
    function buyTicket(uint _numberOfTickets) public payable {
        // Error handling
        require(
            _numberOfTickets <= availableSeats,
            "Not enough seats available"
        );
        require(
            msg.value >= ticketPrice * _numberOfTickets,
            "Insufficient funds sent"
        );

        // Update state
        availableSeats -= _numberOfTickets;
        ticketsBought[msg.sender] += _numberOfTickets;

        // Emit event
        emit TicketPurchased(msg.sender, _numberOfTickets);

        // Return excess funds if any
        uint excess = msg.value - (ticketPrice * _numberOfTickets);
        if (excess > 0) {
            payable(msg.sender).transfer(excess);
        }
    }

    function getAvailableSeats() public view returns (uint) {
        return availableSeats;
    }

    function getTotalTicketsBought(address _buyer) public view returns (uint) {
        return ticketsBought[_buyer];
    }
}
