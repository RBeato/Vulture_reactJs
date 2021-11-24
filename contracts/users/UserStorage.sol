// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

//15 import BaseStorage.sol and add `is`keyword.
import "../helpers/BaseStorage.sol";

contract UserStorage is BaseStorage {
    //4 add public
    mapping(uint256 => Profile) public profiles;

    struct Profile {
        uint256 id;
        bytes32 username;
    }

    uint256 latestUserId = 0;

    // 16 Remove this because it is in BaseStorage.sol
    // //14
    // address ownerAddr;
    // address controllerAddr;

    // function setControllerAddr(address _controllerAddr) public {
    //     require(msg.sender == ownerAddr);
    //     controllerAddr = _controllerAddr;
    // }

    // //

    function createUser(bytes32 _username)
        public
        onlyController
        returns (uint256)
    {
        //19 add modifier and comment code below
        // // 14
        // require(msg.sender == controllerAddr);
        // //

        latestUserId++;

        profiles[latestUserId] = Profile(latestUserId, _username);

        return latestUserId;
    }

    //5 By adding the keyword public in front of the profiles state variable,
    // solidity will generate a getter and we can skip the getUserFromId function

    // function getUserFromId(uint256 _userId)
    //     public
    //     view
    //     returns (uint256, bytes32)
    // {
    //     return (profiles[_userId].id, profiles[_userId].username);
    // }
}
