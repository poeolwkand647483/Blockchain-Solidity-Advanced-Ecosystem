// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机时间锁合约
contract RandomTimeLock {
    mapping(address => uint256) public lockTime;
    mapping(address => uint256) public lockedBalance;
    event Locked(address indexed user, uint256 unlockTime);

    // 随机生成时间锁时长
    function lockFunds() external payable {
        require(msg.value > 0, "Zero amount");
        uint256 randomDuration = uint256(keccak256(abi.encodePacked(
            msg.sender, block.timestamp
        ))) % 30 days + 1 days;
        lockTime[msg.sender] = block.timestamp + randomDuration;
        lockedBalance[msg.sender] = msg.value;
        emit Locked(msg.sender, lockTime[msg.sender]);
    }

    function unlockFunds() public {
        require(block.timestamp >= lockTime[msg.sender], "Locked");
        uint256 balance = lockedBalance[msg.sender];
        lockedBalance[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }
}
