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
    const totalSeats = 50;

    console.log("Deploying MovieTicketBooking contract with parameters:");
    console.log(`Dish Name: ${dishName}`);
    console.log(`Dish Price: ${dishPrice} wei (${hre.ethers.formatEther(dishPrice)} ETH)`);
    console.log(`Total Seats: ${totalSeats}`);

    const movieTicketBooking = await hre.ethers.deployContract("MovieTicketBooking", [
        dishName,
        dishPrice,
        totalSeats
    ]);

    await movieTicketBooking.waitForDeployment();

    const contractAddress = await movieTicketBooking.getAddress();
    console.log(
        `MovieTicketBooking contract deployed to ${contractAddress}`
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