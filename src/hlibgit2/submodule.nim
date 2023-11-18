{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./checkout,
  ./libgit2_config,
  ./oid,
  ./remote,
  ./types

type
  c_git_submodule_status_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_STATUS_IN_HEAD           = 1 shl 0
    c_GIT_SUBMODULE_STATUS_IN_INDEX          = 1 shl 1
    c_GIT_SUBMODULE_STATUS_IN_CONFIG         = 1 shl 2
    c_GIT_SUBMODULE_STATUS_IN_WD             = 1 shl 3
    c_GIT_SUBMODULE_STATUS_INDEX_ADDED       = 1 shl 4
    c_GIT_SUBMODULE_STATUS_INDEX_DELETED     = 1 shl 5
    c_GIT_SUBMODULE_STATUS_INDEX_MODIFIED    = 1 shl 6
    c_GIT_SUBMODULE_STATUS_WD_UNINITIALIZED  = 1 shl 7
    c_GIT_SUBMODULE_STATUS_WD_ADDED          = 1 shl 8
    c_GIT_SUBMODULE_STATUS_WD_DELETED        = 1 shl 9
    c_GIT_SUBMODULE_STATUS_WD_MODIFIED       = 1 shl 10
    c_GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = 1 shl 11
    c_GIT_SUBMODULE_STATUS_WD_WD_MODIFIED    = 1 shl 12
    c_GIT_SUBMODULE_STATUS_WD_UNTRACKED      = 1 shl 13

  git_submodule_cb* = proc(sm:      ptr git_submodule,
                           name:    cstring,
                           payload: pointer): cint{.cdecl.}

  git_submodule_status_t* {.size: sizeof(cint).} = enum
    GIT_SUBMODULE_STATUS_IN_HEAD
    GIT_SUBMODULE_STATUS_IN_INDEX
    GIT_SUBMODULE_STATUS_IN_CONFIG
    GIT_SUBMODULE_STATUS_IN_WD
    GIT_SUBMODULE_STATUS_INDEX_ADDED
    GIT_SUBMODULE_STATUS_INDEX_DELETED
    GIT_SUBMODULE_STATUS_INDEX_MODIFIED
    GIT_SUBMODULE_STATUS_WD_UNINITIALIZED
    GIT_SUBMODULE_STATUS_WD_ADDED
    GIT_SUBMODULE_STATUS_WD_DELETED
    GIT_SUBMODULE_STATUS_WD_MODIFIED
    GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED
    GIT_SUBMODULE_STATUS_WD_WD_MODIFIED
    GIT_SUBMODULE_STATUS_WD_UNTRACKED

  git_submodule_update_options* {.bycopy, header: "<git2/submodule.h>", importc.} = object
    version*:       cuint
    checkout_opts*: git_checkout_options
    fetch_opts*:    git_fetch_options
    allow_fetch*:   cint


proc to_c_git_submodule_status_t*(
    arg: git_submodule_status_t
  ): c_git_submodule_status_t =
  case arg:
    of GIT_SUBMODULE_STATUS_IN_HEAD:           c_GIT_SUBMODULE_STATUS_IN_HEAD
    of GIT_SUBMODULE_STATUS_IN_INDEX:          c_GIT_SUBMODULE_STATUS_IN_INDEX
    of GIT_SUBMODULE_STATUS_IN_CONFIG:         c_GIT_SUBMODULE_STATUS_IN_CONFIG
    of GIT_SUBMODULE_STATUS_IN_WD:             c_GIT_SUBMODULE_STATUS_IN_WD
    of GIT_SUBMODULE_STATUS_INDEX_ADDED:       c_GIT_SUBMODULE_STATUS_INDEX_ADDED
    of GIT_SUBMODULE_STATUS_INDEX_DELETED:     c_GIT_SUBMODULE_STATUS_INDEX_DELETED
    of GIT_SUBMODULE_STATUS_INDEX_MODIFIED:    c_GIT_SUBMODULE_STATUS_INDEX_MODIFIED
    of GIT_SUBMODULE_STATUS_WD_UNINITIALIZED:  c_GIT_SUBMODULE_STATUS_WD_UNINITIALIZED
    of GIT_SUBMODULE_STATUS_WD_ADDED:          c_GIT_SUBMODULE_STATUS_WD_ADDED
    of GIT_SUBMODULE_STATUS_WD_DELETED:        c_GIT_SUBMODULE_STATUS_WD_DELETED
    of GIT_SUBMODULE_STATUS_WD_MODIFIED:       c_GIT_SUBMODULE_STATUS_WD_MODIFIED
    of GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED: c_GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED
    of GIT_SUBMODULE_STATUS_WD_WD_MODIFIED:    c_GIT_SUBMODULE_STATUS_WD_WD_MODIFIED
    of GIT_SUBMODULE_STATUS_WD_UNTRACKED:      c_GIT_SUBMODULE_STATUS_WD_UNTRACKED


converter to_git_submodule_status_t*(
    arg: c_git_submodule_status_t
  ): git_submodule_status_t =
  case arg:
    of c_GIT_SUBMODULE_STATUS_IN_HEAD:           GIT_SUBMODULE_STATUS_IN_HEAD
    of c_GIT_SUBMODULE_STATUS_IN_INDEX:          GIT_SUBMODULE_STATUS_IN_INDEX
    of c_GIT_SUBMODULE_STATUS_IN_CONFIG:         GIT_SUBMODULE_STATUS_IN_CONFIG
    of c_GIT_SUBMODULE_STATUS_IN_WD:             GIT_SUBMODULE_STATUS_IN_WD
    of c_GIT_SUBMODULE_STATUS_INDEX_ADDED:       GIT_SUBMODULE_STATUS_INDEX_ADDED
    of c_GIT_SUBMODULE_STATUS_INDEX_DELETED:     GIT_SUBMODULE_STATUS_INDEX_DELETED
    of c_GIT_SUBMODULE_STATUS_INDEX_MODIFIED:    GIT_SUBMODULE_STATUS_INDEX_MODIFIED
    of c_GIT_SUBMODULE_STATUS_WD_UNINITIALIZED:  GIT_SUBMODULE_STATUS_WD_UNINITIALIZED
    of c_GIT_SUBMODULE_STATUS_WD_ADDED:          GIT_SUBMODULE_STATUS_WD_ADDED
    of c_GIT_SUBMODULE_STATUS_WD_DELETED:        GIT_SUBMODULE_STATUS_WD_DELETED
    of c_GIT_SUBMODULE_STATUS_WD_MODIFIED:       GIT_SUBMODULE_STATUS_WD_MODIFIED
    of c_GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED: GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED
    of c_GIT_SUBMODULE_STATUS_WD_WD_MODIFIED:    GIT_SUBMODULE_STATUS_WD_WD_MODIFIED
    of c_GIT_SUBMODULE_STATUS_WD_UNTRACKED:      GIT_SUBMODULE_STATUS_WD_UNTRACKED


converter toCint*(arg: c_git_submodule_status_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_submodule_status_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_submodule_status_t(arg)))

func `+`*(
    arg:    c_git_submodule_status_t,
    offset: int
  ): c_git_submodule_status_t =
  cast[c_git_submodule_status_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_submodule_status_t
  ): c_git_submodule_status_t =
  cast[c_git_submodule_status_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_submodule_status_t,
    offset: int
  ): c_git_submodule_status_t =
  cast[c_git_submodule_status_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_submodule_status_t
  ): c_git_submodule_status_t =
  cast[c_git_submodule_status_t](ord(arg) - offset)


converter toCint*(args: set[git_submodule_status_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc git_submodule_update_options_init*(
    opts:    ptr git_submodule_update_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_submodule_update*(
    submodule: ptr git_submodule,
    init:      cint,
    options:   ptr git_submodule_update_options
  ): cint {.git2Proc, importc.}



proc git_submodule_lookup*(
    arg_out: ptr ptr git_submodule,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_submodule_dup*(
    arg_out: ptr ptr git_submodule,
    source:  ptr git_submodule
  ): cint {.git2Proc, importc.}



proc git_submodule_free*(
    submodule: ptr git_submodule
  ): void {.git2Proc, importc.}



proc git_submodule_foreach*(
    repo:     ptr git_repository,
    callback: git_submodule_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_submodule_add_setup*(
    arg_out:     ptr ptr git_submodule,
    repo:        ptr git_repository,
    url:         cstring,
    path:        cstring,
    use_gitlink: cint
  ): cint {.git2Proc, importc.}



proc git_submodule_clone*(
    arg_out:   ptr ptr git_repository,
    submodule: ptr git_submodule,
    opts:      ptr git_submodule_update_options
  ): cint {.git2Proc, importc.}



proc git_submodule_add_finalize*(
    submodule: ptr git_submodule
  ): cint {.git2Proc, importc.}



proc git_submodule_add_to_index*(
    submodule:   ptr git_submodule,
    write_index: cint
  ): cint {.git2Proc, importc.}



proc git_submodule_owner*(
    submodule: ptr git_submodule
  ): ptr git_repository {.git2Proc, importc.}



proc git_submodule_name*(
    submodule: ptr git_submodule
  ): cstring {.git2Proc, importc.}



proc git_submodule_path*(
    submodule: ptr git_submodule
  ): cstring {.git2Proc, importc.}



proc git_submodule_url*(
    submodule: ptr git_submodule
  ): cstring {.git2Proc, importc.}



proc git_submodule_resolve_url*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository,
    url:     cstring
  ): cint {.git2Proc, importc.}



proc git_submodule_branch*(
    submodule: ptr git_submodule
  ): cstring {.git2Proc, importc.}



proc git_submodule_set_branch*(
    repo:   ptr git_repository,
    name:   cstring,
    branch: cstring
  ): cint {.git2Proc, importc.}



proc git_submodule_set_url*(
    repo: ptr git_repository,
    name: cstring,
    url:  cstring
  ): cint {.git2Proc, importc.}



proc git_submodule_index_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.git2Proc, importc.}



proc git_submodule_head_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.git2Proc, importc.}



proc git_submodule_wd_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.git2Proc, importc.}



proc git_submodule_ignore*(
    submodule: ptr git_submodule
  ): c_git_submodule_ignore_t {.git2Proc, importc.}



proc git_submodule_set_ignore*(
    repo:   ptr git_repository,
    name:   cstring,
    ignore: c_git_submodule_ignore_t
  ): cint {.git2Proc, importc.}



proc git_submodule_update_strategy*(
    submodule: ptr git_submodule
  ): c_git_submodule_update_t {.git2Proc, importc.}



proc git_submodule_set_update*(
    repo:   ptr git_repository,
    name:   cstring,
    update: c_git_submodule_update_t
  ): cint {.git2Proc, importc.}



proc git_submodule_fetch_recurse_submodules*(
    submodule: ptr git_submodule
  ): c_git_submodule_recurse_t {.git2Proc, importc.}



proc git_submodule_set_fetch_recurse_submodules*(
    repo:                     ptr git_repository,
    name:                     cstring,
    fetch_recurse_submodules: c_git_submodule_recurse_t
  ): cint {.git2Proc, importc.}



proc git_submodule_init*(
    submodule: ptr git_submodule,
    overwrite: cint
  ): cint {.git2Proc, importc.}



proc git_submodule_repo_init*(
    arg_out:     ptr ptr git_repository,
    sm:          ptr git_submodule,
    use_gitlink: cint
  ): cint {.git2Proc, importc.}



proc git_submodule_sync*(
    submodule: ptr git_submodule
  ): cint {.git2Proc, importc.}



proc git_submodule_open*(
    repo:      ptr ptr git_repository,
    submodule: ptr git_submodule
  ): cint {.git2Proc, importc.}



proc git_submodule_reload*(
    submodule: ptr git_submodule,
    force:     cint
  ): cint {.git2Proc, importc.}



proc git_submodule_status*(
    status: ptr cuint,
    repo:   ptr git_repository,
    name:   cstring,
    ignore: c_git_submodule_ignore_t
  ): cint {.git2Proc, importc.}



proc git_submodule_location*(
    location_status: ptr cuint,
    submodule:       ptr git_submodule
  ): cint {.git2Proc, importc.}



