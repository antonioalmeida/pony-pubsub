actor Main
new create(env: Env) =>

    let p1 = Publisher(1, "ola", env.out)

    let queue = Queue(10, env.out)
    let consumer1 = Consumer(1, env.out)
    let consumer2 = Consumer(2, env.out)
    let consumer3 = Consumer(3, env.out)
    let consumer4 = Consumer(4, env.out)

    let v1 = Ventilator(1, queue, env.out)

    p1.publish_message_v(v1)

    consumer1.subscribe_ventilator(v1)
    consumer2.subscribe_ventilator(v1)
    consumer3.subscribe_ventilator(v1)
    consumer4.subscribe_ventilator(v1)
    
    v1.consume_message()

    env.out.print("**Main** Finished.")