use "time"

class PublisherGen is TimerNotify
    """
    Class that is notified by the system and executes the apply method.
    """

    let _publisher: Publisher
    let _broker: Broker
    
    new iso create(publisher: Publisher, broker: Broker) =>
        _publisher = publisher
        _broker = broker

    fun ref apply(timer: Timer, count: U64): Bool =>
        _publisher.publish_message(_broker)
        true