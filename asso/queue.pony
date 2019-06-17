
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
    var _messages: Array[Message]

    new create(out: OutStream, capacity: USize=50) =>
        _capacity = capacity
        _messages = Array[Message](_capacity)
        _out = out

    """
    Behavior to trigger local push of a given message
    to the messages array, after capacity verification.
    """
    be push(message: Message) =>
        if _messages.size() < _capacity then
            push_sync(message)
        else
            _out.print("queue full") //what to do here?
        end
        
    """
    Behavior to trigger local pop of the message on 
    the messages array, to a given consumer.
    """
    be pop(consumer: Consumer) => 
        let message = pop_sync()

        match message
        | let m: None => _out.print("no message :(")
        | let m: Message => consumer.on_message(m)
        end

    """
    Function to push a given message to the messages
    array.
    """
    fun ref push_sync(message: Message) =>
        _messages.push(message)

    """
    Function to pop and return the top message from 
    the messages array.
    """
    fun ref pop_sync(): (Message | None) =>
        var message: (Message | None) = None
        try
            if _messages.size() > 0 then
                message = _messages.shift()?
            end
        end
        message

