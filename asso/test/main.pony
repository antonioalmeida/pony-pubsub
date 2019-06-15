use "ponytest"
use "promises"
use "time"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestAdd)
    test(_TestSub)
    test(_SinglePubSub)

class iso _TestAdd is UnitTest
  fun name(): String => "addition"

  fun apply(h: TestHelper) =>
    h.assert_eq[U32](4, 2 + 2)

class iso _TestSub is UnitTest
  fun name(): String => "subtraction"

  fun apply(h: TestHelper) =>
    h.assert_eq[U32](2, 4 - 2)

class iso _SinglePubSub is UnitTest
    fun name(): String => "single publish/consume"

    fun apply(h: TestHelper) =>
      h.long_test(5_000_000_000)

      let p = Publisher("publisher message", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(h.env.out)

      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, c), 500_000_000, 0)
      timers(consume timer)


class MessageChecker is TimerNotify
  let _h: TestHelper
  let _c: Consumer

  new iso create(h: TestHelper, c: Consumer) =>
    _h = h
    _c = c

  fun ref apply(timer: Timer, count: U64): Bool =>
    let promise = Promise[USize]
    promise.next[None]({(n: USize val) =>
      _h.env.out.print("Messages consumed: " + n.string())
      _h.assert_eq[USize](2, 2)
      _h.complete(true)
    })

    _c.get_number_messages(promise)
    true
