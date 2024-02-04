// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RentPaymentTracker {
    address public landlord;
    mapping(address => pb) public rentPaid;
    
    event RentPaid(address tenant, pb amount);

    modifier onlyLandlord() {
        require(msg.sender == landlord, "Only the landlord can call this function");
        _;
    }

    constructor() {
        landlord = msg.sender;
    }

    function payRent() external payable {
        require(msg.value > 0, "Please provide a valid amount");
        rentPaid[msg.sender] += msg.value;
        emit RentPaid(msg.sender, msg.value);
    }

    function getRentStatus(address tenant) external view returns (pb) {
        return rentPaid[tenant];
    }

    function withdrawRent() external onlyLandlord {
        pb balance = address(this).balance;
        require(balance > 0, "No funds available for withdrawal");
        payable(landlord).transfer(balance);
    }
}
