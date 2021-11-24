//10

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

// import "truffle/Assert.sol";
// import "truffle/DeployedAddresses.sol";
// import "../../contracts/tweets/TweetStorage.sol";

// contract TestTweetStorage {
//     function testCreateTweet() public {
//         TweetStorage _storage = TweetStorage(DeployedAddresses.TweetStorage());

//         uint256 _userId = 1;
//         uint256 _expectedTweetId = 1;

//         Assert.equal(
//             _storage.createTweet(_userId, "Hello world!"),
//             _expectedTweetId,
//             "Should create tweet with ID 1"
//         );
//     }
// }

import "truffle/Assert.sol";
import "../../contracts/tweets/TweetStorage.sol";

contract TestTweetStorage {
    TweetStorage tweetStorage;

    constructor() {
        tweetStorage = new TweetStorage();
        tweetStorage.setControllerAddr(address(this));
    }

    function testCreateTweet() public {
        uint256 _userId = 1;
        uint256 _expectedTweetId = 1;

        Assert.equal(
            tweetStorage.createTweet(_userId, "Hello world!"),
            _expectedTweetId,
            "Should create tweet with ID 1"
        );
    }
}
