const handler = require('serve-handler');
const http = require('http');
const fs = require('fs');
const path = require('path');

// Create a simple HTTP server to serve the frontend
const server = http.createServer((request, response) => {
    return handler(request, response, {
        public: 'public',
    });
});

// Start the server
server.listen(3000, () => {
    console.log('Frontend server is running at:');
    console.log('- http://localhost:3000 (User Interface)');
    console.log('- http://localhost:3000/admin.html (Admin Interface)');
    console.log('\nImportant instructions:');
    console.log('1. Make sure your Hardhat node is running in another terminal with:');
    console.log('   npx hardhat node');
    console.log('2. Connect MetaMask to Hardhat network (http://127.0.0.1:8545)');
    console.log('3. Import a test account private key into MetaMask from the Hardhat console output');
    console.log('4. Use the Admin interface to deploy a new movie contract');
    console.log('5. After deployment, you can use the User interface to buy tickets');
}); 