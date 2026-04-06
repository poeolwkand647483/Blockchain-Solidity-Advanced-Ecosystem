// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机权限管理合约
contract RandomPermissionManager {
    mapping(address => mapping(bytes4 => bool)) public permissions;
    event PermissionSet(address indexed user, bytes4 indexed func, bool allowed);

    // 随机设置函数调用权限
    function setRandomPermission(address user, bytes4 funcSig) public {
        bool allowed = uint256(keccak256(abi.encodePacked(
            user, funcSig, block.timestamp
        ))) % 2 == 0;
        permissions[user][funcSig] = allowed;
        emit PermissionSet(user, funcSig, allowed);
    }
}
