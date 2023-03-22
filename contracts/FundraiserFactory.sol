// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Fundraiser.sol";

contract FundraiserFactory {
    mapping(address => address) public creatorToFundraiser;

    address[] arrayOfFundraisers;

    uint numOfFundraisers;

    // event to emitted whenever a new fund is created
    event NewFundCreated(
        uint256 fundIndex,
        address creator,
        uint256 goalAmount,
        uint256 deadline
    );

    function createFundraiser(uint256 goal, uint256 deadline) public {
        //require fund is not already made
        require(creatorToFundraiser[msg.sender] != address(0));

        //create new fundraiser contract
        Fundraiser newFundraiser = new Fundraiser(msg.sender, goal, deadline);

        //assign new fundraiser contract to creator->fundraiser mapping
        creatorToFundraiser[msg.sender] = address(newFundraiser);

        //push new fundraiser contract to list of all fundraisers
        arrayOfFundraisers.push(address(newFundraiser));

        //increment total number of fundraisers
        numOfFundraisers++;

        //emit the event
        emit NewFundCreated(numOfFundraisers, msg.sender, goal, deadline);
    }

    function allFundraisers() public view returns (address[] memory) {
        return arrayOfFundraisers;
    }

    function numFundraisers() public view returns (uint256) {
        return numOfFundraisers;
    }
}
