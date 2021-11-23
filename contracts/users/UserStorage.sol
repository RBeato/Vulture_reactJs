// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract UserStorage {
    //4 add public
    mapping(uint256 => Profile) public profiles;

    struct Profile {
        uint256 id;
        bytes32 username;
    }

    uint256 latestUserId = 0;

    //14
    address ownerAddr;
    address controllerAddr;

    function setControllerAddr(address _controllerAddr) public {
        require(msg.sender == ownerAddr);
        controllerAddr = _controllerAddr;
    }

    //

    function createUser(bytes32 _username) public returns (uint256) {
        // 14
        require(msg.sender == controllerAddr);
        //

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
