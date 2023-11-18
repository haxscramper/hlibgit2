import "../oid.nim"
import "../types.nim"

type
  c_git_odb_stream_t {.size: sizeof(cint).} = enum
    c_GIT_STREAM_RDONLY = 1 shl 1
    c_GIT_STREAM_WRONLY = 1 shl 2
    c_GIT_STREAM_RW     = 6

  git_odb_stream_t = enum
    GIT_STREAM_RDONLY
    GIT_STREAM_WRONLY
    GIT_STREAM_RW

  git_odb_stream* {.importc, bycopy.} = object
    backend        *: ptr git_odb_backend
    mode           *: cuint
    hash_ctx       *: ptr void
    declared_size  *: git_object_size_t
    received_bytes *: git_object_size_t
    read           *: proc (a0: ptr git_odb_stream, a1: ptr char, a2: csize_t): cint
    write          *: proc (a0: ptr git_odb_stream, a1: cstring, a2: csize_t): cint
    finalize_write *: proc (a0: ptr git_odb_stream, a1: ptr git_oid): cint
    free           *: proc (a0: ptr git_odb_stream): void

  git_odb_writepack* {.importc, bycopy.} = object
    backend *: ptr git_odb_backend
    append  *: proc (a0: ptr git_odb_writepack, a1: ptr const void, a2: csize_t, a3: ptr git_indexer_progress): cint
    commit  *: proc (a0: ptr git_odb_writepack, a1: ptr git_indexer_progress): cint
    free    *: proc (a0: ptr git_odb_writepack): void

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

  c_git_odb_backend_loose_flag_t {.size: sizeof(cint).} = enum
    c_GIT_ODB_BACKEND_LOOSE_FSYNC = 1 shl 0

  git_odb_backend_loose_flag_t = enum
    GIT_ODB_BACKEND_LOOSE_FSYNC



converter toCInt*(arg: c_git_odb_stream_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_odb_stream_t)): cint =
  for value in items(args):
    case value:
      of GIT_STREAM_RDONLY: result = cint(result or 2)
      of GIT_STREAM_WRONLY: result = cint(result or 4)
      of GIT_STREAM_RW    : result = cint(result or 6)

func `-`*(arg: c_git_odb_stream_t, offset: int): cint = cast[c_git_odb_stream_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_stream_t): cint = cast[c_git_odb_stream_t](ord(arg) - offset)

func `+`*(arg: c_git_odb_stream_t, offset: int): cint = cast[c_git_odb_stream_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_stream_t): cint = cast[c_git_odb_stream_t](ord(arg) + offset)

proc git_odb_backend_pack*(out: ptr git_odb_backend, objects_dir: cstring): cint {.git2Proc, importc.}

proc git_odb_backend_one_pack*(out: ptr git_odb_backend, index_file: cstring): cint {.git2Proc, importc.}

proc git_odb_backend_loose*(out: ptr git_odb_backend, objects_dir: cstring, compression_level: cint, do_fsync: cint, dir_mode: cuint, file_mode: cuint): cint {.git2Proc, importc.}

converter toCInt*(arg: c_git_odb_backend_loose_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_odb_backend_loose_flag_t)): cint =
  for value in items(args):
    case value:
      of GIT_ODB_BACKEND_LOOSE_FSYNC: result = cint(result or 1)

func `-`*(arg: c_git_odb_backend_loose_flag_t, offset: int): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_backend_loose_flag_t): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_odb_backend_loose_flag_t, offset: int): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_backend_loose_flag_t): cint = cast[c_git_odb_backend_loose_flag_t](ord(arg) + offset)