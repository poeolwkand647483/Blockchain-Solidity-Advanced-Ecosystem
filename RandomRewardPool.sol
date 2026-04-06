// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机奖励池合约
contract RandomRewardPool {
    address public owner;
    uint256 public poolBalance;
    event RewardDistributed(address indexed user, uint256 randomReward);

    constructor() {
        owner = msg.sender;
    }

    function depositToPool() external payable {
        poolBalance += msg.value;
    }

    // 随机分配奖励池奖金
    function distributeRandomReward() public {
        uint256 reward = uint256(keccak256(abi.encodePacked(
            block.timestamp, msg.sender
        ))) % poolBalance;
        poolBalance -= reward;
        payable(msg.sender).transfer(reward);
        emit RewardDistributed(msg.sender, reward);
    }
}
