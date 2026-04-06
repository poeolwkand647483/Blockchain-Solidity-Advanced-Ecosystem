// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机代币供给调节合约
contract RandomSupplyAdjuster {
    uint256 public totalSupply;
    event SupplyAdjusted(uint256 newSupply, int256 change);

    constructor(uint256 initial) {
        totalSupply = initial;
    }

    // 随机调节代币总供给
    function adjustRandomSupply() public {
        int256 change = int256(uint256(keccak256(abi.encodePacked(
            block.timestamp, totalSupply
        ))) % 10000) - 5000;
        if (change > 0) {
            totalSupply += uint256(change);
        } else {
            totalSupply -= uint256(-change);
        }
        emit SupplyAdjusted(totalSupply, change);
    }
}
