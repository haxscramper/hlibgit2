import "./libgit2_config.nim" ## From gen file
import "./odb.nim"
import "./indexer.nim"
import "./oid.nim"
import "./types.nim"

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

  git_odb_stream* {.importc, bycopy.} = object
    backend        *: `ptr` git_odb_backend
    mode           *: cuint
    hash_ctx       *: pointer
    declared_size  *: git_object_size_t
    received_bytes *: git_object_size_t
    read           *: proc (a0: `ptr` git_odb_stream, a1: `ptr` char, a2: csize_t): cint
    write          *: proc (a0: `ptr` git_odb_stream, a1: cstring, a2: csize_t): cint
    finalize_write *: proc (a0: `ptr` git_odb_stream, a1: `ptr` git_oid): cint
    free           *: proc (a0: `ptr` git_odb_stream): void

  git_odb_writepack* {.importc, bycopy.} = object
    backend *: `ptr` git_odb_backend
    append  *: proc (a0: `ptr` git_odb_writepack, a1: pointer, a2: csize_t, a3: `ptr` git_indexer_progress): cint
    commit  *: proc (a0: `ptr` git_odb_writepack, a1: `ptr` git_indexer_progress): cint
    free    *: proc (a0: `ptr` git_odb_writepack): void

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



proc git_odb_init_backend*(backend: `ptr` git_odb_backend, version: cuint): cint {.git2Proc, importc.}

proc git_odb_backend_data_alloc*(backend: `ptr` git_odb_backend, len: csize_t): pointer {.git2Proc, importc.}

proc git_odb_backend_data_free*(backend: `ptr` git_odb_backend, data: pointer): void {.git2Proc, importc.}

proc git_odb_backend_malloc*(backend: `ptr` git_odb_backend, len: csize_t): pointer {.git2Proc, importc.}

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

proc git_odb_backend_pack*(`out`: `ptr` git_odb_backend, objects_dir: cstring): cint {.git2Proc, importc.}

proc git_odb_backend_one_pack*(`out`: `ptr` git_odb_backend, index_file: cstring): cint {.git2Proc, importc.}

proc git_odb_backend_loose*(`out`: `ptr` git_odb_backend, objects_dir: cstring, compression_level: cint, do_fsync: cint, dir_mode: cuint, file_mode: cuint): cint {.git2Proc, importc.}