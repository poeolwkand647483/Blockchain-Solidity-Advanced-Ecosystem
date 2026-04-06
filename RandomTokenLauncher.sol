// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机代币发行合约
contract RandomTokenLauncher {
    struct TokenInfo {
        string name;
        string symbol;
        uint256 totalSupply;
        uint8 taxRate;
    }

    TokenInfo public deployedToken;
    event TokenLaunched(string name, uint256 supply);

    // 随机生成代币参数并发行
    function launchRandomToken(string memory name, string memory symbol) public {
        uint256 seed = uint256(keccak256(abi.encodePacked(name, symbol, block.timestamp)));
        deployedToken = TokenInfo({
            name: name,
            symbol: symbol,
            totalSupply: seed % 1000000000 ether + 1000000 ether,
            taxRate: uint8(seed % 10)
        });
        emit TokenLaunched(name, deployedToken.totalSupply);
    }
}
