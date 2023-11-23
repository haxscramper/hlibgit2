import "../indexer.nim"
import "../libgit2_config.nim"
import "../odb.nim"
import "../odb_backend.nim"
import "../oid.nim"
import "../types.nim"

type
  git_odb_backend* {.importc, bycopy, incompleteStruct.} = object
    version       *: cuint
    odb           *: `ptr` git_odb
    read          *: proc (a0: pointer, a1: `ptr` csize_t, a2: `ptr` git_object_t, a3: `ptr` git_odb_backend, a4: `ptr` git_oid): cint
    read_prefix   *: proc (a0: `ptr` git_oid, a1: pointer, a2: `ptr` csize_t, a3: `ptr` git_object_t, a4: `ptr` git_odb_backend, a5: `ptr` git_oid, a6: csize_t): cint
    read_header   *: proc (a0: `ptr` csize_t, a1: `ptr` git_object_t, a2: `ptr` git_odb_backend, a3: `ptr` git_oid): cint
    write         *: proc (a0: `ptr` git_odb_backend, a1: `ptr` git_oid, a2: pointer, a3: csize_t, a4: git_object_t): cint
    writestream   *: proc (a0: `ptr` git_odb_stream, a1: `ptr` git_odb_backend, a2: git_object_size_t, a3: git_object_t): cint
    readstream    *: proc (a0: `ptr` git_odb_stream, a1: `ptr` csize_t, a2: `ptr` git_object_t, a3: `ptr` git_odb_backend, a4: `ptr` git_oid): cint
    exists        *: proc (a0: `ptr` git_odb_backend, a1: `ptr` git_oid): cint
    exists_prefix *: proc (a0: `ptr` git_oid, a1: `ptr` git_odb_backend, a2: `ptr` git_oid, a3: csize_t): cint
    refresh       *: proc (a0: `ptr` git_odb_backend): cint
    foreach       *: proc (a0: `ptr` git_odb_backend, a1: git_odb_foreach_cb, a2: pointer): cint
    writepack     *: proc (a0: `ptr` git_odb_writepack, a1: `ptr` git_odb_backend, a2: `ptr` git_odb, a3: git_indexer_progress_cb, a4: pointer): cint
    writemidx     *: proc (a0: `ptr` git_odb_backend): cint
    freshen       *: proc (a0: `ptr` git_odb_backend, a1: `ptr` git_oid): cint
    free          *: proc (a0: `ptr` git_odb_backend): void



proc git_odb_init_backend*(backend: `ptr` git_odb_backend, version: cuint): cint {.git2Proc, importc.}

proc git_odb_backend_data_alloc*(backend: `ptr` git_odb_backend, len: csize_t): pointer {.git2Proc, importc.}

proc git_odb_backend_data_free*(backend: `ptr` git_odb_backend, data: pointer): void {.git2Proc, importc.}

proc git_odb_backend_malloc*(backend: `ptr` git_odb_backend, len: csize_t): pointer {.git2Proc, importc.}