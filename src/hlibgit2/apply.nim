import "./diff.nim"
import "./libgit2_config.nim"
import "./types.nim"

type
  c_git_apply_location_t* {.size: sizeof(cint).} = enum
    c_GIT_APPLY_LOCATION_WORKDIR = 0
    c_GIT_APPLY_LOCATION_INDEX   = 1
    c_GIT_APPLY_LOCATION_BOTH    = 2

  git_apply_location_t* = enum
    GIT_APPLY_LOCATION_WORKDIR
    GIT_APPLY_LOCATION_INDEX
    GIT_APPLY_LOCATION_BOTH

  git_apply_options* {.importc, bycopy.} = object
    version  *: cuint
    delta_cb *: git_apply_delta_cb
    hunk_cb  *: git_apply_hunk_cb
    payload  *: pointer
    flags    *: cuint

  git_apply_delta_cb* = proc (a0: `ptr` git_diff_delta, a1: pointer): cint

  git_apply_hunk_cb* = proc (a0: `ptr` git_diff_hunk, a1: pointer): cint

  c_git_apply_flags_t* {.size: sizeof(cint).} = enum
    c_GIT_APPLY_CHECK = 1 shl 0

  git_apply_flags_t* = enum
    GIT_APPLY_CHECK



converter toCInt*(arg: c_git_apply_location_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_apply_location_t]): cint =
  for value in items(args):
    case value:
      of GIT_APPLY_LOCATION_WORKDIR: result = cint(result or 0)
      of GIT_APPLY_LOCATION_INDEX  : result = cint(result or 1)
      of GIT_APPLY_LOCATION_BOTH   : result = cint(result or 2)

func `-`*(arg: c_git_apply_location_t, offset: int): cint = cast[c_git_apply_location_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_apply_location_t): cint = cast[c_git_apply_location_t](ord(arg) - offset)

func `+`*(arg: c_git_apply_location_t, offset: int): cint = cast[c_git_apply_location_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_apply_location_t): cint = cast[c_git_apply_location_t](ord(arg) + offset)

proc git_apply_options_init*(opts: `ptr` git_apply_options, version: cuint): cint {.git2Proc, importc.}

proc git_apply_to_tree*(`out`: `ptr` git_index, repo: `ptr` git_repository, preimage: `ptr` git_tree, diff: `ptr` git_diff, options: `ptr` git_apply_options): cint {.git2Proc, importc.}

proc git_apply*(repo: `ptr` git_repository, diff: `ptr` git_diff, location: git_apply_location_t, options: `ptr` git_apply_options): cint {.git2Proc, importc.}

converter toCInt*(arg: c_git_apply_flags_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_apply_flags_t]): cint =
  for value in items(args):
    case value:
      of GIT_APPLY_CHECK: result = cint(result or 1)

func `-`*(arg: c_git_apply_flags_t, offset: int): cint = cast[c_git_apply_flags_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_apply_flags_t): cint = cast[c_git_apply_flags_t](ord(arg) - offset)

func `+`*(arg: c_git_apply_flags_t, offset: int): cint = cast[c_git_apply_flags_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_apply_flags_t): cint = cast[c_git_apply_flags_t](ord(arg) + offset)