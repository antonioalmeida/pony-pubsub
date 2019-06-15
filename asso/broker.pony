use collections = "collections"

actor Broker
    let _id: USize
    let _queue : Queue
    let _out: OutStream
    let _subscriptions: collections.Map[USize, Array[Consumer]] = _subscriptions.create()
    let _publishers: collections.Map[USize, Publisher] = _publishers.create()
    

    new create(id: USize, queue: Queue, out: OutStream) =>
        _id = id
        _queue = queue
        _out = out

    
    be can_produce(publisher: Publisher) =>
        // logic here to only serve those that need (queue for each publisher?)
        _queue.can_produce(publisher)


    /*
    be add_subscriber(consumer: Consumer) =>
        _out.print("TODO")
        /*
        _subscribers.push(consumer)
        */

    be consume_message() =>
        _queue.can_consume(this)
    
    be on_message(m: Message) =>
        _out.print("TODO")
        /*
        for sub in _subscribers.values() do
            sub.on_message(m)
        end*/
    */

    be add_subscription(consumer: Consumer, publisher: Publisher) =>
        _out.print("TODO")
        


    

