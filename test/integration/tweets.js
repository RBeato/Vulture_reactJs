//12
const TweetStorage = artifacts.require('TweetStorage')

contract('tweets', () =>{

    it("can get tweet", async () => {
        // 13  each test in Truffle uses a clean room environment to avoid state sharing
        before(async() => {
            const tweetStorage = await TweetStorage.deployed()
            await tweetStorage.createTweet(1, "Hello world!")
        })
        //

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