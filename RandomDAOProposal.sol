// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机DAO提案合约
contract RandomDAOProposal {
    struct Proposal {
        uint256 id;
        string content;
        uint256 randomThreshold;
        bool passed;
    }

    Proposal[] public proposals;
    uint256 public proposalId;

    // 创建带随机通过阈值的提案
    function createProposal(string memory content) public {
        uint256 threshold = uint256(keccak256(abi.encodePacked(
            content, block.timestamp
        ))) % 1000 + 500;
        proposals.push(Proposal({
            id: proposalId,
            content: content,
            randomThreshold: threshold,
            passed: false
        }));
        proposalId++;
    }
}
