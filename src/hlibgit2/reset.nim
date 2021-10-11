{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./checkout

import
  ./strarray

type
  git_reset_t* = enum
    GIT_RESET_SOFT = 1
    GIT_RESET_MIXED = 2 ## Move the head to the given commit 
    GIT_RESET_HARD = 3 ## SOFT plus reset index to the commit 
   

proc git_reset*(
    repo:          ptr git_repository,
    target:        ptr git_object,
    reset_type:    git_reset_t,
    checkout_opts: ptr git_checkout_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_reset_from_annotated*(
    repo:          ptr git_repository,
    commit:        ptr git_annotated_commit,
    reset_type:    git_reset_t,
    checkout_opts: ptr git_checkout_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_reset_default*(
    repo:      ptr git_repository,
    target:    ptr git_object,
    pathspecs: ptr git_strarray
  ): cint {.dynlib: libgitDl, importc.}


