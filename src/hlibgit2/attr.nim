{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

type
  git_attr_foreach_cb* = proc(name: cstring, value: cstring, payload: pointer): cint{.cdecl.}
   
  git_attr_foreach_cbNim* = proc(name: cstring, value: cstring): cint
   
  git_attr_value_t* = enum
    GIT_ATTR_VALUE_UNSPECIFIED = 0
    GIT_ATTR_VALUE_TRUE = 1 ## The attribute has been left unspecified 
    GIT_ATTR_VALUE_FALSE = 2 ## The attribute has been set 
    GIT_ATTR_VALUE_STRING = 3 ## The attribute has been unset 
   

proc git_attr_value*(
    attr: cstring
  ): git_attr_value_t {.dynlib: libgitDl, importc.}


proc git_attr_get*(
    value_out: ptr cstring,
    repo:      ptr git_repository,
    flags:     uint32,
    path:      cstring,
    name:      cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_attr_get_many*(
    values_out: ptr cstring,
    repo:       ptr git_repository,
    flags:      uint32,
    path:       cstring,
    num_attr:   csize_t,
    names:      ptr cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_attr_foreach*(
    repo:     ptr git_repository,
    flags:    uint32,
    path:     cstring,
    callback: git_attr_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_attr_cache_flush*(
    repo: ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_attr_add_macro*(
    repo:   ptr git_repository,
    name:   cstring,
    values: cstring
  ): cint {.dynlib: libgitDl, importc.}


