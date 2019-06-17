actor Consumer
    """
    Actor that represents a Consumer on a Publish-Subscribe
    pattern.
    """

    let _out: OutStream

    """
    Array to hold the Consumer's received messages.
    """
    let _messages: Array[String]
    """
    Maximum ammount of messages the consumer can hold.
    """
    let _capacity: USize

    new create(out: OutStream, capacity: USize = 50) =>
        _out = out
        _capacity = capacity
        _messages = Array[String](_capacity)

    """
    Behaviour to be called when a message is to be consumed.
    """ 
    be consume_message(queue: Queue) =>
        queue.pull(this)

    """
    Handler triggered when the consumer receives/consumes
    a message. Stores and it prints its content to screen.
    """
    be on_message(message: String) =>
        _messages.push(message)
        _out.print("Consumed message " + message)

