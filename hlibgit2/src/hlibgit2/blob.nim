import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./buffer.nim"
import "./types.nim"

type
  git_blob_filter_options* {.bycopy.} = object
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
    GIT_BLOB_FILTER_CHECK_FOR_BINARY
    GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES
    GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD
    GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT



converter toCInt*(arg: c_git_blob_filter_flag_t): cint = cint(ord(arg))

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
): cint {.git2Proc, importc: "git_blob_lookup".}

proc git_blob_lookup_prefix*(
    blob: ptr ptr git_blob,
    repo: ptr git_repository,
    id: ptr git_oid,
    len: csize_t,
): cint {.git2Proc, importc: "git_blob_lookup_prefix".}

proc git_blob_free*(blob: ptr git_blob): void {.git2Proc, importc: "git_blob_free".}

proc git_blob_id*(blob: ptr git_blob): ptr git_oid {.git2Proc, importc: "git_blob_id".}

proc git_blob_owner*(blob: ptr git_blob): ptr git_repository {.git2Proc, importc: "git_blob_owner".}

proc git_blob_rawcontent*(blob: ptr git_blob): pointer {.git2Proc, importc: "git_blob_rawcontent".}

proc git_blob_rawsize*(blob: ptr git_blob): git_object_size_t {.git2Proc, importc: "git_blob_rawsize".}

proc git_blob_filter_options_init*(opts: ptr git_blob_filter_options, version: cuint): cint {.git2Proc, importc: "git_blob_filter_options_init".}

proc git_blob_filter*(
    `out`: ptr git_buf,
    blob: ptr git_blob,
    as_path: cstring,
    opts: ptr git_blob_filter_options,
): cint {.git2Proc, importc: "git_blob_filter".}

proc git_blob_create_from_workdir*(
    id: ptr git_oid,
    repo: ptr git_repository,
    relative_path: cstring,
): cint {.git2Proc, importc: "git_blob_create_from_workdir".}

proc git_blob_create_from_disk*(
    id: ptr git_oid,
    repo: ptr git_repository,
    path: cstring,
): cint {.git2Proc, importc: "git_blob_create_from_disk".}

proc git_blob_create_from_stream*(
    `out`: ptr ptr git_writestream,
    repo: ptr git_repository,
    hintpath: cstring,
): cint {.git2Proc, importc: "git_blob_create_from_stream".}

proc git_blob_create_from_stream_commit*(`out`: ptr git_oid, stream: ptr git_writestream): cint {.git2Proc, importc: "git_blob_create_from_stream_commit".}

proc git_blob_create_from_buffer*(
    id: ptr git_oid,
    repo: ptr git_repository,
    buffer: pointer,
    len: csize_t,
): cint {.git2Proc, importc: "git_blob_create_from_buffer".}

proc git_blob_is_binary*(blob: ptr git_blob): cint {.git2Proc, importc: "git_blob_is_binary".}

proc git_blob_data_is_binary*(data: cstring, len: csize_t): cint {.git2Proc, importc: "git_blob_data_is_binary".}

proc git_blob_dup*(`out`: ptr ptr git_blob, source: ptr git_blob): cint {.git2Proc, importc: "git_blob_dup".}