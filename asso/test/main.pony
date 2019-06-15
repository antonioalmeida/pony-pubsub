use "ponytest"
use "promises"
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
        let pu = Publisher(1, "ola", h.env.out)
        let queue = Queue(1, h.env.out)
        let c = Consumer(1, h.env.out)

        pu.publish_message(queue)
        c.consume_message(queue)

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
