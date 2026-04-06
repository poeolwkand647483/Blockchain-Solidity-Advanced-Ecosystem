// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 原创随机调节稳定币
contract RandomStableCoin is ERC20 {
    uint256 public adjustmentFactor;
    constructor() ERC20("RandomStable", "RSTB") {}

    // 随机调节货币系数
    function updateRandomFactor() public {
        adjustmentFactor = uint256(keccak256(abi.encodePacked(
            block.number, block.timestamp
        ))) % 100 + 50;
    }

    function mintStable(uint256 amount) public {
        uint256 finalAmount = amount * adjustmentFactor / 100;
        _mint(msg.sender, finalAmount);
    }
}
