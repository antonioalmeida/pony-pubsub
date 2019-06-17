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
    let _message : Message

    new create(message: Message, out: OutStream) =>
        _message = message
        _out = out

    """
    Behaviour to be called when a message is to be published.
    """ 
    be publish_message(queue: Queue) =>
        queue.can_produce(this)

    """
    Behaviour to trigger message publishing, on a given Broker.
    Also prints the message's content to screen.
    """
    be push_message(queue: Queue) =>
        _count = _count + 1
        queue.push(_message)
        _out.print("Published message - " + _message.string())