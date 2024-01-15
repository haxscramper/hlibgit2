import "./types.nim"
import "./strarray.nim"
import "./diff.nim"

type
  git_checkout_perfdata* {.bycopy.} = object
    mkdir_calls *: csize_t
    stat_calls  *: csize_t
    chmod_calls *: csize_t

  git_checkout_options* {.bycopy.} = object
    version           *: cuint
    checkout_strategy *: cuint
    disable_filters   *: cint
    dir_mode          *: cuint
    file_mode         *: cuint
    file_open_flags   *: cint
    notify_flags      *: cuint
    notify_cb         *: git_checkout_notify_cb
    notify_payload    *: pointer
    progress_cb       *: git_checkout_progress_cb
    progress_payload  *: pointer
    paths             *: git_strarray
    baseline          *: ptr git_tree
    baseline_index    *: ptr git_index
    target_directory  *: cstring
    ancestor_label    *: cstring
    our_label         *: cstring
    their_label       *: cstring
    perfdata_cb       *: git_checkout_perfdata_cb
    perfdata_payload  *: pointer

  c_git_checkout_strategy_t* {.size: sizeof(cint).} = enum
    c_GIT_CHECKOUT_NONE                         = 0
    c_GIT_CHECKOUT_SAFE                         = 1
    c_GIT_CHECKOUT_FORCE                        = 2
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
    c_GIT_CHECKOUT_UPDATE_SUBMODULES            = 1 shl 16
    c_GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 1 shl 17
    c_GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES      = 1 shl 18
    c_GIT_CHECKOUT_DONT_OVERWRITE_IGNORED       = 1 shl 19
    c_GIT_CHECKOUT_CONFLICT_STYLE_MERGE         = 1 shl 20
    c_GIT_CHECKOUT_CONFLICT_STYLE_DIFF3         = 1 shl 21
    c_GIT_CHECKOUT_DONT_REMOVE_EXISTING         = 1 shl 22
    c_GIT_CHECKOUT_DONT_WRITE_INDEX             = 1 shl 23
    c_GIT_CHECKOUT_DRY_RUN                      = 1 shl 24
    c_GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3        = 1 shl 25

  git_checkout_strategy_t* = enum
    GIT_CHECKOUT_NONE                         = 0
    GIT_CHECKOUT_SAFE                         = 1
    GIT_CHECKOUT_FORCE                        = 2
    GIT_CHECKOUT_RECREATE_MISSING             = 3
    GIT_CHECKOUT_ALLOW_CONFLICTS              = 4
    GIT_CHECKOUT_REMOVE_UNTRACKED             = 5
    GIT_CHECKOUT_REMOVE_IGNORED               = 6
    GIT_CHECKOUT_UPDATE_ONLY                  = 7
    GIT_CHECKOUT_DONT_UPDATE_INDEX            = 8
    GIT_CHECKOUT_NO_REFRESH                   = 9
    GIT_CHECKOUT_SKIP_UNMERGED                = 10
    GIT_CHECKOUT_USE_OURS                     = 11
    GIT_CHECKOUT_USE_THEIRS                   = 12
    GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH       = 13
    GIT_CHECKOUT_UPDATE_SUBMODULES            = 14
    GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 15
    GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES      = 16
    GIT_CHECKOUT_DONT_OVERWRITE_IGNORED       = 17
    GIT_CHECKOUT_CONFLICT_STYLE_MERGE         = 18
    GIT_CHECKOUT_CONFLICT_STYLE_DIFF3         = 19
    GIT_CHECKOUT_DONT_REMOVE_EXISTING         = 20
    GIT_CHECKOUT_DONT_WRITE_INDEX             = 21
    GIT_CHECKOUT_DRY_RUN                      = 22
    GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3        = 23

  c_git_checkout_notify_t* {.size: sizeof(cint).} = enum
    c_GIT_CHECKOUT_NOTIFY_NONE      = 0
    c_GIT_CHECKOUT_NOTIFY_CONFLICT  = 1
    c_GIT_CHECKOUT_NOTIFY_DIRTY     = 2
    c_GIT_CHECKOUT_NOTIFY_UPDATED   = 1 shl 2
    c_GIT_CHECKOUT_NOTIFY_UNTRACKED = 1 shl 3
    c_GIT_CHECKOUT_NOTIFY_IGNORED   = 1 shl 4
    c_GIT_CHECKOUT_NOTIFY_ALL       = 65535

  git_checkout_notify_t* = enum
    GIT_CHECKOUT_NOTIFY_NONE      = 0
    GIT_CHECKOUT_NOTIFY_CONFLICT  = 1
    GIT_CHECKOUT_NOTIFY_DIRTY     = 2
    GIT_CHECKOUT_NOTIFY_UPDATED   = 3
    GIT_CHECKOUT_NOTIFY_UNTRACKED = 4
    GIT_CHECKOUT_NOTIFY_IGNORED   = 5
    GIT_CHECKOUT_NOTIFY_ALL       = 6

  git_checkout_notify_cb* = proc (a0: git_checkout_notify_t, a1: cstring, a2: ptr git_diff_file, a3: ptr git_diff_file, a4: ptr git_diff_file, a5: pointer): cint

  git_checkout_progress_cb* = proc (a0: cstring, a1: csize_t, a2: csize_t, a3: pointer): void

  git_checkout_perfdata_cb* = proc (a0: ptr git_checkout_perfdata, a1: pointer): void



converter to_git_checkout_strategy_t*(arg: c_git_checkout_strategy_t): git_checkout_strategy_t =
  case arg:
    of c_GIT_CHECKOUT_NONE                        : GIT_CHECKOUT_NONE
    of c_GIT_CHECKOUT_SAFE                        : GIT_CHECKOUT_SAFE
    of c_GIT_CHECKOUT_FORCE                       : GIT_CHECKOUT_FORCE
    of c_GIT_CHECKOUT_RECREATE_MISSING            : GIT_CHECKOUT_RECREATE_MISSING
    of c_GIT_CHECKOUT_ALLOW_CONFLICTS             : GIT_CHECKOUT_ALLOW_CONFLICTS
    of c_GIT_CHECKOUT_REMOVE_UNTRACKED            : GIT_CHECKOUT_REMOVE_UNTRACKED
    of c_GIT_CHECKOUT_REMOVE_IGNORED              : GIT_CHECKOUT_REMOVE_IGNORED
    of c_GIT_CHECKOUT_UPDATE_ONLY                 : GIT_CHECKOUT_UPDATE_ONLY
    of c_GIT_CHECKOUT_DONT_UPDATE_INDEX           : GIT_CHECKOUT_DONT_UPDATE_INDEX
    of c_GIT_CHECKOUT_NO_REFRESH                  : GIT_CHECKOUT_NO_REFRESH
    of c_GIT_CHECKOUT_SKIP_UNMERGED               : GIT_CHECKOUT_SKIP_UNMERGED
    of c_GIT_CHECKOUT_USE_OURS                    : GIT_CHECKOUT_USE_OURS
    of c_GIT_CHECKOUT_USE_THEIRS                  : GIT_CHECKOUT_USE_THEIRS
    of c_GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH      : GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH
    of c_GIT_CHECKOUT_UPDATE_SUBMODULES           : GIT_CHECKOUT_UPDATE_SUBMODULES
    of c_GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED: GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED
    of c_GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES     : GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES
    of c_GIT_CHECKOUT_DONT_OVERWRITE_IGNORED      : GIT_CHECKOUT_DONT_OVERWRITE_IGNORED
    of c_GIT_CHECKOUT_CONFLICT_STYLE_MERGE        : GIT_CHECKOUT_CONFLICT_STYLE_MERGE
    of c_GIT_CHECKOUT_CONFLICT_STYLE_DIFF3        : GIT_CHECKOUT_CONFLICT_STYLE_DIFF3
    of c_GIT_CHECKOUT_DONT_REMOVE_EXISTING        : GIT_CHECKOUT_DONT_REMOVE_EXISTING
    of c_GIT_CHECKOUT_DONT_WRITE_INDEX            : GIT_CHECKOUT_DONT_WRITE_INDEX
    of c_GIT_CHECKOUT_DRY_RUN                     : GIT_CHECKOUT_DRY_RUN
    of c_GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3       : GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3

proc to_c_git_checkout_strategy_t*(arg: git_checkout_strategy_t): c_git_checkout_strategy_t =
  case arg:
    of GIT_CHECKOUT_NONE                        : c_GIT_CHECKOUT_NONE
    of GIT_CHECKOUT_SAFE                        : c_GIT_CHECKOUT_SAFE
    of GIT_CHECKOUT_FORCE                       : c_GIT_CHECKOUT_FORCE
    of GIT_CHECKOUT_RECREATE_MISSING            : c_GIT_CHECKOUT_RECREATE_MISSING
    of GIT_CHECKOUT_ALLOW_CONFLICTS             : c_GIT_CHECKOUT_ALLOW_CONFLICTS
    of GIT_CHECKOUT_REMOVE_UNTRACKED            : c_GIT_CHECKOUT_REMOVE_UNTRACKED
    of GIT_CHECKOUT_REMOVE_IGNORED              : c_GIT_CHECKOUT_REMOVE_IGNORED
    of GIT_CHECKOUT_UPDATE_ONLY                 : c_GIT_CHECKOUT_UPDATE_ONLY
    of GIT_CHECKOUT_DONT_UPDATE_INDEX           : c_GIT_CHECKOUT_DONT_UPDATE_INDEX
    of GIT_CHECKOUT_NO_REFRESH                  : c_GIT_CHECKOUT_NO_REFRESH
    of GIT_CHECKOUT_SKIP_UNMERGED               : c_GIT_CHECKOUT_SKIP_UNMERGED
    of GIT_CHECKOUT_USE_OURS                    : c_GIT_CHECKOUT_USE_OURS
    of GIT_CHECKOUT_USE_THEIRS                  : c_GIT_CHECKOUT_USE_THEIRS
    of GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH      : c_GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH
    of GIT_CHECKOUT_UPDATE_SUBMODULES           : c_GIT_CHECKOUT_UPDATE_SUBMODULES
    of GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED: c_GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED
    of GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES     : c_GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES
    of GIT_CHECKOUT_DONT_OVERWRITE_IGNORED      : c_GIT_CHECKOUT_DONT_OVERWRITE_IGNORED
    of GIT_CHECKOUT_CONFLICT_STYLE_MERGE        : c_GIT_CHECKOUT_CONFLICT_STYLE_MERGE
    of GIT_CHECKOUT_CONFLICT_STYLE_DIFF3        : c_GIT_CHECKOUT_CONFLICT_STYLE_DIFF3
    of GIT_CHECKOUT_DONT_REMOVE_EXISTING        : c_GIT_CHECKOUT_DONT_REMOVE_EXISTING
    of GIT_CHECKOUT_DONT_WRITE_INDEX            : c_GIT_CHECKOUT_DONT_WRITE_INDEX
    of GIT_CHECKOUT_DRY_RUN                     : c_GIT_CHECKOUT_DRY_RUN
    of GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3       : c_GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3

converter toCInt*(arg: c_git_checkout_strategy_t): cint = cint(ord(arg))

converter toCInt*(arg: git_checkout_strategy_t): cint = cint(ord(to_c_git_checkout_strategy_t(arg)))

converter toCInt*(args: set[git_checkout_strategy_t]): cint =
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
      of GIT_CHECKOUT_UPDATE_SUBMODULES           : result = cint(result or 65536)
      of GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED: result = cint(result or 131072)
      of GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES     : result = cint(result or 262144)
      of GIT_CHECKOUT_DONT_OVERWRITE_IGNORED      : result = cint(result or 524288)
      of GIT_CHECKOUT_CONFLICT_STYLE_MERGE        : result = cint(result or 1048576)
      of GIT_CHECKOUT_CONFLICT_STYLE_DIFF3        : result = cint(result or 2097152)
      of GIT_CHECKOUT_DONT_REMOVE_EXISTING        : result = cint(result or 4194304)
      of GIT_CHECKOUT_DONT_WRITE_INDEX            : result = cint(result or 8388608)
      of GIT_CHECKOUT_DRY_RUN                     : result = cint(result or 16777216)
      of GIT_CHECKOUT_CONFLICT_STYLE_ZDIFF3       : result = cint(result or 33554432)

func `-`*(arg: c_git_checkout_strategy_t, offset: int): c_git_checkout_strategy_t = cast[c_git_checkout_strategy_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_checkout_strategy_t): c_git_checkout_strategy_t = cast[c_git_checkout_strategy_t](ord(arg) - offset)

func `+`*(arg: c_git_checkout_strategy_t, offset: int): c_git_checkout_strategy_t = cast[c_git_checkout_strategy_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_checkout_strategy_t): c_git_checkout_strategy_t = cast[c_git_checkout_strategy_t](ord(arg) + offset)

converter to_git_checkout_notify_t*(arg: c_git_checkout_notify_t): git_checkout_notify_t =
  case arg:
    of c_GIT_CHECKOUT_NOTIFY_NONE     : GIT_CHECKOUT_NOTIFY_NONE
    of c_GIT_CHECKOUT_NOTIFY_CONFLICT : GIT_CHECKOUT_NOTIFY_CONFLICT
    of c_GIT_CHECKOUT_NOTIFY_DIRTY    : GIT_CHECKOUT_NOTIFY_DIRTY
    of c_GIT_CHECKOUT_NOTIFY_UPDATED  : GIT_CHECKOUT_NOTIFY_UPDATED
    of c_GIT_CHECKOUT_NOTIFY_UNTRACKED: GIT_CHECKOUT_NOTIFY_UNTRACKED
    of c_GIT_CHECKOUT_NOTIFY_IGNORED  : GIT_CHECKOUT_NOTIFY_IGNORED
    of c_GIT_CHECKOUT_NOTIFY_ALL      : GIT_CHECKOUT_NOTIFY_ALL

proc to_c_git_checkout_notify_t*(arg: git_checkout_notify_t): c_git_checkout_notify_t =
  case arg:
    of GIT_CHECKOUT_NOTIFY_NONE     : c_GIT_CHECKOUT_NOTIFY_NONE
    of GIT_CHECKOUT_NOTIFY_CONFLICT : c_GIT_CHECKOUT_NOTIFY_CONFLICT
    of GIT_CHECKOUT_NOTIFY_DIRTY    : c_GIT_CHECKOUT_NOTIFY_DIRTY
    of GIT_CHECKOUT_NOTIFY_UPDATED  : c_GIT_CHECKOUT_NOTIFY_UPDATED
    of GIT_CHECKOUT_NOTIFY_UNTRACKED: c_GIT_CHECKOUT_NOTIFY_UNTRACKED
    of GIT_CHECKOUT_NOTIFY_IGNORED  : c_GIT_CHECKOUT_NOTIFY_IGNORED
    of GIT_CHECKOUT_NOTIFY_ALL      : c_GIT_CHECKOUT_NOTIFY_ALL

converter toCInt*(arg: c_git_checkout_notify_t): cint = cint(ord(arg))

converter toCInt*(arg: git_checkout_notify_t): cint = cint(ord(to_c_git_checkout_notify_t(arg)))

converter toCInt*(args: set[git_checkout_notify_t]): cint =
  for value in items(args):
    case value:
      of GIT_CHECKOUT_NOTIFY_NONE     : result = cint(result or 0)
      of GIT_CHECKOUT_NOTIFY_CONFLICT : result = cint(result or 1)
      of GIT_CHECKOUT_NOTIFY_DIRTY    : result = cint(result or 2)
      of GIT_CHECKOUT_NOTIFY_UPDATED  : result = cint(result or 4)
      of GIT_CHECKOUT_NOTIFY_UNTRACKED: result = cint(result or 8)
      of GIT_CHECKOUT_NOTIFY_IGNORED  : result = cint(result or 16)
      of GIT_CHECKOUT_NOTIFY_ALL      : result = cint(result or 65535)

func `-`*(arg: c_git_checkout_notify_t, offset: int): c_git_checkout_notify_t = cast[c_git_checkout_notify_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_checkout_notify_t): c_git_checkout_notify_t = cast[c_git_checkout_notify_t](ord(arg) - offset)

func `+`*(arg: c_git_checkout_notify_t, offset: int): c_git_checkout_notify_t = cast[c_git_checkout_notify_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_checkout_notify_t): c_git_checkout_notify_t = cast[c_git_checkout_notify_t](ord(arg) + offset)

proc git_checkout_options_init*(opts: ptr git_checkout_options, version: cuint): cint {.importc: "git_checkout_options_init".}

proc git_checkout_head*(repo: ptr git_repository, opts: ptr git_checkout_options): cint {.importc: "git_checkout_head".}

proc git_checkout_index*(
    repo: ptr git_repository,
    index: ptr git_index,
    opts: ptr git_checkout_options,
): cint {.importc: "git_checkout_index".}

proc git_checkout_tree*(
    repo: ptr git_repository,
    treeish: ptr git_object,
    opts: ptr git_checkout_options,
): cint {.importc: "git_checkout_tree".}