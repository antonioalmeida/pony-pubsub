use collections = "collections"

actor Broker
    let _id: USize
    let _out: OutStream

    let _subscriptions: collections.MapIs[Publisher, Array[Consumer]] 

    new create(id: USize, out: OutStream) =>
        _id = id
        _out = out
        _subscriptions = _subscriptions.create()

    be can_produce(publisher: Publisher, message: Message) =>
        try
            let consumers = _subscriptions(publisher)?

            for consumer in consumers.values() do
                consumer.on_message(message)
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
    
    be remove_subscription(consumer: Consumer, publisher: Publisher) =>
        try
            let consumers = _subscriptions(publisher)?
            let index = consumers.find(consumer)?
            consumers.remove(index, 1)
        end
        _out.print("Removed subscription")

        


    

