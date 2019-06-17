actor Consumer
    """
    Actor that represents a Consumer on a Publish-Subscribe
    pattern.
    """

    let _id: USize
    let _out: OutStream

    """
    Array to hold the Consumer's received messages.
    """
    let _messages: Array[Message]
    """
    Maximum ammount of messages the consumer can hold.
    """
    let _capacity: USize

    new create(id: USize, out: OutStream, capacity: USize = 50) =>
        _id = id
        _out = out
        _capacity = capacity
        _messages = Array[Message](_capacity)

    """
    Handler triggered when the consumer receives/consumes
    a message. Stores and it prints its content to screen.
    """
    be on_message(message: Message) =>
        _messages.push(message)
        _out.print("    > c" + _id.string() +  ": consumed '" + message.string() + "'")