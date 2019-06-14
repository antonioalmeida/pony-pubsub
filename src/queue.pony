actor Queue
    let _capacity: USize
    var _messages: Array[Message]
    let _out: OutStream

    let _consume_requests: Array[Consumer]

    new create(capacity: USize, out: OutStream) =>
        _capacity = capacity
        _messages = Array[Message](_capacity)
        _out = out
        _consume_requests = Array[Consumer](_capacity)

    be push(message: Message) =>
        push_sync(message)
        try
            if _consume_requests.size() > 0 then
                let msg = _messages.shift()?
                let consumer = _consume_requests.shift()?
                consumer.on_message(msg)
            end
        end

    be can_produce(publisher: Publisher) =>
        if (_messages.size() + 1) < _capacity then
            publisher.push_message(this)
        else 
            // add to waiting array?
            _out.print("queue full")
        end

    be can_consume(consumer: Consumer) => 
        let message = pull_sync()

        if message.string() == "no message to consume" then
            _consume_requests.push(consumer)
        else
            consumer.on_message(message)
        end

    fun ref push_sync(message: Message) =>
        _messages.push(message)

    fun ref pull_sync(): Message =>
        var message: Message 
        message = "no message to consume"
        try
            if _messages.size() > 0 then
                message = _messages.shift()?
            end
        end
        message

