// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机空投分发合约
contract RandomAirdropDistributor {
    mapping(address => bool) public claimed;
    event AirdropClaimed(address indexed user, uint256 randomAmount);

    // 随机空投代币数量
    function claimRandomAirdrop() public {
        require(!claimed[msg.sender], "Already claimed");
        claimed[msg.sender] = true;
        uint256 randomAmount = uint256(keccak256(abi.encodePacked(
            msg.sender, block.timestamp
        ))) % 10000 ether + 100 ether;
        payable(msg.sender).transfer(randomAmount);
        emit AirdropClaimed(msg.sender, randomAmount);
    }

    receive() external payable {}
}
