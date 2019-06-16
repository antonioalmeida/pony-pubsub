
actor Queue
    let _capacity: USize
    var _messages: Array[Message]
    let _out: OutStream

    new create(out: OutStream, capacity: USize=50) =>
        _capacity = capacity
        _messages = Array[Message](_capacity)
        _out = out

    be push(message: Message) =>
        if _messages.size() < _capacity then
            push_sync(message)
        else
            _out.print("queue full") //what to do here?
        end
        
    be pop(consumer: Consumer) => 
        let message = pop_sync()

        match message
        | let m: None => _out.print("no message :(")
        | let m: Message => consumer.on_message(m)
        end

    fun ref push_sync(message: Message) =>
        _messages.push(message)

    fun ref pop_sync(): (Message | None) =>
        var message: (Message | None) = None
        try
            if _messages.size() > 0 then
                message = _messages.shift()?
            end
        end
        message

