actor Consumer
        """
    Actor that represents a Consumer on a Publish-Subscribe
    pattern.
    """

    let _out: OutStream

    """
    Array to hold the Consumer's received messages.
    """
    let _messages: Array[Message]
    """
    Maximum ammount of messages the consumer can hold.
    """
    let _capacity: USize

    new create(out: OutStream, capacity: USize = 50) =>
        _out = out
        _capacity = capacity
        _messages = Array[Message](_capacity)


    """
    Behaviour to be called when a message is to be consumed.
    """ 
    be consume_message(queue: Queue) =>
        queue.can_consume(this)

    """
    Handler triggered when the consumer receives/consumes
    a message. Stores and it prints its content to screen.
    """
    be on_message(message: Message) =>
        _messages.push(message)
        _out.print("Consumed message " + message.string())

    be report_messages(mc: MessageCounter) =>
        mc.on_consumer_report(_messages.size())
