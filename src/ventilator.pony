actor Ventilator
    let _id: USize
    let _message : Message
    var _count : U32 = 0
    let _out: OutStream

    new create(id: USize, message: Message, out: OutStream) =>
        _id = id
        _message = message
        _out = out

    be publish_message(queue: Queue) =>
        _out.print("TODO")

    be push_message(queue: Queue) =>
        _out.print("TODO")