# Movie Ticket Booking System

This project implements a smart contract for movie ticket booking along with web-based UI for users and admins to interact with the contract.

## Components

1. **Smart Contract (`MovieTicketBooking.sol`)**: A Solidity contract that handles:
   - Movie name, ticket price, and seat management
   - Ticket purchasing functionality
   - Tracking user ticket ownership

2. **User Interface (`public/index.html`)**: A web UI that allows users to:
   - Connect their wallet (MetaMask)
   - View movie information and available seats
   - Purchase tickets

3. **Admin Interface (`public/admin.html`)**: A web UI for administrators to:
   - Deploy new movie contracts with custom parameters
   - View a list of deployed contracts
   - Select which movie contract to use in the user interface

## Setup and Running the Application

### Prerequisites

- [Node.js](https://nodejs.org/) (for Hardhat and deployment tools)
- [MetaMask](https://metamask.io/) browser extension
- [Hardhat](https://hardhat.org/) for local blockchain development

### Running the Application

1. Start a local Hardhat blockchain in one terminal:
   ```
   npx hardhat node
   ```

2. In a second terminal, start the web server:
   ```
   node scripts/serve-frontend.js
   ```

3. Configure MetaMask:
   - Add a new network with RPC URL: `http://127.0.0.1:8545` and Chain ID: `31337`
   - Import a test account private key from the Hardhat node console output (any of the accounts listed)

4. Open the Admin Interface in your browser:
   - Go to `http://localhost:3000/admin.html`
   - Connect your wallet using the "Connect Wallet" button
   - Fill in the movie details and deploy a new contract

5. Use the User Interface to purchase tickets:
   - Go to `http://localhost:3000/`
   - Connect your wallet
   - View movie details and purchase tickets

## Using the Admin Interface

The admin interface allows you to:

1. **Deploy New Movie Contracts**:
   - Enter the movie name (e.g., "Inception")
   - Set the ticket price in ETH (e.g., 0.01)
   - Specify the total number of available seats (e.g., 50)
   - Click "Deploy New Movie Contract" to create a new contract

2. **View Deployed Contracts**:
   - All deployed contracts will be listed in the "Your Deployed Movie Contracts" section
   - Each contract shows its details (name, address, ticket price, total seats)

3. **Select Active Contract**:
   - Click "Load This Movie" on any contract to make it active in the user interface

## Testing

You can test various scenarios:

1. **Deploying Multiple Movies**:
   - Try creating different movie contracts with various parameters

2. **Purchasing Tickets**:
   - Buy tickets using the user interface
   - Verify that available seats and your ticket count update correctly
   - Try buying more tickets than available to test error handling

3. **Switching Between Movies**:
   - Deploy multiple movie contracts
   - Switch between them using the admin interface
   - Verify that the user interface updates to show the selected movie's details

## Architecture

- Each movie is deployed as a separate smart contract
- The admin interface tracks deployed contracts in browser localStorage
- The user interface can load contract addresses from localStorage or deployments.json
- All interactions with the blockchain are handled through MetaMask and ethers.js

## Security Considerations

- This is a basic implementation for educational purposes
- For production use, consider:
  - Adding more comprehensive error handling
  - Implementing access control for admin functions
  - Adding pausable functionality for emergencies
  - Having the contract professionally audited
