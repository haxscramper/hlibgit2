import "../types.nim"
import "../oid.nim"

type
  git_reference_iterator* {.importc, bycopy.} = object
    db        *: ptr git_refdb
    next      *: proc (a0: ptr ptr git_reference, a1: ptr git_reference_iterator): cint
    next_name *: proc (a0: cstringArray, a1: ptr git_reference_iterator): cint
    free      *: proc (a0: ptr git_reference_iterator): void

  git_refdb_backend* {.importc, bycopy.} = object
    version       *: cuint
    exists        *: proc (a0: ptr cint, a1: ptr git_refdb_backend, a2: cstring): cint
    lookup        *: proc (a0: ptr ptr git_reference, a1: ptr git_refdb_backend, a2: cstring): cint
    `iterator`    *: proc (a0: ptr ptr git_reference_iterator, a1: ptr git_refdb_backend, a2: cstring): cint
    write         *: proc (a0: ptr git_refdb_backend, a1: ptr git_reference, a2: cint, a3: ptr git_signature, a4: cstring, a5: ptr git_oid, a6: cstring): cint
    rename        *: proc (a0: ptr ptr git_reference, a1: ptr git_refdb_backend, a2: cstring, a3: cstring, a4: cint, a5: ptr git_signature, a6: cstring): cint
    del           *: proc (a0: ptr git_refdb_backend, a1: cstring, a2: ptr git_oid, a3: cstring): cint
    compress      *: proc (a0: ptr git_refdb_backend): cint
    has_log       *: proc (a0: ptr git_refdb_backend, a1: cstring): cint
    ensure_log    *: proc (a0: ptr git_refdb_backend, a1: cstring): cint
    free          *: proc (a0: ptr git_refdb_backend): void
    reflog_read   *: proc (a0: ptr ptr git_reflog, a1: ptr git_refdb_backend, a2: cstring): cint
    reflog_write  *: proc (a0: ptr git_refdb_backend, a1: ptr git_reflog): cint
    reflog_rename *: proc (a0: ptr git_refdb_backend, a1: cstring, a2: cstring): cint
    reflog_delete *: proc (a0: ptr git_refdb_backend, a1: cstring): cint
    lock          *: proc (a0: ptr pointer, a1: ptr git_refdb_backend, a2: cstring): cint
    unlock        *: proc (a0: ptr git_refdb_backend, a1: pointer, a2: cint, a3: cint, a4: ptr git_reference, a5: ptr git_signature, a6: cstring): cint



proc git_refdb_init_backend*(backend: ptr git_refdb_backend, version: cuint): cint {.importc: "git_refdb_init_backend".}

proc git_refdb_backend_fs*(backend_out: ptr ptr git_refdb_backend, repo: ptr git_repository): cint {.importc: "git_refdb_backend_fs".}

proc git_refdb_set_backend*(refdb: ptr git_refdb, backend: ptr git_refdb_backend): cint {.importc: "git_refdb_set_backend".}