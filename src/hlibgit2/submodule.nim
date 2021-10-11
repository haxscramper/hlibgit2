{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./oid

import
  ./buffer

import
  ./checkout

import
  ./remote

type
  git_submodule_cb* = proc(sm: ptr git_submodule, name: cstring, payload: pointer): cint{.cdecl.}
   
  git_submodule_cbNim* = proc(sm: ptr git_submodule, name: cstring): cint
   
  git_submodule_status_t* = enum
    GIT_SUBMODULE_STATUS_IN_HEAD = 1
    GIT_SUBMODULE_STATUS_IN_INDEX = 2
    GIT_SUBMODULE_STATUS_IN_CONFIG = 4
    GIT_SUBMODULE_STATUS_IN_WD = 8
    GIT_SUBMODULE_STATUS_INDEX_ADDED = 16
    GIT_SUBMODULE_STATUS_INDEX_DELETED = 32
    GIT_SUBMODULE_STATUS_INDEX_MODIFIED = 64
    GIT_SUBMODULE_STATUS_WD_UNINITIALIZED = 128
    GIT_SUBMODULE_STATUS_WD_ADDED = 256
    GIT_SUBMODULE_STATUS_WD_DELETED = 512
    GIT_SUBMODULE_STATUS_WD_MODIFIED = 1024
    GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = 2048
    GIT_SUBMODULE_STATUS_WD_WD_MODIFIED = 4096
    GIT_SUBMODULE_STATUS_WD_UNTRACKED = 8192
   
  git_submodule_update_options* {.bycopy, header: "<git2/submodule.h>", importc.} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    allow_fetch*: cint
   

proc git_submodule_update_options_init*(
    opts:    ptr git_submodule_update_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_update*(
    submodule: ptr git_submodule,
    init:      cint,
    options:   ptr git_submodule_update_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_lookup*(
    arg_out: ptr ptr git_submodule,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_free*(
    submodule: ptr git_submodule
  ): void {.dynlib: libgitDl, importc.}


proc git_submodule_foreach*(
    repo:     ptr git_repository,
    callback: git_submodule_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_add_setup*(
    arg_out:     ptr ptr git_submodule,
    repo:        ptr git_repository,
    url:         cstring,
    path:        cstring,
    use_gitlink: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_clone*(
    arg_out:   ptr ptr git_repository,
    submodule: ptr git_submodule,
    opts:      ptr git_submodule_update_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_add_finalize*(
    submodule: ptr git_submodule
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_add_to_index*(
    submodule:   ptr git_submodule,
    write_index: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_owner*(
    submodule: ptr git_submodule
  ): ptr git_repository {.dynlib: libgitDl, importc.}


proc git_submodule_name*(
    submodule: ptr git_submodule
  ): cstring {.dynlib: libgitDl, importc.}


proc git_submodule_path*(
    submodule: ptr git_submodule
  ): cstring {.dynlib: libgitDl, importc.}


proc git_submodule_url*(
    submodule: ptr git_submodule
  ): cstring {.dynlib: libgitDl, importc.}


proc git_submodule_resolve_url*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository,
    url:     cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_branch*(
    submodule: ptr git_submodule
  ): cstring {.dynlib: libgitDl, importc.}


proc git_submodule_set_branch*(
    repo:   ptr git_repository,
    name:   cstring,
    branch: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_set_url*(
    repo: ptr git_repository,
    name: cstring,
    url:  cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_index_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_submodule_head_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_submodule_wd_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_submodule_ignore*(
    submodule: ptr git_submodule
  ): git_submodule_ignore_t {.dynlib: libgitDl, importc.}


proc git_submodule_set_ignore*(
    repo:   ptr git_repository,
    name:   cstring,
    ignore: git_submodule_ignore_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_update_strategy*(
    submodule: ptr git_submodule
  ): git_submodule_update_t {.dynlib: libgitDl, importc.}


proc git_submodule_set_update*(
    repo:   ptr git_repository,
    name:   cstring,
    update: git_submodule_update_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_fetch_recurse_submodules*(
    submodule: ptr git_submodule
  ): git_submodule_recurse_t {.dynlib: libgitDl, importc.}


proc git_submodule_set_fetch_recurse_submodules*(
    repo:                     ptr git_repository,
    name:                     cstring,
    fetch_recurse_submodules: git_submodule_recurse_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_init*(
    submodule: ptr git_submodule,
    overwrite: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_repo_init*(
    arg_out:     ptr ptr git_repository,
    sm:          ptr git_submodule,
    use_gitlink: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_sync*(
    submodule: ptr git_submodule
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_open*(
    repo:      ptr ptr git_repository,
    submodule: ptr git_submodule
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_reload*(
    submodule: ptr git_submodule,
    force:     cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_status*(
    status: ptr cuint,
    repo:   ptr git_repository,
    name:   cstring,
    ignore: git_submodule_ignore_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_location*(
    location_status: ptr cuint,
    submodule:       ptr git_submodule
  ): cint {.dynlib: libgitDl, importc.}


