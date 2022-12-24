pragma solidity ^0.6.12;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/SafeERC721.sol";

// The name and symbol for our NFT
string public name = "My NFT";
string public symbol = "MNFT";

// The address that will be able to mint new NFTs
address public minter;

// The owner of the contract
address public owner;

// The SafeERC721 contract that we will use as the base for our NFT contract
SafeERC721 public nftContract;

// The cost to mint a new NFT
uint256 public mintingFee = 0.1 ether;

constructor() public {
  // Set the minter and owner to the contract deployer
  minter = msg.sender;
  owner = msg.sender;

  // Initialize the SafeERC721 contract
  nftContract = new SafeERC721(name, symbol);
}

// Function to mint a new NFT
function mint(uint256 _tokenId) public payable {
  // Check that the caller is the minter
  require(msg.sender == minter, "Only the minter can mint new NFTs");

  // Check that the caller has paid the minting fee
  require(msg.value == mintingFee, "Incorrect minting fee");

  // Mint the new NFT
  nftContract.mint(_tokenId, msg.sender);

  // Send the minting fee to the owner
  owner.transfer(msg.value);
}

