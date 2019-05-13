actor Consumer
    let _out: OutStream

    new create(out: OutStream) =>
        _out = out

    be ask_message(queue: Queue) =>
        queue.pull(this)
    
    be consume_message(message: String) =>
        _out.print("Consumed message " + message)