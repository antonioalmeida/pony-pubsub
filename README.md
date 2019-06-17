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

### v0.1.0.0

Started Scenario 3

![scenario-3](https://github.com/hugoferreira/asso-pipes-and-stuff-v19/raw/master/assets/scenario-3.png)

* Unbounded queue and publishes asap;
* *Ventilator* (or Subscription Manager) knows about the subscribers:
    * [Observer](https://en.wikipedia.org/wiki/Observer_pattern) used to push to subscribers (*Explicit* subscription);
    * Different specializations of *ventilators* ([Fanout](https://en.wikipedia.org/wiki/Fan-out_(software)), Round-robin...).
