{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./types

type
  c_git_revparse_mode_t* = enum
    c_GIT_REVPARSE_SINGLE     = 1 ## The spec targeted a single object.                                 
    c_GIT_REVPARSE_RANGE      = 2 ## The spec targeted a range of commits.                              
    c_GIT_REVPARSE_MERGE_BASE = 4 ## The spec used the '...' operator, which invokes special semantics. 
   
  git_revparse_mode_t* = enum
    GIT_REVPARSE_SINGLE     ## The spec targeted a single object.                                 
    GIT_REVPARSE_RANGE      ## The spec targeted a range of commits.                              
    GIT_REVPARSE_MERGE_BASE ## The spec used the '...' operator, which invokes special semantics. 
   
  git_revspec* {.bycopy, header: "<git2/revparse.h>", importc.} = object
    from_f* {.importc: "from".}: ptr git_object ## The left element of the revspec; must be freed by the user   
    to*:                         ptr git_object ## The right element of the revspec; must be freed by the user  
    flags*:                      cuint          ## The intent of the revspec (i.e. `git_revparse_mode_t` flags) 
   

proc git_revparse_single*(
    arg_out: ptr ptr git_object,
    repo:    ptr git_repository,
    spec:    cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_revparse_ext*(
    object_out:    ptr ptr git_object,
    reference_out: ptr ptr git_reference,
    repo:          ptr git_repository,
    spec:          cstring
  ): cint {.git2Proc, importc.}
  
 

proc to_c_git_revparse_mode_t*(
    arg: git_revparse_mode_t
  ): c_git_revparse_mode_t = 
  case arg:
    of GIT_REVPARSE_SINGLE:
      c_GIT_REVPARSE_SINGLE
    of GIT_REVPARSE_RANGE:
      c_GIT_REVPARSE_RANGE
    of GIT_REVPARSE_MERGE_BASE:
      c_GIT_REVPARSE_MERGE_BASE
 

converter to_git_revparse_mode_t*(
    arg: c_git_revparse_mode_t
  ): git_revparse_mode_t = 
  case arg:
    of c_GIT_REVPARSE_SINGLE:
      GIT_REVPARSE_SINGLE
    of c_GIT_REVPARSE_RANGE:
      GIT_REVPARSE_RANGE
    of c_GIT_REVPARSE_MERGE_BASE:
      GIT_REVPARSE_MERGE_BASE
 

converter toCint*(arg: c_git_revparse_mode_t): cint = 
  cint(ord(arg))
 
func `+`*(arg: c_git_revparse_mode_t, offset: int): c_git_revparse_mode_t = 
  c_git_revparse_mode_t(ord(arg) + offset)
 
func `+`*(offset: int, arg: c_git_revparse_mode_t): c_git_revparse_mode_t = 
  c_git_revparse_mode_t(ord(arg) + offset)
 
func `-`*(arg: c_git_revparse_mode_t, offset: int): c_git_revparse_mode_t = 
  c_git_revparse_mode_t(ord(arg) - offset)
 
func `-`*(offset: int, arg: c_git_revparse_mode_t): c_git_revparse_mode_t = 
  c_git_revparse_mode_t(ord(arg) - offset)
 

proc git_revparse*(
    revspec: ptr git_revspec,
    repo:    ptr git_repository,
    spec:    cstring
  ): cint {.git2Proc, importc.}
  
 

