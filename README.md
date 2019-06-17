# Scenario 3

![scenario-3](assets/scenario-3.png)

## "Changelog"

### v1.0

Started Scenario 3.

* Unbounded queue and publishes asap;
* *Ventilator* (or Subscription Manager) knows about the subscribers:
    * [Observer](https://en.wikipedia.org/wiki/Observer_pattern) used to push to subscribers (*Explicit* subscription);
    * Different specializations of *ventilators* ([Fanout](https://en.wikipedia.org/wiki/Fan-out_(software)), Round-robin...).
