// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

interface IFundraiser {
    function getBalance() external view returns (uint);
    function contribute() external payable;
    function getRefund() external payable;
    function createRequest(string memory _description, uint _value, address payable _receipient) external;
    function voteRequest(uint _requestNo) external;
    function makePayment(uint _requestNo) external;
}
