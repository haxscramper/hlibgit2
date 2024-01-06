import "./libgit2_config.nim" ## From gen file
import "./indexer.nim"
import "./types.nim"
import "./oid.nim"

type
  git_odb_backend* {.header: "<sys/odb_backend.h>", importc, bycopy.} = object
    version       *: cuint
    odb           *: ptr git_odb
    read          *: proc (a0: ptr pointer, a1: ptr csize_t, a2: ptr git_object_t, a3: ptr git_odb_backend, a4: ptr git_oid): cint
    read_prefix   *: proc (a0: ptr git_oid, a1: ptr pointer, a2: ptr csize_t, a3: ptr git_object_t, a4: ptr git_odb_backend, a5: ptr git_oid, a6: csize_t): cint
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

  git_odb_stream* {.header: "<odb_backend.h>", importc, bycopy.} = object
    backend        *: ptr git_odb_backend
    mode           *: cuint
    hash_ctx       *: pointer
    declared_size  *: git_object_size_t
    received_bytes *: git_object_size_t
    read           *: proc (a0: ptr git_odb_stream, a1: ptr char, a2: csize_t): cint
    write          *: proc (a0: ptr git_odb_stream, a1: cstring, a2: csize_t): cint
    finalize_write *: proc (a0: ptr git_odb_stream, a1: ptr git_oid): cint
    free           *: proc (a0: ptr git_odb_stream): void

  git_odb_writepack* {.header: "<odb_backend.h>", importc, bycopy.} = object
    backend *: ptr git_odb_backend
    append  *: proc (a0: ptr git_odb_writepack, a1: pointer, a2: csize_t, a3: ptr git_indexer_progress): cint
    commit  *: proc (a0: ptr git_odb_writepack, a1: ptr git_indexer_progress): cint
    free    *: proc (a0: ptr git_odb_writepack): void

  git_odb_backend_pack_options* {.header: "<odb_backend.h>", importc, bycopy.} = object
    version  *: cuint
    oid_type *: git_oid_t

  git_odb_backend_loose_options* {.header: "<odb_backend.h>", importc, bycopy.} = object
    version           *: cuint
    flags             *: uint32
    compression_level *: cint
    dir_mode          *: cuint
    file_mode         *: cuint
    oid_type          *: git_oid_t

  c_git_odb_backend_loose_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_ODB_BACKEND_LOOSE_FSYNC = 1 shl 0

  git_odb_backend_loose_flag_t* = enum
    GIT_ODB_BACKEND_LOOSE_FSYNC = 0

  c_git_odb_stream_t* {.size: sizeof(cint).} = enum
    c_GIT_STREAM_RDONLY = 1 shl 1
    c_GIT_STREAM_WRONLY = 1 shl 2
    c_GIT_STREAM_RW     = 6

  git_odb_stream_t* = enum
    GIT_STREAM_RDONLY = 0
    GIT_STREAM_WRONLY = 1
    GIT_STREAM_RW     = 2

  git_odb_options* {.header: "<odb.h>", importc, bycopy.} = object
    version  *: cuint
    oid_type *: git_oid_t

  git_odb_expand_id* {.header: "<odb.h>", importc, bycopy.} = object
    id     *: git_oid
    length *: cushort
    `type` *: git_object_t

  c_git_odb_lookup_flags_t* {.size: sizeof(cint).} = enum
    c_GIT_ODB_LOOKUP_NO_REFRESH = 1 shl 0

  git_odb_lookup_flags_t* = enum
    GIT_ODB_LOOKUP_NO_REFRESH = 0

  git_odb_foreach_cb* = proc (a0: ptr git_oid, a1: pointer): cint



proc git_odb_get_backend*(
    `out`: ptr ptr git_odb_backend,
    odb: ptr git_odb,
    pos: csize_t,
): cint {.importc: "git_odb_get_backend", header: "<odb.h>".}

proc git_odb_set_commit_graph*(odb: ptr git_odb, cgraph: ptr git_commit_graph): cint {.importc: "git_odb_set_commit_graph", header: "<odb.h>".}

proc git_odb_init_backend*(backend: ptr git_odb_backend, version: cuint): cint {.importc: "git_odb_init_backend", header: "<sys/odb_backend.h>".}

proc git_odb_backend_data_alloc*(backend: ptr git_odb_backend, len: csize_t): pointer {.importc: "git_odb_backend_data_alloc", header: "<sys/odb_backend.h>".}

proc git_odb_backend_data_free*(backend: ptr git_odb_backend, data: pointer): void {.importc: "git_odb_backend_data_free", header: "<sys/odb_backend.h>".}

proc git_odb_backend_malloc*(backend: ptr git_odb_backend, len: csize_t): pointer {.importc: "git_odb_backend_malloc", header: "<sys/odb_backend.h>".}

converter to_git_odb_backend_loose_flag_t*(arg: c_git_odb_backend_loose_flag_t): git_odb_backend_loose_flag_t =
  case arg:
    of c_GIT_ODB_BACKEND_LOOSE_FSYNC: GIT_ODB_BACKEND_LOOSE_FSYNC

proc to_c_git_odb_backend_loose_flag_t*(arg: git_odb_backend_loose_flag_t): c_git_odb_backend_loose_flag_t =
  case arg:
    of GIT_ODB_BACKEND_LOOSE_FSYNC: c_GIT_ODB_BACKEND_LOOSE_FSYNC

converter toCInt*(arg: c_git_odb_backend_loose_flag_t): cint = cint(ord(arg))

converter toCInt*(arg: git_odb_backend_loose_flag_t): cint = cint(ord(to_c_git_odb_backend_loose_flag_t(arg)))

converter toCInt*(args: set[git_odb_backend_loose_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_ODB_BACKEND_LOOSE_FSYNC: result = cint(result or 1)

func `-`*(arg: c_git_odb_backend_loose_flag_t, offset: int): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_backend_loose_flag_t): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_odb_backend_loose_flag_t, offset: int): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_backend_loose_flag_t): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) + offset)

converter to_git_odb_stream_t*(arg: c_git_odb_stream_t): git_odb_stream_t =
  case arg:
    of c_GIT_STREAM_RDONLY: GIT_STREAM_RDONLY
    of c_GIT_STREAM_WRONLY: GIT_STREAM_WRONLY
    of c_GIT_STREAM_RW    : GIT_STREAM_RW

proc to_c_git_odb_stream_t*(arg: git_odb_stream_t): c_git_odb_stream_t =
  case arg:
    of GIT_STREAM_RDONLY: c_GIT_STREAM_RDONLY
    of GIT_STREAM_WRONLY: c_GIT_STREAM_WRONLY
    of GIT_STREAM_RW    : c_GIT_STREAM_RW

converter toCInt*(arg: c_git_odb_stream_t): cint = cint(ord(arg))

converter toCInt*(arg: git_odb_stream_t): cint = cint(ord(to_c_git_odb_stream_t(arg)))

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

proc git_odb_backend_pack*(`out`: ptr ptr git_odb_backend, objects_dir: cstring): cint {.importc: "git_odb_backend_pack", header: "<odb_backend.h>".}

proc git_odb_backend_one_pack*(`out`: ptr ptr git_odb_backend, index_file: cstring): cint {.importc: "git_odb_backend_one_pack", header: "<odb_backend.h>".}

proc git_odb_backend_loose*(
    `out`: ptr ptr git_odb_backend,
    objects_dir: cstring,
    compression_level: cint,
    do_fsync: cint,
    dir_mode: cuint,
    file_mode: cuint,
): cint {.importc: "git_odb_backend_loose", header: "<odb_backend.h>".}

converter to_git_odb_lookup_flags_t*(arg: c_git_odb_lookup_flags_t): git_odb_lookup_flags_t =
  case arg:
    of c_GIT_ODB_LOOKUP_NO_REFRESH: GIT_ODB_LOOKUP_NO_REFRESH

proc to_c_git_odb_lookup_flags_t*(arg: git_odb_lookup_flags_t): c_git_odb_lookup_flags_t =
  case arg:
    of GIT_ODB_LOOKUP_NO_REFRESH: c_GIT_ODB_LOOKUP_NO_REFRESH

converter toCInt*(arg: c_git_odb_lookup_flags_t): cint = cint(ord(arg))

converter toCInt*(arg: git_odb_lookup_flags_t): cint = cint(ord(to_c_git_odb_lookup_flags_t(arg)))

converter toCInt*(args: set[git_odb_lookup_flags_t]): cint =
  for value in items(args):
    case value:
      of GIT_ODB_LOOKUP_NO_REFRESH: result = cint(result or 1)

func `-`*(arg: c_git_odb_lookup_flags_t, offset: int): cint = cast[c_git_odb_lookup_flags_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_lookup_flags_t): cint = cast[c_git_odb_lookup_flags_t](ord(arg) - offset)

func `+`*(arg: c_git_odb_lookup_flags_t, offset: int): cint = cast[c_git_odb_lookup_flags_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_lookup_flags_t): cint = cast[c_git_odb_lookup_flags_t](ord(arg) + offset)

proc git_odb_new*(`out`: ptr ptr git_odb): cint {.importc: "git_odb_new", header: "<odb.h>".}

proc git_odb_open*(`out`: ptr ptr git_odb, objects_dir: cstring): cint {.importc: "git_odb_open", header: "<odb.h>".}

proc git_odb_add_disk_alternate*(odb: ptr git_odb, path: cstring): cint {.importc: "git_odb_add_disk_alternate", header: "<odb.h>".}

proc git_odb_free*(db: ptr git_odb): void {.importc: "git_odb_free", header: "<odb.h>".}

proc git_odb_read*(
    `out`: ptr ptr git_odb_object,
    db: ptr git_odb,
    id: ptr git_oid,
): cint {.importc: "git_odb_read", header: "<odb.h>".}

proc git_odb_read_prefix*(
    `out`: ptr ptr git_odb_object,
    db: ptr git_odb,
    short_id: ptr git_oid,
    len: csize_t,
): cint {.importc: "git_odb_read_prefix", header: "<odb.h>".}

proc git_odb_read_header*(
    len_out: ptr csize_t,
    type_out: ptr git_object_t,
    db: ptr git_odb,
    id: ptr git_oid,
): cint {.importc: "git_odb_read_header", header: "<odb.h>".}

proc git_odb_exists*(db: ptr git_odb, id: ptr git_oid): cint {.importc: "git_odb_exists", header: "<odb.h>".}

proc git_odb_exists_ext*(
    db: ptr git_odb,
    id: ptr git_oid,
    flags: cuint,
): cint {.importc: "git_odb_exists_ext", header: "<odb.h>".}

proc git_odb_exists_prefix*(
    `out`: ptr git_oid,
    db: ptr git_odb,
    short_id: ptr git_oid,
    len: csize_t,
): cint {.importc: "git_odb_exists_prefix", header: "<odb.h>".}

proc git_odb_expand_ids*(
    db: ptr git_odb,
    ids: ptr git_odb_expand_id,
    count: csize_t,
): cint {.importc: "git_odb_expand_ids", header: "<odb.h>".}

proc git_odb_refresh*(db: ptr git_odb): cint {.importc: "git_odb_refresh", header: "<odb.h>".}

proc git_odb_foreach*(
    db: ptr git_odb,
    cb: git_odb_foreach_cb,
    payload: pointer,
): cint {.importc: "git_odb_foreach", header: "<odb.h>".}

proc git_odb_write*(
    `out`: ptr git_oid,
    odb: ptr git_odb,
    data: pointer,
    len: csize_t,
    `type`: git_object_t,
): cint {.importc: "git_odb_write", header: "<odb.h>".}

proc git_odb_open_wstream*(
    `out`: ptr ptr git_odb_stream,
    db: ptr git_odb,
    size: git_object_size_t,
    `type`: git_object_t,
): cint {.importc: "git_odb_open_wstream", header: "<odb.h>".}

proc git_odb_stream_write*(
    stream: ptr git_odb_stream,
    buffer: cstring,
    len: csize_t,
): cint {.importc: "git_odb_stream_write", header: "<odb.h>".}

proc git_odb_stream_finalize_write*(`out`: ptr git_oid, stream: ptr git_odb_stream): cint {.importc: "git_odb_stream_finalize_write", header: "<odb.h>".}

proc git_odb_stream_read*(
    stream: ptr git_odb_stream,
    buffer: ptr char,
    len: csize_t,
): cint {.importc: "git_odb_stream_read", header: "<odb.h>".}

proc git_odb_stream_free*(stream: ptr git_odb_stream): void {.importc: "git_odb_stream_free", header: "<odb.h>".}

proc git_odb_open_rstream*(
    `out`: ptr ptr git_odb_stream,
    len: ptr csize_t,
    `type`: ptr git_object_t,
    db: ptr git_odb,
    oid: ptr git_oid,
): cint {.importc: "git_odb_open_rstream", header: "<odb.h>".}

proc git_odb_write_pack_fn*(
    `out`: ptr ptr git_odb_writepack,
    db: ptr git_odb,
    progress_cb: git_indexer_progress_cb,
    progress_payload: pointer,
): cint {.importc: "git_odb_write_pack", header: "<odb.h>".}

proc git_odb_write_multi_pack_index*(db: ptr git_odb): cint {.importc: "git_odb_write_multi_pack_index", header: "<odb.h>".}

proc git_odb_hash*(
    `out`: ptr git_oid,
    data: pointer,
    len: csize_t,
    `type`: git_object_t,
): cint {.importc: "git_odb_hash", header: "<odb.h>".}

proc git_odb_hashfile*(
    `out`: ptr git_oid,
    path: cstring,
    `type`: git_object_t,
): cint {.importc: "git_odb_hashfile", header: "<odb.h>".}

proc git_odb_object_dup*(dest: ptr ptr git_odb_object, source: ptr git_odb_object): cint {.importc: "git_odb_object_dup", header: "<odb.h>".}

proc git_odb_object_free*(`object`: ptr git_odb_object): void {.importc: "git_odb_object_free", header: "<odb.h>".}

proc git_odb_object_id*(`object`: ptr git_odb_object): ptr git_oid {.importc: "git_odb_object_id", header: "<odb.h>".}

proc git_odb_object_data*(`object`: ptr git_odb_object): pointer {.importc: "git_odb_object_data", header: "<odb.h>".}

proc git_odb_object_size*(`object`: ptr git_odb_object): csize_t {.importc: "git_odb_object_size", header: "<odb.h>".}

proc git_odb_object_type*(`object`: ptr git_odb_object): git_object_t {.importc: "git_odb_object_type", header: "<odb.h>".}

proc git_odb_add_backend*(
    odb: ptr git_odb,
    backend: ptr git_odb_backend,
    priority: cint,
): cint {.importc: "git_odb_add_backend", header: "<odb.h>".}

proc git_odb_add_alternate*(
    odb: ptr git_odb,
    backend: ptr git_odb_backend,
    priority: cint,
): cint {.importc: "git_odb_add_alternate", header: "<odb.h>".}

proc git_odb_num_backends*(odb: ptr git_odb): csize_t {.importc: "git_odb_num_backends", header: "<odb.h>".}