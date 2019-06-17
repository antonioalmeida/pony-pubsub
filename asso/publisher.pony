actor Publisher
    """
    Actor that represents a Publisher on a Publish-Subscribe
    pattern.
    """

    let _id: USize
    let _out: OutStream
    var _count : U32 = 0

    """
    The message the Publisher intends to propagate.
    """
    let _message : Message

    new create(id: USize, message: Message, out: OutStream) =>
        _id = id
        _message = message
        _out = out

    """
    Behavior to trigger message publishing.
    """
    be publish_message(queue: Queue) =>
        queue.can_produce(this)

    """
    Behavior to trigger message publishing, on a given Ventilator.
    """
    be publish_message_v(ventilator: Ventilator) =>
        ventilator.can_produce(this)

    """
    Behavior called when a queue confirms it can be pushed to.
    Calls the queue's 'push message' behavior.
    """
    be push_message(queue: Queue) =>
        _count = _count + 1
        queue.push(_message)
        _out.print("p" + _id.string() +  ": published message " + _message.string())