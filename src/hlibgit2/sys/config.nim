import "../libgit2_config.nim" ## From gen file
import "../types.nim"
import "../config.nim"

type
  git_config_backend* {.importc, bycopy, incompleteStruct.} = object
    version      *: cuint
    readonly     *: cint
    cfg          *: `ptr` git_config
    open         *: proc (a0: `ptr` git_config_backend, a1: git_config_level_t, a2: `ptr` git_repository): cint
    get          *: proc (a0: `ptr` git_config_backend, a1: cstring, a2: `ptr` git_config_entry): cint
    set          *: proc (a0: `ptr` git_config_backend, a1: cstring, a2: cstring): cint
    set_multivar *: proc (a0: `ptr` git_config_backend, a1: cstring, a2: cstring, a3: cstring): cint
    del          *: proc (a0: `ptr` git_config_backend, a1: cstring): cint
    del_multivar *: proc (a0: `ptr` git_config_backend, a1: cstring, a2: cstring): cint
    `iterator`   *: proc (a0: `ptr` git_config_iterator, a1: `ptr` git_config_backend): cint
    snapshot     *: proc (a0: `ptr` git_config_backend, a1: `ptr` git_config_backend): cint
    lock         *: proc (a0: `ptr` git_config_backend): cint
    unlock       *: proc (a0: `ptr` git_config_backend, a1: cint): cint
    free         *: proc (a0: `ptr` git_config_backend): void

  git_config_iterator* {.importc, bycopy, incompleteStruct.} = object
    backend *: `ptr` git_config_backend
    flags   *: cuint
    next    *: proc (a0: `ptr` git_config_entry, a1: `ptr` git_config_iterator): cint
    free    *: proc (a0: `ptr` git_config_iterator): void



proc git_config_init_backend*(backend: `ptr` git_config_backend, version: cuint): cint {.git2Proc, importc.}

proc git_config_add_backend*(cfg: `ptr` git_config, file: `ptr` git_config_backend, level: git_config_level_t, repo: `ptr` git_repository, force: cint): cint {.git2Proc, importc.}