use "time"

actor Main
new create(env: Env) =>
    
    let p1 = Publisher(1, "hello", env.out) 
    let p2 = Publisher(2, "world", env.out) 

    let consumer1 = Consumer(1, env.out)
    let consumer2 = Consumer(2, env.out)
    let consumer3 = Consumer(3, env.out)
    let consumer4 = Consumer(4, env.out)

    let b1 = Broker(1, env.out)

    // start the timers, p1 is twice as fast, both start 1 second after Timer begins
    let timers = Timers
    let timer_p1 = Timer(PublisherGen(p1, b1), 1_000_000_000, 1_000_000_000)
    let timer_p2 = Timer(PublisherGen(p2, b1), 1_000_000_000, 2_000_000_000)
    timers(consume timer_p1)
    timers(consume timer_p2)


    b1.add_subscription(consumer1, p1)
    b1.add_subscription(consumer2, p1)

    b1.add_subscription(consumer1, p2)
    b1.add_subscription(consumer3, p2)

    env.out.print("**Main** Finished.")