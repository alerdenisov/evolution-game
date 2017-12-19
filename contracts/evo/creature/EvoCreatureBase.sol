pragma solidity ^0.4.18;

contract EvoCreatureBase {
  /// @notice Creature data specification
  /// @dev ensure that it fits neatly into exactly two 256-bit words. 
  /// @dev Because of the byte-packing rules used by Ethereum. [Ref](http://solidity.readthedocs.io/en/develop/miscellaneous.html)
  struct Creature {
    /// @notice The timestamp from the block when this creatures came into existence.
    /// @notice {{t:uint32}} is huge enough to hold date before **02/07/2106 @ 6:28am (UTC)**
    /// @dev Timestamp in UNIX specification. [Ref](https://en.wikipedia.org/wiki/Unix_time)
    uint32 birthTime;

    /// @dev pad data struct to fit into two 265 bit words
    uint32  pad0;
    /// @dev pad data struct to fit into two 265 bit words
    uint64  pad1;
    /// @dev pad data struct to fit into two 265 bit words
    uint128 pad2;
  }

  /// @notice List of all existed creatures in game
  /// @dev The array index is a creature ID
  Creature[] internal creatures;

  /// @notice A mapping from creature IDs to the address that owns them. 
  /// @dev All creature have some valid owner address.
  mapping (uint256 => address) public creatureIdToOwner;
}