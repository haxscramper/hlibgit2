import "./types.nim"
import "./oid.nim"

type
  c_git_sort_t* {.size: sizeof(cint).} = enum
    c_GIT_SORT_NONE        = 0
    c_GIT_SORT_TOPOLOGICAL = 1
    c_GIT_SORT_TIME        = 2
    c_GIT_SORT_REVERSE     = 1 shl 2

  git_sort_t* = enum
    GIT_SORT_NONE        = 0
    GIT_SORT_TOPOLOGICAL = 1
    GIT_SORT_TIME        = 2
    GIT_SORT_REVERSE     = 3

  git_revwalk_hide_cb* = proc (a0: ptr git_oid, a1: pointer): cint



proc git_revwalk_hide_ref*(walk: ptr git_revwalk, refname: cstring): cint {.importc: "git_revwalk_hide_ref".}

proc git_revwalk_next*(`out`: ptr git_oid, walk: ptr git_revwalk): cint {.importc: "git_revwalk_next".}

proc git_revwalk_sorting*(walk: ptr git_revwalk, sort_mode: cuint): cint {.importc: "git_revwalk_sorting".}

proc git_revwalk_push_range*(walk: ptr git_revwalk, range: cstring): cint {.importc: "git_revwalk_push_range".}

proc git_revwalk_simplify_first_parent*(walk: ptr git_revwalk): cint {.importc: "git_revwalk_simplify_first_parent".}

proc git_revwalk_free*(walk: ptr git_revwalk): void {.importc: "git_revwalk_free".}

proc git_revwalk_repository*(walk: ptr git_revwalk): ptr git_repository {.importc: "git_revwalk_repository".}

proc git_revwalk_add_hide_cb*(
    walk: ptr git_revwalk,
    hide_cb: git_revwalk_hide_cb,
    payload: pointer,
): cint {.importc: "git_revwalk_add_hide_cb".}

converter to_git_sort_t*(arg: c_git_sort_t): git_sort_t =
  case arg:
    of c_GIT_SORT_NONE       : GIT_SORT_NONE
    of c_GIT_SORT_TOPOLOGICAL: GIT_SORT_TOPOLOGICAL
    of c_GIT_SORT_TIME       : GIT_SORT_TIME
    of c_GIT_SORT_REVERSE    : GIT_SORT_REVERSE

proc to_c_git_sort_t*(arg: git_sort_t): c_git_sort_t =
  case arg:
    of GIT_SORT_NONE       : c_GIT_SORT_NONE
    of GIT_SORT_TOPOLOGICAL: c_GIT_SORT_TOPOLOGICAL
    of GIT_SORT_TIME       : c_GIT_SORT_TIME
    of GIT_SORT_REVERSE    : c_GIT_SORT_REVERSE

converter toCInt*(arg: c_git_sort_t): cint = cint(ord(arg))

converter toCInt*(arg: git_sort_t): cint = cint(ord(to_c_git_sort_t(arg)))

converter toCInt*(args: set[git_sort_t]): cint =
  for value in items(args):
    case value:
      of GIT_SORT_NONE       : result = cint(result or 0)
      of GIT_SORT_TOPOLOGICAL: result = cint(result or 1)
      of GIT_SORT_TIME       : result = cint(result or 2)
      of GIT_SORT_REVERSE    : result = cint(result or 4)

func `-`*(arg: c_git_sort_t, offset: int): c_git_sort_t = cast[c_git_sort_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_sort_t): c_git_sort_t = cast[c_git_sort_t](ord(arg) - offset)

func `+`*(arg: c_git_sort_t, offset: int): c_git_sort_t = cast[c_git_sort_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_sort_t): c_git_sort_t = cast[c_git_sort_t](ord(arg) + offset)

proc git_revwalk_new*(`out`: ptr ptr git_revwalk, repo: ptr git_repository): cint {.importc: "git_revwalk_new".}

proc git_revwalk_reset*(walker: ptr git_revwalk): cint {.importc: "git_revwalk_reset".}

proc git_revwalk_push*(walk: ptr git_revwalk, id: ptr git_oid): cint {.importc: "git_revwalk_push".}

proc git_revwalk_push_glob*(walk: ptr git_revwalk, glob: cstring): cint {.importc: "git_revwalk_push_glob".}

proc git_revwalk_push_head*(walk: ptr git_revwalk): cint {.importc: "git_revwalk_push_head".}

proc git_revwalk_hide*(walk: ptr git_revwalk, commit_id: ptr git_oid): cint {.importc: "git_revwalk_hide".}

proc git_revwalk_hide_glob*(walk: ptr git_revwalk, glob: cstring): cint {.importc: "git_revwalk_hide_glob".}

proc git_revwalk_hide_head*(walk: ptr git_revwalk): cint {.importc: "git_revwalk_hide_head".}

proc git_revwalk_push_ref*(walk: ptr git_revwalk, refname: cstring): cint {.importc: "git_revwalk_push_ref".}