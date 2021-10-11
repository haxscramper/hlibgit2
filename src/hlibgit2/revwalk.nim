{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./types

type
  git_revwalk_hide_cb* = proc(commit_id: ptr git_oid, payload: pointer): cint{.cdecl.}
   
  git_revwalk_hide_cbNim* = proc(commit_id: ptr git_oid): cint
   
  git_sort_t* = enum
    GIT_SORT_NONE = 0
    GIT_SORT_TOPOLOGICAL = 1
    GIT_SORT_TIME = 2
    GIT_SORT_REVERSE = 4
   

proc git_revwalk_new*(
    arg_out: ptr ptr git_revwalk,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_reset*(
    walker: ptr git_revwalk
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_push*(
    walk: ptr git_revwalk,
    id:   ptr git_oid
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_push_glob*(
    walk: ptr git_revwalk,
    glob: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_push_head*(
    walk: ptr git_revwalk
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_hide*(
    walk:      ptr git_revwalk,
    commit_id: ptr git_oid
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_hide_glob*(
    walk: ptr git_revwalk,
    glob: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_hide_head*(
    walk: ptr git_revwalk
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_push_ref*(
    walk:    ptr git_revwalk,
    refname: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_hide_ref*(
    walk:    ptr git_revwalk,
    refname: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_next*(
    arg_out: ptr git_oid,
    walk:    ptr git_revwalk
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_sorting*(
    walk:      ptr git_revwalk,
    sort_mode: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_push_range*(
    walk:  ptr git_revwalk,
    range: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_simplify_first_parent*(
    walk: ptr git_revwalk
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_revwalk_free*(
    walk: ptr git_revwalk
  ): void {.dynlib: libgit2Dl, importc.}


proc git_revwalk_repository*(
    walk: ptr git_revwalk
  ): ptr git_repository {.dynlib: libgit2Dl, importc.}


proc git_revwalk_add_hide_cb*(
    walk:    ptr git_revwalk,
    hide_cb: git_revwalk_hide_cb,
    payload: pointer
  ): cint {.dynlib: libgit2Dl, importc.}


