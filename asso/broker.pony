use collections = "collections"

actor Broker
    """
    Actor that manages subscriptions between Publishers and 
    their Consumers. Also redirects messages according to 
    said subscriptions.
    """

    let _id: USize
    let _out: OutStream

    """
    Map to hold each Publisher's subscribers. The publisher's
    identity is used as hashing key.
    """
    let _subscriptions: collections.MapIs[Publisher, Array[Consumer]] 

    """
    Map to hold each Consumer's queue. The consumer's
    identity is used as hashing key.
    """ 
    let _consumer_queues: collections.MapIs[Consumer, Queue] 

    new create(id: USize, out: OutStream) =>
        _id = id
        _out = out
        _subscriptions = _subscriptions.create()
        _consumer_queues = _consumer_queues.create()

    """
    Handler triggered when the broker receives a message.
    After retrieving the publishers's subscribers and their
    respective queue, it pushes the message to it.
    """
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

    """
    Add a subscription entry for [publisher, consumer].
    """
    be add_subscription(consumer: Consumer, publisher: Publisher) =>
        try
            _subscriptions.insert_if_absent(publisher, Array[Consumer])?
            let consumers = _subscriptions(publisher)?
            consumers.push(consumer)
            _subscriptions.update(publisher, consumers)
        end

        _out.print("Added subscription")
        
    """
    Remove a subscription entry for [publisher, consumer].
    """
    be remove_subscription(consumer: Consumer, publisher: Publisher) =>
        try
            let consumers = _subscriptions(publisher)?
            let index = consumers.find(consumer)?
            consumers.remove(index, 1)
        end
        _out.print("Removed subscription")

    

