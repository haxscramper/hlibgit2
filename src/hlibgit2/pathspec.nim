
import
  . / strarray

import
  . / diff

type
  git_pathspec* {.bycopy, incompleteStruct.} = object
  
  git_pathspec_match_list* {.bycopy, incompleteStruct.} = object
  
  git_pathspec_flag_t* = enum
    GIT_PATHSPEC_DEFAULT = 0, GIT_PATHSPEC_IGNORE_CASE = 1,
    GIT_PATHSPEC_USE_CASE = 2, GIT_PATHSPEC_NO_GLOB = 4,
    GIT_PATHSPEC_NO_MATCH_ERROR = 8, GIT_PATHSPEC_FIND_FAILURES = 16,
    GIT_PATHSPEC_FAILURES_ONLY = 32
proc git_pathspec_new*(out: ptr ptr git_pathspec; pathspec: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_pathspec_free*(ps: ptr git_pathspec): void {.dynlib: libgitDl, importc.}
proc git_pathspec_matches_path*(ps: ptr git_pathspec; flags: uint32;
                                path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_pathspec_match_workdir*(out: ptr ptr git_pathspec_match_list;
                                 repo: ptr git_repository; flags: uint32;
                                 ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_index*(out: ptr ptr git_pathspec_match_list;
                               index: ptr git_index; flags: uint32;
                               ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_tree*(out: ptr ptr git_pathspec_match_list;
                              tree: ptr git_tree; flags: uint32;
                              ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_diff*(out: ptr ptr git_pathspec_match_list;
                              diff: ptr git_diff; flags: uint32;
                              ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_list_free*(m: ptr git_pathspec_match_list): void {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_entrycount*(m: ptr git_pathspec_match_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_entry*(m: ptr git_pathspec_match_list; pos: size_t): cstring {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_diff_entry*(m: ptr git_pathspec_match_list;
    pos: size_t): ptr git_diff_delta {.dynlib: libgitDl, importc.}
proc git_pathspec_match_list_failed_entrycount*(m: ptr git_pathspec_match_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_failed_entry*(m: ptr git_pathspec_match_list;
    pos: size_t): cstring {.dynlib: libgitDl, importc.}