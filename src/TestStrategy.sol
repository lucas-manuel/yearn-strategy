// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;
pragma experimental ABIEncoderV2;

import { AddressRegistry } from "./AddressRegistry.sol";

contract MapleStrategy is AddressRegistry {
    address public vault = YV_USDC;
    address public want  = USDC;
}
