{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./merge

import
  ./checkout

type
  git_revert_options* {.bycopy, header: "<git2/revert.h>", importc.} = object
    version*: cuint
    mainline*: cuint ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
   

proc git_revert_options_init*(
    opts:    ptr git_revert_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_revert_commit*(
    arg_out:       ptr ptr git_index,
    repo:          ptr git_repository,
    revert_commit: ptr git_commit,
    our_commit:    ptr git_commit,
    mainline:      cuint,
    merge_options: ptr git_merge_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_revert*(
    repo:       ptr git_repository,
    commit:     ptr git_commit,
    given_opts: ptr git_revert_options
  ): cint {.dynlib: libgitDl, importc.}


