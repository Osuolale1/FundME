// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "src/FundMe.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {DeployFundMe} from "script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "script/Interaction.s.sol";

contract FundMeTestInteractionsTest is Test {
  FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STANDING_BALANCE = 10 ether;
    uint256 constant  GAS_PRICE = 1;

    function setUp() external {
        //  fundMe = new FundMe(0x61Ec26aA57019C486B10502285c5A3D4A4750AD7);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STANDING_BALANCE);
    }


    function testUserCanFundInteractions() public {
       
        vm.prank(USER);
        vm.deal(USER, 1e18); 
        
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

         WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

         assert(address(fundMe).balance == 0);
        // assertEq(afterUserBalance + SEND_VALUE, preUserBalance);
        // assertEq(preOwnerBalance + SEND_VALUE, afterOwnerBalance);

    }

}
