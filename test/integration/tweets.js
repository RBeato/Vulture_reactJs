//12
const TweetStorage = artifacts.require('TweetStorage')

//25 Use these 2 lines instead of the function we created in this file earlier:
const utils = require('../utils')
const { assertVMException } = utils

contract('tweets', () =>{

     //32 Add this test:
     it("can create tweet with controller", async () => {
         const controller = await TweetController.deployed()
         
         const tx = await controller.createTweet(1, "Hello world!")
         
         assert.isOk(tx)
    })

    
    //26 This can be now removed
    // // 13  each test in Truffle uses a clean room environment to avoid state sharing
    // before(async() => {
        //     const tweetStorage = await TweetStorage.deployed()
        //     await tweetStorage.createTweet(1, "Hello world!")
        // })
        // //
        //26 add this:
        it("can't create tweet without controller", async () => {
            const storage = await TweetStorage.deployed()
            
            try {
                const tx = await storage.createTweet(1, "romeu")
                assert.fail();
            } catch (err) {
                assertVMException(err);
            }
        })
        //<26
        
        it("can get tweet", async () => {
            const storage = await TweetStorage.deployed()
            
            const tweet = await storage.tweets.call(1) //get the data
            const { id, text, userId} = tweet // Destructure the data
            
            // Check if the different parts contain the expected values
            assert.equal(parseInt(id), 1)
            assert.equal(text, "Hello world!")
            assert.equal(parseInt(userId), 1)
            
            //web3 users `bigNumber` to  support Ethereum's standard 
            //numeric data type (which is much larger than the one built into JavaScript).
            //because the numbers in this test are small we can use `parseInt()`
    })
})