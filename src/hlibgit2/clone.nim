{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./checkout

import
  ./remote

type
  git_clone_local_t* = enum
    GIT_CLONE_LOCAL_AUTO = 0
    GIT_CLONE_LOCAL = 1
    GIT_CLONE_NO_LOCAL = 2
    GIT_CLONE_LOCAL_NO_LINKS = 3
   
  git_clone_options* {.bycopy, header: "<git2/clone.h>", importc.} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    bare*: cint
    local*: git_clone_local_t
    checkout_branch*: cstring
    repository_cb*: git_repository_create_cb
    repository_cb_payload*: pointer
    remote_cb*: git_remote_create_cb
    remote_cb_payload*: pointer
   
  git_remote_create_cb* = proc(arg_out: ptr ptr git_remote, repo: ptr git_repository, name: cstring, url: cstring, payload: pointer): cint{.cdecl.}
   
  git_remote_create_cbNim* = proc(arg_out: ptr ptr git_remote, repo: ptr git_repository, name: cstring, url: cstring): cint
   
  git_repository_create_cb* = proc(arg_out: ptr ptr git_repository, path: cstring, bare: cint, payload: pointer): cint{.cdecl.}
   
  git_repository_create_cbNim* = proc(arg_out: ptr ptr git_repository, path: cstring, bare: cint): cint
   

proc git_clone_options_init*(
    opts:    ptr git_clone_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_clone*(
    arg_out:    ptr ptr git_repository,
    url:        cstring,
    local_path: cstring,
    options:    ptr git_clone_options
  ): cint {.dynlib: libgitDl, importc.}


