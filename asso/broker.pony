use collections = "collections"

actor Broker
    let _id: USize
    let _out: OutStream

    let _subscriptions: collections.MapIs[Publisher, Array[Consumer]] 
    let _consumer_queues: collections.MapIs[Consumer, Queue] 

    new create(id: USize, out: OutStream) =>
        _id = id
        _out = out
        _subscriptions = _subscriptions.create()
        _consumer_queues = _consumer_queues.create()

    be can_produce(publisher: Publisher, message: Message) =>
        try
            let consumers = _subscriptions(publisher)?

            for consumer in consumers.values() do
                _consumer_queues.insert_if_absent(consumer, Queue(_out))?
                let queue = _consumer_queues(consumer)?
                queue.push(message)
                queue.pop(consumer)
            end
        else
            _out.print("There was an error in Broker.")
        end

    be add_subscription(consumer: Consumer, publisher: Publisher) =>
        try
            _subscriptions.insert_if_absent(publisher, Array[Consumer])?
            let consumers = _subscriptions(publisher)?
            consumers.push(consumer)
            _subscriptions.update(publisher, consumers)
        end

        _out.print("Added subscription")
        


    

