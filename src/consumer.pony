actor Consumer
    let _messages: Array[String]
    let _capacity: USize
    let _out: OutStream

    new create(out: OutStream, capacity: USize = 50) =>
        _out = out
        _capacity = capacity
        _messages = Array[String](_capacity)

    "'ask' queue for a message"  
    be consume_message(queue: Queue) =>
        queue.pull(this)

    "actually receive the message - invoked by the queue" 
    be on_message(message: String) =>
        _messages.push(message)
        _out.print("Consumed message " + message)

