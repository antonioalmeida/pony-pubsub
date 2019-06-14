use "ponytest"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestAdd)
    test(_TestSub)

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
        let p = Publisher("ola", h.env.out)
        let queue = Queue(1, h.env.out)
        let c = Consumer(h.env.out)

        p.publish_message(queue)
        c.consume_message(queue)


