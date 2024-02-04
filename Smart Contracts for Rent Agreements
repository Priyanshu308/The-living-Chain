// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PGBookingSystem {
    address public owner;
    uint256 public rentAmount;
    uint256 public securityDeposit;
    mapping(address => uint256) public bookedRooms;
    mapping(address => uint256) public paidRent;

    event RoomBooked(address tenant, uint256 roomNumber);
    event RentPaid(address tenant, uint256 amount);

    constructor(uint256 _rentAmount, uint256 _securityDeposit) {
        owner = msg.sender;
        rentAmount = _rentAmount;
        securityDeposit = _securityDeposit;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier roomAvailable() {
        require(bookedRooms[msg.sender] == 0, "You have already booked a room");
        _;
    }

    modifier hasBookedRoom() {
        require(bookedRooms[msg.sender] != 0, "You haven't booked any room yet");
        _;
    }

    function bookRoom() external onlyOwner roomAvailable {
        bookedRooms[msg.sender] = uint256(uint160(msg.sender)) % 10 + 1; // Simulating room allocation
        emit RoomBooked(msg.sender, bookedRooms[msg.sender]);
    }

    function payRent() external payable hasBookedRoom {
        require(msg.value == rentAmount, "Incorrect rent amount");
        paidRent[msg.sender] += msg.value;
        emit RentPaid(msg.sender, msg.value);
    }

    function getBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }

    function withdrawBalance() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
