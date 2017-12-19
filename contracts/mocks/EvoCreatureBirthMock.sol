pragma solidity ^0.4.18;

import '../evo/creature/EvoCreatureBirth.sol';

contract EvoCreatureBirthMock is EvoCreatureBirth {
  function giveBirth() public returns (uint256 creatureId, Creature creature) {
    creatureId = _giveBirth(42); 
    creature = creatures[creatureId];
  }

  function giveBirthTo5() public {
    _giveBirth(42);
    _giveBirth(43);
    _giveBirth(44);
    _giveBirth(45);
    _giveBirth(46);
  }
}