// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创DeFi随机质押收益合约
contract DefiRandomStaking {
    mapping(address => uint256) public stakedBalance;
    mapping(address => uint256) public rewardRate;
    event Staked(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 reward);

    // 质押资产 随机生成基础收益率
    function stake() external payable {
        require(msg.value > 0, "Stake: Zero amount");
        stakedBalance[msg.sender] += msg.value;
        rewardRate[msg.sender] = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100 + 10;
        emit Staked(msg.sender, msg.value);
    }

    // 领取随机收益
    function claimReward() external {
        uint256 reward = stakedBalance[msg.sender] * rewardRate[msg.sender] / 1000;
        require(address(this).balance >= reward, "Insufficient balance");
        payable(msg.sender).transfer(reward);
        emit RewardClaimed(msg.sender, reward);
    }
}
