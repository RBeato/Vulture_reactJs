const UserStorage = artifacts.require('UserStorage');
//8
const TweetStorage = artifacts.require('TweetStorage')

module.exports = (deployer) => {
  deployer.deploy(UserStorage);
  //9
  deployer.deploy(TweetStorage);
}