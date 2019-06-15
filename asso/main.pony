actor Main
new create(env: Env) =>
    
    let queue = Queue(10, env.out)

    let p1 = Publisher(1, "ola", env.out)
    let p2 = Publisher(2, "hello", env.out)

    let consumer1 = Consumer(1, env.out)
    let consumer2 = Consumer(2, env.out)
    let consumer3 = Consumer(3, env.out)
    let consumer4 = Consumer(4, env.out)

    let b1 = Broker(1, queue, env.out)

    b1.add_subscription(consumer1, p1)
    b1.add_subscription(consumer2, p1)
    b1.add_subscription(consumer3, p1)
    b1.add_subscription(consumer1, p2)
    b1.add_subscription(consumer2, p2)
    b1.add_subscription(consumer4, p2)

    /*
    p1.publish_message_b(b1)
    p2.publish_message_b(b1)
    */

    // consume messages? 

    env.out.print("**Main** Finished.")