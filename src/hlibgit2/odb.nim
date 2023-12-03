import "./libgit2_config.nim" ## From gen file
import "./indexer.nim"
import "./oid.nim"
import "./types.nim"

type
  git_odb_stream* {.importc, bycopy.} = object
    backend        *: ptr git_odb_backend
    mode           *: cuint
    hash_ctx       *: pointer
    declared_size  *: git_object_size_t
    received_bytes *: git_object_size_t
    read           *: proc (a0: ptr git_odb_stream, a1: ptr char, a2: csize_t): cint
    write          *: proc (a0: ptr git_odb_stream, a1: cstring, a2: csize_t): cint
    finalize_write *: proc (a0: ptr git_odb_stream, a1: ptr git_oid): cint
    free           *: proc (a0: ptr git_odb_stream): void

  git_odb_writepack* {.importc, bycopy.} = object
    backend *: ptr git_odb_backend
    append  *: proc (a0: ptr git_odb_writepack, a1: pointer, a2: csize_t, a3: ptr git_indexer_progress): cint
    commit  *: proc (a0: ptr git_odb_writepack, a1: ptr git_indexer_progress): cint
    free    *: proc (a0: ptr git_odb_writepack): void

  git_odb_backend* {.importc, bycopy, incompleteStruct.} = object
    version       *: cuint
    odb           *: ptr git_odb
    read          *: proc (a0: ptr ptr void, a1: ptr csize_t, a2: ptr git_object_t, a3: ptr git_odb_backend, a4: ptr git_oid): cint
    read_prefix   *: proc (a0: ptr git_oid, a1: ptr ptr void, a2: ptr csize_t, a3: ptr git_object_t, a4: ptr git_odb_backend, a5: ptr git_oid, a6: csize_t): cint
    read_header   *: proc (a0: ptr csize_t, a1: ptr git_object_t, a2: ptr git_odb_backend, a3: ptr git_oid): cint
    write         *: proc (a0: ptr git_odb_backend, a1: ptr git_oid, a2: pointer, a3: csize_t, a4: git_object_t): cint
    writestream   *: proc (a0: ptr ptr git_odb_stream, a1: ptr git_odb_backend, a2: git_object_size_t, a3: git_object_t): cint
    readstream    *: proc (a0: ptr ptr git_odb_stream, a1: ptr csize_t, a2: ptr git_object_t, a3: ptr git_odb_backend, a4: ptr git_oid): cint
    exists        *: proc (a0: ptr git_odb_backend, a1: ptr git_oid): cint
    exists_prefix *: proc (a0: ptr git_oid, a1: ptr git_odb_backend, a2: ptr git_oid, a3: csize_t): cint
    refresh       *: proc (a0: ptr git_odb_backend): cint
    foreach       *: proc (a0: ptr git_odb_backend, a1: git_odb_foreach_cb, a2: pointer): cint
    writepack     *: proc (a0: ptr ptr git_odb_writepack, a1: ptr git_odb_backend, a2: ptr git_odb, a3: git_indexer_progress_cb, a4: pointer): cint
    writemidx     *: proc (a0: ptr git_odb_backend): cint
    freshen       *: proc (a0: ptr git_odb_backend, a1: ptr git_oid): cint
    free          *: proc (a0: ptr git_odb_backend): void

  c_git_odb_backend_loose_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_ODB_BACKEND_LOOSE_FSYNC = 1 shl 0

  git_odb_backend_loose_flag_t* = enum
    GIT_ODB_BACKEND_LOOSE_FSYNC

  c_git_odb_stream_t* {.size: sizeof(cint).} = enum
    c_GIT_STREAM_RDONLY = 1 shl 1
    c_GIT_STREAM_WRONLY = 1 shl 2
    c_GIT_STREAM_RW     = 6

  git_odb_stream_t* = enum
    GIT_STREAM_RDONLY
    GIT_STREAM_WRONLY
    GIT_STREAM_RW

  git_odb_options* {.importc, bycopy.} = object
    version  *: cuint
    oid_type *: git_oid_t

  git_odb_expand_id* {.importc, bycopy.} = object
    id     *: git_oid
    length *: cushort
    `type` *: git_object_t

  c_git_odb_lookup_flags_t* {.size: sizeof(cint).} = enum
    c_GIT_ODB_LOOKUP_NO_REFRESH = 1 shl 0

  git_odb_lookup_flags_t* = enum
    GIT_ODB_LOOKUP_NO_REFRESH

  git_odb_foreach_cb* = proc (a0: ptr git_oid, a1: pointer): cint

  git_odb_backend_pack_options* {.importc, bycopy.} = object
    version  *: cuint
    oid_type *: git_oid_t

  git_odb_backend_loose_options* {.importc, bycopy.} = object
    version           *: cuint
    flags             *: uint32
    compression_level *: cint
    dir_mode          *: cuint
    file_mode         *: cuint
    oid_type          *: git_oid_t



proc git_odb_init_backend*(backend: ptr git_odb_backend, version: cuint): cint {.git2Proc, importc: "git_odb_init_backend".}

proc git_odb_backend_data_alloc*(backend: ptr git_odb_backend, len: csize_t): pointer {.git2Proc, importc: "git_odb_backend_data_alloc".}

proc git_odb_backend_data_free*(backend: ptr git_odb_backend, data: pointer): void {.git2Proc, importc: "git_odb_backend_data_free".}

proc git_odb_backend_malloc*(backend: ptr git_odb_backend, len: csize_t): pointer {.git2Proc, importc: "git_odb_backend_malloc".}

converter toCInt*(arg: c_git_odb_backend_loose_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_odb_backend_loose_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_ODB_BACKEND_LOOSE_FSYNC: result = cint(result or 1)

func `-`*(arg: c_git_odb_backend_loose_flag_t, offset: int): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_backend_loose_flag_t): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_odb_backend_loose_flag_t, offset: int): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_backend_loose_flag_t): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) + offset)

converter toCInt*(arg: c_git_odb_stream_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_odb_stream_t]): cint =
  for value in items(args):
    case value:
      of GIT_STREAM_RDONLY: result = cint(result or 2)
      of GIT_STREAM_WRONLY: result = cint(result or 4)
      of GIT_STREAM_RW    : result = cint(result or 6)

func `-`*(arg: c_git_odb_stream_t, offset: int): cint = cast[c_git_odb_stream_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_stream_t): cint = cast[c_git_odb_stream_t](ord(arg) - offset)

func `+`*(arg: c_git_odb_stream_t, offset: int): cint = cast[c_git_odb_stream_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_stream_t): cint = cast[c_git_odb_stream_t](ord(arg) + offset)

proc git_odb_backend_pack*(`out`: ptr ptr git_odb_backend, objects_dir: cstring): cint {.git2Proc, importc: "git_odb_backend_pack".}

proc git_odb_backend_one_pack*(`out`: ptr ptr git_odb_backend, index_file: cstring): cint {.git2Proc, importc: "git_odb_backend_one_pack".}

proc git_odb_backend_loose*(`out`: ptr ptr git_odb_backend, objects_dir: cstring, compression_level: cint, do_fsync: cint, dir_mode: cuint, file_mode: cuint): cint {.git2Proc, importc: "git_odb_backend_loose".}

converter toCInt*(arg: c_git_odb_lookup_flags_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_odb_lookup_flags_t]): cint =
  for value in items(args):
    case value:
      of GIT_ODB_LOOKUP_NO_REFRESH: result = cint(result or 1)

func `-`*(arg: c_git_odb_lookup_flags_t, offset: int): cint = cast[c_git_odb_lookup_flags_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_lookup_flags_t): cint = cast[c_git_odb_lookup_flags_t](ord(arg) - offset)

func `+`*(arg: c_git_odb_lookup_flags_t, offset: int): cint = cast[c_git_odb_lookup_flags_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_lookup_flags_t): cint = cast[c_git_odb_lookup_flags_t](ord(arg) + offset)

proc git_odb_new*(`out`: ptr ptr git_odb): cint {.git2Proc, importc: "git_odb_new".}

proc git_odb_open*(`out`: ptr ptr git_odb, objects_dir: cstring): cint {.git2Proc, importc: "git_odb_open".}

proc git_odb_add_disk_alternate*(odb: ptr git_odb, path: cstring): cint {.git2Proc, importc: "git_odb_add_disk_alternate".}

proc git_odb_free*(db: ptr git_odb): void {.git2Proc, importc: "git_odb_free".}

proc git_odb_read*(`out`: ptr ptr git_odb_object, db: ptr git_odb, id: ptr git_oid): cint {.git2Proc, importc: "git_odb_read".}

proc git_odb_read_prefix*(`out`: ptr ptr git_odb_object, db: ptr git_odb, short_id: ptr git_oid, len: csize_t): cint {.git2Proc, importc: "git_odb_read_prefix".}

proc git_odb_read_header*(len_out: ptr csize_t, type_out: ptr git_object_t, db: ptr git_odb, id: ptr git_oid): cint {.git2Proc, importc: "git_odb_read_header".}

proc git_odb_exists*(db: ptr git_odb, id: ptr git_oid): cint {.git2Proc, importc: "git_odb_exists".}

proc git_odb_exists_ext*(db: ptr git_odb, id: ptr git_oid, flags: cuint): cint {.git2Proc, importc: "git_odb_exists_ext".}

proc git_odb_exists_prefix*(`out`: ptr git_oid, db: ptr git_odb, short_id: ptr git_oid, len: csize_t): cint {.git2Proc, importc: "git_odb_exists_prefix".}

proc git_odb_expand_ids*(db: ptr git_odb, ids: ptr git_odb_expand_id, count: csize_t): cint {.git2Proc, importc: "git_odb_expand_ids".}

proc git_odb_refresh*(db: ptr git_odb): cint {.git2Proc, importc: "git_odb_refresh".}

proc git_odb_foreach*(db: ptr git_odb, cb: git_odb_foreach_cb, payload: pointer): cint {.git2Proc, importc: "git_odb_foreach".}

proc git_odb_write*(`out`: ptr git_oid, odb: ptr git_odb, data: pointer, len: csize_t, `type`: git_object_t): cint {.git2Proc, importc: "git_odb_write".}

proc git_odb_open_wstream*(`out`: ptr ptr git_odb_stream, db: ptr git_odb, size: git_object_size_t, `type`: git_object_t): cint {.git2Proc, importc: "git_odb_open_wstream".}

proc git_odb_stream_write*(stream: ptr git_odb_stream, buffer: cstring, len: csize_t): cint {.git2Proc, importc: "git_odb_stream_write".}

proc git_odb_stream_finalize_write*(`out`: ptr git_oid, stream: ptr git_odb_stream): cint {.git2Proc, importc: "git_odb_stream_finalize_write".}

proc git_odb_stream_read*(stream: ptr git_odb_stream, buffer: ptr char, len: csize_t): cint {.git2Proc, importc: "git_odb_stream_read".}

proc git_odb_stream_free*(stream: ptr git_odb_stream): void {.git2Proc, importc: "git_odb_stream_free".}

proc git_odb_open_rstream*(`out`: ptr ptr git_odb_stream, len: ptr csize_t, `type`: ptr git_object_t, db: ptr git_odb, oid: ptr git_oid): cint {.git2Proc, importc: "git_odb_open_rstream".}

proc git_odb_write_pack_fn*(`out`: ptr ptr git_odb_writepack, db: ptr git_odb, progress_cb: git_indexer_progress_cb, progress_payload: pointer): cint {.git2Proc, importc: "git_odb_write_pack".}

proc git_odb_write_multi_pack_index*(db: ptr git_odb): cint {.git2Proc, importc: "git_odb_write_multi_pack_index".}

proc git_odb_hash*(`out`: ptr git_oid, data: pointer, len: csize_t, `type`: git_object_t): cint {.git2Proc, importc: "git_odb_hash".}

proc git_odb_hashfile*(`out`: ptr git_oid, path: cstring, `type`: git_object_t): cint {.git2Proc, importc: "git_odb_hashfile".}

proc git_odb_object_dup*(dest: ptr ptr git_odb_object, source: ptr git_odb_object): cint {.git2Proc, importc: "git_odb_object_dup".}

proc git_odb_object_free*(`object`: ptr git_odb_object): void {.git2Proc, importc: "git_odb_object_free".}

proc git_odb_object_id*(`object`: ptr git_odb_object): ptr git_oid {.git2Proc, importc: "git_odb_object_id".}

proc git_odb_object_data*(`object`: ptr git_odb_object): pointer {.git2Proc, importc: "git_odb_object_data".}

proc git_odb_object_size*(`object`: ptr git_odb_object): csize_t {.git2Proc, importc: "git_odb_object_size".}

proc git_odb_object_type*(`object`: ptr git_odb_object): git_object_t {.git2Proc, importc: "git_odb_object_type".}

proc git_odb_add_backend*(odb: ptr git_odb, backend: ptr git_odb_backend, priority: cint): cint {.git2Proc, importc: "git_odb_add_backend".}

proc git_odb_add_alternate*(odb: ptr git_odb, backend: ptr git_odb_backend, priority: cint): cint {.git2Proc, importc: "git_odb_add_alternate".}

proc git_odb_num_backends*(odb: ptr git_odb): csize_t {.git2Proc, importc: "git_odb_num_backends".}

proc git_odb_get_backend*(`out`: ptr ptr git_odb_backend, odb: ptr git_odb, pos: csize_t): cint {.git2Proc, importc: "git_odb_get_backend".}

proc git_odb_set_commit_graph*(odb: ptr git_odb, cgraph: ptr git_commit_graph): cint {.git2Proc, importc: "git_odb_set_commit_graph".}