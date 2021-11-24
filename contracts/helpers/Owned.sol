// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

//17
contract Owned {
    address public ownerAddr;

    //18
    modifier onlyOwner() {
        require(msg.sender == ownerAddr);
        _;
    }

    constructor() {
        ownerAddr = msg.sender;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        //18 added modifier and  commented the corresponding code inside this function
        // // Only the current owner can set a new ownerAddr
        // require(msg.sender == ownerAddr);

        // The new address cannot be null
        require(_newOwner != address(0));
        //https://stackoverflow.com/questions/48219716/what-is-address0-in-solidity

        ownerAddr = _newOwner;
    }
}
