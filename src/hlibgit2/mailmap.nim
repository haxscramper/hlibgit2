{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

proc git_mailmap_new*(
    arg_out: ptr ptr git_mailmap
  ): cint {.dynlib: libgitDl, importc.}


proc git_mailmap_free*(mm: ptr git_mailmap): void {.dynlib: libgitDl, importc.}


proc git_mailmap_add_entry*(
    mm:            ptr git_mailmap,
    real_name:     cstring,
    real_email:    cstring,
    replace_name:  cstring,
    replace_email: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_mailmap_from_buffer*(
    arg_out: ptr ptr git_mailmap,
    buf:     cstring,
    len:     csize_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_mailmap_from_repository*(
    arg_out: ptr ptr git_mailmap,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_mailmap_resolve*(
    real_name:  ptr cstring,
    real_email: ptr cstring,
    mm:         ptr git_mailmap,
    name:       cstring,
    email:      cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_mailmap_resolve_signature*(
    arg_out: ptr ptr git_signature,
    mm:      ptr git_mailmap,
    sig:     ptr git_signature
  ): cint {.dynlib: libgitDl, importc.}


