// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机签名验证合约
contract RandomSignatureVerifier {
    mapping(address => bytes32) public userSignature;
    event SignatureVerified(address indexed user, bool result);

    // 生成并验证随机签名
    function verifyRandomSignature() public returns (bool) {
        bytes32 signature = keccak256(abi.encodePacked(
            msg.sender, block.number, block.timestamp
        ));
        userSignature[msg.sender] = signature;
        bool result = signature == keccak256(abi.encodePacked(msg.sender));
        emit SignatureVerified(msg.sender, result);
        return result;
    }
}
