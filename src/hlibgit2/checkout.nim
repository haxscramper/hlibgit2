import "../strarray.nim"
import "../types.nim"

type
  git_checkout_perfdata* {.importc, bycopy.} = object
    mkdir_calls *: csize_t
    stat_calls  *: csize_t
    chmod_calls *: csize_t

  git_checkout_notify_cb = proc (a0: git_checkout_notify_t, a1: cstring, a2: ptr git_diff_file, a3: ptr git_diff_file, a4: ptr git_diff_file, a5: ptr void): cint

  git_checkout_progress_cb = proc (a0: cstring, a1: csize_t, a2: csize_t, a3: ptr void): void

  git_checkout_perfdata_cb = proc (a0: ptr git_checkout_perfdata, a1: ptr void): void

  c_git_checkout_strategy_t {.size: sizeof(cint).} = enum
    c_GIT_CHECKOUT_NONE                         = 0 shl 0
    c_GIT_CHECKOUT_SAFE                         = 1 shl 0
    c_GIT_CHECKOUT_FORCE                        = 1 shl 1
    c_GIT_CHECKOUT_RECREATE_MISSING             = 1 shl 2
    c_GIT_CHECKOUT_ALLOW_CONFLICTS              = 1 shl 4
    c_GIT_CHECKOUT_REMOVE_UNTRACKED             = 1 shl 5
    c_GIT_CHECKOUT_REMOVE_IGNORED               = 1 shl 6
    c_GIT_CHECKOUT_UPDATE_ONLY                  = 1 shl 7
    c_GIT_CHECKOUT_DONT_UPDATE_INDEX            = 1 shl 8
    c_GIT_CHECKOUT_NO_REFRESH                   = 1 shl 9
    c_GIT_CHECKOUT_SKIP_UNMERGED                = 1 shl 10
    c_GIT_CHECKOUT_USE_OURS                     = 1 shl 11
    c_GIT_CHECKOUT_USE_THEIRS                   = 1 shl 12
    c_GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH       = 1 shl 13
    c_GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES      = 1 shl 18
    c_GIT_CHECKOUT_DONT_OVERWRITE_IGNORED       = 1 shl 19
    c_GIT_CHECKOUT_CONFLICT_STYLE_MERGE         = 1 shl 20
    c_GIT_CHECKOUT_CONFLICT_STYLE_DIFF3         = 1 shl 21
    c_GIT_CHECKOUT_DONT_REMOVE_EXISTING         = 1 shl 22
    c_GIT_CHECKOUT_DONT_WRITE_INDEX             = 1 shl 23
    c_GIT_CHECKOUT_DRY_RUN                      = 1 shl 24
    c_GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3        = 1 shl 25
    c_GIT_CHECKOUT_UPDATE_SUBMODULES            = 1 shl 16
    c_GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 1 shl 17

  git_checkout_strategy_t = enum
    GIT_CHECKOUT_NONE
    GIT_CHECKOUT_SAFE
    GIT_CHECKOUT_FORCE
    GIT_CHECKOUT_RECREATE_MISSING
    GIT_CHECKOUT_ALLOW_CONFLICTS
    GIT_CHECKOUT_REMOVE_UNTRACKED
    GIT_CHECKOUT_REMOVE_IGNORED
    GIT_CHECKOUT_UPDATE_ONLY
    GIT_CHECKOUT_DONT_UPDATE_INDEX
    GIT_CHECKOUT_NO_REFRESH
    GIT_CHECKOUT_SKIP_UNMERGED
    GIT_CHECKOUT_USE_OURS
    GIT_CHECKOUT_USE_THEIRS
    GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH
    GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES
    GIT_CHECKOUT_DONT_OVERWRITE_IGNORED
    GIT_CHECKOUT_CONFLICT_STYLE_MERGE
    GIT_CHECKOUT_CONFLICT_STYLE_DIFF3
    GIT_CHECKOUT_DONT_REMOVE_EXISTING
    GIT_CHECKOUT_DONT_WRITE_INDEX
    GIT_CHECKOUT_DRY_RUN
    GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3
    GIT_CHECKOUT_UPDATE_SUBMODULES
    GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED

  c_git_checkout_notify_t {.size: sizeof(cint).} = enum
    c_GIT_CHECKOUT_NOTIFY_NONE      = 0 shl 0
    c_GIT_CHECKOUT_NOTIFY_CONFLICT  = 1 shl 0
    c_GIT_CHECKOUT_NOTIFY_DIRTY     = 1 shl 1
    c_GIT_CHECKOUT_NOTIFY_UPDATED   = 1 shl 2
    c_GIT_CHECKOUT_NOTIFY_UNTRACKED = 1 shl 3
    c_GIT_CHECKOUT_NOTIFY_IGNORED   = 1 shl 4
    c_GIT_CHECKOUT_NOTIFY_ALL       = 65535

  git_checkout_notify_t = enum
    GIT_CHECKOUT_NOTIFY_NONE
    GIT_CHECKOUT_NOTIFY_CONFLICT
    GIT_CHECKOUT_NOTIFY_DIRTY
    GIT_CHECKOUT_NOTIFY_UPDATED
    GIT_CHECKOUT_NOTIFY_UNTRACKED
    GIT_CHECKOUT_NOTIFY_IGNORED
    GIT_CHECKOUT_NOTIFY_ALL

  git_checkout_options* {.importc, bycopy.} = object
    version           *: cuint
    checkout_strategy *: cuint
    disable_filters   *: cint
    dir_mode          *: cuint
    file_mode         *: cuint
    file_open_flags   *: cint
    notify_flags      *: cuint
    notify_cb         *: git_checkout_notify_cb
    notify_payload    *: ptr void
    progress_cb       *: git_checkout_progress_cb
    progress_payload  *: ptr void
    paths             *: git_strarray
    baseline          *: ptr git_tree
    baseline_index    *: ptr git_index
    target_directory  *: cstring
    ancestor_label    *: cstring
    our_label         *: cstring
    their_label       *: cstring
    perfdata_cb       *: git_checkout_perfdata_cb
    perfdata_payload  *: ptr void



converter toCInt*(arg: c_git_checkout_strategy_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_checkout_strategy_t)): cint =
  for value in items(args):
    case value:
      of GIT_CHECKOUT_NONE                        : result = cint(result or 0)
      of GIT_CHECKOUT_SAFE                        : result = cint(result or 1)
      of GIT_CHECKOUT_FORCE                       : result = cint(result or 2)
      of GIT_CHECKOUT_RECREATE_MISSING            : result = cint(result or 4)
      of GIT_CHECKOUT_ALLOW_CONFLICTS             : result = cint(result or 16)
      of GIT_CHECKOUT_REMOVE_UNTRACKED            : result = cint(result or 32)
      of GIT_CHECKOUT_REMOVE_IGNORED              : result = cint(result or 64)
      of GIT_CHECKOUT_UPDATE_ONLY                 : result = cint(result or 128)
      of GIT_CHECKOUT_DONT_UPDATE_INDEX           : result = cint(result or 256)
      of GIT_CHECKOUT_NO_REFRESH                  : result = cint(result or 512)
      of GIT_CHECKOUT_SKIP_UNMERGED               : result = cint(result or 1024)
      of GIT_CHECKOUT_USE_OURS                    : result = cint(result or 2048)
      of GIT_CHECKOUT_USE_THEIRS                  : result = cint(result or 4096)
      of GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH      : result = cint(result or 8192)
      of GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES     : result = cint(result or 262144)
      of GIT_CHECKOUT_DONT_OVERWRITE_IGNORED      : result = cint(result or 524288)
      of GIT_CHECKOUT_CONFLICT_STYLE_MERGE        : result = cint(result or 1048576)
      of GIT_CHECKOUT_CONFLICT_STYLE_DIFF3        : result = cint(result or 2097152)
      of GIT_CHECKOUT_DONT_REMOVE_EXISTING        : result = cint(result or 4194304)
      of GIT_CHECKOUT_DONT_WRITE_INDEX            : result = cint(result or 8388608)
      of GIT_CHECKOUT_DRY_RUN                     : result = cint(result or 16777216)
      of GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3       : result = cint(result or 33554432)
      of GIT_CHECKOUT_UPDATE_SUBMODULES           : result = cint(result or 65536)
      of GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED: result = cint(result or 131072)

func `-`*(arg: c_git_checkout_strategy_t, offset: int): cint = cast[c_git_checkout_strategy_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_checkout_strategy_t): cint = cast[c_git_checkout_strategy_t](ord(arg) - offset)

func `+`*(arg: c_git_checkout_strategy_t, offset: int): cint = cast[c_git_checkout_strategy_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_checkout_strategy_t): cint = cast[c_git_checkout_strategy_t](ord(arg) + offset)

converter toCInt*(arg: c_git_checkout_notify_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_checkout_notify_t)): cint =
  for value in items(args):
    case value:
      of GIT_CHECKOUT_NOTIFY_NONE     : result = cint(result or 0)
      of GIT_CHECKOUT_NOTIFY_CONFLICT : result = cint(result or 1)
      of GIT_CHECKOUT_NOTIFY_DIRTY    : result = cint(result or 2)
      of GIT_CHECKOUT_NOTIFY_UPDATED  : result = cint(result or 4)
      of GIT_CHECKOUT_NOTIFY_UNTRACKED: result = cint(result or 8)
      of GIT_CHECKOUT_NOTIFY_IGNORED  : result = cint(result or 16)
      of GIT_CHECKOUT_NOTIFY_ALL      : result = cint(result or 65535)

func `-`*(arg: c_git_checkout_notify_t, offset: int): cint = cast[c_git_checkout_notify_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_checkout_notify_t): cint = cast[c_git_checkout_notify_t](ord(arg) - offset)

func `+`*(arg: c_git_checkout_notify_t, offset: int): cint = cast[c_git_checkout_notify_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_checkout_notify_t): cint = cast[c_git_checkout_notify_t](ord(arg) + offset)

proc git_checkout_options_init*(opts: ptr git_checkout_options, version: cuint): cint {.git2Proc, importc.}

proc git_checkout_head*(repo: ptr git_repository, opts: ptr git_checkout_options): cint {.git2Proc, importc.}

proc git_checkout_index*(repo: ptr git_repository, index: ptr git_index, opts: ptr git_checkout_options): cint {.git2Proc, importc.}

proc git_checkout_tree*(repo: ptr git_repository, treeish: ptr git_object, opts: ptr git_checkout_options): cint {.git2Proc, importc.}