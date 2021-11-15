// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;

interface IERC20Like {
    
    function name() external view returns (string memory);
    
    function symbol() external view returns (string memory);
    
    function decimals() external view returns (uint8);
    
    function totalSupply() external view returns (uint256);
    
    function balanceOf(address account) external view returns (uint256);
    
    function allowance(address owner, address spender) external view returns (uint256);
    
    function approve(address spender, uint256 amount) external returns (bool);
    
    function transfer(address recipient, uint256 amount) external returns (bool);
    
    function transferFrom(address owner, address recipient, uint256 amount) external returns (bool);

}

interface IVaultLike is IERC20Like {

    function addStrategy(
        address strategy,
        uint256 debtRatio,
        uint256 minDebtPerHarvest,
        uint256 maxDebtPerHarvest,
        uint256 performanceFee
    ) external;

    function deposit(uint256 amount, address account) external;

    function updateStrategyDebtRatio(address strategy, uint256 debtRatio) external;

}
