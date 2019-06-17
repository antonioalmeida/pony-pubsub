use "ponytest"
use "time"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_BrokerNormalOrderTestSinglePublisherSingleConsumer)
    test(_BrokerInterleavedTestSinglePublisherSingleConsumer)
    test(_BrokerInverseOrderTestSinglePublisherSingleConsumer)
    
    test(_BrokerNormalOrderTestMultiplePublishersSingleConsumer)
    test(_BrokerInterleavedTestMultiplePublishersSingleConsumer)
    test(_BrokerInverseOrderTestMultiplePublishersSingleConsumer)

    test(_BrokerNormalOrderTestSinglePublisherMultipleConsumers)
    test(_BrokerInterleavedTestSinglePublisherMultipleConsumers)
    test(_BrokerInverseOrderTestSinglePublisherMultipleConsumers)

    test(_BrokerNormalOrderTestMultiplePublishersMultipleConsumers)
    test(_BrokerInterleavedTestMultiplePublishersMultipleConsumers)
    test(_BrokerInverseOrderTestMultiplePublishersMultipleConsumers)


class iso _BrokerNormalOrderTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Broker: Single publisher / Single consumer: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let c = Consumer(1, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c, p)

      p.publish_message(b)
      p.publish_message(b)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 2), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerInterleavedTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Broker: Single publisher / Single consumer: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let c = Consumer(1, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c, p)

      p.publish_message(b)
      p.publish_message(b)
      p.publish_message(b)
      p.publish_message(b)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 4), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerInverseOrderTestSinglePublisherSingleConsumer is UnitTest
    fun name(): String => "Broker: Single publisher / Single consumer: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let c = Consumer(1, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c, p)

      p.publish_message(b)
      p.publish_message(b)
      p.publish_message(b)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 3), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerNormalOrderTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Broker: Multiple publishers / Single consumer: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let c = Consumer(1, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c, p1)
      b.add_subscription(c, p2)

      p2.publish_message(b)
      p1.publish_message(b)
      p2.publish_message(b)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 3), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerInterleavedTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Broker: Multiple publishers / Single consumer: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let c = Consumer(1, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c, p1)
      b.add_subscription(c, p2)

      p1.publish_message(b)
      p1.publish_message(b)
      p2.publish_message(b)
      p1.publish_message(b)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 4), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerInverseOrderTestMultiplePublishersSingleConsumer is UnitTest
    fun name(): String => "Broker: Multiple publishers / Single consumer: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let c = Consumer(1, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c, p1)
      b.add_subscription(c, p2)

      p2.publish_message(b)
      p1.publish_message(b)
      p1.publish_message(b)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c], 3), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerNormalOrderTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Broker: Single publisher / Multiple consumers: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c1, p)
      b.add_subscription(c2, p)

      p.publish_message(b)
      p.publish_message(b)
      p.publish_message(b)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 3*2), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerInterleavedTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Broker: Single publisher / Multiple consumers: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c1, p)
      b.add_subscription(c2, p)

      p.publish_message(b)
      p.publish_message(b)
      p.publish_message(b)
      p.publish_message(b)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 4*2), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerInverseOrderTestSinglePublisherMultipleConsumers is UnitTest
    fun name(): String => "Broker: Single publisher / Multiple consumers: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p = Publisher(1, "Hello World", h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c1, p)
      b.add_subscription(c2, p)

      p.publish_message(b)
      p.publish_message(b)
      p.publish_message(b)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1;c2], 3*2), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerNormalOrderTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Broker: Multiple publishers / Multiple consumers: Normal Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c1, p1)
      b.add_subscription(c1, p2)
      b.add_subscription(c2, p1)

      p2.publish_message(b)
      p2.publish_message(b)
      p1.publish_message(b)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 4), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerInterleavedTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Broker: Multiple publishers / Multiple consumers: Interleaved"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c1, p1)
      b.add_subscription(c2, p1)
      b.add_subscription(c2, p2)

      p2.publish_message(b)
      p1.publish_message(b)
      p1.publish_message(b)
      p1.publish_message(b)

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1; c2], 7), 100_000_000, 0)
      timers(consume timer)


class iso _BrokerInverseOrderTestMultiplePublishersMultipleConsumers is UnitTest
    fun name(): String => "Broker: Multiple publishers / Multiple consumers: Inverse Order"

    fun apply(h: TestHelper) =>
      h.long_test(1_000_000_000)

      let p1 = Publisher(1, "Hello World 1", h.env.out)
      let p2 = Publisher(2, "Hello World 2", h.env.out)
      let c1 = Consumer(1, h.env.out)
      let c2 = Consumer(2, h.env.out)
      let b = Broker(1, h.env.out)

      b.add_subscription(c1, p2)
      b.add_subscription(c2, p1)

      p1.publish_message(b)
      p2.publish_message(b)
      p2.publish_message(b)
      

      let timers = Timers
      let timer = Timer(MessageChecker(h, [c1;c2], 3), 100_000_000, 0)
      timers(consume timer)
