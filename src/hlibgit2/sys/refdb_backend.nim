import "../../types.nim"
proc git_refdb_init_backend*(backend: ptr git_refdb_backend, version: cuint): cint {.git2Proc, importc.}

proc git_refdb_backend_fs*(backend_out: ptr git_refdb_backend, repo: ptr git_repository): cint {.git2Proc, importc.}

proc git_refdb_set_backend*(refdb: ptr git_refdb, backend: ptr git_refdb_backend): cint {.git2Proc, importc.}