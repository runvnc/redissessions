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