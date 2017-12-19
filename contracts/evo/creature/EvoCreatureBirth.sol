pragma solidity ^0.4.18;

import './EvoCreatureToken.sol';

/// @title Implementation of birth logic for EvoCreature
contract EvoCreatureBirth is EvoCreatureToken {

  function _giveBirth(uint salt) internal returns (uint256 creatureId) {
    return _createCreature(salt);
  }
}