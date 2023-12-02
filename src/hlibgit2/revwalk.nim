import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./types.nim"

type
  c_git_sort_t* {.size: sizeof(cint).} = enum
    c_GIT_SORT_NONE        = 0
    c_GIT_SORT_TOPOLOGICAL = 1
    c_GIT_SORT_TIME        = 2
    c_GIT_SORT_REVERSE     = 1 shl 2

  git_sort_t* = enum
    GIT_SORT_NONE
    GIT_SORT_TOPOLOGICAL
    GIT_SORT_TIME
    GIT_SORT_REVERSE

  git_revwalk_hide_cb* = proc (a0: `ptr` git_oid, a1: pointer): cint



converter toCInt*(arg: c_git_sort_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_sort_t]): cint =
  for value in items(args):
    case value:
      of GIT_SORT_NONE       : result = cint(result or 0)
      of GIT_SORT_TOPOLOGICAL: result = cint(result or 1)
      of GIT_SORT_TIME       : result = cint(result or 2)
      of GIT_SORT_REVERSE    : result = cint(result or 4)

func `-`*(arg: c_git_sort_t, offset: int): cint = cast[c_git_sort_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_sort_t): cint = cast[c_git_sort_t](ord(arg) - offset)

func `+`*(arg: c_git_sort_t, offset: int): cint = cast[c_git_sort_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_sort_t): cint = cast[c_git_sort_t](ord(arg) + offset)

proc git_revwalk_new*(`out`: `ptr` git_revwalk, repo: `ptr` git_repository): cint {.git2Proc, importc: "git_revwalk_new".}

proc git_revwalk_reset*(walker: `ptr` git_revwalk): cint {.git2Proc, importc: "git_revwalk_reset".}

proc git_revwalk_push*(walk: `ptr` git_revwalk, id: `ptr` git_oid): cint {.git2Proc, importc: "git_revwalk_push".}

proc git_revwalk_push_glob*(walk: `ptr` git_revwalk, glob: cstring): cint {.git2Proc, importc: "git_revwalk_push_glob".}

proc git_revwalk_push_head*(walk: `ptr` git_revwalk): cint {.git2Proc, importc: "git_revwalk_push_head".}

proc git_revwalk_hide*(walk: `ptr` git_revwalk, commit_id: `ptr` git_oid): cint {.git2Proc, importc: "git_revwalk_hide".}

proc git_revwalk_hide_glob*(walk: `ptr` git_revwalk, glob: cstring): cint {.git2Proc, importc: "git_revwalk_hide_glob".}

proc git_revwalk_hide_head*(walk: `ptr` git_revwalk): cint {.git2Proc, importc: "git_revwalk_hide_head".}

proc git_revwalk_push_ref*(walk: `ptr` git_revwalk, refname: cstring): cint {.git2Proc, importc: "git_revwalk_push_ref".}

proc git_revwalk_hide_ref*(walk: `ptr` git_revwalk, refname: cstring): cint {.git2Proc, importc: "git_revwalk_hide_ref".}

proc git_revwalk_next*(`out`: `ptr` git_oid, walk: `ptr` git_revwalk): cint {.git2Proc, importc: "git_revwalk_next".}

proc git_revwalk_sorting*(walk: `ptr` git_revwalk, sort_mode: cuint): cint {.git2Proc, importc: "git_revwalk_sorting".}

proc git_revwalk_push_range*(walk: `ptr` git_revwalk, range: cstring): cint {.git2Proc, importc: "git_revwalk_push_range".}

proc git_revwalk_simplify_first_parent*(walk: `ptr` git_revwalk): cint {.git2Proc, importc: "git_revwalk_simplify_first_parent".}

proc git_revwalk_free*(walk: `ptr` git_revwalk): void {.git2Proc, importc: "git_revwalk_free".}

proc git_revwalk_repository*(walk: `ptr` git_revwalk): `ptr` git_repository {.git2Proc, importc: "git_revwalk_repository".}

proc git_revwalk_add_hide_cb*(walk: `ptr` git_revwalk, hide_cb: git_revwalk_hide_cb, payload: pointer): cint {.git2Proc, importc: "git_revwalk_add_hide_cb".}