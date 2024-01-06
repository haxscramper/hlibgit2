import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./oid.nim"

type
  git_attr_options* {.header: "<attr.h>", importc, bycopy.} = object
    version        *: cuint
    flags          *: cuint
    commit_id      *: ptr git_oid
    attr_commit_id *: git_oid

  c_git_attr_value_t* {.size: sizeof(cint).} = enum
    c_GIT_ATTR_VALUE_UNSPECIFIED = 0
    c_GIT_ATTR_VALUE_TRUE        = 1
    c_GIT_ATTR_VALUE_FALSE       = 2
    c_GIT_ATTR_VALUE_STRING      = 3

  git_attr_value_t* = enum
    GIT_ATTR_VALUE_UNSPECIFIED = 0
    GIT_ATTR_VALUE_TRUE        = 1
    GIT_ATTR_VALUE_FALSE       = 2
    GIT_ATTR_VALUE_STRING      = 3

  git_attr_foreach_cb* = proc (a0: cstring, a1: cstring, a2: pointer): cint



proc git_attr_get_ext*(
    value_out: cstringArray,
    repo: ptr git_repository,
    opts: ptr git_attr_options,
    path: cstring,
    name: cstring,
): cint {.importc: "git_attr_get_ext", header: "<attr.h>".}

proc git_attr_get_many*(
    values_out: cstringArray,
    repo: ptr git_repository,
    flags: uint32,
    path: cstring,
    num_attr: csize_t,
    names: cstringArray,
): cint {.importc: "git_attr_get_many", header: "<attr.h>".}

proc git_attr_get_many_ext*(
    values_out: cstringArray,
    repo: ptr git_repository,
    opts: ptr git_attr_options,
    path: cstring,
    num_attr: csize_t,
    names: cstringArray,
): cint {.importc: "git_attr_get_many_ext", header: "<attr.h>".}

proc git_attr_foreach*(
    repo: ptr git_repository,
    flags: uint32,
    path: cstring,
    callback: git_attr_foreach_cb,
    payload: pointer,
): cint {.importc: "git_attr_foreach", header: "<attr.h>".}

proc git_attr_foreach_ext*(
    repo: ptr git_repository,
    opts: ptr git_attr_options,
    path: cstring,
    callback: git_attr_foreach_cb,
    payload: pointer,
): cint {.importc: "git_attr_foreach_ext", header: "<attr.h>".}

proc git_attr_cache_flush*(repo: ptr git_repository): cint {.importc: "git_attr_cache_flush", header: "<attr.h>".}

proc git_attr_add_macro*(
    repo: ptr git_repository,
    name: cstring,
    values: cstring,
): cint {.importc: "git_attr_add_macro", header: "<attr.h>".}

converter to_git_attr_value_t*(arg: c_git_attr_value_t): git_attr_value_t =
  case arg:
    of c_GIT_ATTR_VALUE_UNSPECIFIED: GIT_ATTR_VALUE_UNSPECIFIED
    of c_GIT_ATTR_VALUE_TRUE       : GIT_ATTR_VALUE_TRUE
    of c_GIT_ATTR_VALUE_FALSE      : GIT_ATTR_VALUE_FALSE
    of c_GIT_ATTR_VALUE_STRING     : GIT_ATTR_VALUE_STRING

proc to_c_git_attr_value_t*(arg: git_attr_value_t): c_git_attr_value_t =
  case arg:
    of GIT_ATTR_VALUE_UNSPECIFIED: c_GIT_ATTR_VALUE_UNSPECIFIED
    of GIT_ATTR_VALUE_TRUE       : c_GIT_ATTR_VALUE_TRUE
    of GIT_ATTR_VALUE_FALSE      : c_GIT_ATTR_VALUE_FALSE
    of GIT_ATTR_VALUE_STRING     : c_GIT_ATTR_VALUE_STRING

converter toCInt*(arg: c_git_attr_value_t): cint = cint(ord(arg))

converter toCInt*(arg: git_attr_value_t): cint = cint(ord(to_c_git_attr_value_t(arg)))

converter toCInt*(args: set[git_attr_value_t]): cint =
  for value in items(args):
    case value:
      of GIT_ATTR_VALUE_UNSPECIFIED: result = cint(result or 0)
      of GIT_ATTR_VALUE_TRUE       : result = cint(result or 1)
      of GIT_ATTR_VALUE_FALSE      : result = cint(result or 2)
      of GIT_ATTR_VALUE_STRING     : result = cint(result or 3)

func `-`*(arg: c_git_attr_value_t, offset: int): cint = cast[c_git_attr_value_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_attr_value_t): cint = cast[c_git_attr_value_t](ord(arg) - offset)

func `+`*(arg: c_git_attr_value_t, offset: int): cint = cast[c_git_attr_value_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_attr_value_t): cint = cast[c_git_attr_value_t](ord(arg) + offset)

proc git_attr_value*(attr: cstring): git_attr_value_t {.importc: "git_attr_value", header: "<attr.h>".}

proc git_attr_get*(
    value_out: cstringArray,
    repo: ptr git_repository,
    flags: uint32,
    path: cstring,
    name: cstring,
): cint {.importc: "git_attr_get", header: "<attr.h>".}