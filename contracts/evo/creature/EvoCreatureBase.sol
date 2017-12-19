pragma solidity ^0.4.18;

/// @title Base contract of EvoCreature structure
/// @author Aler Denisov <aler.zampillo@gmail.com>
contract EvoCreatureBase {
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

  /// @notice A mapping from creature IDs to the address that owns them. 
  /// @dev All creature have some valid owner address.
  mapping (uint256 => address) public creatureIdToOwner;

  event Birth(
      address indexed _owner,
      uint256 indexed creatureId,
      uint16 _attack, uint16 _defence, uint32 _hp,
      uint8 _water, uint8 _nature, uint8 _toxic, uint8 _beast, uint8 _chaos,
      uint8 _generation, uint16 _seed,
      bytes16 _genesis
  );

  // --- Internal methods ---

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
      
      attack: _attack,
      defence: _defence,
      healthPoints: _hp,
      
      geneWater: _water,
      geneNature: _nature,
      geneToxic: _toxic,
      geneBeast: _beast,
      geneChaos: _chaos,
      
      generation: _generation,
      seed: _seed,

      genesis: _genesis
    });

    uint256 creatureId = creatures.push(creature) - 1;
    Birth(
      _owner,
      creatureId,
      _attack, _defence, _hp,
      _water, _nature, _toxic, _beast, _chaos,
      _generation, _seed,
      _genesis
    );

    return creatureId;
  }
}