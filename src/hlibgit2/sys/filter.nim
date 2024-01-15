import "../types.nim"
import "../filter.nim"
import "../oid.nim"
import "../buffer.nim"

type
  git_filter_source* {.incompleteStruct.} = object


  git_filter_init_fn* = proc (a0: ptr git_filter): cint

  git_filter_shutdown_fn* = proc (a0: ptr git_filter): void

  git_filter_check_fn* = proc (a0: ptr git_filter, a1: ptr pointer, a2: ptr git_filter_source, a3: cstringArray): cint

  git_filter_apply_fn* = proc (a0: ptr git_filter, a1: ptr pointer, a2: ptr git_buf, a3: ptr git_buf, a4: ptr git_filter_source): cint

  git_filter_stream_fn* = proc (a0: ptr ptr git_writestream, a1: ptr git_filter, a2: ptr pointer, a3: ptr git_filter_source, a4: ptr git_writestream): cint

  git_filter_cleanup_fn* = proc (a0: ptr git_filter, a1: pointer): void

  git_filter* {.bycopy.} = object
    version    *: cuint
    attributes *: cstring
    initialize *: git_filter_init_fn
    shutdown   *: git_filter_shutdown_fn
    check      *: git_filter_check_fn
    apply      *: git_filter_apply_fn
    stream     *: git_filter_stream_fn
    cleanup    *: git_filter_cleanup_fn



proc git_filter_lookup*(name: cstring): ptr git_filter {.importc: "git_filter_lookup".}

proc git_filter_list_new*(
    `out`: ptr ptr git_filter_list,
    repo: ptr git_repository,
    mode: git_filter_mode_t,
    options: uint32,
): cint {.importc: "git_filter_list_new".}

proc git_filter_list_push*(
    fl: ptr git_filter_list,
    filter: ptr git_filter,
    payload: pointer,
): cint {.importc: "git_filter_list_push".}

proc git_filter_list_length*(fl: ptr git_filter_list): csize_t {.importc: "git_filter_list_length".}

proc git_filter_source_repo*(src: ptr git_filter_source): ptr git_repository {.importc: "git_filter_source_repo".}

proc git_filter_source_path*(src: ptr git_filter_source): cstring {.importc: "git_filter_source_path".}

proc git_filter_source_filemode*(src: ptr git_filter_source): uint16 {.importc: "git_filter_source_filemode".}

proc git_filter_source_id*(src: ptr git_filter_source): ptr git_oid {.importc: "git_filter_source_id".}

proc git_filter_source_mode*(src: ptr git_filter_source): git_filter_mode_t {.importc: "git_filter_source_mode".}

proc git_filter_source_flags*(src: ptr git_filter_source): uint32 {.importc: "git_filter_source_flags".}

proc git_filter_init*(filter: ptr git_filter, version: cuint): cint {.importc: "git_filter_init".}

proc git_filter_register*(
    name: cstring,
    filter: ptr git_filter,
    priority: cint,
): cint {.importc: "git_filter_register".}

proc git_filter_unregister*(name: cstring): cint {.importc: "git_filter_unregister".}