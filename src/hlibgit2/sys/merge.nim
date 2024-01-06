import "../libgit2_config.nim" ## From gen file
import "../index.nim"
import "../types.nim"
import "../merge.nim"
import "../buffer.nim"

type
  git_merge_driver* {.header: "<sys/merge.h>", importc, bycopy.} = object
    version    *: cuint
    initialize *: git_merge_driver_init_fn
    shutdown   *: git_merge_driver_shutdown_fn
    apply      *: git_merge_driver_apply_fn

  git_merge_driver_source* {.header: "<sys/merge.h>", importc, incompleteStruct.} = object


  git_merge_driver_init_fn* = proc (a0: ptr git_merge_driver): cint

  git_merge_driver_shutdown_fn* = proc (a0: ptr git_merge_driver): void

  git_merge_driver_apply_fn* = proc (a0: ptr git_merge_driver, a1: cstringArray, a2: ptr uint32, a3: ptr git_buf, a4: cstring, a5: ptr git_merge_driver_source): cint



proc git_merge_driver_unregister*(name: cstring): cint {.importc: "git_merge_driver_unregister", header: "<sys/merge.h>".}

proc git_merge_driver_lookup*(name: cstring): ptr git_merge_driver {.importc: "git_merge_driver_lookup", header: "<sys/merge.h>".}

proc git_merge_driver_source_repo*(src: ptr git_merge_driver_source): ptr git_repository {.importc: "git_merge_driver_source_repo", header: "<sys/merge.h>".}

proc git_merge_driver_source_ancestor*(src: ptr git_merge_driver_source): ptr git_index_entry {.importc: "git_merge_driver_source_ancestor", header: "<sys/merge.h>".}

proc git_merge_driver_source_ours*(src: ptr git_merge_driver_source): ptr git_index_entry {.importc: "git_merge_driver_source_ours", header: "<sys/merge.h>".}

proc git_merge_driver_source_theirs*(src: ptr git_merge_driver_source): ptr git_index_entry {.importc: "git_merge_driver_source_theirs", header: "<sys/merge.h>".}

proc git_merge_driver_source_file_options*(src: ptr git_merge_driver_source): ptr git_merge_file_options {.importc: "git_merge_driver_source_file_options", header: "<sys/merge.h>".}

proc git_merge_driver_register*(name: cstring, driver: ptr git_merge_driver): cint {.importc: "git_merge_driver_register", header: "<sys/merge.h>".}