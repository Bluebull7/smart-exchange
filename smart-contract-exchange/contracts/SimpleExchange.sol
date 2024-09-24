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
    function createOffer(uint256 amount, uint256 price) public {
        require(balances[msg.sender] >= amount, "Insufficient balance to create an offer.");

        // Create a new offer and add it to the offers array
        offers.push(Offer({
            trader: msg.sender,
            amount: amount,
            price: price,
            isActive: true
        }));

        // Emit the offer creation event
        emit OfferCreated(offers.length - 1, msg.sender, amount, price);
    
    }

    // Function to execute a trade by matching an existing offer
    function executeTrade(uint256 offerId) public payable {
        Offer storage offer = offers[offerId];
        require(offer.isActive, "Offer is no longer active.");
        require(msg.value == offer.price * offer.amount, "Incorrect Ether amount sent for");
        
        // transfer tokens and Ether between buyer and seller
        balances[offer.trader] -= offer.amount;
        balances[msg.sender] += offer.amount;
        payable(offer.trader).transfer(msg.value);

        // Mark the offer as inactive
        offer.isActive = false;

        // Emit the trade execution event
        emit TradeExecuted(offerId, msg.sender, offer.amount);        
    }

}