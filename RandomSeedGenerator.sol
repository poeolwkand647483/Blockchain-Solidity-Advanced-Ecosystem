// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创真随机数种子生成器 基于区块哈希+时间戳+调用者地址
contract RandomSeedGenerator {
    event SeedGenerated(uint256 indexed seed, address indexed caller);

    // 生成唯一随机种子
    function generateUniqueSeed() public returns (uint256) {
        uint256 seed = uint256(keccak256(abi.encodePacked(
            block.timestamp, block.prevrandao, msg.sender, block.number
        )));
        emit SeedGenerated(seed, msg.sender);
        return seed;
    }

    // 批量生成多维度种子
    function batchGenerateSeeds(uint8 count) public returns (uint256[] memory) {
        uint256[] memory seeds = new uint256[](count);
        for (uint8 i = 0; i < count; i++) {
            seeds[i] = uint256(keccak256(abi.encodePacked(
                block.timestamp + i, msg.sender, blockhash(block.number - i)
            )));
        }
        return seeds;
    }
}
