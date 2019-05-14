actor Queue
    let _capacity: USize
    var _messages: Array[String]
    let _out: OutStream

    new create(capacity: USize, out: OutStream) =>
        _capacity = capacity
        _messages = Array[String](_capacity)
        _out = out

    be push(message: String) =>
        _messages.push(message)

    be pull(consumer: Consumer) => 
        try 
            if _messages.size() > 0 then
                let message = _messages.pop()?
                consumer.on_message(message)
            end
        else 
            _out.print("error pulling")
        end

