import { inTransaction } from './helpers/expectEvents'
const DebuggableMock = artifacts.require('./DebuggableMock.sol')

contract('Debuggable', ([ coinbase ]) => {
  let debuggable
  before(async () => {
    debuggable = await DebuggableMock.new()
  })

  it('simple log', async () => {
    const events = await inTransaction(
      debuggable.testSimpleLog(),
      'Log'
    )

    assert(events[0].args.message === 'hello world', `unxpected log message: ${events[0].args.message}`)
  })

  it('address log', async () => {
    const events = await inTransaction(
      debuggable.testAddressLog({ from: coinbase }),
      'Log'
    )

    assert(`0x${events[0].args.extra}` === coinbase, `unxpected address logged: ${events[0].args.extra}`)
    assert(`0x${events[1].args.extra}` === debuggable.address, `unxpected address logged: ${events[1].args.extra}`)
  })

  it('bool log', async () => {
    const events = await inTransaction(
      debuggable.testBoolLog(),
      'Log'
    )

    assert(events[0].args.extra === 'true')
    assert(events[1].args.extra === 'false')
  })

  it('value log', async () => {
    const events = await inTransaction(
      debuggable.testValueLog(),
      'Log'
    )

    assert(events[0].args.extra === new web3.BigNumber(1e18).toString(10))
    console.log(`timestamp is ${events[1].args.extra}`)
  })
  // function testSimpleLog() public {
  //   log("hello world");
  // }

  // function testAddressLog() public {
  //   log("called by", msg.sender);
  //   log("contract at", address(this));
  // }

  // function testBoolLog() public {
  //   log("should be true", true);
  //   log("should be false", true);
  // }

  // function testValueLog() public {
  //   log("timestamp is", block.timestamp);
  // }
})