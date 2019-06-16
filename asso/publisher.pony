use collections = "collections"

actor Publisher  
    let _id: USize 
    let _message : Message
    let _out: OutStream

    new create(id: USize, message: Message, out: OutStream) =>
        _id = id
        _message = message
        _out = out

    be publish_message_b(broker: Broker) =>
        broker.can_produce(this, _message)
        _out.print("p" + _id.string() +  ": publishing message " + _message.string())

    be push_message(queue: Queue) =>
        queue.push(_message)
