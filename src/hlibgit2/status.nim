{.push warning[UnusedImport]:off.}

import
  ./diff,
  ./libgit2_config,
  ./strarray,
  ./types

type
  git_status_cb* = proc(path: cstring, status_flags: cuint, payload: pointer): cint{.cdecl.}
   
  git_status_cbNim* = proc(path: cstring, status_flags: cuint): cint
   
  git_status_entry* {.bycopy, header: "<git2/status.h>", importc.} = object
    status*: git_status_t
    head_to_index*: ptr git_diff_delta
    index_to_workdir*: ptr git_diff_delta
   
  git_status_opt_t* = enum
    GIT_STATUS_OPT_INCLUDE_UNTRACKED = 1
    GIT_STATUS_OPT_INCLUDE_IGNORED = 2
    GIT_STATUS_OPT_INCLUDE_UNMODIFIED = 4
    GIT_STATUS_OPT_EXCLUDE_SUBMODULES = 8
    GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS = 16
    GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH = 32
    GIT_STATUS_OPT_RECURSE_IGNORED_DIRS = 64
    GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX = 128
    GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR = 256
    GIT_STATUS_OPT_SORT_CASE_SENSITIVELY = 512
    GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY = 1024
    GIT_STATUS_OPT_RENAMES_FROM_REWRITES = 2048
    GIT_STATUS_OPT_NO_REFRESH = 4096
    GIT_STATUS_OPT_UPDATE_INDEX = 8192
    GIT_STATUS_OPT_INCLUDE_UNREADABLE = 16384
    GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED = 32768
   
  git_status_options* {.bycopy, header: "<git2/status.h>", importc.} = object
    version*: cuint
    show*: git_status_show_t ## The version 
    flags*: cuint
    pathspec*: git_strarray
    baseline*: ptr git_tree
   
  git_status_show_t* = enum
    GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0
    GIT_STATUS_SHOW_INDEX_ONLY = 1
    GIT_STATUS_SHOW_WORKDIR_ONLY = 2
   
  git_status_t* = enum
    GIT_STATUS_CURRENT = 0
    GIT_STATUS_INDEX_NEW = 1
    GIT_STATUS_INDEX_MODIFIED = 2
    GIT_STATUS_INDEX_DELETED = 4
    GIT_STATUS_INDEX_RENAMED = 8
    GIT_STATUS_INDEX_TYPECHANGE = 16
    GIT_STATUS_WT_NEW = 128
    GIT_STATUS_WT_MODIFIED = 256
    GIT_STATUS_WT_DELETED = 512
    GIT_STATUS_WT_TYPECHANGE = 1024
    GIT_STATUS_WT_RENAMED = 2048
    GIT_STATUS_WT_UNREADABLE = 4096
    GIT_STATUS_IGNORED = 16384
    GIT_STATUS_CONFLICTED = 32768
   

proc git_status_options_init*(
    opts:    ptr git_status_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_status_foreach*(
    repo:     ptr git_repository,
    callback: git_status_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_status_foreach_ext*(
    repo:     ptr git_repository,
    opts:     ptr git_status_options,
    callback: git_status_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_status_file*(
    status_flags: ptr cuint,
    repo:         ptr git_repository,
    path:         cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_status_list_new*(
    arg_out: ptr ptr git_status_list,
    repo:    ptr git_repository,
    opts:    ptr git_status_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_status_list_entrycount*(
    statuslist: ptr git_status_list
  ): csize_t {.dynlib: libgit2Dl, importc.}


proc git_status_byindex*(
    statuslist: ptr git_status_list,
    idx:        csize_t
  ): ptr git_status_entry {.dynlib: libgit2Dl, importc.}


proc git_status_list_free*(
    statuslist: ptr git_status_list
  ): void {.dynlib: libgit2Dl, importc.}


proc git_status_should_ignore*(
    ignored: ptr cint,
    repo:    ptr git_repository,
    path:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


