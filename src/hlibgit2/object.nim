{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./oid,
  ./types

proc git_object_lookup*(
    arg_object: ptr ptr git_object,
    repo:       ptr git_repository,
    id:         ptr git_oid,
    type_f:     c_git_object_t
  ): cint {.git2Proc, importc.}
  
 

proc git_object_lookup_prefix*(
    object_out: ptr ptr git_object,
    repo:       ptr git_repository,
    id:         ptr git_oid,
    len:        csize_t,
    type_f:     c_git_object_t
  ): cint {.git2Proc, importc.}
  
 

proc git_object_lookup_bypath*(
    arg_out: ptr ptr git_object,
    treeish: ptr git_object,
    path:    cstring,
    type_f:  c_git_object_t
  ): cint {.git2Proc, importc.}
  
 

proc git_object_id*(obj: ptr git_object): ptr git_oid {.git2Proc, importc.}
  
 

proc git_object_short_id*(
    arg_out: ptr git_buf,
    obj:     ptr git_object
  ): cint {.git2Proc, importc.}
  
 

proc git_object_type*(obj: ptr git_object): c_git_object_t {.git2Proc, importc.}
  
 

proc git_object_owner*(
    obj: ptr git_object
  ): ptr git_repository {.git2Proc, importc.}
  
 

proc git_object_free*(arg_object: ptr git_object): void {.git2Proc, importc.}
  
 

proc git_object_type2string*(
    type_f: c_git_object_t
  ): cstring {.git2Proc, importc.}
  
 

proc git_object_string2type*(str: cstring): c_git_object_t {.git2Proc, importc.}
  
 

proc git_object_typeisloose*(type_f: c_git_object_t): cint {.git2Proc, importc.}
  
 

proc git_object_peel*(
    peeled:      ptr ptr git_object,
    arg_object:  ptr git_object,
    target_type: c_git_object_t
  ): cint {.git2Proc, importc.}
  
 

proc git_object_dup*(
    dest:   ptr ptr git_object,
    source: ptr git_object
  ): cint {.git2Proc, importc.}
  
 

