// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创去中心化随机彩票系统
contract RandomLotterySystem {
    address[] public participants;
    uint256 public lotteryId;
    event WinnerSelected(address indexed winner, uint256 reward, uint256 lotteryId);

    function joinLottery() external payable {
        require(msg.value == 0.01 ether, "Fee: 0.01 ETH");
        participants.push(msg.sender);
    }

    // 随机抽取中奖者
    function drawWinner() public {
        require(participants.length > 0, "No participants");
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(
            block.timestamp, block.number, participants.length
        ))) % participants.length;
        address winner = participants[randomIndex];
        uint256 reward = address(this).balance;
        payable(winner).transfer(reward);
        emit WinnerSelected(winner, reward, lotteryId);
        lotteryId++;
        delete participants;
    }
}
