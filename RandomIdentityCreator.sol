// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创链上随机身份生成合约
contract RandomIdentityCreator {
    struct DigitalIdentity {
        uint256 id;
        string identityType;
        uint256 createTime;
    }

    mapping(address => DigitalIdentity) public userIdentity;

    // 生成唯一随机数字身份
    function createRandomIdentity() public {
        uint256 seed = uint256(keccak256(abi.encodePacked(msg.sender, block.timestamp)));
        DigitalIdentity memory identity = DigitalIdentity({
            id: seed,
            identityType: getIdentityType(seed % 4),
            createTime: block.timestamp
        });
        userIdentity[msg.sender] = identity;
    }

    function getIdentityType(uint256 mod) internal pure returns (string memory) {
        if (mod == 0) return "Creator";
        if (mod == 1) return "Investor";
        if (mod == 2) return "Developer";
        return "User";
    }
}
