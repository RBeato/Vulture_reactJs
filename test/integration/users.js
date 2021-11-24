const UserStorage = artifacts.require('UserStorage')

//25 Use these 2 lines instead of the function we created in this file earlier:
const utils = require('../utils')
const { assertVMException } = utils

//32
const UserController = artifacts.require('UserController') // <-- Add this!

contract('users', () => {

    //24 added can't create user without controller
    it("can't create user without controller", async () => {
        const storage = await UserStorage.deployed()
    
        try {
          const username = web3.utils.fromAscii("romeu")
          await storage.createUser(username)
          assert.fail()
        } catch (err) {
            //25 call function
            assertVMException(err);
        //   console.log(err);
        }
      })

    //32 remove "can create user"
    // it("can create user", async () => {
    //     const storage = await UserStorage.deployed()

    //     const username = web3.utils.fromAscii("romeu")
    //     const tx = await storage.createUser(username)

    //     // console.log(tx)
    //     assert.isOk(tx)
    // })

    //32 add "cam create user with controller"
    it("can create user with controller", async () => {
        const controller = await UserController.deployed()
    
        const username = web3.utils.fromAscii("romeu")
        const tx = await controller.createUser(username)
    
        assert.isOk(tx)
      })

    
    // for:
    // struct Profile {
    //   uint id;
    //   bytes32 username;
    // }

    it("can get user", async () => {
        const storage = await UserStorage.deployed()
        const userId = 1
        
        // Get the userInfo array
        //6 replace
        // const userInfo = await storage.getUserFromId.call(userId)
        // with
        const userInfo = await storage.profiles(userId) 
        //!Check the correct way original way was .profiles.call(userId)
         // the first element (of index 0) represents the ID, and the 
         // second one (of index 1) is the username
        
        //1 
        //Get the second element (the username)
        // const username = userInfo[1]

        //2
        // const username = web3.utils.toAscii(userInfo[1])
        // Whenever we retrieve a bytes32 value in a JavaScript environment, 
        // we have to convert it to a string before using it in our assertions

         //3
         // Use the "replace" function at the end:
         const username = web3.utils.toAscii(userInfo[1]).replace(/\u0000/g, '')
         // Whenever we retrieve a bytes32 value in a JavaScript environment, 
         // we have to convert it to a string before using it in our assertions
 

    
        assert.equal(username, "romeu")
      });
})