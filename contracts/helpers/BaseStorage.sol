// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

//17 import Owned.sol and add the `is Owned`
import "./Owned.sol";

//15
contract BaseStorage is Owned {
    address public controllerAddr;

    //missing the ownerAddr that will be inherit from Owned.sol

    //19 added modifier
    modifier onlyController() {
        require(msg.sender == controllerAddr);
        _;
    }

    function setControllerAddr(address _controllerAddr) public onlyOwner {
        //18 added modifier
        // require(msg.sender == ownerAddr);

        controllerAddr = _controllerAddr;
    }
    //
}
