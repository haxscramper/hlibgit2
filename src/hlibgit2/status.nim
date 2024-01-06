import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./strarray.nim"
import "./diff.nim"

type
  git_status_options* {.importc, bycopy.} = object
    version          *: cuint
    show             *: git_status_show_t
    flags            *: cuint
    pathspec         *: git_strarray
    baseline         *: ptr git_tree
    rename_threshold *: uint16

  git_status_entry* {.importc, bycopy.} = object
    status           *: git_status_t
    head_to_index    *: ptr git_diff_delta
    index_to_workdir *: ptr git_diff_delta

  c_git_status_t* {.size: sizeof(cint).} = enum
    c_GIT_STATUS_CURRENT          = 0
    c_GIT_STATUS_INDEX_NEW        = 1
    c_GIT_STATUS_INDEX_MODIFIED   = 2
    c_GIT_STATUS_INDEX_DELETED    = 1 shl 2
    c_GIT_STATUS_INDEX_RENAMED    = 1 shl 3
    c_GIT_STATUS_INDEX_TYPECHANGE = 1 shl 4
    c_GIT_STATUS_WT_NEW           = 1 shl 7
    c_GIT_STATUS_WT_MODIFIED      = 1 shl 8
    c_GIT_STATUS_WT_DELETED       = 1 shl 9
    c_GIT_STATUS_WT_TYPECHANGE    = 1 shl 10
    c_GIT_STATUS_WT_RENAMED       = 1 shl 11
    c_GIT_STATUS_WT_UNREADABLE    = 1 shl 12
    c_GIT_STATUS_IGNORED          = 1 shl 14
    c_GIT_STATUS_CONFLICTED       = 1 shl 15

  git_status_t* = enum
    GIT_STATUS_CURRENT          = 0
    GIT_STATUS_INDEX_NEW        = 1
    GIT_STATUS_INDEX_MODIFIED   = 2
    GIT_STATUS_INDEX_DELETED    = 3
    GIT_STATUS_INDEX_RENAMED    = 4
    GIT_STATUS_INDEX_TYPECHANGE = 5
    GIT_STATUS_WT_NEW           = 6
    GIT_STATUS_WT_MODIFIED      = 7
    GIT_STATUS_WT_DELETED       = 8
    GIT_STATUS_WT_TYPECHANGE    = 9
    GIT_STATUS_WT_RENAMED       = 10
    GIT_STATUS_WT_UNREADABLE    = 11
    GIT_STATUS_IGNORED          = 12
    GIT_STATUS_CONFLICTED       = 13

  c_git_status_show_t* {.size: sizeof(cint).} = enum
    c_GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0
    c_GIT_STATUS_SHOW_INDEX_ONLY        = 1
    c_GIT_STATUS_SHOW_WORKDIR_ONLY      = 2

  git_status_show_t* = enum
    GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0
    GIT_STATUS_SHOW_INDEX_ONLY        = 1
    GIT_STATUS_SHOW_WORKDIR_ONLY      = 2

  c_git_status_opt_t* {.size: sizeof(cint).} = enum
    c_GIT_STATUS_OPT_INCLUDE_UNTRACKED               = 1 shl 0
    c_GIT_STATUS_OPT_INCLUDE_IGNORED                 = 1 shl 1
    c_GIT_STATUS_OPT_INCLUDE_UNMODIFIED              = 1 shl 2
    c_GIT_STATUS_OPT_EXCLUDE_SUBMODULES              = 1 shl 3
    c_GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS          = 1 shl 4
    c_GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH          = 1 shl 5
    c_GIT_STATUS_OPT_RECURSE_IGNORED_DIRS            = 1 shl 6
    c_GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX           = 1 shl 7
    c_GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR        = 1 shl 8
    c_GIT_STATUS_OPT_SORT_CASE_SENSITIVELY           = 1 shl 9
    c_GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY         = 1 shl 10
    c_GIT_STATUS_OPT_RENAMES_FROM_REWRITES           = 1 shl 11
    c_GIT_STATUS_OPT_NO_REFRESH                      = 1 shl 12
    c_GIT_STATUS_OPT_UPDATE_INDEX                    = 1 shl 13
    c_GIT_STATUS_OPT_INCLUDE_UNREADABLE              = 1 shl 14
    c_GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED = 1 shl 15

  git_status_opt_t* = enum
    GIT_STATUS_OPT_INCLUDE_UNTRACKED               = 0
    GIT_STATUS_OPT_INCLUDE_IGNORED                 = 1
    GIT_STATUS_OPT_INCLUDE_UNMODIFIED              = 2
    GIT_STATUS_OPT_EXCLUDE_SUBMODULES              = 3
    GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS          = 4
    GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH          = 5
    GIT_STATUS_OPT_RECURSE_IGNORED_DIRS            = 6
    GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX           = 7
    GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR        = 8
    GIT_STATUS_OPT_SORT_CASE_SENSITIVELY           = 9
    GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY         = 10
    GIT_STATUS_OPT_RENAMES_FROM_REWRITES           = 11
    GIT_STATUS_OPT_NO_REFRESH                      = 12
    GIT_STATUS_OPT_UPDATE_INDEX                    = 13
    GIT_STATUS_OPT_INCLUDE_UNREADABLE              = 14
    GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED = 15

  git_status_cb* = proc (a0: cstring, a1: cuint, a2: pointer): cint



converter to_git_status_t*(arg: c_git_status_t): git_status_t =
  case arg:
    of c_GIT_STATUS_CURRENT         : GIT_STATUS_CURRENT
    of c_GIT_STATUS_INDEX_NEW       : GIT_STATUS_INDEX_NEW
    of c_GIT_STATUS_INDEX_MODIFIED  : GIT_STATUS_INDEX_MODIFIED
    of c_GIT_STATUS_INDEX_DELETED   : GIT_STATUS_INDEX_DELETED
    of c_GIT_STATUS_INDEX_RENAMED   : GIT_STATUS_INDEX_RENAMED
    of c_GIT_STATUS_INDEX_TYPECHANGE: GIT_STATUS_INDEX_TYPECHANGE
    of c_GIT_STATUS_WT_NEW          : GIT_STATUS_WT_NEW
    of c_GIT_STATUS_WT_MODIFIED     : GIT_STATUS_WT_MODIFIED
    of c_GIT_STATUS_WT_DELETED      : GIT_STATUS_WT_DELETED
    of c_GIT_STATUS_WT_TYPECHANGE   : GIT_STATUS_WT_TYPECHANGE
    of c_GIT_STATUS_WT_RENAMED      : GIT_STATUS_WT_RENAMED
    of c_GIT_STATUS_WT_UNREADABLE   : GIT_STATUS_WT_UNREADABLE
    of c_GIT_STATUS_IGNORED         : GIT_STATUS_IGNORED
    of c_GIT_STATUS_CONFLICTED      : GIT_STATUS_CONFLICTED

proc to_c_git_status_t*(arg: git_status_t): c_git_status_t =
  case arg:
    of GIT_STATUS_CURRENT         : c_GIT_STATUS_CURRENT
    of GIT_STATUS_INDEX_NEW       : c_GIT_STATUS_INDEX_NEW
    of GIT_STATUS_INDEX_MODIFIED  : c_GIT_STATUS_INDEX_MODIFIED
    of GIT_STATUS_INDEX_DELETED   : c_GIT_STATUS_INDEX_DELETED
    of GIT_STATUS_INDEX_RENAMED   : c_GIT_STATUS_INDEX_RENAMED
    of GIT_STATUS_INDEX_TYPECHANGE: c_GIT_STATUS_INDEX_TYPECHANGE
    of GIT_STATUS_WT_NEW          : c_GIT_STATUS_WT_NEW
    of GIT_STATUS_WT_MODIFIED     : c_GIT_STATUS_WT_MODIFIED
    of GIT_STATUS_WT_DELETED      : c_GIT_STATUS_WT_DELETED
    of GIT_STATUS_WT_TYPECHANGE   : c_GIT_STATUS_WT_TYPECHANGE
    of GIT_STATUS_WT_RENAMED      : c_GIT_STATUS_WT_RENAMED
    of GIT_STATUS_WT_UNREADABLE   : c_GIT_STATUS_WT_UNREADABLE
    of GIT_STATUS_IGNORED         : c_GIT_STATUS_IGNORED
    of GIT_STATUS_CONFLICTED      : c_GIT_STATUS_CONFLICTED

converter toCInt*(arg: c_git_status_t): cint = cint(ord(arg))

converter toCInt*(arg: git_status_t): cint = cint(ord(to_c_git_status_t(arg)))

converter toCInt*(args: set[git_status_t]): cint =
  for value in items(args):
    case value:
      of GIT_STATUS_CURRENT         : result = cint(result or 0)
      of GIT_STATUS_INDEX_NEW       : result = cint(result or 1)
      of GIT_STATUS_INDEX_MODIFIED  : result = cint(result or 2)
      of GIT_STATUS_INDEX_DELETED   : result = cint(result or 4)
      of GIT_STATUS_INDEX_RENAMED   : result = cint(result or 8)
      of GIT_STATUS_INDEX_TYPECHANGE: result = cint(result or 16)
      of GIT_STATUS_WT_NEW          : result = cint(result or 128)
      of GIT_STATUS_WT_MODIFIED     : result = cint(result or 256)
      of GIT_STATUS_WT_DELETED      : result = cint(result or 512)
      of GIT_STATUS_WT_TYPECHANGE   : result = cint(result or 1024)
      of GIT_STATUS_WT_RENAMED      : result = cint(result or 2048)
      of GIT_STATUS_WT_UNREADABLE   : result = cint(result or 4096)
      of GIT_STATUS_IGNORED         : result = cint(result or 16384)
      of GIT_STATUS_CONFLICTED      : result = cint(result or 32768)

func `-`*(arg: c_git_status_t, offset: int): cint = cast[c_git_status_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_status_t): cint = cast[c_git_status_t](ord(arg) - offset)

func `+`*(arg: c_git_status_t, offset: int): cint = cast[c_git_status_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_status_t): cint = cast[c_git_status_t](ord(arg) + offset)

converter to_git_status_show_t*(arg: c_git_status_show_t): git_status_show_t =
  case arg:
    of c_GIT_STATUS_SHOW_INDEX_AND_WORKDIR: GIT_STATUS_SHOW_INDEX_AND_WORKDIR
    of c_GIT_STATUS_SHOW_INDEX_ONLY       : GIT_STATUS_SHOW_INDEX_ONLY
    of c_GIT_STATUS_SHOW_WORKDIR_ONLY     : GIT_STATUS_SHOW_WORKDIR_ONLY

proc to_c_git_status_show_t*(arg: git_status_show_t): c_git_status_show_t =
  case arg:
    of GIT_STATUS_SHOW_INDEX_AND_WORKDIR: c_GIT_STATUS_SHOW_INDEX_AND_WORKDIR
    of GIT_STATUS_SHOW_INDEX_ONLY       : c_GIT_STATUS_SHOW_INDEX_ONLY
    of GIT_STATUS_SHOW_WORKDIR_ONLY     : c_GIT_STATUS_SHOW_WORKDIR_ONLY

converter toCInt*(arg: c_git_status_show_t): cint = cint(ord(arg))

converter toCInt*(arg: git_status_show_t): cint = cint(ord(to_c_git_status_show_t(arg)))

converter toCInt*(args: set[git_status_show_t]): cint =
  for value in items(args):
    case value:
      of GIT_STATUS_SHOW_INDEX_AND_WORKDIR: result = cint(result or 0)
      of GIT_STATUS_SHOW_INDEX_ONLY       : result = cint(result or 1)
      of GIT_STATUS_SHOW_WORKDIR_ONLY     : result = cint(result or 2)

func `-`*(arg: c_git_status_show_t, offset: int): cint = cast[c_git_status_show_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_status_show_t): cint = cast[c_git_status_show_t](ord(arg) - offset)

func `+`*(arg: c_git_status_show_t, offset: int): cint = cast[c_git_status_show_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_status_show_t): cint = cast[c_git_status_show_t](ord(arg) + offset)

converter to_git_status_opt_t*(arg: c_git_status_opt_t): git_status_opt_t =
  case arg:
    of c_GIT_STATUS_OPT_INCLUDE_UNTRACKED              : GIT_STATUS_OPT_INCLUDE_UNTRACKED
    of c_GIT_STATUS_OPT_INCLUDE_IGNORED                : GIT_STATUS_OPT_INCLUDE_IGNORED
    of c_GIT_STATUS_OPT_INCLUDE_UNMODIFIED             : GIT_STATUS_OPT_INCLUDE_UNMODIFIED
    of c_GIT_STATUS_OPT_EXCLUDE_SUBMODULES             : GIT_STATUS_OPT_EXCLUDE_SUBMODULES
    of c_GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS         : GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS
    of c_GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH         : GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH
    of c_GIT_STATUS_OPT_RECURSE_IGNORED_DIRS           : GIT_STATUS_OPT_RECURSE_IGNORED_DIRS
    of c_GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX          : GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX
    of c_GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR       : GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR
    of c_GIT_STATUS_OPT_SORT_CASE_SENSITIVELY          : GIT_STATUS_OPT_SORT_CASE_SENSITIVELY
    of c_GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY        : GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY
    of c_GIT_STATUS_OPT_RENAMES_FROM_REWRITES          : GIT_STATUS_OPT_RENAMES_FROM_REWRITES
    of c_GIT_STATUS_OPT_NO_REFRESH                     : GIT_STATUS_OPT_NO_REFRESH
    of c_GIT_STATUS_OPT_UPDATE_INDEX                   : GIT_STATUS_OPT_UPDATE_INDEX
    of c_GIT_STATUS_OPT_INCLUDE_UNREADABLE             : GIT_STATUS_OPT_INCLUDE_UNREADABLE
    of c_GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED: GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED

proc to_c_git_status_opt_t*(arg: git_status_opt_t): c_git_status_opt_t =
  case arg:
    of GIT_STATUS_OPT_INCLUDE_UNTRACKED              : c_GIT_STATUS_OPT_INCLUDE_UNTRACKED
    of GIT_STATUS_OPT_INCLUDE_IGNORED                : c_GIT_STATUS_OPT_INCLUDE_IGNORED
    of GIT_STATUS_OPT_INCLUDE_UNMODIFIED             : c_GIT_STATUS_OPT_INCLUDE_UNMODIFIED
    of GIT_STATUS_OPT_EXCLUDE_SUBMODULES             : c_GIT_STATUS_OPT_EXCLUDE_SUBMODULES
    of GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS         : c_GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS
    of GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH         : c_GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH
    of GIT_STATUS_OPT_RECURSE_IGNORED_DIRS           : c_GIT_STATUS_OPT_RECURSE_IGNORED_DIRS
    of GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX          : c_GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX
    of GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR       : c_GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR
    of GIT_STATUS_OPT_SORT_CASE_SENSITIVELY          : c_GIT_STATUS_OPT_SORT_CASE_SENSITIVELY
    of GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY        : c_GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY
    of GIT_STATUS_OPT_RENAMES_FROM_REWRITES          : c_GIT_STATUS_OPT_RENAMES_FROM_REWRITES
    of GIT_STATUS_OPT_NO_REFRESH                     : c_GIT_STATUS_OPT_NO_REFRESH
    of GIT_STATUS_OPT_UPDATE_INDEX                   : c_GIT_STATUS_OPT_UPDATE_INDEX
    of GIT_STATUS_OPT_INCLUDE_UNREADABLE             : c_GIT_STATUS_OPT_INCLUDE_UNREADABLE
    of GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED: c_GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED

converter toCInt*(arg: c_git_status_opt_t): cint = cint(ord(arg))

converter toCInt*(arg: git_status_opt_t): cint = cint(ord(to_c_git_status_opt_t(arg)))

converter toCInt*(args: set[git_status_opt_t]): cint =
  for value in items(args):
    case value:
      of GIT_STATUS_OPT_INCLUDE_UNTRACKED              : result = cint(result or 1)
      of GIT_STATUS_OPT_INCLUDE_IGNORED                : result = cint(result or 2)
      of GIT_STATUS_OPT_INCLUDE_UNMODIFIED             : result = cint(result or 4)
      of GIT_STATUS_OPT_EXCLUDE_SUBMODULES             : result = cint(result or 8)
      of GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS         : result = cint(result or 16)
      of GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH         : result = cint(result or 32)
      of GIT_STATUS_OPT_RECURSE_IGNORED_DIRS           : result = cint(result or 64)
      of GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX          : result = cint(result or 128)
      of GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR       : result = cint(result or 256)
      of GIT_STATUS_OPT_SORT_CASE_SENSITIVELY          : result = cint(result or 512)
      of GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY        : result = cint(result or 1024)
      of GIT_STATUS_OPT_RENAMES_FROM_REWRITES          : result = cint(result or 2048)
      of GIT_STATUS_OPT_NO_REFRESH                     : result = cint(result or 4096)
      of GIT_STATUS_OPT_UPDATE_INDEX                   : result = cint(result or 8192)
      of GIT_STATUS_OPT_INCLUDE_UNREADABLE             : result = cint(result or 16384)
      of GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED: result = cint(result or 32768)

func `-`*(arg: c_git_status_opt_t, offset: int): cint = cast[c_git_status_opt_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_status_opt_t): cint = cast[c_git_status_opt_t](ord(arg) - offset)

func `+`*(arg: c_git_status_opt_t, offset: int): cint = cast[c_git_status_opt_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_status_opt_t): cint = cast[c_git_status_opt_t](ord(arg) + offset)

proc git_status_options_init*(opts: ptr git_status_options, version: cuint): cint {.importc: "git_status_options_init".}

proc git_status_foreach*(
    repo: ptr git_repository,
    callback: git_status_cb,
    payload: pointer,
): cint {.importc: "git_status_foreach".}

proc git_status_foreach_ext*(
    repo: ptr git_repository,
    opts: ptr git_status_options,
    callback: git_status_cb,
    payload: pointer,
): cint {.importc: "git_status_foreach_ext".}

proc git_status_file*(
    status_flags: ptr cuint,
    repo: ptr git_repository,
    path: cstring,
): cint {.importc: "git_status_file".}

proc git_status_list_new*(
    `out`: ptr ptr git_status_list,
    repo: ptr git_repository,
    opts: ptr git_status_options,
): cint {.importc: "git_status_list_new".}

proc git_status_list_entrycount*(statuslist: ptr git_status_list): csize_t {.importc: "git_status_list_entrycount".}

proc git_status_byindex*(statuslist: ptr git_status_list, idx: csize_t): ptr git_status_entry {.importc: "git_status_byindex".}

proc git_status_list_free*(statuslist: ptr git_status_list): void {.importc: "git_status_list_free".}

proc git_status_should_ignore*(
    ignored: ptr cint,
    repo: ptr git_repository,
    path: cstring,
): cint {.importc: "git_status_should_ignore".}