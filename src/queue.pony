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
        var message = "empty"
        try 
            if _messages.size() > 0 then
                message = _messages.pop()?
                consumer.consume_message(message)
            end
        else 
            _out.print("error pulling")
        end

