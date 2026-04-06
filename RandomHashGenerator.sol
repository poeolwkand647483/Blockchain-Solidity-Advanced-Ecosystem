// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创多维度随机哈希生成器
contract RandomHashGenerator {
    event HashCreated(bytes32 indexed hash, uint256 indexed seed);

    // 生成唯一随机哈希
    function generateUniqueHash() public returns (bytes32, uint256) {
        uint256 seed = uint256(keccak256(abi.encodePacked(
            block.timestamp, block.number, msg.sender, tx.gasprice
        )));
        bytes32 hash = keccak256(abi.encodePacked(seed));
        emit HashCreated(hash, seed);
        return (hash, seed);
    }
}
