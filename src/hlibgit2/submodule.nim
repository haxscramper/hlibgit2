import "./buffer.nim"
import "./checkout.nim"
import "./libgit2_config.nim"
import "./oid.nim"
import "./remote.nim"
import "./types.nim"

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

  git_submodule_cb* = proc (a0: `ptr` git_submodule, a1: cstring, a2: pointer): cint



converter toCInt*(arg: c_git_submodule_status_t): cint = cint(ord(arg))

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

proc git_submodule_update_options_init*(opts: `ptr` git_submodule_update_options, version: cuint): cint {.git2Proc, importc.}

proc git_submodule_update*(submodule: `ptr` git_submodule, init: cint, options: `ptr` git_submodule_update_options): cint {.git2Proc, importc.}

proc git_submodule_lookup*(`out`: `ptr` git_submodule, repo: `ptr` git_repository, name: cstring): cint {.git2Proc, importc.}

proc git_submodule_dup*(`out`: `ptr` git_submodule, source: `ptr` git_submodule): cint {.git2Proc, importc.}

proc git_submodule_free*(submodule: `ptr` git_submodule): void {.git2Proc, importc.}

proc git_submodule_foreach*(repo: `ptr` git_repository, callback: git_submodule_cb, payload: pointer): cint {.git2Proc, importc.}

proc git_submodule_add_setup*(`out`: `ptr` git_submodule, repo: `ptr` git_repository, url: cstring, path: cstring, use_gitlink: cint): cint {.git2Proc, importc.}

proc git_submodule_clone*(`out`: `ptr` git_repository, submodule: `ptr` git_submodule, opts: `ptr` git_submodule_update_options): cint {.git2Proc, importc.}

proc git_submodule_add_finalize*(submodule: `ptr` git_submodule): cint {.git2Proc, importc.}

proc git_submodule_add_to_index*(submodule: `ptr` git_submodule, write_index: cint): cint {.git2Proc, importc.}

proc git_submodule_owner*(submodule: `ptr` git_submodule): `ptr` git_repository {.git2Proc, importc.}

proc git_submodule_name*(submodule: `ptr` git_submodule): cstring {.git2Proc, importc.}

proc git_submodule_path*(submodule: `ptr` git_submodule): cstring {.git2Proc, importc.}

proc git_submodule_url*(submodule: `ptr` git_submodule): cstring {.git2Proc, importc.}

proc git_submodule_resolve_url*(`out`: `ptr` git_buf, repo: `ptr` git_repository, url: cstring): cint {.git2Proc, importc.}

proc git_submodule_branch*(submodule: `ptr` git_submodule): cstring {.git2Proc, importc.}

proc git_submodule_set_branch*(repo: `ptr` git_repository, name: cstring, branch: cstring): cint {.git2Proc, importc.}

proc git_submodule_set_url*(repo: `ptr` git_repository, name: cstring, url: cstring): cint {.git2Proc, importc.}

proc git_submodule_index_id*(submodule: `ptr` git_submodule): `ptr` git_oid {.git2Proc, importc.}

proc git_submodule_head_id*(submodule: `ptr` git_submodule): `ptr` git_oid {.git2Proc, importc.}

proc git_submodule_wd_id*(submodule: `ptr` git_submodule): `ptr` git_oid {.git2Proc, importc.}

proc git_submodule_ignore*(submodule: `ptr` git_submodule): git_submodule_ignore_t {.git2Proc, importc.}

proc git_submodule_set_ignore*(repo: `ptr` git_repository, name: cstring, ignore: git_submodule_ignore_t): cint {.git2Proc, importc.}

proc git_submodule_update_strategy*(submodule: `ptr` git_submodule): git_submodule_update_t {.git2Proc, importc.}

proc git_submodule_set_update*(repo: `ptr` git_repository, name: cstring, update: git_submodule_update_t): cint {.git2Proc, importc.}

proc git_submodule_fetch_recurse_submodules*(submodule: `ptr` git_submodule): git_submodule_recurse_t {.git2Proc, importc.}

proc git_submodule_set_fetch_recurse_submodules*(repo: `ptr` git_repository, name: cstring, fetch_recurse_submodules: git_submodule_recurse_t): cint {.git2Proc, importc.}

proc git_submodule_init*(submodule: `ptr` git_submodule, overwrite: cint): cint {.git2Proc, importc.}

proc git_submodule_repo_init*(`out`: `ptr` git_repository, sm: `ptr` git_submodule, use_gitlink: cint): cint {.git2Proc, importc.}

proc git_submodule_sync*(submodule: `ptr` git_submodule): cint {.git2Proc, importc.}

proc git_submodule_open*(repo: `ptr` git_repository, submodule: `ptr` git_submodule): cint {.git2Proc, importc.}

proc git_submodule_reload*(submodule: `ptr` git_submodule, force: cint): cint {.git2Proc, importc.}

proc git_submodule_status*(status: `ptr` cuint, repo: `ptr` git_repository, name: cstring, ignore: git_submodule_ignore_t): cint {.git2Proc, importc.}

proc git_submodule_location*(location_status: `ptr` cuint, submodule: `ptr` git_submodule): cint {.git2Proc, importc.}