pragma solidity ^0.4.18;

import '../../lib/NonFungibleToken.sol';
import './EvoCreatureBase.sol';

/// @title Implementation of Non-Fungible Token for EvoCreature
/// @author Aler Denisov <aler.zampillo@gmail.com>
contract EvoCreatureToken is EvoCreatureBase, NonFungibleToken {
  // --- Token Related Store ---
  
  /// @notice The map of creature confidants
  /// @param _index The index of creature
  /// @return The address of confidant to transfer creature, or 0 if no confidants is approved
  mapping (uint256 => address) creatureIndexApprove;
  
  /// @notice The map of owner creatures count
  /// @param _index The address of owner to lookup
  /// @return Amount of creatures owned by providen address
  mapping (address => uint256) ownershipCreaturesCount;
  
  // --- Implementation of NonFungibleToken ---
  /// @notice Flag of implementation NonFungibleToken
  /// @return true as fact of [NonFungibleToken](/NonFungibleToken) implementation
  /// @dev [NonFungibleToken](/NonFungibleToken) Implementation
  function implementsNonFungibleToken () public pure returns (bool) { return true; }

  /// @notice the number of Creatures in game 
  /// @return the number of Creatures in game 
  /// @dev [NonFungibleToken](/NonFungibleToken) Implementation
  function totalSupply () public view returns (uint256 total) {
    return creatures.length - 1;
  }
  
  /// @notice The number of Creatures owned by address
  /// @param _owner The owner address to check
  /// @param _owner The address to check
  /// @return The number of Creatures owned by address
  /// @dev [NonFungibleToken](/NonFungibleToken) Implementation
  function balanceOf (address _owner) public view returns (uint256 count) {
      return ownershipCreaturesCount[_owner];
  }

  /// @notice Returns the address of the owner of a given Creature
  /// @param _creatureId The uint256 identity of the Creature
  /// @return owner The address of current owner of the Creature 
  /// @dev [NonFungibleToken](/NonFungibleToken) Implementation
  function ownerOf (uint256 _creatureId) public view returns (address owner) {
    owner = creatureIdToOwner[_creatureId];
    require(owner != address(0));
  }

  /// @notice Setup allowance rule to transfer creature for providen confidant
  /// @param _confidant The address of confidant to transfer creature
  /// @param _creatureId The index of creature
  /// @dev [NonFungibleToken](/NonFungibleToken) Implementation
  function approve (address _confidant, uint256 _creatureId) public {
    // Only an owner can grant transfer approval.
    require(ownerOf(_creatureId) == msg.sender);

    // Register the approval.
    _approve(_creatureId, _confidant);

    // Emit approval event.
    Approval(msg.sender, _confidant, _creatureId);
  }

  /// @notice Returns `true` if providen address is known as a confidant of creature, `false` overwise
  /// @param _creatureId The index of creature
  /// @param _who The address to check as a confidant  
  function allowed (uint256 _creatureId, address _who) public view returns (bool) {
    return creatureIndexApprove[_creatureId] == _who;
  }

  /// @notice test
  ///  multiple
  function transferFrom(address _from, address _to, uint256 _tokenId) public {

  }

  /// @notice test
  /// @dev hello
  /// @dev second dev
  function transfer(address _to, uint256 _tokenId) public {

  }

  // --- Internal logic (state change) ---

  /**
    @notice Internal method to setup allowance to transfer creature without strict ownership
    @param _confidant The address of confidant to transfer creature
    @param _creatureId The index of creature
    @dev Method doesn't fire any events and just change state! 
         Method doesn't make any checks! 
  */
  function _approve (uint256 _creatureId, address _confidant) internal {
    creatureIndexApprove[_creatureId] = _confidant;
  }
}