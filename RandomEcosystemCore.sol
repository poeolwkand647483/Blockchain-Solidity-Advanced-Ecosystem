// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创区块链生态随机核心合约 项目总入口
contract RandomEcosystemCore {
    address public owner;
    uint256 public ecosystemSeed;
    event EcosystemInitialized(uint256 seed);

    constructor() {
        owner = msg.sender;
        ecosystemSeed = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
        emit EcosystemInitialized(ecosystemSeed);
    }

    // 获取生态唯一随机种子
    function getEcosystemSeed() public view returns (uint256) {
        return ecosystemSeed;
    }

    // 刷新生态核心种子
    function refreshSeed() public {
        require(msg.sender == owner, "Only owner");
        ecosystemSeed = uint256(keccak256(abi.encodePacked(block.number, msg.sender)));
    }
}
