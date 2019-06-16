use "ponytest"
use "time"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_VentilatorNormalOrderTestSinglePublisherSingleConsumer)
    test(_VentilatorInterleavedTestSinglePublisherSingleConsumer)
    test(_VentilatorInverseOrderTestSinglePublisherSingleConsumer)
    
    test(_VentilatorNormalOrderTestMultiplePublishersSingleConsumer)
    test(_VentilatorInterleavedTestMultiplePublishersSingleConsumer)
    test(_VentilatorInverseOrderTestMultiplePublishersSingleConsumer)

    test(_VentilatorNormalOrderTestSinglePublisherMultipleConsumers)
    test(_VentilatorInterleavedTestSinglePublisherMultipleConsumers)
    test(_VentilatorInverseOrderTestSinglePublisherMultipleConsumers)

    test(_VentilatorNormalOrderTestMultiplePublishersMultipleConsumers)
    test(_VentilatorInterleavedTestMultiplePublishersMultipleConsumers)
    test(_VentilatorInverseOrderTestMultiplePublishersMultipleConsumers)


class iso _VentilatorNormalOrderTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Ventilator: Single publisher / Single consumer: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(1, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c.subscribe_ventilator(v)

      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      v.consume_message()
      v.consume_message()

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 2), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorInterleavedTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Ventilator: Single publisher / Single consumer: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(1, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c.subscribe_ventilator(v)

      p.publish_message(queue)
      v.consume_message()
      p.publish_message(queue)
      p.publish_message(queue)
      v.consume_message()
      v.consume_message()
      p.publish_message(queue)
      v.consume_message()

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 4), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorInverseOrderTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Ventilator: Single publisher / Single consumer: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(1, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c.subscribe_ventilator(v)

      v.consume_message()
      v.consume_message()
      v.consume_message()
      v.consume_message()
      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 3), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorNormalOrderTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Ventilator: Multiple publishers / Single consumer: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(1, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c.subscribe_ventilator(v)

      p2.publish_message(queue)
      p1.publish_message(queue)
      p2.publish_message(queue)
      v.consume_message()
      v.consume_message()

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 2), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorInterleavedTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Ventilator: Multiple publishers / Single consumer: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(1, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c.subscribe_ventilator(v)

      p1.publish_message(queue)
      v.consume_message()
      p1.publish_message(queue)
      p2.publish_message(queue)
      v.consume_message()
      v.consume_message()
      p1.publish_message(queue)
      v.consume_message()

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 4), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorInverseOrderTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Ventilator: Multiple publishers / Single consumer: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(1, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c.subscribe_ventilator(v)

      v.consume_message()
      v.consume_message()
      v.consume_message()
      v.consume_message()
      p2.publish_message(queue)
      p1.publish_message(queue)
      p1.publish_message(queue)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 3), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorNormalOrderTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Ventilator: Single publisher / Multiple consumers: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c1.subscribe_ventilator(v)
      c1.subscribe_ventilator(v)

      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      v.consume_message()
      v.consume_message()

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 2*2), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorInterleavedTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Ventilator: Single publisher / Multiple consumers: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c1.subscribe_ventilator(v)
      c1.subscribe_ventilator(v)

      p.publish_message(queue)
      v.consume_message()
      p.publish_message(queue)
      p.publish_message(queue)
      v.consume_message()
      v.consume_message()
      p.publish_message(queue)
      v.consume_message()

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 4*2), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorInverseOrderTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Ventilator: Single publisher / Multiple consumers: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c1.subscribe_ventilator(v)
      c1.subscribe_ventilator(v)

      v.consume_message()
      v.consume_message()
      v.consume_message()
      v.consume_message()
      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1;c2], 3*2), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorNormalOrderTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Ventilator: Multiple publishers / Multiple consumers: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c1.subscribe_ventilator(v)
      c1.subscribe_ventilator(v)

      p2.publish_message(queue)
      p2.publish_message(queue)
      p1.publish_message(queue)
      v.consume_message()
      v.consume_message()

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 2*2), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorInterleavedTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Ventilator: Multiple publishers / Multiple consumers: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c1.subscribe_ventilator(v)
      c1.subscribe_ventilator(v)

      p2.publish_message(queue)
      v.consume_message()
      p1.publish_message(queue)
      p1.publish_message(queue)
      v.consume_message()
      v.consume_message()
      p1.publish_message(queue)
      v.consume_message()

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 4*2), 100_000_000, 0)
      timers(consume timer)


class iso _VentilatorInverseOrderTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Ventilator: Multiple publishers / Multiple consumers: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let v = Ventilator(1, queue, h.env.out)

      c1.subscribe_ventilator(v)
      c1.subscribe_ventilator(v)

      v.consume_message()
      v.consume_message()
      v.consume_message()
      v.consume_message()
      p1.publish_message(queue)
      p2.publish_message(queue)
      p2.publish_message(queue)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1;c2], 3*2), 100_000_000, 0)
      timers(consume timer)
