{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_blob_filter_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_BLOB_FILTER_CHECK_FOR_BINARY       = 1 shl 0 ## When set, filters will not be applied to binary files.
    c_GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES   = 1 shl 1
    c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD   = 1 shl 2
    c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT = 1 shl 3

  git_blob_filter_flag_t* {.size: sizeof(cint).} = enum
    GIT_BLOB_FILTER_CHECK_FOR_BINARY       ## When set, filters will not be applied to binary files.
    GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES
    GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD
    GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT

  git_blob_filter_options* {.bycopy, header: "<git2/blob.h>", importc.} = object
    version*:   cint
    flags*:     uint32      ## Flags to control the filtering process, see `git_blob_filter_flag_t` above
    commit_id*: ptr git_oid


proc git_blob_lookup*(
    blob: ptr ptr git_blob,
    repo: ptr git_repository,
    id:   ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_blob_lookup_prefix*(
    blob: ptr ptr git_blob,
    repo: ptr git_repository,
    id:   ptr git_oid,
    len:  csize_t
  ): cint {.git2Proc, importc.}



proc git_blob_free*(blob: ptr git_blob): void {.git2Proc, importc.}



proc git_blob_id*(blob: ptr git_blob): ptr git_oid {.git2Proc, importc.}



proc git_blob_owner*(
    blob: ptr git_blob
  ): ptr git_repository {.git2Proc, importc.}



proc git_blob_rawcontent*(blob: ptr git_blob): pointer {.git2Proc, importc.}



proc git_blob_rawsize*(
    blob: ptr git_blob
  ): git_object_size_t {.git2Proc, importc.}



proc to_c_git_blob_filter_flag_t*(
    arg: git_blob_filter_flag_t
  ): c_git_blob_filter_flag_t =
  case arg:
    of GIT_BLOB_FILTER_CHECK_FOR_BINARY:       c_GIT_BLOB_FILTER_CHECK_FOR_BINARY
    of GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES:   c_GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES
    of GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD:   c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD
    of GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT: c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT


converter to_git_blob_filter_flag_t*(
    arg: c_git_blob_filter_flag_t
  ): git_blob_filter_flag_t =
  case arg:
    of c_GIT_BLOB_FILTER_CHECK_FOR_BINARY:       GIT_BLOB_FILTER_CHECK_FOR_BINARY
    of c_GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES:   GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES
    of c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD:   GIT_BLOB_FILTER_ATTRIBUTES_FROM_HEAD
    of c_GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT: GIT_BLOB_FILTER_ATTRIBUTES_FROM_COMMIT


converter toCint*(arg: c_git_blob_filter_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_blob_filter_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_blob_filter_flag_t(arg)))

func `+`*(
    arg:    c_git_blob_filter_flag_t,
    offset: int
  ): c_git_blob_filter_flag_t =
  cast[c_git_blob_filter_flag_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_blob_filter_flag_t
  ): c_git_blob_filter_flag_t =
  cast[c_git_blob_filter_flag_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_blob_filter_flag_t,
    offset: int
  ): c_git_blob_filter_flag_t =
  cast[c_git_blob_filter_flag_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_blob_filter_flag_t
  ): c_git_blob_filter_flag_t =
  cast[c_git_blob_filter_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_blob_filter_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc git_blob_filter_options_init*(
    opts:    ptr git_blob_filter_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_blob_filter*(
    arg_out: ptr git_buf,
    blob:    ptr git_blob,
    as_path: cstring,
    opts:    ptr git_blob_filter_options
  ): cint {.git2Proc, importc.}



proc git_blob_create_from_workdir*(
    id:            ptr git_oid,
    repo:          ptr git_repository,
    relative_path: cstring
  ): cint {.git2Proc, importc.}



proc git_blob_create_from_disk*(
    id:   ptr git_oid,
    repo: ptr git_repository,
    path: cstring
  ): cint {.git2Proc, importc.}



proc git_blob_create_from_stream*(
    arg_out:  ptr ptr git_writestream,
    repo:     ptr git_repository,
    hintpath: cstring
  ): cint {.git2Proc, importc.}



proc git_blob_create_from_stream_commit*(
    arg_out: ptr git_oid,
    stream:  ptr git_writestream
  ): cint {.git2Proc, importc.}



proc git_blob_create_from_buffer*(
    id:     ptr git_oid,
    repo:   ptr git_repository,
    buffer: pointer,
    len:    csize_t
  ): cint {.git2Proc, importc.}



proc git_blob_is_binary*(blob: ptr git_blob): cint {.git2Proc, importc.}



proc git_blob_dup*(
    arg_out: ptr ptr git_blob,
    source:  ptr git_blob
  ): cint {.git2Proc, importc.}



