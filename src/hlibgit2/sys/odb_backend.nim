proc git_odb_init_backend*(backend: ptr git_odb_backend, version: cuint): cint {.git2Proc, importc.}

proc git_odb_backend_data_alloc*(backend: ptr git_odb_backend, len: csize_t): ptr void {.git2Proc, importc.}

proc git_odb_backend_data_free*(backend: ptr git_odb_backend, data: ptr void): void {.git2Proc, importc.}

proc git_odb_backend_malloc*(backend: ptr git_odb_backend, len: csize_t): ptr void {.git2Proc, importc.}