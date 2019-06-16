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
    test(_SinglePubSub)
    test(_Ventilator)

class iso _SinglePubSub is UnitTest
    fun name(): String => "single publish/consume"

    fun apply(h: TestHelper) =>
      h.long_test(5_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(1, h.env.out)

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

class iso _Ventilator is UnitTest
    fun name(): String => "ventilator test"

    fun apply(h: TestHelper) =>
          let p1 = Publisher(1, "ola", h.env.out)
          let queue = Queue(10, h.env.out)
          let consumer1 = Consumer(1, h.env.out)
          let consumer2 = Consumer(2, h.env.out)
          let consumer3 = Consumer(3, h.env.out)
          let consumer4 = Consumer(3, h.env.out)

          let v1 = Ventilator(1, queue, h.env.out)
          p1.publish_message_v(v1)
   
          consumer1.subscribe_ventilator(v1)
          consumer2.subscribe_ventilator(v1)
          consumer3.subscribe_ventilator(v1)
          consumer4.subscribe_ventilator(v1)
    
          v1.consume_message()
