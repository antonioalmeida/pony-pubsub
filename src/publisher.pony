actor Publisher
    let _message : Message
    var _count : U32 = 0
    let _out: OutStream

    new create(message: Message, out: OutStream) =>
        _message = message
        _out = out

    be publish_message(queue: Queue) =>
        queue.can_produce(this)

    be push_message(queue: Queue) =>
        _count = _count + 1
        queue.push(_message)
        _out.print("Published message - " + _message.string())