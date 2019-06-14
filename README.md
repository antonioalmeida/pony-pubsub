# Publish-Subscriber scenarios using an Actor-Model programming language

We implemented different scenarios (explicited below) using **Pony**. From Pony's [website](https://www.ponylang.io/): *"Pony is an open-source, object-oriented, actor-model, capabilities-secure, high-performance programming language."*

## Scenarios to Implement

- [Scenario 1](https://github.com/antonioalmeida/feup-asso/tree/scenario1)
- [Scenario 2](https://github.com/antonioalmeida/feup-asso/tree/scenario2)
- [Scenario 3](https://github.com/antonioalmeida/feup-asso/tree/scenario3)
- [Scenario 4](https://github.com/antonioalmeida/feup-asso/tree/scenario4)










## Design Patterns to Consider

| Design Pattern  | Link                                                   |
|-----------------|--------------------------------------------------------|
| Singleton       |  https://sourcemaking.com/design_patterns/singleton    |
| Builder         |  https://sourcemaking.com/design_patterns/builder      |
| Composite       |  https://sourcemaking.com/design_patterns/composite    |
| Flyweight       |  https://sourcemaking.com/design_patterns/flyweight    |
| Command         |  https://sourcemaking.com/design_patterns/command      |
| Iterator        |  https://sourcemaking.com/design_patterns/iterator     |
| Null Object     |  https://sourcemaking.com/design_patterns/null_object  |
| Visitor         |  https://sourcemaking.com/design_patterns/visitor      |
| ...             |  more to come                                          |


### Notes on the Design Patterns

**[Observer](https://en.wikipedia.org/wiki/Actor_model)**: ```For example, an Actor might need to send a message to a recipient Actor from which it later expects to receive a response, but the response will actually be handled by a third Actor component that has been configured to receive and handle the response (for example, a different Actor implementing the Observer pattern). The original Actor could accomplish this by sending a communication that includes the message it wishes to send, along with the address of the third Actor that will handle the response. This third Actor that will handle the response is called the resumption (sometimes also called a continuation or stack frame). When the recipient Actor is ready to send a response, it sends the response message to the resumption Actor address that was included in the original communication.```

**[Option Pattern](https://www.codeproject.com/Articles/17607/The-Option-Pattern)**: ![option_pattern](assets/option_pattern.PNG "Pony Option Pattern")


### Notes on Pony
![capabilities](assets/capabilities_pony.PNG "Pony Capabilities Table")


## Possibilities

#### Quantum Computing 
  - Design comparisons/implementations of CC design patterns/logical operations on QC, with a pedagogical goal in mind
     - Design Patterns in QC - too ambitious?
     - Low level logical operations - already extensively covered?
     - What is the sweet spot?
  - Alternative: analyse [Qiskit's](https://qiskit.org/) architetucture

#### Rust / Scala / [OOP language that has typeclasses]
  - Approach commons design problems and implement them
  - By relying solely on [typeclasses](https://medium.com/@olxc/type-classes-explained-a9767f64ed2c) instead of the "OOP way"
  
####  Pony
  - Approach common design problems and implement them
  - As Pony is OOP based, we can start from common patterns and approach the problems they're trying to solve
