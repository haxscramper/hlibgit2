import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./remote.nim"
import "./checkout.nim"
import "./oid.nim"
import "./buffer.nim"

type
  git_submodule_update_options* {.importc, bycopy.} = object
    version       *: cuint
    checkout_opts *: git_checkout_options
    fetch_opts    *: git_fetch_options
    allow_fetch   *: cint

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

  git_submodule_status_t* = enum
    GIT_SUBMODULE_STATUS_IN_HEAD           = 0
    GIT_SUBMODULE_STATUS_IN_INDEX          = 1
    GIT_SUBMODULE_STATUS_IN_CONFIG         = 2
    GIT_SUBMODULE_STATUS_IN_WD             = 3
    GIT_SUBMODULE_STATUS_INDEX_ADDED       = 4
    GIT_SUBMODULE_STATUS_INDEX_DELETED     = 5
    GIT_SUBMODULE_STATUS_INDEX_MODIFIED    = 6
    GIT_SUBMODULE_STATUS_WD_UNINITIALIZED  = 7
    GIT_SUBMODULE_STATUS_WD_ADDED          = 8
    GIT_SUBMODULE_STATUS_WD_DELETED        = 9
    GIT_SUBMODULE_STATUS_WD_MODIFIED       = 10
    GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = 11
    GIT_SUBMODULE_STATUS_WD_WD_MODIFIED    = 12
    GIT_SUBMODULE_STATUS_WD_UNTRACKED      = 13

  git_submodule_cb* = proc (a0: ptr git_submodule, a1: cstring, a2: pointer): cint



converter to_git_submodule_status_t*(arg: c_git_submodule_status_t): git_submodule_status_t =
  case arg:
    of c_GIT_SUBMODULE_STATUS_IN_HEAD          : GIT_SUBMODULE_STATUS_IN_HEAD
    of c_GIT_SUBMODULE_STATUS_IN_INDEX         : GIT_SUBMODULE_STATUS_IN_INDEX
    of c_GIT_SUBMODULE_STATUS_IN_CONFIG        : GIT_SUBMODULE_STATUS_IN_CONFIG
    of c_GIT_SUBMODULE_STATUS_IN_WD            : GIT_SUBMODULE_STATUS_IN_WD
    of c_GIT_SUBMODULE_STATUS_INDEX_ADDED      : GIT_SUBMODULE_STATUS_INDEX_ADDED
    of c_GIT_SUBMODULE_STATUS_INDEX_DELETED    : GIT_SUBMODULE_STATUS_INDEX_DELETED
    of c_GIT_SUBMODULE_STATUS_INDEX_MODIFIED   : GIT_SUBMODULE_STATUS_INDEX_MODIFIED
    of c_GIT_SUBMODULE_STATUS_WD_UNINITIALIZED : GIT_SUBMODULE_STATUS_WD_UNINITIALIZED
    of c_GIT_SUBMODULE_STATUS_WD_ADDED         : GIT_SUBMODULE_STATUS_WD_ADDED
    of c_GIT_SUBMODULE_STATUS_WD_DELETED       : GIT_SUBMODULE_STATUS_WD_DELETED
    of c_GIT_SUBMODULE_STATUS_WD_MODIFIED      : GIT_SUBMODULE_STATUS_WD_MODIFIED
    of c_GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED: GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED
    of c_GIT_SUBMODULE_STATUS_WD_WD_MODIFIED   : GIT_SUBMODULE_STATUS_WD_WD_MODIFIED
    of c_GIT_SUBMODULE_STATUS_WD_UNTRACKED     : GIT_SUBMODULE_STATUS_WD_UNTRACKED

proc to_c_git_submodule_status_t*(arg: git_submodule_status_t): c_git_submodule_status_t =
  case arg:
    of GIT_SUBMODULE_STATUS_IN_HEAD          : c_GIT_SUBMODULE_STATUS_IN_HEAD
    of GIT_SUBMODULE_STATUS_IN_INDEX         : c_GIT_SUBMODULE_STATUS_IN_INDEX
    of GIT_SUBMODULE_STATUS_IN_CONFIG        : c_GIT_SUBMODULE_STATUS_IN_CONFIG
    of GIT_SUBMODULE_STATUS_IN_WD            : c_GIT_SUBMODULE_STATUS_IN_WD
    of GIT_SUBMODULE_STATUS_INDEX_ADDED      : c_GIT_SUBMODULE_STATUS_INDEX_ADDED
    of GIT_SUBMODULE_STATUS_INDEX_DELETED    : c_GIT_SUBMODULE_STATUS_INDEX_DELETED
    of GIT_SUBMODULE_STATUS_INDEX_MODIFIED   : c_GIT_SUBMODULE_STATUS_INDEX_MODIFIED
    of GIT_SUBMODULE_STATUS_WD_UNINITIALIZED : c_GIT_SUBMODULE_STATUS_WD_UNINITIALIZED
    of GIT_SUBMODULE_STATUS_WD_ADDED         : c_GIT_SUBMODULE_STATUS_WD_ADDED
    of GIT_SUBMODULE_STATUS_WD_DELETED       : c_GIT_SUBMODULE_STATUS_WD_DELETED
    of GIT_SUBMODULE_STATUS_WD_MODIFIED      : c_GIT_SUBMODULE_STATUS_WD_MODIFIED
    of GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED: c_GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED
    of GIT_SUBMODULE_STATUS_WD_WD_MODIFIED   : c_GIT_SUBMODULE_STATUS_WD_WD_MODIFIED
    of GIT_SUBMODULE_STATUS_WD_UNTRACKED     : c_GIT_SUBMODULE_STATUS_WD_UNTRACKED

converter toCInt*(arg: c_git_submodule_status_t): cint = cint(ord(arg))

converter toCInt*(arg: git_submodule_status_t): cint = cint(ord(to_c_git_submodule_status_t(arg)))

converter toCInt*(args: set[git_submodule_status_t]): cint =
  for value in items(args):
    case value:
      of GIT_SUBMODULE_STATUS_IN_HEAD          : result = cint(result or 1)
      of GIT_SUBMODULE_STATUS_IN_INDEX         : result = cint(result or 2)
      of GIT_SUBMODULE_STATUS_IN_CONFIG        : result = cint(result or 4)
      of GIT_SUBMODULE_STATUS_IN_WD            : result = cint(result or 8)
      of GIT_SUBMODULE_STATUS_INDEX_ADDED      : result = cint(result or 16)
      of GIT_SUBMODULE_STATUS_INDEX_DELETED    : result = cint(result or 32)
      of GIT_SUBMODULE_STATUS_INDEX_MODIFIED   : result = cint(result or 64)
      of GIT_SUBMODULE_STATUS_WD_UNINITIALIZED : result = cint(result or 128)
      of GIT_SUBMODULE_STATUS_WD_ADDED         : result = cint(result or 256)
      of GIT_SUBMODULE_STATUS_WD_DELETED       : result = cint(result or 512)
      of GIT_SUBMODULE_STATUS_WD_MODIFIED      : result = cint(result or 1024)
      of GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED: result = cint(result or 2048)
      of GIT_SUBMODULE_STATUS_WD_WD_MODIFIED   : result = cint(result or 4096)
      of GIT_SUBMODULE_STATUS_WD_UNTRACKED     : result = cint(result or 8192)

func `-`*(arg: c_git_submodule_status_t, offset: int): cint = cast[c_git_submodule_status_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_submodule_status_t): cint = cast[c_git_submodule_status_t](ord(arg) - offset)

func `+`*(arg: c_git_submodule_status_t, offset: int): cint = cast[c_git_submodule_status_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_submodule_status_t): cint = cast[c_git_submodule_status_t](ord(arg) + offset)

proc git_submodule_update_options_init*(opts: ptr git_submodule_update_options, version: cuint): cint {.importc: "git_submodule_update_options_init".}

proc git_submodule_update*(
    submodule: ptr git_submodule,
    init: cint,
    options: ptr git_submodule_update_options,
): cint {.importc: "git_submodule_update".}

proc git_submodule_lookup*(
    `out`: ptr ptr git_submodule,
    repo: ptr git_repository,
    name: cstring,
): cint {.importc: "git_submodule_lookup".}

proc git_submodule_dup*(`out`: ptr ptr git_submodule, source: ptr git_submodule): cint {.importc: "git_submodule_dup".}

proc git_submodule_free*(submodule: ptr git_submodule): void {.importc: "git_submodule_free".}

proc git_submodule_foreach*(
    repo: ptr git_repository,
    callback: git_submodule_cb,
    payload: pointer,
): cint {.importc: "git_submodule_foreach".}

proc git_submodule_add_setup*(
    `out`: ptr ptr git_submodule,
    repo: ptr git_repository,
    url: cstring,
    path: cstring,
    use_gitlink: cint,
): cint {.importc: "git_submodule_add_setup".}

proc git_submodule_clone*(
    `out`: ptr ptr git_repository,
    submodule: ptr git_submodule,
    opts: ptr git_submodule_update_options,
): cint {.importc: "git_submodule_clone".}

proc git_submodule_add_finalize*(submodule: ptr git_submodule): cint {.importc: "git_submodule_add_finalize".}

proc git_submodule_add_to_index*(submodule: ptr git_submodule, write_index: cint): cint {.importc: "git_submodule_add_to_index".}

proc git_submodule_owner*(submodule: ptr git_submodule): ptr git_repository {.importc: "git_submodule_owner".}

proc git_submodule_name*(submodule: ptr git_submodule): cstring {.importc: "git_submodule_name".}

proc git_submodule_path*(submodule: ptr git_submodule): cstring {.importc: "git_submodule_path".}

proc git_submodule_url*(submodule: ptr git_submodule): cstring {.importc: "git_submodule_url".}

proc git_submodule_resolve_url*(
    `out`: ptr git_buf,
    repo: ptr git_repository,
    url: cstring,
): cint {.importc: "git_submodule_resolve_url".}

proc git_submodule_branch*(submodule: ptr git_submodule): cstring {.importc: "git_submodule_branch".}

proc git_submodule_set_branch*(
    repo: ptr git_repository,
    name: cstring,
    branch: cstring,
): cint {.importc: "git_submodule_set_branch".}

proc git_submodule_set_url*(
    repo: ptr git_repository,
    name: cstring,
    url: cstring,
): cint {.importc: "git_submodule_set_url".}

proc git_submodule_index_id*(submodule: ptr git_submodule): ptr git_oid {.importc: "git_submodule_index_id".}

proc git_submodule_head_id*(submodule: ptr git_submodule): ptr git_oid {.importc: "git_submodule_head_id".}

proc git_submodule_wd_id*(submodule: ptr git_submodule): ptr git_oid {.importc: "git_submodule_wd_id".}

proc git_submodule_ignore*(submodule: ptr git_submodule): git_submodule_ignore_t {.importc: "git_submodule_ignore".}

proc git_submodule_set_ignore*(
    repo: ptr git_repository,
    name: cstring,
    ignore: git_submodule_ignore_t,
): cint {.importc: "git_submodule_set_ignore".}

proc git_submodule_update_strategy*(submodule: ptr git_submodule): git_submodule_update_t {.importc: "git_submodule_update_strategy".}

proc git_submodule_set_update*(
    repo: ptr git_repository,
    name: cstring,
    update: git_submodule_update_t,
): cint {.importc: "git_submodule_set_update".}

proc git_submodule_fetch_recurse_submodules*(submodule: ptr git_submodule): git_submodule_recurse_t {.importc: "git_submodule_fetch_recurse_submodules".}

proc git_submodule_set_fetch_recurse_submodules*(
    repo: ptr git_repository,
    name: cstring,
    fetch_recurse_submodules: git_submodule_recurse_t,
): cint {.importc: "git_submodule_set_fetch_recurse_submodules".}

proc git_submodule_init*(submodule: ptr git_submodule, overwrite: cint): cint {.importc: "git_submodule_init".}

proc git_submodule_repo_init*(
    `out`: ptr ptr git_repository,
    sm: ptr git_submodule,
    use_gitlink: cint,
): cint {.importc: "git_submodule_repo_init".}

proc git_submodule_sync*(submodule: ptr git_submodule): cint {.importc: "git_submodule_sync".}

proc git_submodule_open*(repo: ptr ptr git_repository, submodule: ptr git_submodule): cint {.importc: "git_submodule_open".}

proc git_submodule_reload*(submodule: ptr git_submodule, force: cint): cint {.importc: "git_submodule_reload".}

proc git_submodule_status*(
    status: ptr cuint,
    repo: ptr git_repository,
    name: cstring,
    ignore: git_submodule_ignore_t,
): cint {.importc: "git_submodule_status".}

proc git_submodule_location*(location_status: ptr cuint, submodule: ptr git_submodule): cint {.importc: "git_submodule_location".}