pragma solidity ^0.4.18;

import '../lib/Debuggable.sol';

contract DebuggableMock is Debuggable {
  function testSimpleLog() public {
    log("hello world");
  }

  function testAddressLog() public {
    log("called by", msg.sender);
    log("contract at", address(this));
  }

  function testBoolLog() public {
    log("should be true", true);
    log("should be false", false);
  }

  function testValueLog() public {
    log("log 1 ETH", uint(1 ether));
    log("timestamp is", block.timestamp);
  }
}