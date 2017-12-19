pragma solidity ^0.4.18;

import '../../lib/NonFungibleToken.sol';

/// @notice EvoCreature Contract token implementation
/// @notice Implements bunch of methods to provide features to trade/send creatures over network
/// @seealso {{ref: EvoCreatureBase}}
/// @seealso {{ref: NonFungibleToken}}
contract EvoCreatureToken is EvoCreatureBase, NonFungibleToken {
  // --- Implementation of NonFungibleToken ---

  /// @returns true as fact of {{ref:NonFungibleToken}} implementation
  /// @dev Implementation of {{ref:NonFungibleToken}}
  /// @group NonFungibleToken Implementation
  function implementsERC721() public pure returns (bool) { return true; }

  /// @notice the number of Creatures in game 
  /// @returns 
  /// @dev Implementation of {{ref:NonFungibleToken}}
  /// @group NonFungibleToken Implementation
  function totalSupply() public view returns (uint256 total) {
    return creatures.length - 1;
  }
  
  /// @param _owner The owner address to check
  /// @returns The number of Creatures owned by address
  /// @param _owner The address to check
  /// @dev Implementation of {{ref:NonFungibleToken}}
  /// @group NonFungibleToken Implementation
  function balanceOf(address _owner) public view returns (uint256 count) {
      return ownershipTokenCount[_owner];
  }

  /// @notice Returns the address of the owner of a given Creature
  /// @param _tokenId The {{type:uint256}} identity of the Creature
  /// @returns owner The address of current owner of the Creature 
  /// @dev Implementation of {{ref:NonFungibleToken}}
  /// @group NonFungibleToken Implementation
  function ownerOf(uint256 _tokenId) public view returns (address owner) {
    owner = creatureIdToOwner[_tokenId];
    require(owner != address(0));
  }
}