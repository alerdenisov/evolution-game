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
  function transferFrom(address _from, address _to, uint256 _creatureId) public {
    // Check for approval and valid ownership
    require(allowed(_creatureId, msg.sender));
    require(ownerOf(_creatureId) == _from);

    // Reassign ownership (also clears pending approvals and emits Transfer event).
    _transfer(_from, _to, _tokenId);
  }

  /// @notice test
  /// @dev hello
  /// @dev second dev
  function transfer(address _to, uint256 _creatureId) public {
    // Safety check to prevent against an unexpected 0x0 default.
    require(_to != address(0));
    // You can only send your own creature.
    require(ownerOf(_creatureId) == msg.sender);

    // Reassign ownership, clear pending approvals, emit Transfer event.
    _transfer(msg.sender, _to, _tokenId);
  }

  // --- Internal logic (state change) ---

  /// @notice Internal method to setup allowance to transfer creature without strict ownership
  /// @param _confidant The address of confidant to transfer creature
  /// @param _creatureId The index of creature
  /// @dev Method doesn't fire any events and just change state! 
  ///      Method doesn't make any checks! 
  function _approve (uint256 _creatureId, address _confidant) internal {
    creatureIndexApprove[_creatureId] = _confidant;
  }

  /// @notice Internal method to transfer a specific creature from one address to another
  /// @dev Assigns ownership of a specific creature to an address.
  function _transfer(address _from, address _to, uint256 _creatureId) internal {
    // there is no way to overflow this (creatures capped in uint32)
    ownershipCreaturesCount[_to]++;
    // transfer ownership
    creatureIdToOwner[_creatureId] = _to;
    // When creating new kittens _from is 0x0, but we can't account that address.
    if (_from != address(0)) {
        ownershipCreaturesCount[_from]--;
        // clear any previously approved ownership exchange
        delete creatureIndexApprove[_creatureId];
    }

    // Emit the transfer event.
    Transfer(_from, _to, _creatureId);
  }

  function _createCreature(
    address _owner,

    uint16 _attack,
    uint16 _defence,
    uint32 _hp,

    uint8 _water,
    uint8 _nature,
    uint8 _toxic,
    uint8 _beast,
    uint8 _chaos,

    uint8 _generation,
    uint16 _seed,
    
    bytes16 _genesis
  ) internal returns (uint256) {
    uint256 creatureId = super._createCreature(_owner, _attack, _defence, _hp, _water, _nature, _toxic, _beast, _chaos, _generation, _seed, _genesis);
    _transfer(address(0x0), _owner, creatureId);
    return creatureId;
  }
}