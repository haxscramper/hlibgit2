import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./sys/transport.nim"

type
  git_transport_message_cb* = proc (a0: cstring, a1: cint, a2: pointer): cint

  git_transport_cb* = proc (a0: `ptr` git_transport, a1: `ptr` git_remote, a2: pointer): cint

