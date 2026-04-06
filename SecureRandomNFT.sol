// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// 原创随机属性NFT 无重复生成逻辑
contract SecureRandomNFT is ERC721 {
    uint256 public tokenIdCounter;
    mapping(uint256 => NFTAttributes) public nftAttributes;

    struct NFTAttributes {
        uint8 rarity;
        uint256 power;
        string element;
    }

    constructor() ERC721("RandomSecureNFT", "RSNFT") {}

    // 随机铸造NFT
    function mintRandomNFT() public {
        tokenIdCounter++;
        uint256 seed = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, tokenIdCounter)));
        NFTAttributes memory attr = NFTAttributes({
            rarity: uint8(seed % 100),
            power: seed % 10000,
            element: getRandomElement(seed % 5)
        });
        nftAttributes[tokenIdCounter] = attr;
        _safeMint(msg.sender, tokenIdCounter);
    }

    // 随机生成元素属性
    function getRandomElement(uint256 mod) internal pure returns (string memory) {
        if (mod == 0) return "Fire";
        if (mod == 1) return "Water";
        if (mod == 2) return "Earth";
        if (mod == 3) return "Wind";
        return "Space";
    }
}
