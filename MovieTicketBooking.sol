// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MovieTicketBooking {
    // State Variables
    string public dishName;
    uint public dishPrice;
    uint public Inventory;
    uint public availableInventory;
    uint public CarbonCredits;
    string public mainComponent;
    string public SupplySource;
    mapping(address => uint) public ticketsBought;

    // Event declaration
    event TicketPurchased(address buyer, uint numberOfTickets);

    // Constructor
    constructor(
        string memory _dishName,
        uint _dishPrice,
        uint _Inventory,
        uint _CarbonCredits,
        string memory _mainComponent,
        string memory _SupplySource
    ) {
        dishName = _dishName;
        dishPrice = _dishPrice;
        Inventory = _Inventory;
        availableInventory = _Inventory;
        CarbonCredits = _CarbonCredits;
        mainComponent = _mainComponent;
        SupplySource = _SupplySource;
    }

    // Functions
    function buyTicket(uint _numberOfTickets) public payable {
        // Error handling
        require(
            _numberOfTickets <= availableInventory,
            "Not enough seats available"
        );
        require(
            msg.value >= dishPrice * _numberOfTickets,
            "Insufficient funds sent"
        );

        // Update state
        availableInventory -= _numberOfTickets;
        ticketsBought[msg.sender] += _numberOfTickets;

        // Emit event
        emit TicketPurchased(msg.sender, _numberOfTickets);

        // Return excess funds if any
        uint excess = msg.value - (dishPrice * _numberOfTickets);
        if (excess > 0) {
            payable(msg.sender).transfer(excess);
        }
    }

    function getAvailableSeats() public view returns (uint) {
        return availableInventory;
    }

    function getTotalTicketsBought(address _buyer) public view returns (uint) {
        return ticketsBought[_buyer];
    }
}
