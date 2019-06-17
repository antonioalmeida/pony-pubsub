# Scenario 2

![scenario-2](assets/scenario-2.png)

## "Changelog"

### v1.0

First attempt at scenario 1.

#### Checklist

- [x] ~~Unbounded queue~~. Queue has a predefined capacity defined on its constructor. 
- [x] Publishes asap (again). Pro: from the publisher's POV, the publish mechanism is asynchronous
- [x] Multiple subscribers:
    - [x] They pull messages concurrently;
    - [x] Each gets a different message;
- [x] *Implicit* subscription (fetch from data structure).

#### Potential problems:

* Possible out-of-memory in queue (again);
* Eager producer (again);
* No guarantees on ~~delivery-order, or~~ load-balancing;
* Potentially *loses* messages if they are consumed asap (?). *Not sure if this is true*
* Potentially *duplicates* messages if they are consumed only after subscriber finishes work (?). *Not sure if this is true*

### v2.0

Improvements on Scenario 2.

#### Improvements:
* Make better use of the typing system, namely [Type Aliases](https://tutorial.ponylang.io/types/type-aliases.html), to encapsulate and improve semantics on messages;
* Not having a `null` value was weird, we now handle that better. [This](https://patterns.ponylang.io/creation/supply-chain.html) helped
* CI through [CircleCI](https://circleci.com/) with containerized build ~~and test~~ jobs
