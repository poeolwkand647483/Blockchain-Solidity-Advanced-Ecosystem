// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机白名单生成合约
contract RandomWhitelistGenerator {
    mapping(address => bool) public whitelist;
    address[] public eligibleUsers;

    function addEligibleUser(address user) public {
        eligibleUsers.push(user);
    }

    // 随机生成白名单
    function generateRandomWhitelist(uint8 count) public {
        require(count <= eligibleUsers.length, "Count exceeds");
        for (uint8 i = 0; i < count; i++) {
            uint256 randomIndex = uint256(keccak256(abi.encodePacked(
                block.timestamp, i
            ))) % eligibleUsers.length;
            whitelist[eligibleUsers[randomIndex]] = true;
        }
    }
}
