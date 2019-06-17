use collections = "collections"

actor Publisher  
    let _id: USize 
    let _message : Message
    let _out: OutStream

    new create(id: USize, message: Message, out: OutStream) =>
        _id = id
        _message = message
        _out = out

    be publish_message(broker: Broker) =>
        broker.on_message(this, _message)
        _out.print("> p" + _id.string() +  ": published '" + _message.string() + "'")

