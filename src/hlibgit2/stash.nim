import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./strarray.nim"
import "./checkout.nim"
import "./oid.nim"

type
  git_stash_apply_options* {.importc, bycopy.} = object
    version          *: cuint
    flags            *: uint32
    checkout_options *: git_checkout_options
    progress_cb      *: git_stash_apply_progress_cb
    progress_payload *: pointer

  c_git_stash_flags* {.size: sizeof(cint).} = enum
    c_GIT_STASH_DEFAULT           = 0
    c_GIT_STASH_KEEP_INDEX        = 1
    c_GIT_STASH_INCLUDE_UNTRACKED = 2
    c_GIT_STASH_INCLUDE_IGNORED   = 1 shl 2
    c_GIT_STASH_KEEP_ALL          = 1 shl 3

  git_stash_flags* = enum
    GIT_STASH_DEFAULT           = 0
    GIT_STASH_KEEP_INDEX        = 1
    GIT_STASH_INCLUDE_UNTRACKED = 2
    GIT_STASH_INCLUDE_IGNORED   = 3
    GIT_STASH_KEEP_ALL          = 4

  c_git_stash_apply_flags* {.size: sizeof(cint).} = enum
    c_GIT_STASH_APPLY_DEFAULT         = 0
    c_GIT_STASH_APPLY_REINSTATE_INDEX = 1

  git_stash_apply_flags* = enum
    GIT_STASH_APPLY_DEFAULT         = 0
    GIT_STASH_APPLY_REINSTATE_INDEX = 1

  c_git_stash_apply_progress_t* {.size: sizeof(cint).} = enum
    c_GIT_STASH_APPLY_PROGRESS_NONE               = 0
    c_GIT_STASH_APPLY_PROGRESS_LOADING_STASH      = 1
    c_GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX      = 2
    c_GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED   = 3
    c_GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED  = 4
    c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = 5
    c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED  = 6
    c_GIT_STASH_APPLY_PROGRESS_DONE               = 7

  git_stash_apply_progress_t* = enum
    GIT_STASH_APPLY_PROGRESS_NONE               = 0
    GIT_STASH_APPLY_PROGRESS_LOADING_STASH      = 1
    GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX      = 2
    GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED   = 3
    GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED  = 4
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = 5
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED  = 6
    GIT_STASH_APPLY_PROGRESS_DONE               = 7

  git_stash_apply_progress_cb* = proc (a0: git_stash_apply_progress_t, a1: pointer): cint

  git_stash_cb* = proc (a0: csize_t, a1: cstring, a2: ptr git_oid, a3: pointer): cint

  git_stash_save_options* {.importc, bycopy.} = object
    version *: cuint
    flags   *: uint32
    stasher *: ptr git_signature
    message *: cstring
    paths   *: git_strarray



converter to_git_stash_flags*(arg: c_git_stash_flags): git_stash_flags =
  case arg:
    of c_GIT_STASH_DEFAULT          : GIT_STASH_DEFAULT
    of c_GIT_STASH_KEEP_INDEX       : GIT_STASH_KEEP_INDEX
    of c_GIT_STASH_INCLUDE_UNTRACKED: GIT_STASH_INCLUDE_UNTRACKED
    of c_GIT_STASH_INCLUDE_IGNORED  : GIT_STASH_INCLUDE_IGNORED
    of c_GIT_STASH_KEEP_ALL         : GIT_STASH_KEEP_ALL

proc to_c_git_stash_flags*(arg: git_stash_flags): c_git_stash_flags =
  case arg:
    of GIT_STASH_DEFAULT          : c_GIT_STASH_DEFAULT
    of GIT_STASH_KEEP_INDEX       : c_GIT_STASH_KEEP_INDEX
    of GIT_STASH_INCLUDE_UNTRACKED: c_GIT_STASH_INCLUDE_UNTRACKED
    of GIT_STASH_INCLUDE_IGNORED  : c_GIT_STASH_INCLUDE_IGNORED
    of GIT_STASH_KEEP_ALL         : c_GIT_STASH_KEEP_ALL

converter toCInt*(arg: c_git_stash_flags): cint = cint(ord(arg))

converter toCInt*(arg: git_stash_flags): cint = cint(ord(to_c_git_stash_flags(arg)))

converter toCInt*(args: set[git_stash_flags]): cint =
  for value in items(args):
    case value:
      of GIT_STASH_DEFAULT          : result = cint(result or 0)
      of GIT_STASH_KEEP_INDEX       : result = cint(result or 1)
      of GIT_STASH_INCLUDE_UNTRACKED: result = cint(result or 2)
      of GIT_STASH_INCLUDE_IGNORED  : result = cint(result or 4)
      of GIT_STASH_KEEP_ALL         : result = cint(result or 8)

func `-`*(arg: c_git_stash_flags, offset: int): cint = cast[c_git_stash_flags](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_stash_flags): cint = cast[c_git_stash_flags](ord(arg) - offset)

func `+`*(arg: c_git_stash_flags, offset: int): cint = cast[c_git_stash_flags](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_stash_flags): cint = cast[c_git_stash_flags](ord(arg) + offset)

converter to_git_stash_apply_flags*(arg: c_git_stash_apply_flags): git_stash_apply_flags =
  case arg:
    of c_GIT_STASH_APPLY_DEFAULT        : GIT_STASH_APPLY_DEFAULT
    of c_GIT_STASH_APPLY_REINSTATE_INDEX: GIT_STASH_APPLY_REINSTATE_INDEX

proc to_c_git_stash_apply_flags*(arg: git_stash_apply_flags): c_git_stash_apply_flags =
  case arg:
    of GIT_STASH_APPLY_DEFAULT        : c_GIT_STASH_APPLY_DEFAULT
    of GIT_STASH_APPLY_REINSTATE_INDEX: c_GIT_STASH_APPLY_REINSTATE_INDEX

converter toCInt*(arg: c_git_stash_apply_flags): cint = cint(ord(arg))

converter toCInt*(arg: git_stash_apply_flags): cint = cint(ord(to_c_git_stash_apply_flags(arg)))

converter toCInt*(args: set[git_stash_apply_flags]): cint =
  for value in items(args):
    case value:
      of GIT_STASH_APPLY_DEFAULT        : result = cint(result or 0)
      of GIT_STASH_APPLY_REINSTATE_INDEX: result = cint(result or 1)

func `-`*(arg: c_git_stash_apply_flags, offset: int): cint = cast[c_git_stash_apply_flags](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_stash_apply_flags): cint = cast[c_git_stash_apply_flags](ord(arg) - offset)

func `+`*(arg: c_git_stash_apply_flags, offset: int): cint = cast[c_git_stash_apply_flags](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_stash_apply_flags): cint = cast[c_git_stash_apply_flags](ord(arg) + offset)

converter to_git_stash_apply_progress_t*(arg: c_git_stash_apply_progress_t): git_stash_apply_progress_t =
  case arg:
    of c_GIT_STASH_APPLY_PROGRESS_NONE              : GIT_STASH_APPLY_PROGRESS_NONE
    of c_GIT_STASH_APPLY_PROGRESS_LOADING_STASH     : GIT_STASH_APPLY_PROGRESS_LOADING_STASH
    of c_GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX     : GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX
    of c_GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED  : GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED
    of c_GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED : GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED
    of c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED: GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED
    of c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED : GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED
    of c_GIT_STASH_APPLY_PROGRESS_DONE              : GIT_STASH_APPLY_PROGRESS_DONE

proc to_c_git_stash_apply_progress_t*(arg: git_stash_apply_progress_t): c_git_stash_apply_progress_t =
  case arg:
    of GIT_STASH_APPLY_PROGRESS_NONE              : c_GIT_STASH_APPLY_PROGRESS_NONE
    of GIT_STASH_APPLY_PROGRESS_LOADING_STASH     : c_GIT_STASH_APPLY_PROGRESS_LOADING_STASH
    of GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX     : c_GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX
    of GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED  : c_GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED
    of GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED : c_GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED
    of GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED: c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED
    of GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED : c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED
    of GIT_STASH_APPLY_PROGRESS_DONE              : c_GIT_STASH_APPLY_PROGRESS_DONE

converter toCInt*(arg: c_git_stash_apply_progress_t): cint = cint(ord(arg))

converter toCInt*(arg: git_stash_apply_progress_t): cint = cint(ord(to_c_git_stash_apply_progress_t(arg)))

converter toCInt*(args: set[git_stash_apply_progress_t]): cint =
  for value in items(args):
    case value:
      of GIT_STASH_APPLY_PROGRESS_NONE              : result = cint(result or 0)
      of GIT_STASH_APPLY_PROGRESS_LOADING_STASH     : result = cint(result or 1)
      of GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX     : result = cint(result or 2)
      of GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED  : result = cint(result or 3)
      of GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED : result = cint(result or 4)
      of GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED: result = cint(result or 5)
      of GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED : result = cint(result or 6)
      of GIT_STASH_APPLY_PROGRESS_DONE              : result = cint(result or 7)

func `-`*(arg: c_git_stash_apply_progress_t, offset: int): cint = cast[c_git_stash_apply_progress_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_stash_apply_progress_t): cint = cast[c_git_stash_apply_progress_t](ord(arg) - offset)

func `+`*(arg: c_git_stash_apply_progress_t, offset: int): cint = cast[c_git_stash_apply_progress_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_stash_apply_progress_t): cint = cast[c_git_stash_apply_progress_t](ord(arg) + offset)

proc git_stash_save*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    stasher: ptr git_signature,
    message: cstring,
    flags: uint32,
): cint {.importc: "git_stash_save".}

proc git_stash_save_options_init*(opts: ptr git_stash_save_options, version: cuint): cint {.importc: "git_stash_save_options_init".}

proc git_stash_save_with_opts*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    opts: ptr git_stash_save_options,
): cint {.importc: "git_stash_save_with_opts".}

proc git_stash_apply_options_init*(opts: ptr git_stash_apply_options, version: cuint): cint {.importc: "git_stash_apply_options_init".}

proc git_stash_apply*(
    repo: ptr git_repository,
    index: csize_t,
    options: ptr git_stash_apply_options,
): cint {.importc: "git_stash_apply".}

proc git_stash_foreach*(
    repo: ptr git_repository,
    callback: git_stash_cb,
    payload: pointer,
): cint {.importc: "git_stash_foreach".}

proc git_stash_drop*(repo: ptr git_repository, index: csize_t): cint {.importc: "git_stash_drop".}

proc git_stash_pop*(
    repo: ptr git_repository,
    index: csize_t,
    options: ptr git_stash_apply_options,
): cint {.importc: "git_stash_pop".}