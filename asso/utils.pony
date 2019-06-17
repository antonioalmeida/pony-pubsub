use "ponytest"
use "time"

actor MessageCounter
  let _expected_messages: USize
  let _n_consumers: USize
  var _consumers_counter: USize
  var _message_counter: USize
  let _helper: TestHelper

  new create(helper: TestHelper, expected_messages: USize, n_consumers: USize) =>
    _consumers_counter = 0
    _message_counter = 0
    _helper = helper
    _expected_messages = expected_messages
    _n_consumers = n_consumers

  be on_consumer_report(n: USize) =>
    _consumers_counter = _consumers_counter + 1
    _message_counter = _message_counter + n

    if (_message_counter == _expected_messages) and (_n_consumers == _consumers_counter) then
      _helper.complete(true)
    elseif (_message_counter > _expected_messages) or
         ((_n_consumers == _consumers_counter) and (_message_counter < _expected_messages)) then
      _helper.fail()
    end


class MessageChecker is TimerNotify
  let _helper: TestHelper
  let _consumers: Array[Consumer]
  let _expected_messages: USize
  let _n_consumers: USize
  let _message_counter: MessageCounter

  new iso create(helper: TestHelper, consumers: Array[Consumer] iso, expected_messages: USize) =>
    _helper = helper
    _expected_messages = expected_messages
    _consumers = (consume consumers).clone()
    _n_consumers = _consumers.size()
    _message_counter = MessageCounter(_helper, _expected_messages, _n_consumers)

  fun ref apply(timer: Timer, count: U64): Bool =>
    for consumer in _consumers.values() do
      consumer.report_messages(_message_counter)
    end
    true
