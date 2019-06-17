actor Consumer
    let _id: USize
    let _messages: Array[Message]
    let _capacity: USize
    let _out: OutStream

    new create(id: USize, out: OutStream, capacity: USize = 50) =>
        _id = id
        _out = out
        _capacity = capacity
        _messages = Array[Message](_capacity)

    be on_message(message: Message) =>
        _messages.push(message)
        _out.print("    > c" + _id.string() +  ": consumed '" + message.string() + "'")

