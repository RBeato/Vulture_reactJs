# Vulture Dapp

## What is Ethereum

## Dapps and smart contracts
### The ether currency
### Gas
### How Ether relates to gas

## Hello Solidity
### Using Remix
Writing the contract in solidity.


## Running locally

```
brew install node
```

### Get a blockchain client

```
npm install -g ganache-cli
```

```
ganache-cli
```

## Creating Vulture
The concept is very simple: anyone can sign up using their Ethereum wallet. Once they are logged in, they can post tweets that are stored forever on the immutable blockchain. You should also be able to view other profiles and their tweets.

### A note on immutability...
The most important thing to remember when developing for Ethereum is that, once a smart contract is deployed to an address, it can no longer be changed – the code that sits on that address will be there for all eternity.

The conclusion is therefore that you shouldn't treat your smart contracts like any other code. Here are some concepts that are especially important when writing in Solidity:

1. KISS (Keep It Simple Stupid). In other words, don't overcomplicate things. What is really the purpose of your smart contract? Why does it even need to be on the blockchain? Are there some features that are better off using a traditional database? The truth is that most good smart contracts out there are incredibly basic, and strive at doing just one simple thing.

2. Decide in advance which parts should be upgradeable, and which parts should not.

3. Test, test, test! This part cannot be stressed enough. You should have tests written for every function of your smart contract before you deploy it to the mainnet.


### Planning the structure

1. Register new users
2. Find users based on their ID or username, and get their info
3. Post new tweets
4. Find tweets based on different criteria (for example their author) and read them

![image info](./images/contracts_structure.png)

The idea behind our so-called "storage contracts" (like UserStorage and TweetStorage) is that they are never replaced. The reason for this is because their only task should be to store all of our data (the users and tweets). If we were to replace them some time in the future, that data is lost. Storage contracts work pretty much like databases, which is why they're sometimes referred to as "database contracts".

The controller contracts on the other hand are supposed to act as "gatekeepers" for anyone who wants to write to the storage contracts. They are responsible for all the logic and validation that our supplied information will have to go through before it is granted the privilege of being added to the blockchain. These contracts should also have the possibility to be replaced with newer versions if the logic needs to changed in the future.

Finally, we have the "Contract manager", which simply keeps track of the most recent version of each contract, and what address they are deployed to. That way, if the TweetController contract needs to get some info from the UserStorage contract for example, it can always go through the ContractManager.


Build UserStorage
```javascript
contract UserStorage {

  mapping(uint => Profile) profiles;

  struct Profile {
    uint id;
    bytes32 username;
  }

  uint latestUserId = 0;
  
  function createUser(bytes32 _username) public returns(uint) {
    latestUserId++;  

    profiles[latestUserId] = Profile(latestUserId, _username);

    return latestUserId;
  }
}
```
Write a deploy script so that the `UserStorage`can be interacted with.

```javascript
const UserStorage = artifacts.require('UserStorage');

module.exports = (deployer) => {
  deployer.deploy(UserStorage);
}
```

Create integration folder, create `users.js` and write test.
The web3 library (which is automatically injected into our test files)


```javascript
//test/integration/users.js
const UserStorage = artifacts.require('UserStorage')

contract('users', () => {

    it("can create user", async () => {
        const storage = await UserStorage.deployed()

        const username = web3.utils.fromAscii("romeu")
        const tx = await storage.createUser(username)

        console.log(tx)
    })
})
```
The test does not return the value of the createUser function, which we expected to be the latestUserId variable. Instead, it returns some kind of tx object?

This is again because createUser is a writable function that actively changes the state of the contract. In order to write something to the Ethereum blockchain, a new block has to be mined, which means that we need to make a transaction. That transaction data is what we see here.

```javascript
//test/integration/users.js
const UserStorage = artifacts.require('UserStorage')

contract('users', () => {

    it("can create user", async () => {
        const storage = await UserStorage.deployed()

        // const username = web3.utils.fromAscii("romeu")
        const tx = await storage.createUser(username)

        assert.isOk(tx) //use Chai's isOk assertion, to make sure that the tx object exists
    })
})
```
## Writing tests in Solidity

To check the returned latestUserId we'll need to create a unit test in Solidity.
Create `unit` folder inside `test` and create `TestUserStorage.sol`

```javascript
//test/unit/TestUserStorage.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/users/UserStorage.sol";

contract TestUserStorage {
    function testCreateFirstUser() public {
        // Get the deployed contract
        UserStorage _storage = UserStorage(DeployedAddresses.UserStorage());

        uint256 _expectedId = 1;

        Assert.equal(
            _storage.createUser("tristan"),
            _expectedId,
            "Should create user with ID 1"
        );
    }
}
```

Some things to note here:

1. All contract names related to testing (like "TestUserStorage") must start with Test (with an uppercase "T")
2. All function names related to testing (like "testCreateFirstUser") must start with test (with a lowercase "t")
3. We use the DeployedAddresses library to make sure that we get the last deployed instance of the UserStorage contract.
4. The Assert.equal function takes three parameters: the value that we want to check, the expected value to check against and a string describing what the test does.

While it can be tempting to write all tests in JavaScript, there are sometimes limitations to what you can check when going through a virtual machine. Therefore, a good mix of JavaScript tests and Solidity tests is usually key to write secure DApps.

If, like me, you are using windows and vscode you might get an import error:
![image info](./images/win_solidity_import_error.png)
If this happens use `truffle develop` to run the tests.


## Test-driven Solidity

### Retrieving the user info based on ID
To return structures in Solidity, we have to convert them to tuples, which in turn will be interpreted as arrays in the JavaScript environment.

```javascript
//test/integration/users.js
const UserStorage = artifacts.require('UserStorage')

contract('users', () => {

    it("can create user", async () => {
        const storage = await UserStorage.deployed()

        // const username = web3.utils.fromAscii("romeu")
        const tx = await storage.createUser(username)

        assert.isOk(tx) //use Chai's isOk assertion, to make sure that the tx object exists
    })

    //for:
    // struct Profile {
    //   uint id;
    //   bytes32 username;
    // }

      it("can get user", async () => {
    const storage = await UserStorage.deployed()
    const userId = 1
    
    // Get the userInfo array
    const userInfo = await storage.getUserFromId.call(userId)
    // the first element (of index 0) represents the ID, and the second one (of index 1) is the username
    
    // Get the second element (the username)
    const username = userInfo[1]

    assert.equal(username, "tristan")
  });
})
```
 The first element (of index 0) represents the ID, and the second one (of index 1) is the username.

The tests will fail.

```javascript
const username = web3.utils.toAscii(userInfo[1])
```

And even after converting the bytes32 value name to string the test will fail, due to the fact that it's a bytes32 object and therefore must be exactly 32 characters long. \u000 is simply a representation of a "null" character.

```
 AssertionError: expected 'romeu\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000' to equal 'romeu'
      + expected - actual
```

To remove these trailing null characters, we can simply replace them through a simple JavaScript RegEx

```javascript
    const username = web3.utils.toAscii(userInfo[1]).replace(/\u0000/g, '')
```

While our Solidity code above works great, there's actually a cleaner way to get all information for a profile.
By adding the keyword public in front of our `profiles` state variable, Solidity will automatically generate the getter function for us. In other words, we can skip the getUserFromId function altogether!

```javascript
  mapping(uint => Profile) public profiles;
```
Change the corresponding test (//6).

### Create the TweetStorage contract

Now test the following:
1. Creating a new tweet (and get its newly added ID)

2. Get a tweet's data based on its ID (for now, that info will be the tweet's ID, text, author ID and creation date).

Write the solidity test for getting testing the createTweet function.

```javascript
//contracts/tweets/TweetStorage.sol

contract TweetStorage {
  // SPDX-License-Identifier: GPL-3.0
  pragma solidity ^0.8.7; 

  mapping(uint => Tweet) public tweets;
  
  struct Tweet {
    uint id;
    string text;
    uint userId;
    uint postedAt;
  }

  uint latestTweetId = 0;

  function createTweet(uint _userId, string memory _text) public returns(uint) {
    latestTweetId++;

    tweets[latestTweetId] = Tweet(latestTweetId, _text, _userId, now);

    return latestTweetId;
  }

}

```

### Getting the Tweet data 
//12
Write a test in javascript as na unit test would result in error since one cannot pass strings from one contract to another in solidity.





