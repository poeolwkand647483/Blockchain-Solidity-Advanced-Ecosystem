// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机权限控制合约
contract RandomAccessController {
    mapping(address => uint8) public accessLevel;
    event AccessGranted(address indexed user, uint8 level);

    // 随机分配用户权限等级
    function grantRandomAccess(address user) public {
        uint8 level = uint8(uint256(keccak256(abi.encodePacked(
            user, block.timestamp
        ))) % 5 + 1);
        accessLevel[user] = level;
        emit AccessGranted(user, level);
    }

    function checkAccess(address user, uint8 required) public view returns (bool) {
        return accessLevel[user] >= required;
    }
}
