kv-bash [![Build Status](https://travis-ci.org/damphat/kv-bash.png?branch=master)](https://travis-ci.org/damphat/kv-bash)
=====================
**About**
 - tiny key/value dabatase
 - database store in home directory
 - each user has 1 database
 - usage by importing 5 bash functions via ```$ source ./kv-bash```
 - forked from https://github.com/damphat/kv-bash
 - https://travis-ci.org/damphat/kv-bash
 
**Requirements**

unix-like environement, no dependencies

**Usage**

import all database functions

```
$ source ./kv-bash         # import kv-bash functions
```

use database functions

```bash
kvset <key> <value>                       # create or change value of key
kvget <key> [<default-value>]             # get value of key or get the optional default
kvdel <key> [type: key|path|all]          # delete key or path
                                          #   type=key -> just delete key 
                                          #   type=path -> just delete path (all keys below <key>!) 
                                          #   type=all -> delete key and path 
kvfind <key> [<path>] [<type>: [k][v]     # find entries by key. type defines what is returned key, value or both
kvgrep <value> [<path>] [<type>: [k][v]]  # find entries by value. type defines what is returned key, value or both
kvlist [<path>] [<type>: [j][r][k][v]]    # list all current key/value pairs. 
                                          #   format=j -> mark folders with a trailing @. useful when json-formatting
                                          #   format=r -> list keys recursively
                                          #   format=k -> show key
                                          #   format=v -> show value
                                          # all types can be combined 
kvexists <key>                            # checks if a key exists
kvflush_garbage                           # removes all empty folders from database
kvclear                                   # clear database
```

**Keys**

A keys can be organized in folders, where the slash is the separator for building
the tree structure. Unlike in file systems, a key can be a folder with subkeys and have a value at the same time. Internally this is mangaged by naming folders with a trailing @ sign. Therefore you cannot have an @ sign as part of the key name.

**Examples**

```bash 
source ./kv-bash
kvclear
kvset user mr.bob
kvset pass abc@123
kvset users/john mr.john
kvset users/jane ms.jane
kvset users foo
kvlist
```

```plain
pass=abc@123
user=mr.bob
users=foo
users={}
```

```bash 
kvlist / r
```

```plain
pass=abc@123
user=mr.bob
users=foo
users/jane=ms.jane
users/john=mr.john
```

As json cannot have keys having values and children at the same time, you can `kvlist / jr` in order to mark folders with a trailing @ sign. So json can distinguish folder from keys

```plain
pass=abc@123
user=mr.bob
users=foo
users@/jane=ms.jane
users@/john=mr.john
```

```bash
kvlist / rj | jo -p -d/
```
 
will give you a json string:
```plain
{
   "pass": "abc@123",
   "user": "mr.bob",
   "users": "foo",
   "users@": {
      "jane": "ms.jane",
      "john": "mr.john"
   }
}
```

```bash
kvget user
mr.bob
kvget pass
abc@123
kvdel pass
kvget pass

kvclear
```

**Run tests**

```
git clone https://github.com/damphat/kv-bash.git
cd kv-bash
./kv-test
```

test result

```
RUN ALL TEST CASES:
===================
  1 call kvget for non-exist key should return empty  [  OK  ]
  2 kvset then kvget a variable                       [  OK  ]
  3 kvset then kvset again with different value       [  OK  ]
  4 deleted variable should be empty                  [  OK  ]
  5 kvdel non exist should be OK                      [  OK  ]
  6 kvset without param return error                  [  OK  ]
  7 kvget without param return error                  [  OK  ]
  8 kvdel without param return error                  [  OK  ]
  9 kvset 3 keys/value; kvlist => line count = 3      [  OK  ]
 10 non-exist-var => empty value => line count = 1    [  OK  ]
 11 kvclear; kvlist => line count = 0                 [  OK  ]
 12 kvget return empty value => error code != 0       [  OK  ]
 13 spaces in value                                   [  OK  ]
```

```bash
$ cd kv-bash/t

$ t/test_key_validator.sh testcases.t 
-> no output if all is ok

$ t/test_key_validator.sh testcases.t -v
-> show passed tests too

$ t/test_key_validator.sh testcases.t -vv
-> show passed tests too and show debug info on failed tests
```
