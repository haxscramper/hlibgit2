{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./oid

import
  ./checkout

type
  git_stash_apply_flags* = enum
    GIT_STASH_APPLY_DEFAULT = 0
    GIT_STASH_APPLY_REINSTATE_INDEX = 1
   
  git_stash_apply_options* {.bycopy, header: "<git2/stash.h>", importc.} = object
    version*: cuint
    flags*: uint32 ## See `git_stash_apply_flags`, above. 
    checkout_options*: git_checkout_options ## Options to use when writing files to the working directory. 
    progress_cb*: git_stash_apply_progress_cb ## Optional callback to notify the consumer of application progress. 
    progress_payload*: pointer
   
  git_stash_apply_progress_cb* = proc(progress: git_stash_apply_progress_t, payload: pointer): cint{.cdecl.}
   
  git_stash_apply_progress_cbNim* = proc(progress: git_stash_apply_progress_t): cint
   
  git_stash_apply_progress_t* = enum
    GIT_STASH_APPLY_PROGRESS_NONE = 0
    GIT_STASH_APPLY_PROGRESS_LOADING_STASH = 1 ## Loading the stashed data from the object database. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX = 2 ## The stored index is being analyzed. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED = 3 ## The modified files are being analyzed. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED = 4 ## The untracked and ignored files are being analyzed. 
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = 5 ## The untracked files are being written to disk. 
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED = 6 ## The modified files are being written to disk. 
    GIT_STASH_APPLY_PROGRESS_DONE = 7 ## The stash was applied successfully. 
   
  git_stash_cb* = proc(index: csize_t, message: cstring, stash_id: ptr git_oid, payload: pointer): cint{.cdecl.}
   
  git_stash_cbNim* = proc(index: csize_t, message: cstring, stash_id: ptr git_oid): cint
   
  git_stash_flags* = enum
    GIT_STASH_DEFAULT = 0
    GIT_STASH_KEEP_INDEX = 1
    GIT_STASH_INCLUDE_UNTRACKED = 2
    GIT_STASH_INCLUDE_IGNORED = 4
   

proc git_stash_save*(
    arg_out: ptr git_oid,
    repo:    ptr git_repository,
    stasher: ptr git_signature,
    message: cstring,
    flags:   uint32
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_apply_options_init*(
    opts:    ptr git_stash_apply_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_apply*(
    repo:    ptr git_repository,
    index:   csize_t,
    options: ptr git_stash_apply_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_foreach*(
    repo:     ptr git_repository,
    callback: git_stash_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_drop*(
    repo:  ptr git_repository,
    index: csize_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_pop*(
    repo:    ptr git_repository,
    index:   csize_t,
    options: ptr git_stash_apply_options
  ): cint {.dynlib: libgitDl, importc.}


