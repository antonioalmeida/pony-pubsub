actor Queue
    """
    Actor that represents a FIFO bounded queue that holds 
    instances of Message.
    """

    let _out: OutStream
    
    """
    Maximum ammount of messages the queue can hold.
    """
    let _capacity: USize

    """
    Array to hold the Consumer's received messages.
    """
    var _messages: Array[String]

    new create(capacity: USize, out: OutStream) =>
        _capacity = capacity
        _messages = Array[String](_capacity)
        _out = out

    """
    Behavior to trigger local push of a given message
    to the messages array.
    """
    be push(message: String) =>
        _messages.push(message)

    """
    Behavior to trigger local pop of the message on 
    the messages array, to a given consumer.
    """
    be pull(consumer: Consumer) => 
        try 
            if _messages.size() > 0 then
                let message = _messages.shift()?
                consumer.on_message(message)
            end
        else 
            _out.print("error pulling")
        end

