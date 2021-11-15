// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;

import { Depositor }              from "../accounts/Depositor.sol";
import { IERC20Like, IVaultLike } from "../interfaces/Interfaces.sol";
import { Strategy }               from "../CompStrategy.sol";

import { TestHelpers } from "./TestHelpers.sol";

contract YearnTest is TestHelpers {

    Depositor  depositor;
    Strategy   strategy;
    IVaultLike vault;
    IERC20Like usdc;


    function setUp() public {
        depositor = new Depositor();
        vault     = IVaultLike(YV_USDC);
        usdc      = IERC20Like(USDC);

        // Code taken from mainnet: https://etherscan.io/address/0x342491C093A640c7c2347c4FFA7D8b9cBC84D1EB#code
        // withdrawalQueue[1] at 0xa354F35829Ae975e850e23e9615b11Da1B3dC4DE (yvUSDC)
        strategy = new Strategy(address(vault), CUSDC);
    }

    function test_strategy() public {
        vault.updateStrategyDebtRatio(COMP_STRATEGY, 0);
        vault.addStrategy(address(strategy), 9500, 0, type(uint256).max - 1, 1000);

        uint256 VAULT_BAL = 2_068_909_364345;  // yvUSDC starting USDC balance

        erc20_mint(USDC, address(depositor), 1_000_000 * USD);

        assertEq(usdc.balanceOf(address(depositor)), 1_000_000 * USD);
        assertEq(usdc.balanceOf(address(vault)),     VAULT_BAL);
        assertEq(usdc.balanceOf(address(strategy)),  0);

        assertEq(vault.balanceOf(address(depositor)), 0);

        depositor.approve(address(usdc),  address(vault),  1_000_000 * USD);
        depositor.deposit(address(vault), 1_000_000 * USD, address(depositor));

        assertEq(usdc.balanceOf(address(depositor)), 0);
        assertEq(usdc.balanceOf(address(vault)),     VAULT_BAL + 1_000_000 * USD);
        assertEq(usdc.balanceOf(address(strategy)),  0);

        assertEq(vault.balanceOf(address(depositor)), 1_000_000 * USD);

        strategy.harvest();

        assertEq(usdc.balanceOf(address(depositor)), 0);
        assertEq(usdc.balanceOf(address(vault)),     VAULT_BAL + 1_000_000 * USD);
        assertEq(usdc.balanceOf(address(strategy)),  0);

        assertEq(vault.balanceOf(address(depositor)), 1_000_000 * USD);
    }
}
