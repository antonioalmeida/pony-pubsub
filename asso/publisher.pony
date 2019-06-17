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
    Behaviour to trigger message publishing, on a given Broker.
    Also prints the message's content to screen.
    """
    be publish_message(broker: Broker) =>
        broker.on_message(this, _message)
        _out.print("> p" + _id.string() +  ": published '" + _message.string() + "'")

