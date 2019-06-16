type GenericConsumer is (Consumer | Ventilator)

actor Queue
    let _capacity: USize
    var _messages: Array[Message]
    let _out: OutStream

    let _consume_requests: Array[GenericConsumer]

    new create(out: OutStream, capacity: USize=50) =>
        _capacity = capacity
        _messages = Array[Message](_capacity)
        _out = out
        _consume_requests = Array[GenericConsumer](_capacity)

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
        if _messages.size()  < _capacity then
            publisher.push_message(this)
        else 
            // add to waiting array?
            _out.print("queue full")
        end

    be can_consume(consumer: GenericConsumer) => 
        let message = pull_sync()

        match message
        | let m: None => _consume_requests.push(consumer)
        | let m: Message => consumer.on_message(m)
        end

    fun ref push_sync(message: Message) =>
        _messages.push(message)

    fun ref pull_sync(): (Message | None) =>
        var message: (Message | None) = None
        try
            if _messages.size() > 0 then
                message = _messages.shift()?
            end
        end
        message

