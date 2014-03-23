# redisSessions

This module provides Redis-backed session support for Jester applications.  

The following is a simple application that demonstrates usage:

```Nimrod
import jester, redissessions

redissessions.config("expiresMinutes", "1")

get "/saveit":
  session["data1"]="Saved"
  resp "ok"

get "/data":
  var outp = ""
  forall session:
    outp = outp & key & ": " & val
  resp outp

get "/loadit":
  resp session["data1"]

get "/notset":
  resp session["notset"]

get "/clearit":
  deleteSession

run()
```

## Configuring
```Nimrod
redissessions.config("expiresMinutes", "1", "host", "127.0.0.1")
```

## Saving a session variable
```Nimrod
session["varname"] = "some string"
```

## Reading a session variable
```Nimrod
resp "The data is " & session["varname"]
```

## Iterating over session variables
```Nimrod
forall session:
  echo key & ": " & val  # key and val injected by 'forall' template
```

## Clearing session data
```Nimrod
deleteSession
```
