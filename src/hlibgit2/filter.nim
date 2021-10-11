{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./types

type
  git_filter* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_filter_flag_t* = enum
    GIT_FILTER_DEFAULT = 0
    GIT_FILTER_ALLOW_UNSAFE = 1 ## Don't error for `safecrlf` violations, allow them to continue. 
    GIT_FILTER_NO_SYSTEM_ATTRIBUTES = 2 ## Don't load `/etc/gitattributes` (or the system equivalent) 
    GIT_FILTER_ATTRIBUTES_FROM_HEAD = 4 ## Load attributes from `.gitattributes` in the root of HEAD 
   
  git_filter_list* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_filter_mode_t* = enum
    GIT_FILTER_TO_WORKTREE = 0
    GIT_FILTER_TO_ODB = 1
   

proc git_filter_list_load*(
    filters: ptr ptr git_filter_list,
    repo:    ptr git_repository,
    blob:    ptr git_blob,
    path:    cstring,
    mode:    git_filter_mode_t,
    flags:   uint32
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_filter_list_contains*(
    filters: ptr git_filter_list,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_filter_list_apply_to_data*(
    arg_out: ptr git_buf,
    filters: ptr git_filter_list,
    arg_in:  ptr git_buf
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_filter_list_apply_to_file*(
    arg_out: ptr git_buf,
    filters: ptr git_filter_list,
    repo:    ptr git_repository,
    path:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_filter_list_apply_to_blob*(
    arg_out: ptr git_buf,
    filters: ptr git_filter_list,
    blob:    ptr git_blob
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_filter_list_stream_data*(
    filters: ptr git_filter_list,
    data:    ptr git_buf,
    target:  ptr git_writestream
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_filter_list_stream_file*(
    filters: ptr git_filter_list,
    repo:    ptr git_repository,
    path:    cstring,
    target:  ptr git_writestream
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_filter_list_stream_blob*(
    filters: ptr git_filter_list,
    blob:    ptr git_blob,
    target:  ptr git_writestream
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_filter_list_free*(
    filters: ptr git_filter_list
  ): void {.dynlib: libgit2Dl, importc.}


