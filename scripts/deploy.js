const { ethers } = require("hardhat");

const main = async () => {
  console.log(`Preparing deployment...\n`);

  // Get contracts
  const MyToken = await ethers.getContractFactory("MyToken");

  // Fetch accounts
  const accounts = await ethers.getSigners();

  console.log(
    `Accounts fetched:\n${accounts[0].address}\n${accounts[1].address}\n`
  );
    
  // Deploy contract
  const myToken = await MyToken.deploy();
  await myToken.deployed();

  console.log(`MyToken Deployed to: ${myToken.address}`);

   //   Give tokens to accounts[1]
   const sender = accounts[0];
   const receiver = accounts[1];

   // user1 transfer 10,000 SiToken
   let transaction, result;
   transaction = await myToken.connect(sender).transfer(
     receiver.address,
     amount
   );
 
   console.log(
     `Transferred ${amount} tokens from ${sender.address} to ${receiver.address}\n`
   );
 

};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (err) {
    console.log(err);
    process.exit(1);
  }
};

runMain();