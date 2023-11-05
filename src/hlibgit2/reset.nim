{.push warning[UnusedImport]:off.}

import
  ./checkout,
  ./libgit2_config,
  ./strarray,
  ./types

type
  c_git_reset_t* {.size: sizeof(cint).} = enum
    c_GIT_RESET_SOFT  = 1
    c_GIT_RESET_MIXED = 2 ## Move the head to the given commit
    c_GIT_RESET_HARD  = 3 ## SOFT plus reset index to the commit

  git_reset_t* = enum
    GIT_RESET_SOFT
    GIT_RESET_MIXED ## Move the head to the given commit
    GIT_RESET_HARD  ## SOFT plus reset index to the commit


proc to_c_git_reset_t*(arg: git_reset_t): c_git_reset_t =
  case arg:
    of GIT_RESET_SOFT:  c_GIT_RESET_SOFT
    of GIT_RESET_MIXED: c_GIT_RESET_MIXED
    of GIT_RESET_HARD:  c_GIT_RESET_HARD


converter to_git_reset_t*(arg: c_git_reset_t): git_reset_t =
  case arg:
    of c_GIT_RESET_SOFT:  GIT_RESET_SOFT
    of c_GIT_RESET_MIXED: GIT_RESET_MIXED
    of c_GIT_RESET_HARD:  GIT_RESET_HARD


converter toCint*(arg: c_git_reset_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_reset_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_reset_t(arg)))

func `+`*(arg: c_git_reset_t, offset: int): c_git_reset_t =
  cast[c_git_reset_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_reset_t): c_git_reset_t =
  cast[c_git_reset_t](ord(arg) + offset)

func `-`*(arg: c_git_reset_t, offset: int): c_git_reset_t =
  cast[c_git_reset_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_reset_t): c_git_reset_t =
  cast[c_git_reset_t](ord(arg) - offset)


proc git_reset*(
    repo:          ptr git_repository,
    target:        ptr git_object,
    reset_type:    c_git_reset_t,
    checkout_opts: ptr git_checkout_options
  ): cint {.git2Proc, importc.}



proc git_reset_from_annotated*(
    repo:          ptr git_repository,
    commit:        ptr git_annotated_commit,
    reset_type:    c_git_reset_t,
    checkout_opts: ptr git_checkout_options
  ): cint {.git2Proc, importc.}



proc git_reset_default*(
    repo:      ptr git_repository,
    target:    ptr git_object,
    pathspecs: ptr git_strarray
  ): cint {.git2Proc, importc.}



