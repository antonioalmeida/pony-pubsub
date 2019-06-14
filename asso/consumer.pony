actor Consumer
    let _messages: Array[Message]
    let _capacity: USize
    let _out: OutStream

    new create(out: OutStream, capacity: USize = 50) =>
        _out = out
        _capacity = capacity
        _messages = Array[Message](_capacity)

    "'ask' queue for a message"  
    be consume_message(queue: Queue) =>
        queue.can_consume(this)

    "actually receive the message - invoked by the queue" 
    be on_message(message: Message) =>
        _messages.push(message)
        _out.print("Consumed message " + message.string())
