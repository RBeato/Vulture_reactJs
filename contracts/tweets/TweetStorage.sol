// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

//7
contract TweetStorage {
    //11
    mapping(uint256 => Tweet) public tweets;

    struct Tweet {
        uint256 id;
        string text; //not using bytes32 because of the limit to 32 characters
        uint256 userId;
        uint256 postedAt;
    }

    uint256 latestTweetId = 0;

    function createTweet(uint256 _userId, string memory _text)
        public
        returns (uint256)
    {
        latestTweetId++;

        tweets[latestTweetId] = Tweet(
            latestTweetId,
            _text,
            _userId,
            block.timestamp
        ); //'now' is deprecated

        return latestTweetId;
    }
}
