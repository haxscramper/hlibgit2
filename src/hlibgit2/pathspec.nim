import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./strarray.nim"
import "./diff.nim"

type
  git_pathspec* {.header: "<pathspec.h>", importc, incompleteStruct.} = object


  git_pathspec_match_list* {.header: "<pathspec.h>", importc, incompleteStruct.} = object


  c_git_pathspec_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_PATHSPEC_DEFAULT        = 0
    c_GIT_PATHSPEC_IGNORE_CASE    = 1
    c_GIT_PATHSPEC_USE_CASE       = 2
    c_GIT_PATHSPEC_NO_GLOB        = 1 shl 2
    c_GIT_PATHSPEC_NO_MATCH_ERROR = 1 shl 3
    c_GIT_PATHSPEC_FIND_FAILURES  = 1 shl 4
    c_GIT_PATHSPEC_FAILURES_ONLY  = 1 shl 5

  git_pathspec_flag_t* = enum
    GIT_PATHSPEC_DEFAULT        = 0
    GIT_PATHSPEC_IGNORE_CASE    = 1
    GIT_PATHSPEC_USE_CASE       = 2
    GIT_PATHSPEC_NO_GLOB        = 3
    GIT_PATHSPEC_NO_MATCH_ERROR = 4
    GIT_PATHSPEC_FIND_FAILURES  = 5
    GIT_PATHSPEC_FAILURES_ONLY  = 6



proc git_pathspec_match_list_diff_entry*(m: ptr git_pathspec_match_list, pos: csize_t): ptr git_diff_delta {.importc: "git_pathspec_match_list_diff_entry", header: "<pathspec.h>".}

proc git_pathspec_match_list_failed_entrycount*(m: ptr git_pathspec_match_list): csize_t {.importc: "git_pathspec_match_list_failed_entrycount", header: "<pathspec.h>".}

proc git_pathspec_match_list_failed_entry*(m: ptr git_pathspec_match_list, pos: csize_t): cstring {.importc: "git_pathspec_match_list_failed_entry", header: "<pathspec.h>".}

converter to_git_pathspec_flag_t*(arg: c_git_pathspec_flag_t): git_pathspec_flag_t =
  case arg:
    of c_GIT_PATHSPEC_DEFAULT       : GIT_PATHSPEC_DEFAULT
    of c_GIT_PATHSPEC_IGNORE_CASE   : GIT_PATHSPEC_IGNORE_CASE
    of c_GIT_PATHSPEC_USE_CASE      : GIT_PATHSPEC_USE_CASE
    of c_GIT_PATHSPEC_NO_GLOB       : GIT_PATHSPEC_NO_GLOB
    of c_GIT_PATHSPEC_NO_MATCH_ERROR: GIT_PATHSPEC_NO_MATCH_ERROR
    of c_GIT_PATHSPEC_FIND_FAILURES : GIT_PATHSPEC_FIND_FAILURES
    of c_GIT_PATHSPEC_FAILURES_ONLY : GIT_PATHSPEC_FAILURES_ONLY

proc to_c_git_pathspec_flag_t*(arg: git_pathspec_flag_t): c_git_pathspec_flag_t =
  case arg:
    of GIT_PATHSPEC_DEFAULT       : c_GIT_PATHSPEC_DEFAULT
    of GIT_PATHSPEC_IGNORE_CASE   : c_GIT_PATHSPEC_IGNORE_CASE
    of GIT_PATHSPEC_USE_CASE      : c_GIT_PATHSPEC_USE_CASE
    of GIT_PATHSPEC_NO_GLOB       : c_GIT_PATHSPEC_NO_GLOB
    of GIT_PATHSPEC_NO_MATCH_ERROR: c_GIT_PATHSPEC_NO_MATCH_ERROR
    of GIT_PATHSPEC_FIND_FAILURES : c_GIT_PATHSPEC_FIND_FAILURES
    of GIT_PATHSPEC_FAILURES_ONLY : c_GIT_PATHSPEC_FAILURES_ONLY

converter toCInt*(arg: c_git_pathspec_flag_t): cint = cint(ord(arg))

converter toCInt*(arg: git_pathspec_flag_t): cint = cint(ord(to_c_git_pathspec_flag_t(arg)))

converter toCInt*(args: set[git_pathspec_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_PATHSPEC_DEFAULT       : result = cint(result or 0)
      of GIT_PATHSPEC_IGNORE_CASE   : result = cint(result or 1)
      of GIT_PATHSPEC_USE_CASE      : result = cint(result or 2)
      of GIT_PATHSPEC_NO_GLOB       : result = cint(result or 4)
      of GIT_PATHSPEC_NO_MATCH_ERROR: result = cint(result or 8)
      of GIT_PATHSPEC_FIND_FAILURES : result = cint(result or 16)
      of GIT_PATHSPEC_FAILURES_ONLY : result = cint(result or 32)

func `-`*(arg: c_git_pathspec_flag_t, offset: int): cint = cast[c_git_pathspec_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_pathspec_flag_t): cint = cast[c_git_pathspec_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_pathspec_flag_t, offset: int): cint = cast[c_git_pathspec_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_pathspec_flag_t): cint = cast[c_git_pathspec_flag_t](ord(arg) + offset)

proc git_pathspec_new*(`out`: ptr ptr git_pathspec, pathspec: ptr git_strarray): cint {.importc: "git_pathspec_new", header: "<pathspec.h>".}

proc git_pathspec_free*(ps: ptr git_pathspec): void {.importc: "git_pathspec_free", header: "<pathspec.h>".}

proc git_pathspec_matches_path*(
    ps: ptr git_pathspec,
    flags: uint32,
    path: cstring,
): cint {.importc: "git_pathspec_matches_path", header: "<pathspec.h>".}

proc git_pathspec_match_workdir*(
    `out`: ptr ptr git_pathspec_match_list,
    repo: ptr git_repository,
    flags: uint32,
    ps: ptr git_pathspec,
): cint {.importc: "git_pathspec_match_workdir", header: "<pathspec.h>".}

proc git_pathspec_match_index*(
    `out`: ptr ptr git_pathspec_match_list,
    index: ptr git_index,
    flags: uint32,
    ps: ptr git_pathspec,
): cint {.importc: "git_pathspec_match_index", header: "<pathspec.h>".}

proc git_pathspec_match_tree*(
    `out`: ptr ptr git_pathspec_match_list,
    tree: ptr git_tree,
    flags: uint32,
    ps: ptr git_pathspec,
): cint {.importc: "git_pathspec_match_tree", header: "<pathspec.h>".}

proc git_pathspec_match_diff*(
    `out`: ptr ptr git_pathspec_match_list,
    diff: ptr git_diff,
    flags: uint32,
    ps: ptr git_pathspec,
): cint {.importc: "git_pathspec_match_diff", header: "<pathspec.h>".}

proc git_pathspec_match_list_free*(m: ptr git_pathspec_match_list): void {.importc: "git_pathspec_match_list_free", header: "<pathspec.h>".}

proc git_pathspec_match_list_entrycount*(m: ptr git_pathspec_match_list): csize_t {.importc: "git_pathspec_match_list_entrycount", header: "<pathspec.h>".}

proc git_pathspec_match_list_entry*(m: ptr git_pathspec_match_list, pos: csize_t): cstring {.importc: "git_pathspec_match_list_entry", header: "<pathspec.h>".}