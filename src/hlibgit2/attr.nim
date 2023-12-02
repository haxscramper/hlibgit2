import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./types.nim"

type
  git_attr_options* {.importc, bycopy.} = object
    version        *: cuint
    flags          *: cuint
    commit_id      *: `ptr` git_oid
    attr_commit_id *: git_oid

  c_git_attr_value_t* {.size: sizeof(cint).} = enum
    c_GIT_ATTR_VALUE_UNSPECIFIED = 0
    c_GIT_ATTR_VALUE_TRUE        = 1
    c_GIT_ATTR_VALUE_FALSE       = 2
    c_GIT_ATTR_VALUE_STRING      = 3

  git_attr_value_t* = enum
    GIT_ATTR_VALUE_UNSPECIFIED
    GIT_ATTR_VALUE_TRUE
    GIT_ATTR_VALUE_FALSE
    GIT_ATTR_VALUE_STRING

  git_attr_foreach_cb* = proc (a0: cstring, a1: cstring, a2: pointer): cint



converter toCInt*(arg: c_git_attr_value_t): cint = cint(ord(arg))

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

proc git_attr_value*(attr: cstring): git_attr_value_t {.git2Proc, importc: "git_attr_value".}

proc git_attr_get*(value_out: cstring, repo: `ptr` git_repository, flags: uint32, path: cstring, name: cstring): cint {.git2Proc, importc: "git_attr_get".}

proc git_attr_get_ext*(value_out: cstring, repo: `ptr` git_repository, opts: `ptr` git_attr_options, path: cstring, name: cstring): cint {.git2Proc, importc: "git_attr_get_ext".}

proc git_attr_get_many*(values_out: cstring, repo: `ptr` git_repository, flags: uint32, path: cstring, num_attr: csize_t, names: cstring): cint {.git2Proc, importc: "git_attr_get_many".}

proc git_attr_get_many_ext*(values_out: cstring, repo: `ptr` git_repository, opts: `ptr` git_attr_options, path: cstring, num_attr: csize_t, names: cstring): cint {.git2Proc, importc: "git_attr_get_many_ext".}

proc git_attr_foreach*(repo: `ptr` git_repository, flags: uint32, path: cstring, callback: git_attr_foreach_cb, payload: pointer): cint {.git2Proc, importc: "git_attr_foreach".}

proc git_attr_foreach_ext*(repo: `ptr` git_repository, opts: `ptr` git_attr_options, path: cstring, callback: git_attr_foreach_cb, payload: pointer): cint {.git2Proc, importc: "git_attr_foreach_ext".}

proc git_attr_cache_flush*(repo: `ptr` git_repository): cint {.git2Proc, importc: "git_attr_cache_flush".}

proc git_attr_add_macro*(repo: `ptr` git_repository, name: cstring, values: cstring): cint {.git2Proc, importc: "git_attr_add_macro".}