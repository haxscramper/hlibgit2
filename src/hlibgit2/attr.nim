{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_attr_value_t* {.size: sizeof(cint).} = enum
    c_GIT_ATTR_VALUE_UNSPECIFIED = 0
    c_GIT_ATTR_VALUE_TRUE        = 1 ## The attribute has been left unspecified
    c_GIT_ATTR_VALUE_FALSE       = 2 ## The attribute has been set
    c_GIT_ATTR_VALUE_STRING      = 3 ## The attribute has been unset

  git_attr_foreach_cb* = proc(name:    cstring,
                              value:   cstring,
                              payload: pointer): cint{.cdecl.}

  git_attr_options* {.bycopy, header: "<git2/attr.h>", importc.} = object
    ## This attribute has a value
    version*:   cuint
    flags*:     cuint       ## A combination of GIT_ATTR_CHECK flags
    commit_id*: ptr git_oid

  git_attr_value_t* = enum
    GIT_ATTR_VALUE_UNSPECIFIED
    GIT_ATTR_VALUE_TRUE        ## The attribute has been left unspecified
    GIT_ATTR_VALUE_FALSE       ## The attribute has been set
    GIT_ATTR_VALUE_STRING      ## The attribute has been unset


proc to_c_git_attr_value_t*(arg: git_attr_value_t): c_git_attr_value_t =
  case arg:
    of GIT_ATTR_VALUE_UNSPECIFIED: c_GIT_ATTR_VALUE_UNSPECIFIED
    of GIT_ATTR_VALUE_TRUE:        c_GIT_ATTR_VALUE_TRUE
    of GIT_ATTR_VALUE_FALSE:       c_GIT_ATTR_VALUE_FALSE
    of GIT_ATTR_VALUE_STRING:      c_GIT_ATTR_VALUE_STRING


converter to_git_attr_value_t*(arg: c_git_attr_value_t): git_attr_value_t =
  case arg:
    of c_GIT_ATTR_VALUE_UNSPECIFIED: GIT_ATTR_VALUE_UNSPECIFIED
    of c_GIT_ATTR_VALUE_TRUE:        GIT_ATTR_VALUE_TRUE
    of c_GIT_ATTR_VALUE_FALSE:       GIT_ATTR_VALUE_FALSE
    of c_GIT_ATTR_VALUE_STRING:      GIT_ATTR_VALUE_STRING


converter toCint*(arg: c_git_attr_value_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_attr_value_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_attr_value_t(arg)))

func `+`*(arg: c_git_attr_value_t, offset: int): c_git_attr_value_t =
  cast[c_git_attr_value_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_attr_value_t): c_git_attr_value_t =
  cast[c_git_attr_value_t](ord(arg) + offset)

func `-`*(arg: c_git_attr_value_t, offset: int): c_git_attr_value_t =
  cast[c_git_attr_value_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_attr_value_t): c_git_attr_value_t =
  cast[c_git_attr_value_t](ord(arg) - offset)


proc git_attr_value*(attr: cstring): c_git_attr_value_t {.git2Proc, importc.}



proc git_attr_get*(
    value_out: ptr cstring,
    repo:      ptr git_repository,
    flags:     uint32,
    path:      cstring,
    name:      cstring
  ): cint {.git2Proc, importc.}



proc git_attr_get_ext*(
    value_out: ptr cstring,
    repo:      ptr git_repository,
    opts:      ptr git_attr_options,
    path:      cstring,
    name:      cstring
  ): cint {.git2Proc, importc.}



proc git_attr_get_many*(
    values_out: ptr cstring,
    repo:       ptr git_repository,
    flags:      uint32,
    path:       cstring,
    num_attr:   csize_t,
    names:      ptr cstring
  ): cint {.git2Proc, importc.}



proc git_attr_get_many_ext*(
    values_out: ptr cstring,
    repo:       ptr git_repository,
    opts:       ptr git_attr_options,
    path:       cstring,
    num_attr:   csize_t,
    names:      ptr cstring
  ): cint {.git2Proc, importc.}



proc git_attr_foreach*(
    repo:     ptr git_repository,
    flags:    uint32,
    path:     cstring,
    callback: git_attr_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_attr_foreach_ext*(
    repo:     ptr git_repository,
    opts:     ptr git_attr_options,
    path:     cstring,
    callback: git_attr_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_attr_cache_flush*(repo: ptr git_repository): cint {.git2Proc, importc.}



proc git_attr_add_macro*(
    repo:   ptr git_repository,
    name:   cstring,
    values: cstring
  ): cint {.git2Proc, importc.}



