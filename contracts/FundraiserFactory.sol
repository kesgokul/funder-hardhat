// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./Fundraiser.sol";
import "./IFundraiser.sol";

contract FundraiserFactory {

    mapping(address=>address) public creatorToFundraiser;
    address[] arrayOfFundraisers;
    uint numOfFundraisers;

    function createFundraiser(uint256 _goal, uint256 _deadline) public {
        //require fund is not already made
        require( creatorToFundraiser[msg.sender] != address(0));

        //create new fundraiser contract
        Fundraiser newFundraiser = new Fundraiser(_goal, _deadline);
        //assign new fundraiser contract to creator=>fundraiser mapping
        creatorToFundraiser[msg.sender] = address(newFundraiser);
        //push new fundraiser contract to list of all fundraisers
        arrayOfFundraisers.push(address(newFundraiser));        
        //increment total number of fundraisers
        numOfFundraisers++;
    }

    function allFundraisers() public view returns (address[] memory) {
        return arrayOfFundraisers;
    }

    function numFundraisers() public view returns (uint256) {
        return numOfFundraisers;
    }

    function createRequest(address payable _fundraiser, string memory _description, uint _value, address payable _receipient) public {
        Fundraiser fundraiser_ = Fundraiser(_fundraiser);
        fundraiser_.createRequest(_description,_value,_receipient);
    }

    function vote(address payable _fundraiser, uint _requestNo) public {
        Fundraiser fundraiser_ = Fundraiser(_fundraiser);
        fundraiser_.voteRequest(_requestNo);
    }

    function contribute(address payable _fundraiser) public payable {
        Fundraiser fundraiser_ = Fundraiser(_fundraiser);
        fundraiser_.contribute{value: msg.value};
    }

    function withdraw(address payable _fundraiser, uint _requestNo) public {
        Fundraiser fundraiser_ = Fundraiser(_fundraiser);
        fundraiser_.makePayment(_requestNo);
    }

    function getRefund(address payable _fundraiser) public {
        Fundraiser fundraiser_ = Fundraiser(_fundraiser);
        fundraiser_.getRefund();
    }

    
 }

