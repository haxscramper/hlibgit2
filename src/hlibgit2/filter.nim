{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./types

type
  c_git_filter_flag_t* = enum
    c_GIT_FILTER_DEFAULT              = 0                                                                   
    c_GIT_FILTER_ALLOW_UNSAFE         = 1 ## Don't error for `safecrlf` violations, allow them to continue. 
    c_GIT_FILTER_NO_SYSTEM_ATTRIBUTES = 2 ## Don't load `/etc/gitattributes` (or the system equivalent)     
    c_GIT_FILTER_ATTRIBUTES_FROM_HEAD = 4 ## Load attributes from `.gitattributes` in the root of HEAD      
   
  c_git_filter_mode_t* = enum
    c_GIT_FILTER_TO_WORKTREE = 0
    c_GIT_FILTER_TO_ODB      = 1
   
  git_filter* {.bycopy, incompleteStruct, header: "<git2/filter.h>", importc.} = object
    
   
  git_filter_flag_t* = enum
    GIT_FILTER_DEFAULT                                                                                
    GIT_FILTER_ALLOW_UNSAFE         ## Don't error for `safecrlf` violations, allow them to continue. 
    GIT_FILTER_NO_SYSTEM_ATTRIBUTES ## Don't load `/etc/gitattributes` (or the system equivalent)     
    GIT_FILTER_ATTRIBUTES_FROM_HEAD ## Load attributes from `.gitattributes` in the root of HEAD      
   
  git_filter_list* {.bycopy, incompleteStruct, header: "<git2/filter.h>", importc.} = object
    
   
  git_filter_mode_t* = enum
    GIT_FILTER_TO_WORKTREE
    GIT_FILTER_TO_ODB     
   

proc to_c_git_filter_mode_t*(arg: git_filter_mode_t): c_git_filter_mode_t = 
  case arg:
    of GIT_FILTER_TO_WORKTREE:
      c_GIT_FILTER_TO_WORKTREE
    of GIT_FILTER_TO_ODB:
      c_GIT_FILTER_TO_ODB
 

converter to_git_filter_mode_t*(arg: c_git_filter_mode_t): git_filter_mode_t = 
  case arg:
    of c_GIT_FILTER_TO_WORKTREE:
      GIT_FILTER_TO_WORKTREE
    of c_GIT_FILTER_TO_ODB:
      GIT_FILTER_TO_ODB
 

converter toCint*(arg: c_git_filter_mode_t): cint = 
  cint(ord(arg))
 
func `+`*(arg: c_git_filter_mode_t, offset: int): c_git_filter_mode_t = 
  c_git_filter_mode_t(ord(arg) + offset)
 
func `+`*(offset: int, arg: c_git_filter_mode_t): c_git_filter_mode_t = 
  c_git_filter_mode_t(ord(arg) + offset)
 
func `-`*(arg: c_git_filter_mode_t, offset: int): c_git_filter_mode_t = 
  c_git_filter_mode_t(ord(arg) - offset)
 
func `-`*(offset: int, arg: c_git_filter_mode_t): c_git_filter_mode_t = 
  c_git_filter_mode_t(ord(arg) - offset)
 

proc to_c_git_filter_flag_t*(arg: git_filter_flag_t): c_git_filter_flag_t = 
  case arg:
    of GIT_FILTER_DEFAULT:
      c_GIT_FILTER_DEFAULT
    of GIT_FILTER_ALLOW_UNSAFE:
      c_GIT_FILTER_ALLOW_UNSAFE
    of GIT_FILTER_NO_SYSTEM_ATTRIBUTES:
      c_GIT_FILTER_NO_SYSTEM_ATTRIBUTES
    of GIT_FILTER_ATTRIBUTES_FROM_HEAD:
      c_GIT_FILTER_ATTRIBUTES_FROM_HEAD
 

converter to_git_filter_flag_t*(arg: c_git_filter_flag_t): git_filter_flag_t = 
  case arg:
    of c_GIT_FILTER_DEFAULT:
      GIT_FILTER_DEFAULT
    of c_GIT_FILTER_ALLOW_UNSAFE:
      GIT_FILTER_ALLOW_UNSAFE
    of c_GIT_FILTER_NO_SYSTEM_ATTRIBUTES:
      GIT_FILTER_NO_SYSTEM_ATTRIBUTES
    of c_GIT_FILTER_ATTRIBUTES_FROM_HEAD:
      GIT_FILTER_ATTRIBUTES_FROM_HEAD
 

converter toCint*(arg: c_git_filter_flag_t): cint = 
  cint(ord(arg))
 
func `+`*(arg: c_git_filter_flag_t, offset: int): c_git_filter_flag_t = 
  c_git_filter_flag_t(ord(arg) + offset)
 
func `+`*(offset: int, arg: c_git_filter_flag_t): c_git_filter_flag_t = 
  c_git_filter_flag_t(ord(arg) + offset)
 
func `-`*(arg: c_git_filter_flag_t, offset: int): c_git_filter_flag_t = 
  c_git_filter_flag_t(ord(arg) - offset)
 
func `-`*(offset: int, arg: c_git_filter_flag_t): c_git_filter_flag_t = 
  c_git_filter_flag_t(ord(arg) - offset)
 

proc git_filter_list_load*(
    filters: ptr ptr git_filter_list,
    repo:    ptr git_repository,
    blob:    ptr git_blob,
    path:    cstring,
    mode:    c_git_filter_mode_t,
    flags:   uint32
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_contains*(
    filters: ptr git_filter_list,
    name:    cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_apply_to_data*(
    arg_out: ptr git_buf,
    filters: ptr git_filter_list,
    arg_in:  ptr git_buf
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_apply_to_file*(
    arg_out: ptr git_buf,
    filters: ptr git_filter_list,
    repo:    ptr git_repository,
    path:    cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_apply_to_blob*(
    arg_out: ptr git_buf,
    filters: ptr git_filter_list,
    blob:    ptr git_blob
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_stream_data*(
    filters: ptr git_filter_list,
    data:    ptr git_buf,
    target:  ptr git_writestream
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_stream_file*(
    filters: ptr git_filter_list,
    repo:    ptr git_repository,
    path:    cstring,
    target:  ptr git_writestream
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_stream_blob*(
    filters: ptr git_filter_list,
    blob:    ptr git_blob,
    target:  ptr git_writestream
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_free*(
    filters: ptr git_filter_list
  ): void {.git2Proc, importc.}
  
 

