# Scenario 4

"This is getting serious!"

![scenario-4](assets/scenario-4.png)

The mains goals of the Scenario 4 were:

* Multiple publishers, multiple subscribers;
* Both have specialized queues:
    * Inbound and Outbound;
    * Broker manages queue binding;
    * Broker moves messages around (between queues);
    * Queues may be persistent;
* No implicit connections between subscribers and producers:
    * *Explicit* subscription;
    * Identification mechanism is needed (keys, topics, ...);
    * Study the [Registry](https://martinfowler.com/eaaCatalog/registry.html) and (if you are feeling adventurous) the [Service Locator](https://en.wikipedia.org/wiki/Service_locator_pattern) patterns.

## Results

* Multiple publishers, multiple subscribers;
* Outbound queues used, no inbound queues - not needed given the approach
* Broker manages queue bindings
* Queues are not persistent, yet could be, by using equivalent structures from the [collections-persistent](https://stdlib.ponylang.io/collections-persistent--index/) package;
* Explicit subscriptions based on producer keys/identification

## "Changelog"

### v0.3

 * Started Scenario 4, based on Scenario 3.
 * Attempted both topic and key based identification mechanisms. Went with keys.
 * Implement base Broker and 1 to 1 subscription mechanism. 
    * Had some trouble handling reference capabilities mixed with collections;
    * [MapIs] collection saved the day;
 * Consumers are now notified of when a new message is ready to be consumed.
 
 ### v0.4
 
 * Implemented 1 to many subscription mechanism
   * Publisher publishes once for each subscriber - not good.
 * Cleanup non-compatible/obsolete code from previous scenarios
 
 ### v1.0
 
 * Fixed Publisher separation of concerns code smell through refactor on the message exchange flow
 * Added documentation
