actor Ventilator
    let _id: USize
    let _queue : Queue
    let _out: OutStream

    new create(id: USize, queue: Queue, out: OutStream) =>
        _id = id
        _queue = queue
        _out = out

    be publish_message(queue: Queue) =>
        _out.print("TODO")

    be push_message(queue: Queue) =>
        _out.print("TODO")

    be can_produce(publisher: Publisher) =>
        _queue.can_produce(publisher)
        