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


#### v0.0.0.2

The file _generators.pony_ clearly needs refactoring but for now the production/consumption of messages is automated using [Timers](https://stdlib.ponylang.io/time-Timer/)
