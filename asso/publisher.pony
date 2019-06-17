use collections = "collections"

actor Publisher  
    """
    Actor that represents a Publisher on a Publish-Subscribe
    pattern.
    """

    let _id: USize 
    let _out: OutStream

    """
    The message the Publisher intends to propagate.
    """
    let _message : Message

    new create(id: USize, message: Message, out: OutStream) =>
        _id = id
        _message = message
        _out = out

    """
    Behavior to trigger message publishing, on a given Broker.
    Also prints the message's content to screen.
    """
    be publish_message_b(broker: Broker) =>
        broker.can_produce(this, _message)
        _out.print("p" + _id.string() +  ": publishing message " + _message.string())

    """
    Behavior called when a queue confirms it can be pushed to.
    Calls the queue's 'push message' behavior.
    """
    be push_message(queue: Queue) =>
        queue.push(_message)
