# feup-asso

## Pony

### Instructions

#### Setup
Install pony compiler `ponyc`

#### Compile
```shell
$ ponyc -d src -o out -b main # compiles directory 'src' to 'out/main'
```

#### Run

Assuming the previous compilation command was executed:
```shell
$ ./out/main
```

### v0.0.1

First attempt at Scenario 1 
![scenario-1](https://github.com/hugoferreira/asso-pipes-and-stuff-v19/raw/master/assets/scenario-1.png)

##### Pros
- "Everything" is asynchronous - no blocking calls
- Making use of the Actor Models and its messaging system on our advantage - through Pony's behaviours

#### Cons
- EVERYTHING is asynchronous - the change in mindset still hasn't kicked in, and the code reflects that
- Message ordering when publishing and consuming is not guaranteed - need to change the push/pull pattern and possibly look into [reference capabilities](https://tutorial.ponylang.io/reference-capabilities.html)

### v0.0.2

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

### v0.0.3

Improvements on Scenario 2

#### Improvements:
* Make better use of the typing system, namely [Type Aliases](https://tutorial.ponylang.io/types/type-aliases.html), to encapsulate and improve semantics on messages;
* Not having a `null` value was weird, we now handle that better. [This](https://patterns.ponylang.io/creation/supply-chain.html) helped
* CI through [CircleCI](https://circleci.com/) with containerized build ~~and test~~ jobs



### v0.0.4 (not yet tho)

Started Scenario 3

Current problems:
* consumers not consuming
* delivery logic by the ventilator not correct (each message in queue should be distributed to all subscribers)

![scenario-3](https://github.com/hugoferreira/asso-pipes-and-stuff-v19/raw/master/assets/scenario-3.png)

* Unbounded queue and publishes asap;
* *Ventilator* (or Subscription Manager) knows about the subscribers:
    * [Observer](https://en.wikipedia.org/wiki/Observer_pattern) used to push to subscribers (*Explicit* subscription);
    * Different specializations of *ventilators* ([Fanout](https://en.wikipedia.org/wiki/Fan-out_(software)), Round-robin...).
