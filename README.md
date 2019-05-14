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

#### v0.0.1

First attempt at Scenario 1 
![scenario-1](https://github.com/hugoferreira/asso-pipes-and-stuff-v19/raw/master/assets/scenario-1.png)

##### Pros
- "Everything" is asynchronous - no blocking calls
- Making use of the Actor Models and its messaging system on our advantage - through Pony's behaviours

#### Cons
- EVERYTHING is asynchronous - the change in mindset still hasn't kicked in, and the code reflects that
- Message ordering when publishing and consuming is not guaranteed - need to change the push/pull pattern and possibly look into [reference capabilities](https://tutorial.ponylang.io/reference-capabilities.html)

