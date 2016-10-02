import jester, asyncdispatch, htmlgen
import redissessions

redissessions.config("expiresMinutes", "1")

routes:
  get "/saveit":
    session["data1"]="Saved"
    resp "ok"

  get "/data":
    var outp = ""
    forall redissessions.session:
      outp = outp & key & ": " & val
    resp outp

  get "/loadit":
    resp session["data1"]

  get "/notset":
    resp session["notset"]

  get "/clearit":
    deleteSession
    resp "Session deleted"

runForever()

