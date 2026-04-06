// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机保险库管理合约
contract RandomVaultManager {
    mapping(address => uint256) public vaultBalance;
    mapping(address => uint256) public vaultKey;
    event VaultCreated(address indexed user, uint256 vaultKey);

    // 创建带随机密钥的保险库
    function createVault() public payable {
        require(msg.value > 0, "Deposit required");
        vaultBalance[msg.sender] += msg.value;
        vaultKey[msg.sender] = uint256(keccak256(abi.encodePacked(
            msg.sender, block.timestamp, msg.value
        )));
        emit VaultCreated(msg.sender, vaultKey[msg.sender]);
    }

    function withdrawVault(uint256 key) public {
        require(vaultKey[msg.sender] == key, "Invalid key");
        uint256 balance = vaultBalance[msg.sender];
        vaultBalance[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }
}
