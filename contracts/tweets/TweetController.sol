// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

//29
import "../helpers/BaseController.sol";
//32 add imports
import "../ContractManager.sol";
import "./TweetStorage.sol";

//7
contract TweetController is BaseController {
    //29 inherit from BaseController

    //32 add createTweet function
    function createTweet(uint256 _userId, string memory _text)
        public
        returns (uint256)
    {
        ContractManager _manager = ContractManager(managerAddr);

        address _tweetStorageAddr = _manager.getAddress("TweetStorage");
        TweetStorage _tweetStorage = TweetStorage(_tweetStorageAddr);

        return _tweetStorage.createTweet(_userId, _text);
    }
}
