{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./types

type
  git_transport_cb* = proc(arg_out: ptr ptr git_transport,
                           owner:   ptr git_remote,
                           param:   pointer): cint{.cdecl.}

  git_transport_message_cb* = proc(str:     cstring,
                                   len:     cint,
                                   payload: pointer): cint{.cdecl.}


