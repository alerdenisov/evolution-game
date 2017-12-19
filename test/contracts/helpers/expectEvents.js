const assert = require('chai').assert;

const inLogs = async (logs, eventName) => {
  const events = logs.filter(e => e.event === eventName)
  assert(events.length > 0, `events not found`)

  return events
}

const inTransaction = async (tx, eventName) => {
  const { logs } = await tx
  return inLogs(logs, eventName)
}

module.exports = {
  inLogs,
  inTransaction,
}