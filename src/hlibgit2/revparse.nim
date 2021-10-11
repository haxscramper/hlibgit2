{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

type
  git_revparse_mode_t* = enum
    GIT_REVPARSE_SINGLE = 1 ## The spec targeted a single object. 
    GIT_REVPARSE_RANGE = 2 ## The spec targeted a range of commits. 
    GIT_REVPARSE_MERGE_BASE = 4 ## The spec used the '...' operator, which invokes special semantics. 
   
  git_revspec* {.bycopy, header: "<git2/revparse.h>", importc.} = object
    from_f* {.importc: "from".}: ptr git_object ## The left element of the revspec; must be freed by the user 
    to*: ptr git_object ## The right element of the revspec; must be freed by the user 
    flags*: cuint ## The intent of the revspec (i.e. `git_revparse_mode_t` flags) 
   

proc git_revparse_single*(
    arg_out: ptr ptr git_object,
    repo:    ptr git_repository,
    spec:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_revparse_ext*(
    object_out:    ptr ptr git_object,
    reference_out: ptr ptr git_reference,
    repo:          ptr git_repository,
    spec:          cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_revparse*(
    revspec: ptr git_revspec,
    repo:    ptr git_repository,
    spec:    cstring
  ): cint {.dynlib: libgitDl, importc.}


