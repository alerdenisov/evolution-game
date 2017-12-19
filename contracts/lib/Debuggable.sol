pragma solidity ^0.4.18;

contract Debuggable {
  event Log(string message, string extra);
  function log(string message) internal {
    Log(message, "");
  }

  function log(string message, uint extra) internal {
    Log(message, uintToString(extra));
  }

  function log(string message, bool extra) internal {
    if(extra) {
      Log(message, "true");
    } else {
      Log(message, "false");
    }
  }

  function log(string message, address extra) internal {
    Log(message, addressToString(extra));
  }

  function log(string message, bytes extra) internal {
    Log(message, bytesToString(extra));
  }


  // Utils
  function uintToString(uint v) internal pure returns (string str) {
    uint maxlength = 100;
    bytes memory reversed = new bytes(maxlength);
    uint i = 0;
    while (v != 0) {
      uint remainder = v % 10;
      v = v / 10;
      reversed[i++] = byte(48 + remainder);
    }
    bytes memory s = new bytes(i);
    for (uint j = 0; j < i; j++) {
      s[j] = reversed[i - 1 - j];
    }
    str = string(s);
  }

  function char(byte b) internal pure returns (byte c) {
    if (b < 10) return byte(uint8(b) + 0x30);
    else return byte(uint8(b) + 0x57);
  }

  function addressToString(address x) internal pure returns (string) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
      byte b = byte(uint8(uint(x) / (2**(8*(19 - i)))));
      byte hi = byte(uint8(b) / 16);
      byte lo = byte(uint8(b) - 16 * uint8(hi));
      s[2*i] = char(hi);
      s[2*i+1] = char(lo);            
    }
    return string(s);
  }

  function bytesToString(bytes arr) internal pure returns (string) {
    return string(arr);
  }
}