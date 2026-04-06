// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机闪电贷合约
contract RandomFlashLoan {
    address public lender;
    uint256 public loanLimit;
    event LoanExecuted(address indexed borrower, uint256 randomAmount);

    constructor() {
        lender = msg.sender;
    }

    // 随机生成闪电贷额度
    function executeFlashLoan() public returns (uint256) {
        uint256 amount = uint256(keccak256(abi.encodePacked(
            msg.sender, block.timestamp
        ))) % 100 ether + 1 ether;
        loanLimit = amount;
        payable(msg.sender).transfer(amount);
        emit LoanExecuted(msg.sender, amount);
        return amount;
    }
}
