import "./libgit2_config.nim" ## From gen file
import "./strarray.nim"
import "./types.nim"
import "./diff.nim"

type
  git_pathspec* {.importc, bycopy, incompleteStruct.} = object


  git_pathspec_match_list* {.importc, bycopy, incompleteStruct.} = object


  c_git_pathspec_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_PATHSPEC_DEFAULT        = 0
    c_GIT_PATHSPEC_IGNORE_CASE    = 1
    c_GIT_PATHSPEC_USE_CASE       = 2
    c_GIT_PATHSPEC_NO_GLOB        = 1 shl 2
    c_GIT_PATHSPEC_NO_MATCH_ERROR = 1 shl 3
    c_GIT_PATHSPEC_FIND_FAILURES  = 1 shl 4
    c_GIT_PATHSPEC_FAILURES_ONLY  = 1 shl 5

  git_pathspec_flag_t* = enum
    GIT_PATHSPEC_DEFAULT
    GIT_PATHSPEC_IGNORE_CASE
    GIT_PATHSPEC_USE_CASE
    GIT_PATHSPEC_NO_GLOB
    GIT_PATHSPEC_NO_MATCH_ERROR
    GIT_PATHSPEC_FIND_FAILURES
    GIT_PATHSPEC_FAILURES_ONLY



converter toCInt*(arg: c_git_pathspec_flag_t): cint = cint(ord(arg))

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

proc git_pathspec_new*(`out`: ptr ptr git_pathspec, pathspec: ptr git_strarray): cint {.git2Proc, importc: "git_pathspec_new".}

proc git_pathspec_free*(ps: ptr git_pathspec): void {.git2Proc, importc: "git_pathspec_free".}

proc git_pathspec_matches_path*(ps: ptr git_pathspec, flags: uint32, path: cstring): cint {.git2Proc, importc: "git_pathspec_matches_path".}

proc git_pathspec_match_workdir*(`out`: ptr ptr git_pathspec_match_list, repo: ptr git_repository, flags: uint32, ps: ptr git_pathspec): cint {.git2Proc, importc: "git_pathspec_match_workdir".}

proc git_pathspec_match_index*(`out`: ptr ptr git_pathspec_match_list, index: ptr git_index, flags: uint32, ps: ptr git_pathspec): cint {.git2Proc, importc: "git_pathspec_match_index".}

proc git_pathspec_match_tree*(`out`: ptr ptr git_pathspec_match_list, tree: ptr git_tree, flags: uint32, ps: ptr git_pathspec): cint {.git2Proc, importc: "git_pathspec_match_tree".}

proc git_pathspec_match_diff*(`out`: ptr ptr git_pathspec_match_list, diff: ptr git_diff, flags: uint32, ps: ptr git_pathspec): cint {.git2Proc, importc: "git_pathspec_match_diff".}

proc git_pathspec_match_list_free*(m: ptr git_pathspec_match_list): void {.git2Proc, importc: "git_pathspec_match_list_free".}

proc git_pathspec_match_list_entrycount*(m: ptr git_pathspec_match_list): csize_t {.git2Proc, importc: "git_pathspec_match_list_entrycount".}

proc git_pathspec_match_list_entry*(m: ptr git_pathspec_match_list, pos: csize_t): cstring {.git2Proc, importc: "git_pathspec_match_list_entry".}

proc git_pathspec_match_list_diff_entry*(m: ptr git_pathspec_match_list, pos: csize_t): ptr git_diff_delta {.git2Proc, importc: "git_pathspec_match_list_diff_entry".}

proc git_pathspec_match_list_failed_entrycount*(m: ptr git_pathspec_match_list): csize_t {.git2Proc, importc: "git_pathspec_match_list_failed_entrycount".}

proc git_pathspec_match_list_failed_entry*(m: ptr git_pathspec_match_list, pos: csize_t): cstring {.git2Proc, importc: "git_pathspec_match_list_failed_entry".}