import "./types.nim"
import "./oid.nim"
import "./buffer.nim"

type
  git_blob_filter_options* {.importc, bycopy.} = object
    version        *: cint
    flags          *: uint32
    commit_id      *: ptr git_oid
    attr_commit_id *: git_oid

  c_git_blob_filter_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_BLOB_FILTER_CHECK_FOR_BINARY       = 1 shl 0
    c_GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES   = 1 shl 1
    c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD   = 1 shl 2
    c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT = 1 shl 3

  git_blob_filter_flag_t* = enum
    GIT_BLOB_FILTER_CHECK_FOR_BINARY       = 0
    GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES   = 1
    GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD   = 2
    GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT = 3



converter to_git_blob_filter_flag_t*(arg: c_git_blob_filter_flag_t): git_blob_filter_flag_t =
  case arg:
    of c_GIT_BLOB_FILTER_CHECK_FOR_BINARY      : GIT_BLOB_FILTER_CHECK_FOR_BINARY
    of c_GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES  : GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES
    of c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD  : GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD
    of c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT: GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT

proc to_c_git_blob_filter_flag_t*(arg: git_blob_filter_flag_t): c_git_blob_filter_flag_t =
  case arg:
    of GIT_BLOB_FILTER_CHECK_FOR_BINARY      : c_GIT_BLOB_FILTER_CHECK_FOR_BINARY
    of GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES  : c_GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES
    of GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD  : c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD
    of GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT: c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT

converter toCInt*(arg: c_git_blob_filter_flag_t): cint = cint(ord(arg))

converter toCInt*(arg: git_blob_filter_flag_t): cint = cint(ord(to_c_git_blob_filter_flag_t(arg)))

converter toCInt*(args: set[git_blob_filter_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_BLOB_FILTER_CHECK_FOR_BINARY      : result = cint(result or 1)
      of GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES  : result = cint(result or 2)
      of GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD  : result = cint(result or 4)
      of GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT: result = cint(result or 8)

func `-`*(arg: c_git_blob_filter_flag_t, offset: int): cint = cast[c_git_blob_filter_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_blob_filter_flag_t): cint = cast[c_git_blob_filter_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_blob_filter_flag_t, offset: int): cint = cast[c_git_blob_filter_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_blob_filter_flag_t): cint = cast[c_git_blob_filter_flag_t](ord(arg) + offset)

proc git_blob_lookup*(
    blob: ptr ptr git_blob,
    repo: ptr git_repository,
    id: ptr git_oid,
): cint {.importc: "git_blob_lookup".}

proc git_blob_lookup_prefix*(
    blob: ptr ptr git_blob,
    repo: ptr git_repository,
    id: ptr git_oid,
    len: csize_t,
): cint {.importc: "git_blob_lookup_prefix".}

proc git_blob_free*(blob: ptr git_blob): void {.importc: "git_blob_free".}

proc git_blob_id*(blob: ptr git_blob): ptr git_oid {.importc: "git_blob_id".}

proc git_blob_owner*(blob: ptr git_blob): ptr git_repository {.importc: "git_blob_owner".}

proc git_blob_rawcontent*(blob: ptr git_blob): pointer {.importc: "git_blob_rawcontent".}

proc git_blob_rawsize*(blob: ptr git_blob): git_object_size_t {.importc: "git_blob_rawsize".}

proc git_blob_filter_options_init*(opts: ptr git_blob_filter_options, version: cuint): cint {.importc: "git_blob_filter_options_init".}

proc git_blob_filter*(
    `out`: ptr git_buf,
    blob: ptr git_blob,
    as_path: cstring,
    opts: ptr git_blob_filter_options,
): cint {.importc: "git_blob_filter".}

proc git_blob_create_from_workdir*(
    id: ptr git_oid,
    repo: ptr git_repository,
    relative_path: cstring,
): cint {.importc: "git_blob_create_from_workdir".}

proc git_blob_create_from_disk*(
    id: ptr git_oid,
    repo: ptr git_repository,
    path: cstring,
): cint {.importc: "git_blob_create_from_disk".}

proc git_blob_create_from_stream*(
    `out`: ptr ptr git_writestream,
    repo: ptr git_repository,
    hintpath: cstring,
): cint {.importc: "git_blob_create_from_stream".}

proc git_blob_create_from_stream_commit*(`out`: ptr git_oid, stream: ptr git_writestream): cint {.importc: "git_blob_create_from_stream_commit".}

proc git_blob_create_from_buffer*(
    id: ptr git_oid,
    repo: ptr git_repository,
    buffer: pointer,
    len: csize_t,
): cint {.importc: "git_blob_create_from_buffer".}

proc git_blob_is_binary*(blob: ptr git_blob): cint {.importc: "git_blob_is_binary".}

proc git_blob_data_is_binary*(data: cstring, len: csize_t): cint {.importc: "git_blob_data_is_binary".}

proc git_blob_dup*(`out`: ptr ptr git_blob, source: ptr git_blob): cint {.importc: "git_blob_dup".}