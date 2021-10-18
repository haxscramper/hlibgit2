{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_sort_t* = enum
    c_GIT_SORT_NONE        = 0
    c_GIT_SORT_TOPOLOGICAL = 1
    c_GIT_SORT_TIME        = 2
    c_GIT_SORT_REVERSE     = 4
   
  git_revwalk_hide_cb* = proc(commit_id: ptr git_oid, payload: pointer): cint{.cdecl.}
   
  git_revwalk_hide_cbNim* = proc(commit_id: ptr git_oid): cint
   
  git_sort_t* = enum
    GIT_SORT_NONE       
    GIT_SORT_TOPOLOGICAL
    GIT_SORT_TIME       
    GIT_SORT_REVERSE    
   

proc to_c_git_sort_t*(arg: git_sort_t): c_git_sort_t = 
  case arg:
    of GIT_SORT_NONE:
      c_GIT_SORT_NONE
    of GIT_SORT_TOPOLOGICAL:
      c_GIT_SORT_TOPOLOGICAL
    of GIT_SORT_TIME:
      c_GIT_SORT_TIME
    of GIT_SORT_REVERSE:
      c_GIT_SORT_REVERSE
 

converter to_git_sort_t*(arg: c_git_sort_t): git_sort_t = 
  case arg:
    of c_GIT_SORT_NONE:
      GIT_SORT_NONE
    of c_GIT_SORT_TOPOLOGICAL:
      GIT_SORT_TOPOLOGICAL
    of c_GIT_SORT_TIME:
      GIT_SORT_TIME
    of c_GIT_SORT_REVERSE:
      GIT_SORT_REVERSE
 

converter toCint*(arg: c_git_sort_t): cint = 
  cint(ord(arg))
 
func `+`*(arg: c_git_sort_t, offset: int): c_git_sort_t = 
  c_git_sort_t(ord(arg) + offset)
 
func `+`*(offset: int, arg: c_git_sort_t): c_git_sort_t = 
  c_git_sort_t(ord(arg) + offset)
 
func `-`*(arg: c_git_sort_t, offset: int): c_git_sort_t = 
  c_git_sort_t(ord(arg) - offset)
 
func `-`*(offset: int, arg: c_git_sort_t): c_git_sort_t = 
  c_git_sort_t(ord(arg) - offset)
 

proc git_revwalk_new*(
    arg_out: ptr ptr git_revwalk,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_reset*(walker: ptr git_revwalk): cint {.git2Proc, importc.}
  
 

proc git_revwalk_push*(
    walk: ptr git_revwalk,
    id:   ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_push_glob*(
    walk: ptr git_revwalk,
    glob: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_push_head*(walk: ptr git_revwalk): cint {.git2Proc, importc.}
  
 

proc git_revwalk_hide*(
    walk:      ptr git_revwalk,
    commit_id: ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_hide_glob*(
    walk: ptr git_revwalk,
    glob: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_hide_head*(walk: ptr git_revwalk): cint {.git2Proc, importc.}
  
 

proc git_revwalk_push_ref*(
    walk:    ptr git_revwalk,
    refname: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_hide_ref*(
    walk:    ptr git_revwalk,
    refname: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_next*(
    arg_out: ptr git_oid,
    walk:    ptr git_revwalk
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_sorting*(
    walk:      ptr git_revwalk,
    sort_mode: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_push_range*(
    walk:  ptr git_revwalk,
    range: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_simplify_first_parent*(
    walk: ptr git_revwalk
  ): cint {.git2Proc, importc.}
  
 

proc git_revwalk_free*(walk: ptr git_revwalk): void {.git2Proc, importc.}
  
 

proc git_revwalk_repository*(
    walk: ptr git_revwalk
  ): ptr git_repository {.git2Proc, importc.}
  
 

proc git_revwalk_add_hide_cb*(
    walk:    ptr git_revwalk,
    hide_cb: git_revwalk_hide_cb,
    payload: pointer
  ): cint {.git2Proc, importc.}
  
 

