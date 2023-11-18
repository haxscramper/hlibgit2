import "../indexer.nim"
import "../odb_backend.nim"
import "../oid.nim"
import "../types.nim"

type
  git_odb_options* {.importc, bycopy.} = object
    version  *: cuint
    oid_type *: git_oid_t

  git_odb_expand_id* {.importc, bycopy.} = object
    id     *: git_oid
    length *: cushort
    type   *: git_object_t

  c_git_odb_lookup_flags_t {.size: sizeof(cint).} = enum
    c_GIT_ODB_LOOKUP_NO_REFRESH = 1 shl 0

  git_odb_lookup_flags_t = enum
    GIT_ODB_LOOKUP_NO_REFRESH

  git_odb_foreach_cb = proc (a0: ptr git_oid, a1: ptr void): cint



converter toCInt*(arg: c_git_odb_lookup_flags_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_odb_lookup_flags_t)): cint =
  for value in items(args):
    case value:
      of GIT_ODB_LOOKUP_NO_REFRESH: result = cint(result or 1)

func `-`*(arg: c_git_odb_lookup_flags_t, offset: int): cint = cast[c_git_odb_lookup_flags_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_lookup_flags_t): cint = cast[c_git_odb_lookup_flags_t](ord(arg) - offset)

func `+`*(arg: c_git_odb_lookup_flags_t, offset: int): cint = cast[c_git_odb_lookup_flags_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_lookup_flags_t): cint = cast[c_git_odb_lookup_flags_t](ord(arg) + offset)

proc git_odb_new*(out: ptr git_odb): cint {.git2Proc, importc.}

proc git_odb_open*(out: ptr git_odb, objects_dir: cstring): cint {.git2Proc, importc.}

proc git_odb_add_disk_alternate*(odb: ptr git_odb, path: cstring): cint {.git2Proc, importc.}

proc git_odb_free*(db: ptr git_odb): void {.git2Proc, importc.}

proc git_odb_read*(out: ptr git_odb_object, db: ptr git_odb, id: ptr git_oid): cint {.git2Proc, importc.}

proc git_odb_read_prefix*(out: ptr git_odb_object, db: ptr git_odb, short_id: ptr git_oid, len: csize_t): cint {.git2Proc, importc.}

proc git_odb_read_header*(len_out: ptr csize_t, type_out: ptr git_object_t, db: ptr git_odb, id: ptr git_oid): cint {.git2Proc, importc.}

proc git_odb_exists*(db: ptr git_odb, id: ptr git_oid): cint {.git2Proc, importc.}

proc git_odb_exists_ext*(db: ptr git_odb, id: ptr git_oid, flags: cuint): cint {.git2Proc, importc.}

proc git_odb_exists_prefix*(out: ptr git_oid, db: ptr git_odb, short_id: ptr git_oid, len: csize_t): cint {.git2Proc, importc.}

proc git_odb_expand_ids*(db: ptr git_odb, ids: ptr git_odb_expand_id, count: csize_t): cint {.git2Proc, importc.}

proc git_odb_refresh*(db: ptr git_odb): cint {.git2Proc, importc.}

proc git_odb_foreach*(db: ptr git_odb, cb: git_odb_foreach_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_odb_write*(out: ptr git_oid, odb: ptr git_odb, data: ptr const void, len: csize_t, type: git_object_t): cint {.git2Proc, importc.}

proc git_odb_open_wstream*(out: ptr git_odb_stream, db: ptr git_odb, size: git_object_size_t, type: git_object_t): cint {.git2Proc, importc.}

proc git_odb_stream_write*(stream: ptr git_odb_stream, buffer: cstring, len: csize_t): cint {.git2Proc, importc.}

proc git_odb_stream_finalize_write*(out: ptr git_oid, stream: ptr git_odb_stream): cint {.git2Proc, importc.}

proc git_odb_stream_read*(stream: ptr git_odb_stream, buffer: ptr char, len: csize_t): cint {.git2Proc, importc.}

proc git_odb_stream_free*(stream: ptr git_odb_stream): void {.git2Proc, importc.}

proc git_odb_open_rstream*(out: ptr git_odb_stream, len: ptr csize_t, type: ptr git_object_t, db: ptr git_odb, oid: ptr git_oid): cint {.git2Proc, importc.}

proc git_odb_write_pack*(out: ptr git_odb_writepack, db: ptr git_odb, progress_cb: git_indexer_progress_cb, progress_payload: ptr void): cint {.git2Proc, importc.}

proc git_odb_write_multi_pack_index*(db: ptr git_odb): cint {.git2Proc, importc.}

proc git_odb_hash*(out: ptr git_oid, data: ptr const void, len: csize_t, type: git_object_t): cint {.git2Proc, importc.}

proc git_odb_hashfile*(out: ptr git_oid, path: cstring, type: git_object_t): cint {.git2Proc, importc.}

proc git_odb_object_dup*(dest: ptr git_odb_object, source: ptr git_odb_object): cint {.git2Proc, importc.}

proc git_odb_object_free*(object: ptr git_odb_object): void {.git2Proc, importc.}

proc git_odb_object_id*(object: ptr git_odb_object): ptr git_oid {.git2Proc, importc.}

proc git_odb_object_data*(object: ptr git_odb_object): ptr const void {.git2Proc, importc.}

proc git_odb_object_size*(object: ptr git_odb_object): csize_t {.git2Proc, importc.}

proc git_odb_object_type*(object: ptr git_odb_object): git_object_t {.git2Proc, importc.}

proc git_odb_add_backend*(odb: ptr git_odb, backend: ptr git_odb_backend, priority: cint): cint {.git2Proc, importc.}

proc git_odb_add_alternate*(odb: ptr git_odb, backend: ptr git_odb_backend, priority: cint): cint {.git2Proc, importc.}

proc git_odb_num_backends*(odb: ptr git_odb): csize_t {.git2Proc, importc.}

proc git_odb_get_backend*(out: ptr git_odb_backend, odb: ptr git_odb, pos: csize_t): cint {.git2Proc, importc.}

proc git_odb_set_commit_graph*(odb: ptr git_odb, cgraph: ptr git_commit_graph): cint {.git2Proc, importc.}