pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract YourContract is ERC1155 {
    // contract state variables
    uint256 public constant GOLD = 0;
    uint256 public constant SILVER = 1;
    uint256 public constant EXCALIBUR = 2;
    address public owner = address(this);
    mapping(address => uint256) public goldBalance;

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this");
        _;
    }

    constructor() public ERC1155("") {
        // create tokens and assign them to pool
        _mint(msg.sender, GOLD, 10**18, ""); // gold tokens
        _mint(msg.sender, SILVER, 10**27, ""); // silver tokens
        _mint(msg.sender, EXCALIBUR, 1, ""); // Excalibur NFT
    }

    function giveMeExcalibur() public {
        safeTransferFrom(address(this), msg.sender, EXCALIBUR, 1, ""); // do not work (does contract have NFT amount?)
    }

    function giveMeSomeGold(uint256 amount) public {
        goldBalance[msg.sender] += amount; // trigger MetaMask transfer
    }

    function getGoldBalance() external view returns (uint256) {
        return balanceOf(msg.sender, 0); // show correct balance after MetaMask transfer
    }

    // function showAllInventory() external view returns (uint256[] memory) {
    //     return balanceOfBatch([msg.sender, msg.sender, msg.sender], [0, 1, 2]); // doesn't work
    // }

    string public purpose = "Building Unstoppable Apps!!!";

    function setPurpose(string memory newPurpose) public {
        purpose = newPurpose;
        console.log(msg.sender, "set purpose to", purpose);

        console.log("Gas test", gasleft());
        console.log("Balance of golds", balanceOf(msg.sender, 0));
    }
}
