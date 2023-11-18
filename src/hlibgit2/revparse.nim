{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./types

type
  c_git_revspec_t* {.size: sizeof(cint).} = enum
    c_GIT_REVSPEC_SINGLE     = 1 shl 0 ## The spec targeted a single object.
    c_GIT_REVSPEC_RANGE      = 1 shl 1 ## The spec targeted a range of commits.
    c_GIT_REVSPEC_MERGE_BASE = 1 shl 2 ## The spec used the '...' operator, which invokes special semantics.

  git_revspec* {.bycopy, header: "<git2/revparse.h>", importc.} = object
    from_f* {.importc: "from".}: ptr git_object ## The left element of the revspec; must be freed by the user
    to*:                         ptr git_object ## The right element of the revspec; must be freed by the user
    flags*:                      cuint          ## The intent of the revspec (i.e. `git_revspec_mode_t` flags)

  git_revspec_t* {.size: sizeof(cint).} = enum
    GIT_REVSPEC_SINGLE     ## The spec targeted a single object.
    GIT_REVSPEC_RANGE      ## The spec targeted a range of commits.
    GIT_REVSPEC_MERGE_BASE ## The spec used the '...' operator, which invokes special semantics.


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



proc to_c_git_revspec_t*(arg: git_revspec_t): c_git_revspec_t =
  case arg:
    of GIT_REVSPEC_SINGLE:     c_GIT_REVSPEC_SINGLE
    of GIT_REVSPEC_RANGE:      c_GIT_REVSPEC_RANGE
    of GIT_REVSPEC_MERGE_BASE: c_GIT_REVSPEC_MERGE_BASE


converter to_git_revspec_t*(arg: c_git_revspec_t): git_revspec_t =
  case arg:
    of c_GIT_REVSPEC_SINGLE:     GIT_REVSPEC_SINGLE
    of c_GIT_REVSPEC_RANGE:      GIT_REVSPEC_RANGE
    of c_GIT_REVSPEC_MERGE_BASE: GIT_REVSPEC_MERGE_BASE


converter toCint*(arg: c_git_revspec_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_revspec_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_revspec_t(arg)))

func `+`*(arg: c_git_revspec_t, offset: int): c_git_revspec_t =
  cast[c_git_revspec_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_revspec_t): c_git_revspec_t =
  cast[c_git_revspec_t](ord(arg) + offset)

func `-`*(arg: c_git_revspec_t, offset: int): c_git_revspec_t =
  cast[c_git_revspec_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_revspec_t): c_git_revspec_t =
  cast[c_git_revspec_t](ord(arg) - offset)


converter toCint*(args: set[git_revspec_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc git_revparse*(
    revspec: ptr git_revspec,
    repo:    ptr git_repository,
    spec:    cstring
  ): cint {.git2Proc, importc.}



