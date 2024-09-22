// scripts/deploy.js
const hre = require("hardhat");

async function main() {
    // compile contract if it hasn't been compiled
    await hre.run('compile');
    
    // deploy the contract
    const SimpleExchange = await hre.ethers.getContractFactory("SimpleExchange");
    const simpleExchange = await SimpleExchange.deploy();

    await simpleExchange.deployed();

    console.log("SimpleExchange deployed to:", simpleExchange.address);
    await simpleExchange.deployed();
};
it("Should create a new offer", async function () {
    // Deposit ether to simulate balance
    await simpleExchange.connect(owner).deposit({ value: ethers.utils.parseEther("1") });

    // Create a new offer
    await simpleExchange.connect(owner).createOffer(1, ethers.utils.parseEther("0.1"));

    // Check that the offer was created successfully
    const offerCount = await simpleExchange.getOfferCount();
    expect(offerCount).to.equal(1);
  });

  it("Should execute a trade", async function () {
    // Deposit ether to set up balances
    await simpleExchange.connect(owner).deposit({ value: ethers.utils.parseEther("1") });
    await simpleExchange.connect(addr1).deposit({ value: ethers.utils.parseEther("0.1") });

    // Create an offer
    await simpleExchange.connect(owner).createOffer(1, ethers.utils.parseEther("0.1"));

    // Execute the trade
    await simpleExchange.connect(addr1).executeTrade(0, { value: ethers.utils.parseEther("0.1") });

    // Check the balances
    const ownerBalance = await simpleExchange.balances(owner.address);
    const addr1Balance = await simpleExchange.balances(addr1.address);
    expect(ownerBalance).to.equal(ethers.utils.parseEther("0"));
    expect(addr1Balance).to.equal(ethers.utils.parseEther("1"));
  });


