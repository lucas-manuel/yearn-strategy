// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;

import { DSTest } from "../../lib/ds-test/src/test.sol";

import { AddressRegistry } from "../AddressRegistry.sol";
import { IERC20Like }      from "../interfaces/Interfaces.sol";

interface Hevm {

    // Sets block timestamp to `x`
    function warp(uint256 x) external view;

    // Sets slot `loc` of contract `c` to value `val`
    function store(address c, bytes32 loc, bytes32 val) external view;

    // Sets the block number
    function roll(uint256 x) external;

    // Reads the slot `loc` of contract `c`
    function load(address c, bytes32 loc) external view returns (bytes32 val);

}

contract TestHelpers is AddressRegistry, DSTest {

    Hevm hevm = Hevm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    mapping(address => uint256) tokenSlots;

    uint256 USD = 10 ** 6;  // USDC denomination

    constructor() public {
        tokenSlots[DAI]  = 2;
        tokenSlots[USDC] = 9;
    }

    // Manipulate mainnet ERC20 balance
    function erc20_mint(address token, address account, uint256 amount) internal view {
        uint256 balance = IERC20Like(token).balanceOf(account);

        hevm.store(
            token,
            keccak256(abi.encode(account, tokenSlots[token])), // Mint tokens
            bytes32(balance + amount)
        );
    }
}
