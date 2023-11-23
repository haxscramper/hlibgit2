import "../buffer.nim"
import "../index.nim"
import "../libgit2_config.nim"
import "../merge.nim"
import "../types.nim"

type
  git_merge_driver* {.importc, bycopy, incompleteStruct.} = object
    version    *: cuint
    initialize *: git_merge_driver_init_fn
    shutdown   *: git_merge_driver_shutdown_fn
    apply      *: git_merge_driver_apply_fn

  git_merge_driver_source* {.importc, bycopy, incompleteStruct.} = object


  git_merge_driver_init_fn* = proc (a0: `ptr` git_merge_driver): cint

  git_merge_driver_shutdown_fn* = proc (a0: `ptr` git_merge_driver): void

  git_merge_driver_apply_fn* = proc (a0: `ptr` git_merge_driver, a1: cstring, a2: `ptr` uint32, a3: `ptr` git_buf, a4: cstring, a5: `ptr` git_merge_driver_source): cint



proc git_merge_driver_lookup*(name: cstring): `ptr` git_merge_driver {.git2Proc, importc.}

proc git_merge_driver_source_repo*(src: `ptr` git_merge_driver_source): `ptr` git_repository {.git2Proc, importc.}

proc git_merge_driver_source_ancestor*(src: `ptr` git_merge_driver_source): `ptr` git_index_entry {.git2Proc, importc.}

proc git_merge_driver_source_ours*(src: `ptr` git_merge_driver_source): `ptr` git_index_entry {.git2Proc, importc.}

proc git_merge_driver_source_theirs*(src: `ptr` git_merge_driver_source): `ptr` git_index_entry {.git2Proc, importc.}

proc git_merge_driver_source_file_options*(src: `ptr` git_merge_driver_source): `ptr` git_merge_file_options {.git2Proc, importc.}

proc git_merge_driver_register*(name: cstring, driver: `ptr` git_merge_driver): cint {.git2Proc, importc.}

proc git_merge_driver_unregister*(name: cstring): cint {.git2Proc, importc.}