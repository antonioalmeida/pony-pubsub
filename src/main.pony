actor Main
new create(env: Env) =>

    let p1 = Publisher("ola", env.out)
    let p2 = Publisher("adeus", env.out)

    let v1 = Ventilator(env.out)

    let consumer1 = Consumer(env.out)
    let consumer2 = Consumer(env.out)
    let consumer3 = Consumer(env.out)

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

    env.out.print("**Main** Finished.")