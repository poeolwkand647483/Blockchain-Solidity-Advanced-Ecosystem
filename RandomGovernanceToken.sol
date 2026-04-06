// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 原创随机权重治理代币
contract RandomGovernanceToken is ERC20 {
    mapping(address => uint256) public governanceWeight;
    constructor() ERC20("RandomGovernance", "RGOV") {}

    // 铸造代币并分配随机治理权重
    function mintWithRandomWeight(uint256 amount) public {
        _mint(msg.sender, amount);
        governanceWeight[msg.sender] = uint256(keccak256(abi.encodePacked(
            block.number, msg.sender, amount
        ))) % 1000 + 100;
    }

    // 获取用户治理权重
    function getUserWeight(address user) public view returns (uint256) {
        return governanceWeight[user];
    }
}
