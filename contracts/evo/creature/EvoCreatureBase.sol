pragma solidity ^0.4.18;

import '../../lib/Debuggable.sol';

/// @title Base contract of EvoCreature structure
/// @author Aler Denisov <aler.zampillo@gmail.com>
contract EvoCreatureBase is Debuggable {
  uint16 constant MIN_ATTACK = 15;
  uint16 constant MAX_ATTACK = 25;
  uint16 constant MIN_DEF    = 0;
  uint16 constant MAX_DEF    = 10;
  uint32 constant MIN_HP     = 50;
  uint32 constant MAX_HP     = 200;
  uint8 constant MIN_GEN     = 0;
  uint8 constant MAX_GEN     = 5;

  /// @notice Creature data specification
  /// @dev Ensure that it fits neatly into exactly two 256-bit words. 
  ///      Because of the byte-packing rules used by Ethereum. 
  ///      [Ref](http://solidity.readthedocs.io/en/develop/miscellaneous.html)
  struct Creature {
    /// @dev The timestamp from the block when this creatures came into existence.
    ///  Uint32 is huge enough to hold date before **02/07/2106 @ 6:28am (UTC)**
    ///  Timestamp in UNIX specification. [Ref](https://en.wikipedia.org/wiki/Unix_time)
    uint32 birthTime;                                         // 000 – 032

    /// @dev Influence data (64 bits)
    uint8 feed;           // |                                // 032 – 040
    uint8 moral;          // |> Trainer affection             // 040 – 048
    uint8 injure;         // |                                // 048 – 056

    uint8 water;          // |                                // 056 – 064
    uint8 nature;         // |                                // 064 – 072
    uint8 toxic;          // |> Environment affection         // 072 – 080
    uint8 beast;          // |                                // 080 – 088
    uint8 chaos;          // |                                // 088 – 096

    /// @dev Progress of evolution
    uint32 generationExperience;                              // 096 – 128

    uint16 attack;                                            // 128 – 144 
    uint16 defence;                                           // 144 – 160
    uint32 healthPoints;                                      // 160 – 176

    uint8 geneWater;          // |                            // 176 – 184
    uint8 geneNature;         // |                            // 184 – 192
    uint8 geneToxic;          // |> Environment affection     // 200 – 208
    uint8 geneBeast;          // |                            // 216 – 224
    uint8 geneChaos;          // |                            // 224 – 232

    uint8 generation;                                         // 232 - 240
    uint16 seed;                                              // 240 - 256

    bytes16 genesis;                                          // 256 – 272
  }

  /// @notice List of all existed creatures in game
  /// @dev The array index is a creature ID 
  Creature[] internal creatures;

  /// @notice Birth event fires each time when new creature is created
  event Birth(
      uint32 indexed creatureId,
      uint16 attack, uint16 defence, uint32 hp,
      uint40 genes, uint16 seed, bytes16 genesis
  );

  // --- Internal methods ---
  function _createCreature(uint256 salt) internal returns (uint256) {
    uint16 seed =       uint16(_random(salt + 0) % (2 ** 16));
    uint16 attack =     uint16(_randomRange(salt + 1, MIN_ATTACK, MAX_ATTACK));
    uint16 defence =    uint16(_randomRange(salt + 2, MIN_DEF, MAX_DEF));
    uint32 hp =         uint32(_randomRange(salt + 3, MIN_HP, MAX_HP));

    uint40 genes =      uint40(_randomRange(salt + 4, MIN_GEN, MAX_GEN) << 0);          // water
    genes |=            uint40(_randomRange(salt + 5, MIN_GEN, MAX_GEN) << 8);          // nature
    genes |=            uint40(_randomRange(salt + 6, MIN_GEN, MAX_GEN) << 16);         // toxic
    genes |=            uint40(_randomRange(salt + 7, MIN_GEN, MAX_GEN) << 24);         // beast
    genes |=            uint40(_randomRange(salt + 8, MIN_GEN, MAX_GEN) << 32);         // chaos

    bytes16 genesis = bytes16(1);

    Creature memory creature = Creature({
      birthTime: uint32(block.timestamp),
      feed: 128,
      moral: 128,
      injure: 0,
      
      water: 0,
      nature: 0,
      toxic: 0,
      beast: 0,
      chaos: 0,

      generationExperience: 0,
      
      attack: attack,
      defence: defence,
      healthPoints: hp,
      
      geneWater: uint8(genes >> 0),
      geneNature: uint8(genes >> 8),
      geneToxic: uint8(genes >> 16),
      geneBeast: uint8(genes >> 24),
      geneChaos: uint8(genes >> 32),
      
      generation: 0,
      seed: seed,

      genesis: genesis
    });

    uint256 creatureId = creatures.push(creature) - 1;
    
    require(creatureId < 2 ** 32);

    // log("Create Creature", creatureId);
    // log("  attack", uint256(attack));
    // log("  defence", uint256(defence));
    // log("  healpoints", uint256(hp));
    // log("  water", uint256(water));
    // log("  nature", uint256(nature));
    // log("  toxic", uint256(toxic));
    // log("  beast", uint256(beast));
    // log("  chaos", uint256(chaos));

    Birth(
      uint32(creatureId),
      attack, defence, hp,
      genes, seed, genesis
    );

    return creatureId;
  }

  function _randomRange(uint salt, uint min, uint max) internal view returns (uint) {
    return _range(_random(salt), min, max);
  }

  function _random(uint salt) internal view returns (uint) {
    return uint(keccak256(block.blockhash(block.number - 1) & bytes32(salt)));
  }

  function _range(uint random, uint min, uint max) internal pure returns (uint) {
    return min + (random % max - min);
  }
}