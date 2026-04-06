// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// 原创随机资产融合合约
contract RandomAssetFusion {
    struct FusionAsset {
        uint256 id;
        uint256 power;
        string typeName;
    }

    FusionAsset[] public fusedAssets;

    // 随机融合两种资产生成新资产
    function fuseAssets(uint256 asset1, uint256 asset2) public {
        uint256 seed = uint256(keccak256(abi.encodePacked(asset1, asset2, block.timestamp)));
        fusedAssets.push(FusionAsset({
            id: seed,
            power: (asset1 + asset2) * (seed % 100) / 50,
            typeName: getFusionType(seed % 3)
        }));
    }

    function getFusionType(uint256 mod) internal pure returns (string memory) {
        if (mod == 0) return "Attack";
        if (mod == 1) return "Defense";
        return "Balance";
    }
}
