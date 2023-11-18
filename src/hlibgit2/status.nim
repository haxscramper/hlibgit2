import "../diff.nim"
import "../strarray.nim"
import "../types.nim"

type
  git_status_options* {.importc, bycopy.} = object
    version          *: cuint
    show             *: git_status_show_t
    flags            *: cuint
    pathspec         *: git_strarray
    baseline         *: ptr git_tree
    rename_threshold *: uint16

  c_git_status_show_t {.size: sizeof(cint).} = enum
    c_GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0 shl 0
    c_GIT_STATUS_SHOW_INDEX_ONLY        = 1 shl 0
    c_GIT_STATUS_SHOW_WORKDIR_ONLY      = 1 shl 1

  git_status_show_t = enum
    GIT_STATUS_SHOW_INDEX_AND_WORKDIR
    GIT_STATUS_SHOW_INDEX_ONLY
    GIT_STATUS_SHOW_WORKDIR_ONLY

  git_status_entry* {.importc, bycopy.} = object
    status           *: git_status_t
    head_to_index    *: ptr git_diff_delta
    index_to_workdir *: ptr git_diff_delta

  c_git_status_t {.size: sizeof(cint).} = enum
    c_GIT_STATUS_CURRENT          = 0 shl 0
    c_GIT_STATUS_INDEX_NEW        = 1 shl 0
    c_GIT_STATUS_INDEX_MODIFIED   = 1 shl 1
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

  git_status_t = enum
    GIT_STATUS_CURRENT
    GIT_STATUS_INDEX_NEW
    GIT_STATUS_INDEX_MODIFIED
    GIT_STATUS_INDEX_DELETED
    GIT_STATUS_INDEX_RENAMED
    GIT_STATUS_INDEX_TYPECHANGE
    GIT_STATUS_WT_NEW
    GIT_STATUS_WT_MODIFIED
    GIT_STATUS_WT_DELETED
    GIT_STATUS_WT_TYPECHANGE
    GIT_STATUS_WT_RENAMED
    GIT_STATUS_WT_UNREADABLE
    GIT_STATUS_IGNORED
    GIT_STATUS_CONFLICTED

  c_git_status_opt_t {.size: sizeof(cint).} = enum
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

  git_status_opt_t = enum
    GIT_STATUS_OPT_INCLUDE_UNTRACKED
    GIT_STATUS_OPT_INCLUDE_IGNORED
    GIT_STATUS_OPT_INCLUDE_UNMODIFIED
    GIT_STATUS_OPT_EXCLUDE_SUBMODULES
    GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS
    GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH
    GIT_STATUS_OPT_RECURSE_IGNORED_DIRS
    GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX
    GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR
    GIT_STATUS_OPT_SORT_CASE_SENSITIVELY
    GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY
    GIT_STATUS_OPT_RENAMES_FROM_REWRITES
    GIT_STATUS_OPT_NO_REFRESH
    GIT_STATUS_OPT_UPDATE_INDEX
    GIT_STATUS_OPT_INCLUDE_UNREADABLE
    GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED

  git_status_cb = proc (a0: cstring, a1: cuint, a2: ptr void): cint



converter toCInt*(arg: c_git_status_show_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_status_show_t)): cint =
  for value in items(args):
    case value:
      of GIT_STATUS_SHOW_INDEX_AND_WORKDIR: result = cint(result or 0)
      of GIT_STATUS_SHOW_INDEX_ONLY       : result = cint(result or 1)
      of GIT_STATUS_SHOW_WORKDIR_ONLY     : result = cint(result or 2)

func `-`*(arg: c_git_status_show_t, offset: int): cint = cast[c_git_status_show_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_status_show_t): cint = cast[c_git_status_show_t](ord(arg) - offset)

func `+`*(arg: c_git_status_show_t, offset: int): cint = cast[c_git_status_show_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_status_show_t): cint = cast[c_git_status_show_t](ord(arg) + offset)

converter toCInt*(arg: c_git_status_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_status_t)): cint =
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

converter toCInt*(arg: c_git_status_opt_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_status_opt_t)): cint =
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

proc git_status_options_init*(opts: ptr git_status_options, version: cuint): cint {.git2Proc, importc.}

proc git_status_foreach*(repo: ptr git_repository, callback: git_status_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_status_foreach_ext*(repo: ptr git_repository, opts: ptr git_status_options, callback: git_status_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_status_file*(status_flags: ptr cuint, repo: ptr git_repository, path: cstring): cint {.git2Proc, importc.}

proc git_status_list_new*(out: ptr git_status_list, repo: ptr git_repository, opts: ptr git_status_options): cint {.git2Proc, importc.}

proc git_status_list_entrycount*(statuslist: ptr git_status_list): csize_t {.git2Proc, importc.}

proc git_status_byindex*(statuslist: ptr git_status_list, idx: csize_t): ptr git_status_entry {.git2Proc, importc.}

proc git_status_list_free*(statuslist: ptr git_status_list): void {.git2Proc, importc.}

proc git_status_should_ignore*(ignored: ptr cint, repo: ptr git_repository, path: cstring): cint {.git2Proc, importc.}