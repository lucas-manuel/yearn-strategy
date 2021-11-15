// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;

import { IERC20Like, IVaultLike } from "../Interfaces.sol";

contract Depositor {

    function approve(address vault, address account, uint256 amount) external {
        IERC20Like(vault).approve(account, amount);
    }
    
    function deposit(address vault, uint256 amount, address account) external {
        IVaultLike(vault).deposit(amount, account);
    }
}
