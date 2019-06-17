use "time"

actor Main
new create(env: Env) =>

    let p1 = Publisher("ola", env.out)
    let p2 = Publisher("adeus", env.out)
    let queue = Queue(10, env.out)
    let c1 = Consumer(env.out)

    let timers = Timers
    let timer_p1 = Timer(PublisherGen(p1, queue), 0, 1_000_000_000)
    let timer_c1 = Timer(ConsumerGen(c1, queue), 0, 2_000_000_000)

    timers(consume timer_p1)
    timers(consume timer_c1)
    /*
    p1.publish_message(queue)
    p1.publish_message(queue)

    p2.publish_message(queue)
    p2.publish_message(queue)
    
    p1.publish_message(queue)
    */

    /*
    consumer.consume_message(queue)
    consumer.consume_message(queue)
    consumer.consume_message(queue)
    */
    
    env.out.print("**Main** Finished.")