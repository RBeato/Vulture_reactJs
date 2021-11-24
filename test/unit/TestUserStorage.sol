// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// import "truffle/Assert.sol";
// import "truffle/DeployedAddresses.sol";
// import "../../contracts/users/UserStorage.sol";

// contract TestUserStorage {
//     function testCreateFirstUser() public {
//         // Get the deployed contract
//         UserStorage _storage = UserStorage(DeployedAddresses.UserStorage());

//         uint256 _expectedId = 1;

//         Assert.equal(
//             _storage.createUser("romeu"),
//             _expectedId,
//             "Should create user with ID 1"
//         );
//     }
// }

//31
import "truffle/Assert.sol";
import "../../contracts/users/UserStorage.sol";

contract TestUserStorage {
    UserStorage userStorage;

    constructor() {
        userStorage = new UserStorage();
        userStorage.setControllerAddr(address(this));
    }

    function testCreateFirstUser() public {
        uint256 _expectedId = 1;

        Assert.equal(
            userStorage.createUser("tristan"),
            _expectedId,
            "Should create user with ID 1"
        );
    }
}
