// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;
pragma experimental ABIEncoderV2;

import { IPoolLike } from "./interfaces/Interfaces.sol";

import { AddressRegistry }                from "./AddressRegistry.sol";
import { BaseStrategy, IERC20, VaultAPI } from "./BaseStrategy.sol";

contract Strategy is AddressRegistry, BaseStrategy {

    IPoolLike public pool;

    /**********************/
    /*** Initialization ***/
    /**********************/

    constructor(address vault_, address pool_) public BaseStrategy(vault_) { 
        pool = IPoolLike(pool_);
    }

    /**********************************/
    /*** Asset Management Functions ***/
    /**********************************/

    function adjustPosition(uint256 _debtOutstanding) internal override {
        if (emergencyExit) return;

        uint256 wantBalance = want.balanceOf(address(this));

        want.approve(address(pool), wantBalance);
        pool.deposit(wantBalance);
    }


    /**********************/
    /*** View Functions ***/
    /**********************/

    function name() external view override returns (string memory) {
        return "StrategyV1";
    }

    /**************************/
    /*** Override Functions ***/
    /**************************/

    function estimatedTotalAssets() public view override returns (uint256) {}

    function prepareReturn(uint256 _debtOutstanding)
        internal
        override
        returns (
            uint256 _profit,
            uint256 _loss,
            uint256 _debtPayment
        )
    {}

    function liquidatePosition(uint256 _amountNeeded)
        internal
        override
        returns (uint256 _liquidatedAmount, uint256 _loss)
    {}

    // NOTE: Can override `tendTrigger` and `harvestTrigger` if necessary

    function prepareMigration(address _newStrategy) internal override {}

    function emergencyWithdrawal(uint256 _pid) external  onlyGovernance {}

    //sell all function
    function _sell() internal {}

    function protectedTokens()
        internal
        view
        override
        returns (address[] memory)
    {}

    function ethToWant(uint256 _amtInWei) public view override returns (uint256) {}

    function liquidateAllPositions() internal override returns (uint256 _amountFreed) {}

}
