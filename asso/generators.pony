use "time"

class PublisherGen is TimerNotify
    let _publisher: Publisher
    let _broker: Broker
    
    new iso create(publisher: Publisher, broker: Broker) =>
        _publisher = publisher
        _broker = broker

    fun ref apply(timer: Timer, count: U64): Bool =>
        _publisher.publish_message_b(_broker)
        true