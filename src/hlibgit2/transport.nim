{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

type
  git_transport_cb* = proc(arg_out: ptr ptr git_transport, owner: ptr git_remote, param: pointer): cint{.cdecl.}
   
  git_transport_cbNim* = proc(arg_out: ptr ptr git_transport, owner: ptr git_remote): cint
   
  git_transport_message_cb* = proc(str: cstring, len: cint, payload: pointer): cint{.cdecl.}
   
  git_transport_message_cbNim* = proc(str: cstring, len: cint): cint
   
