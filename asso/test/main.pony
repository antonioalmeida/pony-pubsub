use "ponytest"
use "time"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_NormalOrderTestSinglePublisherSingleConsumer)
    test(_InterleavedTestSinglePublisherSingleConsumer)
    test(_InverseOrderTestSinglePublisherSingleConsumer)
    
    test(_NormalOrderTestMultiplePublishersSingleConsumer)
    test(_InterleavedTestMultiplePublishersSingleConsumer)
    test(_InverseOrderTestMultiplePublishersSingleConsumer)

    test(_NormalOrderTestSinglePublisherMultipleConsumers)
    test(_InterleavedTestSinglePublisherMultipleConsumers)
    test(_InverseOrderTestSinglePublisherMultipleConsumers)

    test(_NormalOrderTestMultiplePublishersMultipleConsumers)
    test(_InterleavedTestMultiplePublishersMultipleConsumers)
    test(_InverseOrderTestMultiplePublishersMultipleConsumers)


class iso _NormalOrderTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Single publisher / Single consumer: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher("Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(h.env.out)

      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 2), 100_000_000, 0)
      timers(consume timer)


class iso _InterleavedTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Single publisher / Single consumer: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher("Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(h.env.out)

      p.publish_message(queue)
      c.consume_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)
      p.publish_message(queue)
      c.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 4), 100_000_000, 0)
      timers(consume timer)


class iso _InverseOrderTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Single publisher / Single consumer: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher("Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(h.env.out)

      c.consume_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 3), 100_000_000, 0)
      timers(consume timer)


class iso _NormalOrderTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Multiple publishers / Single consumer: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher("Hello World 1", h.env.out)
      let p2 = Publisher("Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(h.env.out)

      p2.publish_message(queue)
      p1.publish_message(queue)
      p2.publish_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 2), 100_000_000, 0)
      timers(consume timer)


class iso _InterleavedTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Multiple publishers / Single consumer: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher("Hello World 1", h.env.out)
      let p2 = Publisher("Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(h.env.out)

      p1.publish_message(queue)
      c.consume_message(queue)
      p1.publish_message(queue)
      p2.publish_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)
      p1.publish_message(queue)
      c.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 4), 100_000_000, 0)
      timers(consume timer)


class iso _InverseOrderTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Multiple publishers / Single consumer: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher("Hello World 1", h.env.out)
      let p2 = Publisher("Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c = Consumer(h.env.out)

      c.consume_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)
      c.consume_message(queue)
      p2.publish_message(queue)
      p1.publish_message(queue)
      p1.publish_message(queue)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 3), 100_000_000, 0)
      timers(consume timer)


class iso _NormalOrderTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Single publisher / Multiple consumers: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher("Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(h.env.out)
      let c2 = Consumer(h.env.out)

      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      c1.consume_message(queue)
      c2.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 2), 100_000_000, 0)
      timers(consume timer)


class iso _InterleavedTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Single publisher / Multiple consumers: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher("Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(h.env.out)
      let c2 = Consumer(h.env.out)

      p.publish_message(queue)
      c2.consume_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      c1.consume_message(queue)
      c1.consume_message(queue)
      p.publish_message(queue)
      c2.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 4), 100_000_000, 0)
      timers(consume timer)


class iso _InverseOrderTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Single publisher / Multiple consumers: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher("Hello World", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(h.env.out)
      let c2 = Consumer(h.env.out)

      c1.consume_message(queue)
      c1.consume_message(queue)
      c2.consume_message(queue)
      c1.consume_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      p.publish_message(queue)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1;c2], 3), 100_000_000, 0)
      timers(consume timer)


class iso _NormalOrderTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Multiple publishers / Multiple consumers: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher("Hello World 1", h.env.out)
      let p2 = Publisher("Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(h.env.out)
      let c2 = Consumer(h.env.out)

      p2.publish_message(queue)
      p2.publish_message(queue)
      p1.publish_message(queue)
      c1.consume_message(queue)
      c2.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 2), 100_000_000, 0)
      timers(consume timer)


class iso _InterleavedTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Multiple publishers / Multiple consumers: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher("Hello World 1", h.env.out)
      let p2 = Publisher("Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(h.env.out)
      let c2 = Consumer(h.env.out)

      p2.publish_message(queue)
      c2.consume_message(queue)
      p1.publish_message(queue)
      p1.publish_message(queue)
      c1.consume_message(queue)
      c1.consume_message(queue)
      p1.publish_message(queue)
      c2.consume_message(queue)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 4), 100_000_000, 0)
      timers(consume timer)


class iso _InverseOrderTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Multiple publishers / Multiple consumers: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher("Hello World 1", h.env.out)
      let p2 = Publisher("Hello World 2", h.env.out)
      let queue = Queue(5, h.env.out)
      let c1 = Consumer(h.env.out)
      let c2 = Consumer(h.env.out)

      c1.consume_message(queue)
      c1.consume_message(queue)
      c2.consume_message(queue)
      c1.consume_message(queue)
      p1.publish_message(queue)
      p2.publish_message(queue)
      p2.publish_message(queue)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1;c2], 3), 100_000_000, 0)
      timers(consume timer)