# pony-pubsub

Implementation of different Publish-Subscribe scenarios (explicited below) in [Pony](https://www.ponylang.io/). 

##### Objectives
The main goals of this project were:

* Infer patterns on how to design Publish/Subscribe systems on an Actor Model language;
* Assess how differently (if at all) traditional OOP design patterns still apply on Pony's paradigm;
* Evaluate Pony's core features (*capabilities-secure, actor-model*) help/hinger on solving the Publish/Subscribe problem;
* Evaluate Pony as a production-level programming language, from various perspectives, e.g., learning curve, community, documentation, stability, etc;


##### Conclusions

Implementing a Publish/Subscribe system on an Actor Model language proved to be very similar to other paradigms. The major difference in patterns was the lack of need of an explicit queue since Pony's actor model paradigm implicitly creates these queues to allow the use of behaviours (asynchronous methods).  

Pony also handles the threads for its Actors, meaning you don't have to deal with its creation, destruction or even data-races and deadlocks. This is an advantage from a language such as C++, where you'd have to build a multithreaded program from scratch to enable this asynchronous behaviour. It's also an advantage in relation to single-threaded asynchronous event-loop-based programming languages such as Javascript in terms of performance and without the hassle of implementing semaphores.

In addition, Pony is not only a typed language, which enables more maintainable code, but also type-safe (and, therefore, memory-safe). Pony also guarantees exception safety, meaning if the program compiles it will run with no unexpected exceptions. All of these capabilities helped to develop safer and cleaner code.

Pony is still a relatively new language and therefore it was expected to encounter some problems with stability, documentation and community. However, we found no stability issues or unexpected behaviour. The documentation is well written and fairly easy to search. Community wise, it lacks support from questions websites like [StackOverflow](https://stackoverflow.com/) (with only 56 watchers and 25 questions for the language tag, comparing to 10.3k/12.4k from Rust). However, Pony does have good support on [Zulip](https://ponylang.zulipchat.com/), where you can also ask questions and contribute to the community. Pony is also [open-source](https://github.com/ponylang/ponyc), allowing the community to point out issues and fix/implement functionality. From a learning perspective, Pony introduces a clean syntax, easy library usage and simple compilation/linking instructions. However, some of its peculiarities, such as its Reference Capabilities can make up a steep learning curve.  


## Scenarios Implemented

### [Scenario 1](https://github.com/antonioalmeida/feup-asso/tree/scenario1)

![scenario-1](assets/scenario-1.png)

* Unbounded queue;
* Publisher sends messages a.s.a.p.;
* Subscriber tries to pull messages and blocks (`awaits`) until it has one;
* *Implicit* subscription (fetch directly from data structure).

----

### [Scenario 2](https://github.com/antonioalmeida/feup-asso/tree/scenario2)

![scenario-2](assets/scenario-2.png)

* Unbounded queue and publishes asap (again);
* Multiple subscribers:
    * They pull messages concurrently;
    * Each gets a different message;
* *Implicit* subscription (fetch from data structure).

----

### [Scenario 3](https://github.com/antonioalmeida/feup-asso/tree/scenario3)

![scenario-3](assets/scenario-3.png)

* Unbounded queue and publishes asap (again);
* *Ventilator* (or Subscription Manager) knows about the subscribers:
    * [Observer](https://en.wikipedia.org/wiki/Observer_pattern) used to push to subscribers (*Explicit* subscription);
    * Different specializations of *ventilators* ([Fanout](https://en.wikipedia.org/wiki/Fan-out_(software)), Round-robin...).
    
----

### [Scenario 4](https://github.com/antonioalmeida/feup-asso/tree/scenario4)

![scenario-4](assets/scenario-4.png)

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

----

### [Scenario 5](https://github.com/antonioalmeida/feup-asso/tree/scenario5)

![scenario-5](assets/scenario-5.png)
    
* Remove the notion of queue altogether;
* Instead, make use of Pony's messaging system, namely through Actor behaviours;

----

## Development 

### Setup
Install pony compiler [`ponyc`](https://github.com/ponylang/ponyc)

### Compile
```shell
# compile the package
$ make build/asso 

# compile tests
$ make build/test 
```

### Run

__Note:__ both these commands will compile the source if they're not built.
```shell

# run the package's Main
$ make run

# run tests
$ make test
```
