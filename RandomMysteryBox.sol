// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创链上随机盲盒合约
contract RandomMysteryBox {
    struct MysteryBox {
        uint256 id;
        uint8 rarity;
        uint256 reward;
    }

    mapping(address => MysteryBox[]) public userBoxes;

    // 开启随机盲盒
    function openMysteryBox() public {
        uint256 seed = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp)));
        MysteryBox memory box = MysteryBox({
            id: seed,
            rarity: uint8(seed % 100),
            reward: seed % 10000 ether
        });
        userBoxes[msg.sender].push(box);
        payable(msg.sender).transfer(box.reward);
    }
}
