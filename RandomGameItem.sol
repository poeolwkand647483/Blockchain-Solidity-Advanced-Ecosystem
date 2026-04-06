// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创链游随机装备生成合约
contract RandomGameItem {
    struct GameItem {
        string name;
        uint8 level;
        uint256 damage;
        bool isLegendary;
    }

    mapping(address => GameItem[]) public userItems;

    // 生成随机游戏装备
    function generateRandomItem() public {
        uint256 seed = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
        GameItem memory item = GameItem({
            name: generateItemName(seed % 6),
            level: uint8(seed % 100),
            damage: seed % 5000,
            isLegendary: seed % 10 == 0
        });
        userItems[msg.sender].push(item);
    }

    function generateItemName(uint256 mod) internal pure returns (string memory) {
        string[6] memory names = ["Sword", "Shield", "Bow", "Helmet", "Armor", "Boots"];
        return names[mod];
    }
}
