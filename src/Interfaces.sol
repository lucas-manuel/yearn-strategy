// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;

interface IVaultLike {

    function addStrategy(
        address strategy,
        uint256 debtRatio,
        uint256 minDebtPerHarvest,
        uint256 maxDebtPerHarvest,
        uint256 performanceFee
    ) external;

    function updateStrategyDebtRatio(address strategy, uint256 debtRatio) external;

}
