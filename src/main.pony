actor Main
new create(env: Env) =>

    let p1 = Publisher(1, "ola", env.out)
    let p2 = Publisher(2, "adeus", env.out)

    let queue = Queue(10, env.out)
    let consumer = Consumer(1, env.out)

    p1.publish_message(queue)
    p1.publish_message(queue)

    p2.publish_message(queue)
    p2.publish_message(queue)
    
    p1.publish_message(queue)

    consumer.consume_message(queue)
    consumer.consume_message(queue)
    consumer.consume_message(queue)
    consumer.consume_message(queue)

    /*
    let v1 = Ventilator(1, env.out)

    let consumer1 = Consumer(1, env.out)
    let consumer2 = Consumer(2, env.out)
    let consumer3 = Consumer(3, env.out)

    p1.publish_message(v1)
    p1.publish_message(v1)

    p2.publish_message(v1)
    p2.publish_message(v1)
    
    p1.publish_message(v1)

    consumer1.subscribe_ventilator(v1)
    consumer3.subscribe_ventilator(v1)

    consumer1.consume_message()
    consumer1.consume_message()
    consumer2.consume_message()
    consumer3.consume_message()

    */

    env.out.print("**Main** Finished.")