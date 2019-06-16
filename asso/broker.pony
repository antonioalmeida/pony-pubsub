use collections = "collections"

actor Broker
    let _id: USize
    let _out: OutStream
    let _subscriptions: collections.Map[USize, Array[Consumer]] = _subscriptions.create()
    let _publishers: collections.Map[USize, Publisher] = _publishers.create()
    let _queues: collections.Map[USize, Queue] = _queues.create()
    

    new create(id: USize, queue: Queue, out: OutStream) =>
        _id = id
        _out = out

    
    be can_produce(publisher: Publisher) =>
        _queues.insert_if_absent(publisher.get_id(), Queue(10, _out))
        match _queues.get_or_else(publisher.get_id(), None)
        | let q: None => _out.print("There was an error in Broker.")
        | let q: Queue => q.can_produce(publisher)
        end

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
        


    

