{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./diff

type
  git_apply_delta_cb* = proc(delta: ptr git_diff_delta, payload: pointer): cint{.cdecl.}
   
  git_apply_delta_cbNim* = proc(delta: ptr git_diff_delta): cint
   
  git_apply_flags_t* = enum
    GIT_APPLY_CHECK = 1
   
  git_apply_hunk_cb* = proc(hunk: ptr git_diff_hunk, payload: pointer): cint{.cdecl.}
   
  git_apply_hunk_cbNim* = proc(hunk: ptr git_diff_hunk): cint
   
  git_apply_location_t* = enum
    GIT_APPLY_LOCATION_WORKDIR = 0
    GIT_APPLY_LOCATION_INDEX = 1
    GIT_APPLY_LOCATION_BOTH = 2
   
  git_apply_options* {.bycopy, header: "<git2/apply.h>", importc.} = object
    version*: cuint
    delta_cb*: git_apply_delta_cb ## The version 
                                  ## When applying a patch, callback that will be made per delta (file). 
    hunk_cb*: git_apply_hunk_cb ## When applying a patch, callback that will be made per hunk. 
    payload*: pointer ## Payload passed to both delta_cb & hunk_cb. 
    flags*: cuint ## Bitmask of git_apply_flags_t 
   

proc git_apply_options_init*(
    opts:    ptr git_apply_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_apply_to_tree*(
    arg_out:  ptr ptr git_index,
    repo:     ptr git_repository,
    preimage: ptr git_tree,
    diff:     ptr git_diff,
    options:  ptr git_apply_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_apply*(
    repo:     ptr git_repository,
    diff:     ptr git_diff,
    location: git_apply_location_t,
    options:  ptr git_apply_options
  ): cint {.dynlib: libgitDl, importc.}


