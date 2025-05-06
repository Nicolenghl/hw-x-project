// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GreenDish {
    // State Variables
    string public dishName;
    uint public dishPrice;
    uint public Inventory;
    uint public availableInventory;
    uint public CarbonCredits;
    string public mainComponent;
    string public SupplySource;
    mapping(address => uint) public DishesBought;
    address public owner;
    bool public isActive;

    // Event declaration
    event DishPurchased(address buyer, uint numberOfDishes);
    event InventoryUpdated(uint newInventory);
    event DishStatusChanged(bool isActive);

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
        owner = msg.sender;
        isActive = true;
    }

    // Modifier to restrict function access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Functions
    function purchaseDish(uint _numberOfDishes) public payable {
        // Error handling
        require(isActive, "This dish is not currently available for purchase");
        require(
            _numberOfDishes <= availableInventory,
            "Not enough dishes available"
        );
        require(
            msg.value >= dishPrice * _numberOfDishes,
            "Insufficient funds sent"
        );

        // Update state
        availableInventory -= _numberOfDishes;
        DishesBought[msg.sender] += _numberOfDishes;

        // Emit event
        emit DishPurchased(msg.sender, _numberOfDishes);

        // Return excess funds if any
        uint excess = msg.value - (dishPrice * _numberOfDishes);
        if (excess > 0) {
            payable(msg.sender).transfer(excess);
        }

        // If inventory is now zero, set isActive to false
        if (availableInventory == 0) {
            isActive = false;
            emit DishStatusChanged(false);
        }
    }

    // New function to update inventory
    function updateInventory(uint _newInventory) public onlyOwner {
        // Update both total and available inventory
        uint additionalInventory = _newInventory > Inventory
            ? _newInventory - Inventory
            : 0;
        Inventory = _newInventory;

        // Only increase available inventory by the additional amount
        // This ensures sold tickets aren't being reset
        availableInventory += additionalInventory;

        // Emit event for the update
        emit InventoryUpdated(_newInventory);

        // If inventory was previously 0 but now has items, set isActive to true
        if (availableInventory > 0 && !isActive) {
            isActive = true;
            emit DishStatusChanged(true);
        }
    }

    // Function to set dish status (active/inactive)
    function setDishStatus(bool _isActive) public onlyOwner {
        // Only update and emit event if the status is actually changing
        if (isActive != _isActive) {
            isActive = _isActive;
            emit DishStatusChanged(_isActive);
        }
    }

    // Check if there's inventory available
    function hasAvailableInventory() public view returns (bool) {
        return availableInventory > 0;
    }

    function getAvailableSeats() public view returns (uint) {
        return availableInventory;
    }

    function getTotalDishesBought(address _buyer) public view returns (uint) {
        return DishesBought[_buyer];
    }
}
