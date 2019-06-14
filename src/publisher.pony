actor Publisher
    let _id: USize
    let _message : Message
    var _count : U32 = 0
    let _out: OutStream

    new create(id: USize, message: Message, out: OutStream) =>
        _id = id
        _message = message
        _out = out

    be publish_message(queue: Queue) =>
        queue.can_produce(this)

    be push_message(queue: Queue) =>
        _count = _count + 1
        queue.push(_message)
        _out.print("p" + _id.string() +  ": published message " + _message.string())