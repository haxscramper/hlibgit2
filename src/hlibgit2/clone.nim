{.push warning[UnusedImport]:off.}

import
  ./checkout,
  ./libgit2_config,
  ./remote,
  ./types

type
  c_git_clone_local_t* {.size: sizeof(cint).} = enum
    c_GIT_CLONE_LOCAL_AUTO     = 0
    c_GIT_CLONE_LOCAL          = 1
    c_GIT_CLONE_NO_LOCAL       = 2
    c_GIT_CLONE_LOCAL_NO_LINKS = 3

  git_clone_local_t* = enum
    GIT_CLONE_LOCAL_AUTO
    GIT_CLONE_LOCAL
    GIT_CLONE_NO_LOCAL
    GIT_CLONE_LOCAL_NO_LINKS

  git_clone_options* {.bycopy, header: "<git2/clone.h>", importc.} = object
    version*:               cuint
    checkout_opts*:         git_checkout_options
    fetch_opts*:            git_fetch_options
    bare*:                  cint
    local*:                 c_git_clone_local_t
    checkout_branch*:       cstring
    repository_cb*:         git_repository_create_cb
    repository_cb_payload*: pointer
    remote_cb*:             git_remote_create_cb
    remote_cb_payload*:     pointer

  git_remote_create_cb* = proc(arg_out: ptr ptr git_remote,
                               repo:    ptr git_repository,
                               name:    cstring,
                               url:     cstring,
                               payload: pointer): cint{.cdecl.}

  git_repository_create_cb* = proc(arg_out: ptr ptr git_repository,
                                   path:    cstring,
                                   bare:    cint,
                                   payload: pointer): cint{.cdecl.}


proc to_c_git_clone_local_t*(arg: git_clone_local_t): c_git_clone_local_t =
  case arg:
    of GIT_CLONE_LOCAL_AUTO:     c_GIT_CLONE_LOCAL_AUTO
    of GIT_CLONE_LOCAL:          c_GIT_CLONE_LOCAL
    of GIT_CLONE_NO_LOCAL:       c_GIT_CLONE_NO_LOCAL
    of GIT_CLONE_LOCAL_NO_LINKS: c_GIT_CLONE_LOCAL_NO_LINKS


converter to_git_clone_local_t*(arg: c_git_clone_local_t): git_clone_local_t =
  case arg:
    of c_GIT_CLONE_LOCAL_AUTO:     GIT_CLONE_LOCAL_AUTO
    of c_GIT_CLONE_LOCAL:          GIT_CLONE_LOCAL
    of c_GIT_CLONE_NO_LOCAL:       GIT_CLONE_NO_LOCAL
    of c_GIT_CLONE_LOCAL_NO_LINKS: GIT_CLONE_LOCAL_NO_LINKS


converter toCint*(arg: c_git_clone_local_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_clone_local_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_clone_local_t(arg)))

func `+`*(arg: c_git_clone_local_t, offset: int): c_git_clone_local_t =
  cast[c_git_clone_local_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_clone_local_t): c_git_clone_local_t =
  cast[c_git_clone_local_t](ord(arg) + offset)

func `-`*(arg: c_git_clone_local_t, offset: int): c_git_clone_local_t =
  cast[c_git_clone_local_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_clone_local_t): c_git_clone_local_t =
  cast[c_git_clone_local_t](ord(arg) - offset)


proc git_clone_options_init*(
    opts:    ptr git_clone_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_clone*(
    arg_out:    ptr ptr git_repository,
    url:        cstring,
    local_path: cstring,
    options:    ptr git_clone_options
  ): cint {.git2Proc, importc.}



