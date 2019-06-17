actor Publisher
    """
    Actor that represents a Publisher on a Publish-Subscribe
    pattern.
    """
    
    var _count : U32 = 0
    let _out: OutStream

    """
    The message the Publisher intends to propagate.
    """
    let _message : String
    

    new create(message: String, out: OutStream) =>
        _message = message
        _out = out

    """
    Behaviour to trigger message publishing, on a given Broker.
    Also prints the message's content to screen.
    """
    be publish_message(queue: Queue) =>
        let message = _message + " " + _count.string()
        queue.push(message)
        _out.print("Published message - " + message)
        _count = _count + 1