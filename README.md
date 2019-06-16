## feup-asso

----

### Instructions

#### Setup
Install pony compiler `ponyc`

#### Compile
```shell
# compile the package
$ make build/asso 

# compile tests
$ make build/test 
```

#### Run

__Note:__ both these commands will compile the source if they're not built.
```shell

# run the package's Main
$ make run

# run tests
$ make test
```

----

## A sort of Changelog

### v0.0.0.1

First attempt at Scenario 1 
![scenario-1](https://github.com/hugoferreira/asso-pipes-and-stuff-v19/raw/master/assets/scenario-1.png)

##### Pros
- "Everything" is asynchronous - no blocking calls
- Making use of the Actor Models and its messaging system on our advantage - through Pony's behaviours

#### Cons
- EVERYTHING is asynchronous - the change in mindset still hasn't kicked in, and the code reflects that
- Message ordering when publishing and consuming is not guaranteed - need to change the push/pull pattern and possibly look into [reference capabilities](https://tutorial.ponylang.io/reference-capabilities.html)

### v0.0.1.0

First attempt at Scenario 2
![scenario-2](https://github.com/hugoferreira/asso-pipes-and-stuff-v19/raw/master/assets/scenario-2.png)

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

### v0.0.2.0

Improvements on Scenario 2

#### Improvements:
* Make better use of the typing system, namely [Type Aliases](https://tutorial.ponylang.io/types/type-aliases.html), to encapsulate and improve semantics on messages;
* Not having a `null` value was weird, we now handle that better. [This](https://patterns.ponylang.io/creation/supply-chain.html) helped
* CI through [CircleCI](https://circleci.com/) with containerized build ~~and test~~ jobs



### v0.1.0.0

Started Scenario 3

![scenario-3](https://github.com/hugoferreira/asso-pipes-and-stuff-v19/raw/master/assets/scenario-3.png)

* Unbounded queue and publishes asap;
* *Ventilator* (or Subscription Manager) knows about the subscribers:
    * [Observer](https://en.wikipedia.org/wiki/Observer_pattern) used to push to subscribers (*Explicit* subscription);
    * Different specializations of *ventilators* ([Fanout](https://en.wikipedia.org/wiki/Fan-out_(software)), Round-robin...).


### v1.0.0.0

Started Scenario 4 from Scenario 3

![scenario-4](https://github.com/hugoferreira/asso-pipes-and-stuff-v19/raw/master/assets/scenario-4.png)

#### Checklist

- [x] Multiple publishers, multiple subscribers;
- [ ] Both have specialized queues:
    - [x] ~~Inbound and~~ Outbound;
    - [x] Broker manages queue binding;
    - [x] Broker moves messages around (between queues);
    - [ ] Queues may be persistent.
- [x] No implicit connections between subscribers and producers:
    - [x] *Explicit* subscription;
    - [x] Identification mechanism is needed (keys, ~~topics, ...~~);
    - [x] Study the [Registry](https://martinfowler.com/eaaCatalog/registry.html) ~~and (if you are feeling adventurous) the [Service Locator](https://en.wikipedia.org/wiki/Service_locator_pattern)~~ patterns.
