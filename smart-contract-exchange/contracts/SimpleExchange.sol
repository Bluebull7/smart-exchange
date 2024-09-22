// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleExchange {
    //define a struct for trade offers
    struct Offer {
        address trader;             // Address of the trader
        uint256 amount;             // Amount of tokens offered
        uint256 price;              // Price per token
        bool isActive;              // Offer status
    }

    // State variables
    mapping(address => uint256) public balances;    // Balances of users
    Offer[] public offers;                          // Array of all offers

    //Event Declarations
    event OfferCreated(uint256 offerId, address trader, uint256 amount, uint256 price);
    event TradeExecuted(uint256 offerId, address buyer, uint256 amount);

    // Function to deposit tokens into the contract (Simulated with Ether)
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    // Function to create a trade offer
    function createOffer(uint256 amount, uint256 price) public {}

}