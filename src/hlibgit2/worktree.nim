{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./buffer

import
  ./strarray

type
  git_worktree_add_options* {.bycopy, header: "<git2/worktree.h>", importc.} = object
    version*: cuint
    lock*: cint
    ref_f* {.importc: "ref".}: ptr git_reference ## lock newly created worktree 
   
  git_worktree_prune_options* {.bycopy, header: "<git2/worktree.h>", importc.} = object
    version*: cuint
    flags*: uint32
   
  git_worktree_prune_t* = enum
    GIT_WORKTREE_PRUNE_VALID = 1 ## Prune working tree even if working tree is valid 
    GIT_WORKTREE_PRUNE_LOCKED = 2 ## Prune working tree even if it is locked 
    GIT_WORKTREE_PRUNE_WORKING_TREE = 4 ## Prune checked out working tree 
   

proc git_worktree_list*(
    arg_out: ptr git_strarray,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_lookup*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_open_from_repository*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_free*(
    wt: ptr git_worktree
  ): void {.dynlib: libgitDl, importc.}


proc git_worktree_validate*(
    wt: ptr git_worktree
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_add_options_init*(
    opts:    ptr git_worktree_add_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_add*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository,
    name:    cstring,
    path:    cstring,
    opts:    ptr git_worktree_add_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_lock*(
    wt:     ptr git_worktree,
    reason: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_unlock*(
    wt: ptr git_worktree
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_is_locked*(
    reason: ptr git_buf,
    wt:     ptr git_worktree
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_name*(
    wt: ptr git_worktree
  ): cstring {.dynlib: libgitDl, importc.}


proc git_worktree_path*(
    wt: ptr git_worktree
  ): cstring {.dynlib: libgitDl, importc.}


proc git_worktree_prune_options_init*(
    opts:    ptr git_worktree_prune_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_is_prunable*(
    wt:   ptr git_worktree,
    opts: ptr git_worktree_prune_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_prune*(
    wt:   ptr git_worktree,
    opts: ptr git_worktree_prune_options
  ): cint {.dynlib: libgitDl, importc.}


