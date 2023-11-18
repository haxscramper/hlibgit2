type

  git_transport_message_cb = proc (a0: cstring, a1: cint, a2: ptr void): cint
  git_transport_cb = proc (a0: ptr git_transport, a1: ptr git_remote, a2: ptr void): cint

