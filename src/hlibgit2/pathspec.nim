{.push warning[UnusedImport]:off.}

import
  ./diff,
  ./libgit2_config,
  ./strarray,
  ./types

type
  c_git_pathspec_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_PATHSPEC_DEFAULT        = 0 shl 0
    c_GIT_PATHSPEC_IGNORE_CASE    = 1 shl 0
    c_GIT_PATHSPEC_USE_CASE       = 1 shl 1
    c_GIT_PATHSPEC_NO_GLOB        = 1 shl 2
    c_GIT_PATHSPEC_NO_MATCH_ERROR = 1 shl 3
    c_GIT_PATHSPEC_FIND_FAILURES  = 1 shl 4
    c_GIT_PATHSPEC_FAILURES_ONLY  = 1 shl 5

  git_pathspec* {.bycopy, incompleteStruct, header: "<git2/pathspec.h>", importc.} = object


  git_pathspec_flag_t* {.size: sizeof(cint).} = enum
    GIT_PATHSPEC_DEFAULT
    GIT_PATHSPEC_IGNORE_CASE
    GIT_PATHSPEC_USE_CASE
    GIT_PATHSPEC_NO_GLOB
    GIT_PATHSPEC_NO_MATCH_ERROR
    GIT_PATHSPEC_FIND_FAILURES
    GIT_PATHSPEC_FAILURES_ONLY

  git_pathspec_match_list* {.bycopy, incompleteStruct, header: "<git2/pathspec.h>", importc.} = object



proc to_c_git_pathspec_flag_t*(
    arg: git_pathspec_flag_t
  ): c_git_pathspec_flag_t =
  case arg:
    of GIT_PATHSPEC_DEFAULT:        c_GIT_PATHSPEC_DEFAULT
    of GIT_PATHSPEC_IGNORE_CASE:    c_GIT_PATHSPEC_IGNORE_CASE
    of GIT_PATHSPEC_USE_CASE:       c_GIT_PATHSPEC_USE_CASE
    of GIT_PATHSPEC_NO_GLOB:        c_GIT_PATHSPEC_NO_GLOB
    of GIT_PATHSPEC_NO_MATCH_ERROR: c_GIT_PATHSPEC_NO_MATCH_ERROR
    of GIT_PATHSPEC_FIND_FAILURES:  c_GIT_PATHSPEC_FIND_FAILURES
    of GIT_PATHSPEC_FAILURES_ONLY:  c_GIT_PATHSPEC_FAILURES_ONLY


converter to_git_pathspec_flag_t*(
    arg: c_git_pathspec_flag_t
  ): git_pathspec_flag_t =
  case arg:
    of c_GIT_PATHSPEC_DEFAULT:        GIT_PATHSPEC_DEFAULT
    of c_GIT_PATHSPEC_IGNORE_CASE:    GIT_PATHSPEC_IGNORE_CASE
    of c_GIT_PATHSPEC_USE_CASE:       GIT_PATHSPEC_USE_CASE
    of c_GIT_PATHSPEC_NO_GLOB:        GIT_PATHSPEC_NO_GLOB
    of c_GIT_PATHSPEC_NO_MATCH_ERROR: GIT_PATHSPEC_NO_MATCH_ERROR
    of c_GIT_PATHSPEC_FIND_FAILURES:  GIT_PATHSPEC_FIND_FAILURES
    of c_GIT_PATHSPEC_FAILURES_ONLY:  GIT_PATHSPEC_FAILURES_ONLY


converter toCint*(arg: c_git_pathspec_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_pathspec_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_pathspec_flag_t(arg)))

func `+`*(arg: c_git_pathspec_flag_t, offset: int): c_git_pathspec_flag_t =
  cast[c_git_pathspec_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_pathspec_flag_t): c_git_pathspec_flag_t =
  cast[c_git_pathspec_flag_t](ord(arg) + offset)

func `-`*(arg: c_git_pathspec_flag_t, offset: int): c_git_pathspec_flag_t =
  cast[c_git_pathspec_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_pathspec_flag_t): c_git_pathspec_flag_t =
  cast[c_git_pathspec_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_pathspec_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_PATHSPEC_DEFAULT:        result = cint(result or (0 shl 0))
      of GIT_PATHSPEC_IGNORE_CASE:    result = cint(result or (1 shl 0))
      of GIT_PATHSPEC_USE_CASE:       result = cint(result or (1 shl 1))
      of GIT_PATHSPEC_NO_GLOB:        result = cint(result or (1 shl 2))
      of GIT_PATHSPEC_NO_MATCH_ERROR: result = cint(result or (1 shl 3))
      of GIT_PATHSPEC_FIND_FAILURES:  result = cint(result or (1 shl 4))
      of GIT_PATHSPEC_FAILURES_ONLY:  result = cint(result or (1 shl 5))


proc git_pathspec_new*(
    arg_out:  ptr ptr git_pathspec,
    pathspec: ptr git_strarray
  ): cint {.git2Proc, importc.}



proc git_pathspec_free*(ps: ptr git_pathspec): void {.git2Proc, importc.}



proc git_pathspec_matches_path*(
    ps:    ptr git_pathspec,
    flags: uint32,
    path:  cstring
  ): cint {.git2Proc, importc.}



proc git_pathspec_match_workdir*(
    arg_out: ptr ptr git_pathspec_match_list,
    repo:    ptr git_repository,
    flags:   uint32,
    ps:      ptr git_pathspec
  ): cint {.git2Proc, importc.}



proc git_pathspec_match_index*(
    arg_out: ptr ptr git_pathspec_match_list,
    index:   ptr git_index,
    flags:   uint32,
    ps:      ptr git_pathspec
  ): cint {.git2Proc, importc.}



proc git_pathspec_match_tree*(
    arg_out: ptr ptr git_pathspec_match_list,
    tree:    ptr git_tree,
    flags:   uint32,
    ps:      ptr git_pathspec
  ): cint {.git2Proc, importc.}



proc git_pathspec_match_diff*(
    arg_out: ptr ptr git_pathspec_match_list,
    diff:    ptr git_diff,
    flags:   uint32,
    ps:      ptr git_pathspec
  ): cint {.git2Proc, importc.}



proc git_pathspec_match_list_free*(
    m: ptr git_pathspec_match_list
  ): void {.git2Proc, importc.}



proc git_pathspec_match_list_entrycount*(
    m: ptr git_pathspec_match_list
  ): csize_t {.git2Proc, importc.}



proc git_pathspec_match_list_entry*(
    m:   ptr git_pathspec_match_list,
    pos: csize_t
  ): cstring {.git2Proc, importc.}



proc git_pathspec_match_list_diff_entry*(
    m:   ptr git_pathspec_match_list,
    pos: csize_t
  ): ptr git_diff_delta {.git2Proc, importc.}



proc git_pathspec_match_list_failed_entrycount*(
    m: ptr git_pathspec_match_list
  ): csize_t {.git2Proc, importc.}



proc git_pathspec_match_list_failed_entry*(
    m:   ptr git_pathspec_match_list,
    pos: csize_t
  ): cstring {.git2Proc, importc.}



