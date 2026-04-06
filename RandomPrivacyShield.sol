// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机隐私保护合约
contract RandomPrivacyShield {
    mapping(address => bytes32) public shieldKey;
    event ShieldActivated(address indexed user, bytes32 key);

    // 激活随机隐私护盾
    function activatePrivacyShield() public {
        bytes32 key = keccak256(abi.encodePacked(
            msg.sender, block.number, block.timestamp
        ));
        shieldKey[msg.sender] = key;
        emit ShieldActivated(msg.sender, key);
    }

    function checkShield(address user) public view returns (bool) {
        return shieldKey[user] != 0;
    }
}
