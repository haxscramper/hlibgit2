import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./diff.nim"

type
  git_apply_options* {.header: "<apply.h>", importc, bycopy.} = object
    version  *: cuint
    delta_cb *: git_apply_delta_cb
    hunk_cb  *: git_apply_hunk_cb
    payload  *: pointer
    flags    *: cuint

  c_git_apply_flags_t* {.size: sizeof(cint).} = enum
    c_GIT_APPLY_CHECK = 1 shl 0

  git_apply_flags_t* = enum
    GIT_APPLY_CHECK = 0

  c_git_apply_location_t* {.size: sizeof(cint).} = enum
    c_GIT_APPLY_LOCATION_WORKDIR = 0
    c_GIT_APPLY_LOCATION_INDEX   = 1
    c_GIT_APPLY_LOCATION_BOTH    = 2

  git_apply_location_t* = enum
    GIT_APPLY_LOCATION_WORKDIR = 0
    GIT_APPLY_LOCATION_INDEX   = 1
    GIT_APPLY_LOCATION_BOTH    = 2

  git_apply_delta_cb* = proc (a0: ptr git_diff_delta, a1: pointer): cint

  git_apply_hunk_cb* = proc (a0: ptr git_diff_hunk, a1: pointer): cint



converter to_git_apply_flags_t*(arg: c_git_apply_flags_t): git_apply_flags_t =
  case arg:
    of c_GIT_APPLY_CHECK: GIT_APPLY_CHECK

proc to_c_git_apply_flags_t*(arg: git_apply_flags_t): c_git_apply_flags_t =
  case arg:
    of GIT_APPLY_CHECK: c_GIT_APPLY_CHECK

converter toCInt*(arg: c_git_apply_flags_t): cint = cint(ord(arg))

converter toCInt*(arg: git_apply_flags_t): cint = cint(ord(to_c_git_apply_flags_t(arg)))

converter toCInt*(args: set[git_apply_flags_t]): cint =
  for value in items(args):
    case value:
      of GIT_APPLY_CHECK: result = cint(result or 1)

func `-`*(arg: c_git_apply_flags_t, offset: int): cint = cast[c_git_apply_flags_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_apply_flags_t): cint = cast[c_git_apply_flags_t](ord(arg) - offset)

func `+`*(arg: c_git_apply_flags_t, offset: int): cint = cast[c_git_apply_flags_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_apply_flags_t): cint = cast[c_git_apply_flags_t](ord(arg) + offset)

converter to_git_apply_location_t*(arg: c_git_apply_location_t): git_apply_location_t =
  case arg:
    of c_GIT_APPLY_LOCATION_WORKDIR: GIT_APPLY_LOCATION_WORKDIR
    of c_GIT_APPLY_LOCATION_INDEX  : GIT_APPLY_LOCATION_INDEX
    of c_GIT_APPLY_LOCATION_BOTH   : GIT_APPLY_LOCATION_BOTH

proc to_c_git_apply_location_t*(arg: git_apply_location_t): c_git_apply_location_t =
  case arg:
    of GIT_APPLY_LOCATION_WORKDIR: c_GIT_APPLY_LOCATION_WORKDIR
    of GIT_APPLY_LOCATION_INDEX  : c_GIT_APPLY_LOCATION_INDEX
    of GIT_APPLY_LOCATION_BOTH   : c_GIT_APPLY_LOCATION_BOTH

converter toCInt*(arg: c_git_apply_location_t): cint = cint(ord(arg))

converter toCInt*(arg: git_apply_location_t): cint = cint(ord(to_c_git_apply_location_t(arg)))

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

proc git_apply_options_init*(opts: ptr git_apply_options, version: cuint): cint {.importc: "git_apply_options_init", header: "<apply.h>".}

proc git_apply_to_tree*(
    `out`: ptr ptr git_index,
    repo: ptr git_repository,
    preimage: ptr git_tree,
    diff: ptr git_diff,
    options: ptr git_apply_options,
): cint {.importc: "git_apply_to_tree", header: "<apply.h>".}

proc git_apply*(
    repo: ptr git_repository,
    diff: ptr git_diff,
    location: git_apply_location_t,
    options: ptr git_apply_options,
): cint {.importc: "git_apply", header: "<apply.h>".}