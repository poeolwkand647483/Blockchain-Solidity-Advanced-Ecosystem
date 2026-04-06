// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机收益耕种合约
contract RandomYieldFarming {
    mapping(address => uint256) public farmedAmount;
    mapping(address => uint256) public yieldRate;
    event Farmed(address indexed user, uint256 yield);

    // 随机生成耕种收益率
    function startFarming(uint256 amount) public {
        farmedAmount[msg.sender] = amount;
        yieldRate[msg.sender] = uint256(keccak256(abi.encodePacked(
            amount, block.timestamp
        ))) % 200 + 50;
    }

    function harvestYield() public {
        uint256 yield = farmedAmount[msg.sender] * yieldRate[msg.sender] / 1000;
        payable(msg.sender).transfer(yield);
        emit Farmed(msg.sender, yield);
    }
}
