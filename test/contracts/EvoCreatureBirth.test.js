import { inTransaction } from './helpers/expectEvents'
const EvoCreatureBirthMock = artifacts.require('./EvoCreatureBirthMock.sol')

function printCreature (creature) {
  const { 
    creatureId,
    attack,
    defence,
    hp,
    genes,
    seed,
    genesis
  } = creature

  //     nature                        water
  // 00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  
  
  const water  = (genes.toNumber() >> 0)  % (2 ** 8)
  const nature = (genes.toNumber() >> 8)  % (2 ** 8)
  const toxic  = (genes.toNumber() >> 16) % (2 ** 8)
  const beast  = (genes.toNumber() >> 24) % (2 ** 8)
  const chaos  = (genes.toNumber() >> 32) % (2 ** 8)

  console.log(`
CREATURE   
  id:       ${creatureId.toString(10)}
  attack:   ${attack.toString(10)}
  defence:  ${defence.toString(10)}
  hp:       ${hp.toString(10)}
  
  GENES:
  water:  ${water}
  nature: ${nature}
  toxic:  ${toxic}
  beast:  ${beast}
  chaos:  ${chaos}
  
  seed:   ${seed.toString(10)}`)
}

contract('EvoCreatureBirth', ([coinbase]) => {
  let evoCreatures
  before(async () => {
    evoCreatures = await EvoCreatureBirthMock.new()
  })
  it('should to create a creature', async () => {
    const events = await inTransaction(
      evoCreatures.giveBirth(),
      'Birth'
    )

    assert(events.length > 0, 'Birth log not found')
  })
  it('should to create five different creatures', async () => {
    const events = await inTransaction(
      evoCreatures.giveBirthTo5(),
      'Birth'
    )

    let uniqueSeeds = [...new Set(events.map(evt => evt.args.seed.toNumber()))];
    assert(uniqueSeeds.length === events.length)
  })
})