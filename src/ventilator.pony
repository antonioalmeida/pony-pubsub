actor Ventilator
    let _id: USize
    let _queue : Queue
    let _out: OutStream
    let _subscribers: Array[Consumer]

    new create(id: USize, queue: Queue, out: OutStream) =>
        _id = id
        _queue = queue
        _out = out
        _subscribers = Array[Consumer]()

    be publish_message(queue: Queue) =>
        _out.print("TODO")

    be push_message(queue: Queue) =>
        _out.print("TODO")

    be can_produce(publisher: Publisher) =>
        _queue.can_produce(publisher)

    be add_subscriber(consumer: Consumer) =>
        _subscribers.push(consumer)

    be consume_message() =>
        for sub in _subscribers.values() do
            sub.consume_message(_queue)
        end