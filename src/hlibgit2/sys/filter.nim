import "../buffer.nim"
import "../filter.nim"
import "../libgit2_config.nim"
import "../oid.nim"
import "../types.nim"

type
  git_filter_source* {.importc, bycopy, incompleteStruct.} = object


  git_filter_init_fn* = proc (a0: `ptr` git_filter): cint

  git_filter_shutdown_fn* = proc (a0: `ptr` git_filter): void

  git_filter_check_fn* = proc (a0: `ptr` git_filter, a1: pointer, a2: `ptr` git_filter_source, a3: cstring): cint

  git_filter_apply_fn* = proc (a0: `ptr` git_filter, a1: pointer, a2: `ptr` git_buf, a3: `ptr` git_buf, a4: `ptr` git_filter_source): cint

  git_filter_stream_fn* = proc (a0: `ptr` git_writestream, a1: `ptr` git_filter, a2: pointer, a3: `ptr` git_filter_source, a4: `ptr` git_writestream): cint

  git_filter_cleanup_fn* = proc (a0: `ptr` git_filter, a1: pointer): void

  git_filter* {.importc, bycopy, incompleteStruct.} = object
    version    *: cuint
    attributes *: cstring
    initialize *: git_filter_init_fn
    shutdown   *: git_filter_shutdown_fn
    check      *: git_filter_check_fn
    apply      *: git_filter_apply_fn
    stream     *: git_filter_stream_fn
    cleanup    *: git_filter_cleanup_fn



proc git_filter_lookup*(name: cstring): `ptr` git_filter {.git2Proc, importc.}

proc git_filter_list_new*(`out`: `ptr` git_filter_list, repo: `ptr` git_repository, mode: git_filter_mode_t, options: uint32): cint {.git2Proc, importc.}

proc git_filter_list_push*(fl: `ptr` git_filter_list, filter: `ptr` git_filter, payload: pointer): cint {.git2Proc, importc.}

proc git_filter_list_length*(fl: `ptr` git_filter_list): csize_t {.git2Proc, importc.}

proc git_filter_source_repo*(src: `ptr` git_filter_source): `ptr` git_repository {.git2Proc, importc.}

proc git_filter_source_path*(src: `ptr` git_filter_source): cstring {.git2Proc, importc.}

proc git_filter_source_filemode*(src: `ptr` git_filter_source): uint16 {.git2Proc, importc.}

proc git_filter_source_id*(src: `ptr` git_filter_source): `ptr` git_oid {.git2Proc, importc.}

proc git_filter_source_mode*(src: `ptr` git_filter_source): git_filter_mode_t {.git2Proc, importc.}

proc git_filter_source_flags*(src: `ptr` git_filter_source): uint32 {.git2Proc, importc.}

proc git_filter_init*(filter: `ptr` git_filter, version: cuint): cint {.git2Proc, importc.}

proc git_filter_register*(name: cstring, filter: `ptr` git_filter, priority: cint): cint {.git2Proc, importc.}

proc git_filter_unregister*(name: cstring): cint {.git2Proc, importc.}