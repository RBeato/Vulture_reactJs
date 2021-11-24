// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

//29
import "../helpers/BaseController.sol";
//32 add imports
import "../ContractManager.sol";
import "./UserStorage.sol";

//7
contract UserController is BaseController {
    //29 inherit from BaseController

    //32 add createUser function
    function createUser(bytes32 _username) public returns (uint256) {
        ContractManager _manager = ContractManager(managerAddr);

        address _userStorageAddr = _manager.getAddress("UserStorage");
        UserStorage _userStorage = UserStorage(_userStorageAddr);

        return _userStorage.createUser(_username);
    }
}
