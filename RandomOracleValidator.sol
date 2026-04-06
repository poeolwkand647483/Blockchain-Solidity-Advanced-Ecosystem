// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机预言机验证合约
contract RandomOracleValidator {
    mapping(bytes32 => bool) public validRequests;
    event OracleRequestCreated(bytes32 indexed requestId, uint256 randomValue);

    // 创建预言机随机请求
    function createOracleRequest() public returns (bytes32, uint256) {
        uint256 randomValue = uint256(keccak256(abi.encodePacked(
            msg.sender, block.number, block.timestamp
        )));
        bytes32 requestId = keccak256(abi.encodePacked(randomValue, msg.sender));
        validRequests[requestId] = true;
        emit OracleRequestCreated(requestId, randomValue);
        return (requestId, randomValue);
    }

    function validateRequest(bytes32 requestId) public view returns (bool) {
        return validRequests[requestId];
    }
}
