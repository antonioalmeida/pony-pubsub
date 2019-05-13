actor Main
new create(env: Env) =>

    let p1 = Publisher("ola", env.out)
    let p2 = Publisher("adeus", env.out)
    let queue = Queue(3, env.out)
    let consumer = Consumer(env.out)

    p1.publish_message(queue)
    p1.publish_message(queue)

    p2.publish_message(queue)
    p2.publish_message(queue)
    
    p1.publish_message(queue)

    consumer.ask_message(queue)
    consumer.ask_message(queue)
    consumer.ask_message(queue)


    env.out.print("**Main** Finished.")