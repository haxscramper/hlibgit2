import
  ./libgit_config

import
  ./types

proc git_signature_new*(
    arg_out: ptr ptr git_signature,
    name:    cstring,
    email:   cstring,
    time:    git_time_t,
    offset:  cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_signature_now*(
    arg_out: ptr ptr git_signature,
    name:    cstring,
    email:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_signature_default*(
    arg_out: ptr ptr git_signature,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_signature_from_buffer*(
    arg_out: ptr ptr git_signature,
    buf:     cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_signature_dup*(
    dest: ptr ptr git_signature,
    sig:  ptr git_signature
  ): cint {.dynlib: libgitDl, importc.}


proc git_signature_free*(
    sig: ptr git_signature
  ): void {.dynlib: libgitDl, importc.}


