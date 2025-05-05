require("@nomicfoundation/hardhat-toolbox");
const fs = require('fs');
const path = require('path');

// Custom task to serve the frontend
task("serve", "Compiles the contract, runs a local hardhat node, deploys the contract, and serves the frontend")
  .setAction(async (taskArgs, hre) => {
    // Start a local node
    const node = await hre.run("node");

    // In a separate process, deploy the contract
    const { spawn } = require('child_process');
    const deployer = spawn('npx', ['hardhat', 'run', 'scripts/deploy.js', '--network', 'localhost'], {
      stdio: 'inherit'
    });

    // Set up a simple HTTP server to serve our frontend
    const handler = require('serve-handler');
    const http = require('http');

    const server = http.createServer((request, response) => {
      return handler(request, response, {
        public: 'public',
      });
    });

    server.listen(3000, () => {
      console.log('Frontend server is running on http://localhost:3000');
    });

    // Keep the node running
    await new Promise(() => { });
  });

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    hardhat: {
      // For frontend testing, we want the node to continue running
      // even if there are no connections
      mining: {
        auto: true,
        interval: 5000
      }
    }
  },
  paths: {
    artifacts: "./public/artifacts",
  }
};
