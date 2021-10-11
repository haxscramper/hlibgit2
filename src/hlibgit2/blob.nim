{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./oid,
  ./types

type
  git_blob_filter_flag_t* = enum
    GIT_BLOB_FILTER_CHECK_FOR_BINARY = 1 ## When set, filters will not be applied to binary files. 
    GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES = 2
    GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD = 4
   
  git_blob_filter_options* {.bycopy, header: "<git2/blob.h>", importc.} = object
    version*: cint
    flags*: uint32 ## Flags to control the filtering process, see `git_blob_filter_flag_t` above 
   

proc git_blob_lookup*(
    blob: ptr ptr git_blob,
    repo: ptr git_repository,
    id:   ptr git_oid
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_lookup_prefix*(
    blob: ptr ptr git_blob,
    repo: ptr git_repository,
    id:   ptr git_oid,
    len:  csize_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_free*(blob: ptr git_blob): void {.dynlib: libgit2Dl, importc.}


proc git_blob_id*(
    blob: ptr git_blob
  ): ptr git_oid {.dynlib: libgit2Dl, importc.}


proc git_blob_owner*(
    blob: ptr git_blob
  ): ptr git_repository {.dynlib: libgit2Dl, importc.}


proc git_blob_rawcontent*(
    blob: ptr git_blob
  ): pointer {.dynlib: libgit2Dl, importc.}


proc git_blob_rawsize*(
    blob: ptr git_blob
  ): git_object_size_t {.dynlib: libgit2Dl, importc.}


proc git_blob_filter_options_init*(
    opts:    ptr git_blob_filter_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_filter*(
    arg_out: ptr git_buf,
    blob:    ptr git_blob,
    as_path: cstring,
    opts:    ptr git_blob_filter_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_create_from_workdir*(
    id:            ptr git_oid,
    repo:          ptr git_repository,
    relative_path: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_create_from_disk*(
    id:   ptr git_oid,
    repo: ptr git_repository,
    path: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_create_from_stream*(
    arg_out:  ptr ptr git_writestream,
    repo:     ptr git_repository,
    hintpath: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_create_from_stream_commit*(
    arg_out: ptr git_oid,
    stream:  ptr git_writestream
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_create_from_buffer*(
    id:     ptr git_oid,
    repo:   ptr git_repository,
    buffer: pointer,
    len:    csize_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_is_binary*(
    blob: ptr git_blob
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blob_dup*(
    arg_out: ptr ptr git_blob,
    source:  ptr git_blob
  ): cint {.dynlib: libgit2Dl, importc.}


