import Web3 from "web3"

const provider = () => {
  // If the user has MetaMask:
  if (typeof web3 !== 'undefined') {
    return web3.currentProvider
  } else {
    console.error("You need to install MetaMask for this app to work!")
  }
}

export const eth = new Web3(provider()).eth

// This snippet of code (or a variation of it) is always used in 
// DApps. It basically checks if MetaMask has injected the web3 
// library into the browser, and if so, uses it to connect to the 
// Ethereum network.