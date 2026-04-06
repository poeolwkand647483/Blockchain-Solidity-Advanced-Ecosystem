// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机奖励追踪合约
contract RandomRewardTracker {
    mapping(address => uint256) public totalRewards;
    mapping(address => uint256) public lastClaimTime;
    event RewardTracked(address indexed user, uint256 newReward);

    // 追踪并更新随机奖励
    function trackUserReward(address user) public {
        uint256 reward = uint256(keccak256(abi.encodePacked(
            user, block.timestamp - lastClaimTime[user]
        ))) % 1000;
        totalRewards[user] += reward;
        lastClaimTime[user] = block.timestamp;
        emit RewardTracked(user, reward);
    }
}
