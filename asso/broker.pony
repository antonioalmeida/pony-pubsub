use collections = "collections"

actor Broker
    let _id: USize
    let _out: OutStream
    let _subscriptions: collections.MapIs[Publisher, Array[Consumer]] = _subscriptions.create()
    let _publishers: collections.Map[USize, Publisher] = _publishers.create()

    let _consumer_queues: collections.MapIs[Consumer, Queue] = _consumer_queues.create()
    
    new create(id: USize, queue: Queue, out: OutStream) =>
        _id = id
        _out = out
    
    be can_produce(publisher: Publisher) =>
        try
            let consumers = _subscriptions(publisher)?

            for consumer in consumers.values() do
                _consumer_queues.insert_if_absent(consumer, Queue(10, _out))?
                _consumer_queues(consumer)?.can_produce(publisher)
                _consumer_queues(consumer)?.can_consume(consumer)
            end
        else
            _out.print("There was an error in Broker.")
        end

    be consume_message(consumer: Consumer) =>
        try
            _consumer_queues(consumer)?.can_consume(consumer)
        end

    be add_subscription(consumer: Consumer, publisher: Publisher) =>
        try
            _subscriptions.insert_if_absent(publisher, Array[Consumer])?
            let consumers = _subscriptions(publisher)?
            consumers.push(consumer)
            _subscriptions.update(publisher, consumers)
        end

        _out.print("added subscription")
        


    

