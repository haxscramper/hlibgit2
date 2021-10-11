{.push warning[UnusedImport]:off.}

import
  ./indexer,
  ./libgit2_config,
  ./oid,
  ./types

type
  git_odb_stream* {.bycopy, header: "<git2/odb_backend.h>", importc.} = object
    backend*: ptr git_odb_backend
    mode*: cuint
    hash_ctx*: pointer
    declared_size*: git_object_size_t
    received_bytes*: git_object_size_t
    read*: proc(stream: ptr git_odb_stream, buffer: cstring, len: csize_t): cint{.cdecl.}
    write*: proc(stream: ptr git_odb_stream, buffer: cstring, len: csize_t): cint{.cdecl.}
    finalize_write*: proc(stream: ptr git_odb_stream, oid: ptr git_oid): cint{.cdecl.}
    free*: proc(stream: ptr git_odb_stream): void{.cdecl.}
   
  git_odb_stream_t* = enum
    GIT_STREAM_RDONLY = 2
    GIT_STREAM_WRONLY = 4
    GIT_STREAM_RW = 6
   
  git_odb_writepack* {.bycopy, header: "<git2/odb_backend.h>", importc.} = object
    ## A stream to write a pack file to the ODB 
    backend*: ptr git_odb_backend
    append*: proc(writepack: ptr git_odb_writepack, data: pointer, size: csize_t, stats: ptr git_indexer_progress): cint{.cdecl.}
    commit*: proc(writepack: ptr git_odb_writepack, stats: ptr git_indexer_progress): cint{.cdecl.}
    free*: proc(writepack: ptr git_odb_writepack): void{.cdecl.}
   

proc git_odb_backend_pack*(
    arg_out:     ptr ptr git_odb_backend,
    objects_dir: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_odb_backend_loose*(
    arg_out:           ptr ptr git_odb_backend,
    objects_dir:       cstring,
    compression_level: cint,
    do_fsync:          cint,
    dir_mode:          cuint,
    file_mode:         cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_odb_backend_one_pack*(
    arg_out:    ptr ptr git_odb_backend,
    index_file: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


