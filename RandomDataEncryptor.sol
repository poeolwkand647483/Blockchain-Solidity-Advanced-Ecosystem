// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机数据加密合约
contract RandomDataEncryptor {
    mapping(address => bytes32) public encryptedData;
    event DataEncrypted(address indexed user, bytes32 encryptedHash);

    // 随机加密用户数据
    function encryptData(string memory input) public returns (bytes32) {
        uint256 randomKey = uint256(keccak256(abi.encodePacked(
            msg.sender, block.timestamp
        )));
        bytes32 encrypted = keccak256(abi.encodePacked(input, randomKey));
        encryptedData[msg.sender] = encrypted;
        emit DataEncrypted(msg.sender, encrypted);
        return encrypted;
    }

    function verifyData(string memory input, bytes32 hash) public view returns (bool) {
        uint256 key = uint256(keccak256(abi.encodePacked(msg.sender)));
        return keccak256(abi.encodePacked(input, key)) == hash;
    }
}
