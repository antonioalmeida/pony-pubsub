actor Publisher
    let _message : String
    var _count : U32 = 0
    let _out: OutStream

    new create(message: String, out: OutStream) =>
        _message = message
        _out = out

    be publish_message(queue : Queue) =>
        let message = _message + " " + _count.string()
        queue.push(message)
        _out.print("Published message - " + message)
        _count = _count + 1