{.push warning[UnusedImport]:off.}

import
  ./indexer,
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_odb_stream_t* {.size: sizeof(cint).} = enum
    c_GIT_STREAM_RDONLY = 2
    c_GIT_STREAM_WRONLY = 4
    c_GIT_STREAM_RW     = 6

  git_odb_stream* {.bycopy, header: "<git2/odb_backend.h>", importc.} = object
    backend*:        ptr git_odb_backend
    mode*:           cuint
    hash_ctx*:       pointer
    declared_size*:  git_object_size_t
    received_bytes*: git_object_size_t
    read*:           proc(stream: ptr git_odb_stream,
                          buffer: cstring,
                          len:    csize_t): cint{.cdecl.}
    write*:          proc(stream: ptr git_odb_stream,
                          buffer: cstring,
                          len:    csize_t): cint{.cdecl.}
    finalize_write*: proc(stream: ptr git_odb_stream,
                          oid:    ptr git_oid): cint{.cdecl.}
    free*:           proc(stream: ptr git_odb_stream): void{.cdecl.}

  git_odb_stream_t* = enum
    GIT_STREAM_RDONLY
    GIT_STREAM_WRONLY
    GIT_STREAM_RW

  git_odb_writepack* {.bycopy, header: "<git2/odb_backend.h>", importc.} = object
    ## A stream to write a pack file to the ODB
    backend*: ptr git_odb_backend
    append*:  proc(writepack: ptr git_odb_writepack,
                   data:      pointer,
                   size:      csize_t,
                   stats:     ptr git_indexer_progress): cint{.cdecl.}
    commit*:  proc(writepack: ptr git_odb_writepack,
                   stats:     ptr git_indexer_progress): cint{.cdecl.}
    free*:    proc(writepack: ptr git_odb_writepack): void{.cdecl.}


proc git_odb_backend_pack*(
    arg_out:     ptr ptr git_odb_backend,
    objects_dir: cstring
  ): cint {.git2Proc, importc.}



proc git_odb_backend_loose*(
    arg_out:           ptr ptr git_odb_backend,
    objects_dir:       cstring,
    compression_level: cint,
    do_fsync:          cint,
    dir_mode:          cuint,
    file_mode:         cuint
  ): cint {.git2Proc, importc.}



proc git_odb_backend_one_pack*(
    arg_out:    ptr ptr git_odb_backend,
    index_file: cstring
  ): cint {.git2Proc, importc.}



proc to_c_git_odb_stream_t*(arg: git_odb_stream_t): c_git_odb_stream_t =
  case arg:
    of GIT_STREAM_RDONLY: c_GIT_STREAM_RDONLY
    of GIT_STREAM_WRONLY: c_GIT_STREAM_WRONLY
    of GIT_STREAM_RW:     c_GIT_STREAM_RW


converter to_git_odb_stream_t*(arg: c_git_odb_stream_t): git_odb_stream_t =
  case arg:
    of c_GIT_STREAM_RDONLY: GIT_STREAM_RDONLY
    of c_GIT_STREAM_WRONLY: GIT_STREAM_WRONLY
    of c_GIT_STREAM_RW:     GIT_STREAM_RW


converter toCint*(arg: c_git_odb_stream_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_odb_stream_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_odb_stream_t(arg)))

func `+`*(arg: c_git_odb_stream_t, offset: int): c_git_odb_stream_t =
  cast[c_git_odb_stream_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_odb_stream_t): c_git_odb_stream_t =
  cast[c_git_odb_stream_t](ord(arg) + offset)

func `-`*(arg: c_git_odb_stream_t, offset: int): c_git_odb_stream_t =
  cast[c_git_odb_stream_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_odb_stream_t): c_git_odb_stream_t =
  cast[c_git_odb_stream_t](ord(arg) - offset)


