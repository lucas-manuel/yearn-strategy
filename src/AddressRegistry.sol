// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.11;

contract AddressRegistry {

    /***********************/
    /*** Yearn Contracts ***/
    /***********************/

    address constant public COMP_STRATEGY = 0x342491C093A640c7c2347c4FFA7D8b9cBC84D1EB;
    address constant public YV_DAI        = 0xdA816459F1AB5631232FE5e97a05BBBb94970c95;
    address constant public GOVERNANCE    = 0xFEB4acf3df3cDEA7399794D0869ef76A6EfAff52;
    address constant public YV_USDC       = 0xa354F35829Ae975e850e23e9615b11Da1B3dC4DE;
    
    /************************/
    /*** ERC-20 Contracts ***/
    /************************/

    address constant public CDAI  = 0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643;
    address constant public CUSDC = 0x39AA39c021dfbaE8faC545936693aC917d5E7563;
    address constant public DAI   = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant public USDC  = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    /****************************/
    /*** Maple Core Contracts ***/
    /****************************/

    address constant DL_FACTORY          = 0x2a7705594899Db6c3924A872676E54f041d1f9D8;
    address constant ORTHOGONAL_PD       = 0xA6cCb9483E3E7a737E3a4F5B72a1Ce51838ba122;
    address constant ORTHOGONAL_POOL     = 0xFeBd6F15Df3B73DC4307B1d7E65D46413e710C27;
    address constant ORTHOGONAL_POOL_LIB = 0x2c1C30fb8cC313Ef3cfd2E2bBf2da88AdD902C30;
    address constant ORTHOGONAL_SL       = 0x12B2BbBfAB2CE6789DF5659E9AC27A4A91C96C5C;
    address constant ORTHOGONAL_LL       = 0xB5321058E209E0F6C1216A7c7922B6962681DD77;
    address constant ORTHOGONAL_REWARDS  = 0x7869D7a3B074b5fa484dc04798E254c9C06A5e90;

    /*******************/
    /*** Maple Loans ***/
    /*******************/

    address[14] loans;

    function setupLoans() internal {
        loans[0]  = 0x51F1A31f9a3854c3c0d9815B5109b1B6F61a2fA7;
        loans[1]  = 0x630b503fa7FebCf4478933F732ec1cDeAABBf3EB;
        loans[2]  = 0x4b15ce7F169eEEd2baB30BF0a5C35F6e837792B1;
        loans[3]  = 0x9231F484321CAE1FDdb0f6f28fce890AD4dE6dAA;
        loans[4]  = 0x7357b9DBc70914D2d20C891b581C19A491Ae7D27;
        loans[5]  = 0x6E2Abeb903dFCFCa08189DC9Bf7255c62Cd4dAEd;
        loans[6]  = 0x5038C72B526008Dbb8Cf1e6Ef5A43e096840fe13;
        loans[7]  = 0xE7a34C48a8BaB6Fcd256c2CE1Bf0be9568891Be2;
        loans[8]  = 0xCBE2eA62cCC1b08F189887238dB40E45e27Cb27d;
        loans[9]  = 0x96e295DCD0c3C4397BeCb8E056B2E0cc12732B1b;
        loans[10] = 0x5ddaf75cAd6DC53D452d25FC65fee2beA6f19d9C;
        loans[11] = 0x844dE39093D26eD4fd74aa564148CEA4255f187A;
        loans[12] = 0x05EfF408E8301F8135d703Dd643383d4A6F47000;
        loans[13] = 0xFc394EDC8969f82B530123079de5B88826A3C4c3;
    }
    
}
