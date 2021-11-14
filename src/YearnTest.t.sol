// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;
pragma experimental ABIEncoderV2;

import { DSTest } from "../lib/ds-test/src/test.sol";

import { AddressRegistry } from "./AddressRegistry.sol";
import { IVaultLike }      from "./Interfaces.sol";
import { MapleStrategy }   from "./MapleStrategy.sol";

contract YearnTest is DSTest, AddressRegistry {

    MapleStrategy strategy;
    IVaultLike    vault;

    function setUp() public {
        strategy = new MapleStrategy();
        vault    = IVaultLike(YV_USDC);
    }

    function test_totalSupply() public {
        address usdc = strategy.want();
        address vault2 = strategy.vault();
        emit log_named_address("usdc", usdc);
        emit log_named_address("vault2", vault2);
        emit log_named_address("address(this)", address(this));
        vault.updateStrategyDebtRatio(COMP_STRATEGY, 0);
        vault.addStrategy(address(strategy), 10_000, 0, type(uint256).max - 1, 1000);
        
    }
}
