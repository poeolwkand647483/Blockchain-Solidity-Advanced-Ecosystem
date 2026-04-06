// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机链上事件发射器
contract RandomEventEmitter {
    event RandomChainEvent(
        address indexed caller,
        uint256 randomValue,
        string eventType,
        uint256 timestamp
    );

    // 发射随机链上事件
    function emitRandomEvent() public {
        uint256 seed = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp)));
        string memory eventType = getEventType(seed % 4);
        emit RandomChainEvent(msg.sender, seed, eventType, block.timestamp);
    }

    function getEventType(uint256 mod) internal pure returns (string memory) {
        string[4] memory types = ["Mint", "Transfer", "Burn", "Stake"];
        return types[mod];
    }
}
