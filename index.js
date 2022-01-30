const express = require('express');
const ethers = require('ethers');
const address = `0x9750a45b0d88F2910d1656217d19503f20423B41`;
const abi = JSON.parse(`[
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "previousOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipTransferred",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "renounceOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]`)
const provider = 'https://rinkeby.infura.io/v3/7fd81eb359ea4252ba1d7e7b675be37f';
let infuraProvider = new ethers.providers.InfuraProvider('rinkeby');
const contract = new ethers.Contract(address, abi, infuraProvider);

const app = express();
const port = 5000;

app.listen(port, () => {
    console.log("server started at port ", port);
    contract.on('Burnt', (caller, tokenId) => {
		console.log('something burnt ', tokenId, ' at ', caller);
	})
	contract.on('Mint', (caller) => {
		console.log("Someone minted at ", caller)
	})
});