use "ponytest"
use "time"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_SinglePubSub)
    test(_SinglePubMultipleSub)
    test(_Ventilator)

class iso _SinglePubSub is UnitTest
    fun name(): String => "Single publisher / Single consumer"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(1, h.env.out)

      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 2), 100_000_000, 0)
      timers(consume timer)


class iso _SinglePubMultipleSub is UnitTest
    fun name(): String => "Single publisher / Multiple consumers"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)

      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      c1.consume_message(queue)
      c2.consume_message(queue)
      c2.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 3), 100_000_000, 0)
      timers(consume timer)


class iso _Ventilator is UnitTest
    fun name(): String => "Ventilator"

    fun apply(h: TestHelper) =>
          let p1 = Publisher(1, "Hello World", h.env.out)
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
