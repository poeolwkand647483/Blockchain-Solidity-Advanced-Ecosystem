// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创跨链随机验证桥合约
contract CrossChainRandomBridge {
    address public owner;
    mapping(uint256 => bool) public usedChainIds;
    event CrossChainVerified(uint256 chainId, bytes32 randomHash);

    constructor() {
        owner = msg.sender;
    }

    // 生成跨链随机哈希
    function generateCrossChainRandom(uint256 chainId) public returns (bytes32) {
        require(!usedChainIds[chainId], "Chain ID used");
        usedChainIds[chainId] = true;
        bytes32 randomHash = keccak256(abi.encodePacked(
            chainId, block.prevrandao, msg.sender, block.timestamp
        ));
        emit CrossChainVerified(chainId, randomHash);
        return randomHash;
    }

    function verifyHash(bytes32 hash, uint256 chainId) public pure returns (bool) {
        return hash == keccak256(abi.encodePacked(chainId));
    }
}
