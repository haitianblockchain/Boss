const { ethers } = require("hardhat");
require("dotenv").config();

async function main() {
  
  // Fetch the contract factory
  const EsdrasCoin = await ethers.getContractFactory("EsdrasCoin");

  // Define constructor arguments
  
  //const cap = hre.ethers.utils.parseUnits("100000000", 18);
  // 1,000,000 tokens (adjust for 18 decimals)
  //const reward = hre.ethers.utils.parseUnits("50", 18);  // Example reward (adjust for 18 decimals)

  // Deploy the contract with constructor arguments
  console.log("Deploying the EsdrasCoin contract...");
  const esdrasCoin = await EsdrasCoin.deploy(100000000, 50);

  // Wait for the deployment transaction to be mined
  const receipt = await esdrasCoin.waitForDeployment();

  console.log("Esdrascoin deployed successfully!");
  console.log("Contract Address: ", await esdrasCoin.getAddress());
  console.log(`Transaction Hash: ${receipt.transactionHash}`);
}



// Handle errors
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });