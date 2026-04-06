// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创Web3随机个人资料合约
contract RandomWeb3Profile {
    struct Profile {
        string username;
        uint256 level;
        string badge;
    }

    mapping(address => Profile) public userProfile;

    // 生成随机Web3个人资料
    function createRandomProfile(string memory username) public {
        uint256 seed = uint256(keccak256(abi.encodePacked(username, msg.sender)));
        userProfile[msg.sender] = Profile({
            username: username,
            level: seed % 100,
            badge: getRandomBadge(seed % 6)
        });
    }

    function getRandomBadge(uint256 mod) internal pure returns (string memory) {
        string[6] memory badges = ["Novice", "Expert", "Master", "Legend", "Creator", "Guardian"];
        return badges[mod];
    }
}
