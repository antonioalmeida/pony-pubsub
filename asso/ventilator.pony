actor Ventilator
    let _message: Message
    let _out: OutStream

    new create(message: Message, out: OutStream) =>
        _message = message
        _out = out

    be push_message(queue: Queue) =>
        queue.push(_message)
    
   

