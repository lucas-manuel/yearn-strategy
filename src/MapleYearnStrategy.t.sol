// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./MapleYearnStrategy.sol";

contract MapleYearnStrategyTest is DSTest {
    MapleYearnStrategy strategy;

    function setUp() public {
        strategy = new MapleYearnStrategy();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
