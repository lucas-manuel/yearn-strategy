// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;

import { IERC20Like, ILoanLike, IPoolLike, IVaultLike } from "../interfaces/Interfaces.sol";

import { Depositor } from "../accounts/Depositor.sol";
import { Strategy }  from "../TestStrategy.sol";

import { TestHelpers } from "./TestHelpers.sol";

contract YearnTest is TestHelpers {

    Depositor  internal depositor;
    IERC20Like internal usdc;
    IPoolLike  internal pool;
    IVaultLike internal vault;
    Strategy   internal strategy;

    uint256 constant VAULT_BAL          =  2_068_909_364345;  // yvUSDC starting USDC balance
    uint256 constant VAULT_TOTAL_ASSETS =  5_332_815_738773;  // yvUSDC starting assets
    uint256 constant POOL_BAL           = 12_699_456_919465;  // Pool starting cash balance

    function setUp() public {
        depositor = new Depositor();

        usdc  = IERC20Like(USDC);
        pool  = IPoolLike(ORTHOGONAL_POOL);
        vault = IVaultLike(YV_USDC);
        
        strategy = new Strategy(address(vault), ORTHOGONAL_POOL);

        setupLoans();

        // Overwrite `governance` storage slot in yvUSDC vault
        hevm.store(
            YV_USDC,
            bytes32(uint256(7)),
            bytes32(uint256(address(this)))
        );
    }

    function test_strategy() public {

        /***************************************/
        /*** Set up strategy in yvUSDC vault ***/
        /***************************************/

        vault.updateStrategyDebtRatio(COMP_STRATEGY, 0);
        vault.addStrategy(address(strategy), 10000, 0, type(uint256).max - 1, 1000);

        /*********************************/
        /*** Deposit into yvUSDC vault ***/
        /*********************************/

        uint256 depositAmount = 500_000 * USD;

        erc20_mint(USDC, address(depositor), depositAmount);

        assertEq(usdc.balanceOf(address(depositor)),  depositAmount);
        assertEq(usdc.balanceOf(address(vault)),      VAULT_BAL);
        assertEq(usdc.balanceOf(address(strategy)),   0);
        assertEq(usdc.balanceOf(ORTHOGONAL_LL),       POOL_BAL);
        assertEq(vault.balanceOf(address(depositor)), 0);
        assertEq(vault.totalAssets(),                 VAULT_TOTAL_ASSETS);
        assertEq(pool.balanceOf(address(strategy)),   0);

        _logState("Pre-Deposit");

        depositor.approve(address(usdc), address(vault), depositAmount);
        depositor.deposit(address(vault), depositAmount, address(depositor));

        /************************************/
        /*** Call `harvest()` on strategy ***/
        /************************************/

        uint256 totalVaultBalance = VAULT_BAL + depositAmount;

        assertEq(usdc.balanceOf(address(depositor)),  0);
        assertEq(usdc.balanceOf(address(vault)),      totalVaultBalance);
        assertEq(usdc.balanceOf(address(strategy)),   0);
        assertEq(usdc.balanceOf(ORTHOGONAL_LL),       POOL_BAL);
        assertEq(vault.balanceOf(address(depositor)), depositAmount);
        assertEq(vault.totalAssets(),                 VAULT_TOTAL_ASSETS + depositAmount);
        assertEq(pool.balanceOf(address(strategy)),   0);

        hevm.warp(block.timestamp + 150 seconds);

        _logState("Pre-Harvest");

        strategy.harvest();

        assertEq(usdc.balanceOf(address(depositor)),  0);
        assertEq(usdc.balanceOf(address(vault)),      0);
        assertEq(usdc.balanceOf(address(strategy)),   0);
        assertEq(usdc.balanceOf(ORTHOGONAL_LL),       POOL_BAL + totalVaultBalance);
        assertEq(vault.balanceOf(address(depositor)), depositAmount);
        assertEq(vault.totalAssets(),                 VAULT_TOTAL_ASSETS + depositAmount);
        assertEq(pool.balanceOf(address(strategy)),   totalVaultBalance * 1e12);  // Convert to WAD

        _logState("Post-Harvest");

        _makeAllPaymentsAndClaims();

        strategy.harvest();

        _logState("Post-Harvest");
    }

    function _makeAllPaymentsAndClaims() internal {
        for(uint256 i; i < loans.length; ++i) {
            ILoanLike loan = ILoanLike(loans[i]);
            uint256 paymentsRemaining = loan.paymentsRemaining();
            while(paymentsRemaining > 0) {
                _makePayment(loan);
                paymentsRemaining = loan.paymentsRemaining();
            }
            pool.claim(address(loan), DL_FACTORY);
        }
    }

    function _makePayment(ILoanLike loan) internal {
        hevm.warp(loan.nextPaymentDue());
        ( uint256 paymentAmount,,, ) = loan.getNextPayment();
        erc20_mint(USDC, address(this), paymentAmount);
        usdc.approve(address(loan), paymentAmount);
        loan.makePayment();
    } 

    function _logState(string memory description) internal {
        emit log(string(abi.encodePacked("Current State - ", description)));
        emit log("---");
        emit log_named_uint("USDC    Depositor Balance", usdc.balanceOf(address(depositor)));
        emit log_named_uint("USDC    Vault Balance    ", usdc.balanceOf(address(vault)));
        emit log_named_uint("USDC    Strategy Balance ", usdc.balanceOf(address(strategy)));
        emit log_named_uint("USDC    Pool Cash Balance", usdc.balanceOf(ORTHOGONAL_LL));
        emit log_named_uint("yvUSDC  Depositor Balance", vault.balanceOf(address(depositor)));
        emit log_named_uint("yvUSDC  Total Assets     ", vault.totalAssets());
        emit log_named_uint("Pool-LP Strategy Balance ", pool.balanceOf(address(strategy)) / 1e12);  // Convert from 1e18
        emit log(" ");
    }

    // function test_cheat_code_for_slot() public {

    //     uint256 i = 0;

    //     while(vault.governance() != address(this) && i < 100) {
    //         hevm.store(
    //             YV_USDC,
    //             bytes32(uint256(i)), // Mint tokens
    //             bytes32(uint256(address(this)))
    //         );
    //         if(vault.governance() == address(this)) {
    //             emit log_named_uint("slot", i);
    //         }
    //         // bytes32 val = hevm.load(YV_USDC, bytes32(uint256(i)));
    //         // emit log_named_uint("i", i);
    //         // emit log_named_bytes32("val", val);
    //         i += 1;
    //     }
    //     assertTrue(false);
    // }

}
