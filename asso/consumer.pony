actor Consumer
    let _id: USize
    let _messages: Array[Message]
    let _capacity: USize
    let _out: OutStream

    new create(id: USize, out: OutStream, capacity: USize = 50) =>
        _id = id
        _out = out
        _capacity = capacity
        _messages = Array[Message](_capacity)

    "'ask' queue for a message"  
    be consume_message(queue: Queue) =>
        queue.can_consume(this)

    "actually receive the message - invoked by the queue" 
    be on_message(message: Message) =>
        _messages.push(message)
        _out.print("c" + _id.string() +  ": consumed message " + message.string())

    be subscribe_ventilator(ventilator: Ventilator) =>
        ventilator.add_subscriber(this)

