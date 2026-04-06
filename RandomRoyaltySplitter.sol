// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机版税分配合约
contract RandomRoyaltySplitter {
    address[] public beneficiaries;
    mapping(address => uint256) public royaltyShare;

    function addBeneficiary(address user) public {
        beneficiaries.push(user);
    }

    // 随机分配版税比例
    function setRandomRoyalty() public {
        uint256 total = 100;
        for (uint256 i = 0; i < beneficiaries.length; i++) {
            uint256 share = uint256(keccak256(abi.encodePacked(
                block.timestamp, i
            ))) % total;
            royaltyShare[beneficiaries[i]] = share;
            total -= share;
        }
    }
}
