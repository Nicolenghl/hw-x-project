// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
const { saveDeployment } = require("./save-deployment");

async function main() {
    const dishName = "Inception";
    const dishPrice = hre.ethers.parseEther("0.01"); // 0.01 ETH per ticket
    const Inventory = 50;
    const CarbonCredits = 25; // Carbon credits per dish
    const mainComponent = "Locally grown vegetables";
    const SupplySource = "Local farmer";

    console.log("Deploying GreenDish contract with parameters:");
    console.log(`Dish Name: ${dishName}`);
    console.log(`Dish Price: ${dishPrice} wei (${hre.ethers.formatEther(dishPrice)} ETH)`);
    console.log(`Inventory: ${Inventory}`);
    console.log(`Carbon Credits: ${CarbonCredits}`);
    console.log(`Main Component: ${mainComponent}`);
    console.log(`Supply Source: ${SupplySource}`);

    const greenDish = await hre.ethers.deployContract("GreenDish", [
        dishName,
        dishPrice,
        Inventory,
        CarbonCredits,
        mainComponent,
        SupplySource
    ]);

    await greenDish.waitForDeployment();

    const contractAddress = await greenDish.getAddress();
    console.log(
        `GreenDish contract deployed to ${contractAddress}`
    );

    // Save deployment info for the frontend
    await saveDeployment(contractAddress);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
}); 