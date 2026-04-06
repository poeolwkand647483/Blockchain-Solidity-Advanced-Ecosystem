// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创NFT随机质押合约
contract RandomNFTStaking {
    mapping(uint256 => address) public stakedNFTs;
    mapping(uint256 => uint256) public stakeRewards;
    event NFTStaked(uint256 indexed tokenId, address indexed owner);

    // 质押NFT获取随机奖励
    function stakeNFT(uint256 tokenId) public {
        stakedNFTs[tokenId] = msg.sender;
        uint256 reward = uint256(keccak256(abi.encodePacked(
            tokenId, block.timestamp
        ))) % 5000;
        stakeRewards[tokenId] = reward;
        emit NFTStaked(tokenId, msg.sender);
    }

    function unstakeNFT(uint256 tokenId) public {
        require(stakedNFTs[tokenId] == msg.sender, "Not owner");
        payable(msg.sender).transfer(stakeRewards[tokenId]);
        stakedNFTs[tokenId] = address(0);
    }
}
