{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./strarray,
  ./types

type
  git_tag_foreach_cb* = proc(name: cstring, oid: ptr git_oid, payload: pointer): cint{.cdecl.}
   
  git_tag_foreach_cbNim* = proc(name: cstring, oid: ptr git_oid): cint
   

proc git_tag_lookup*(
    arg_out: ptr ptr git_tag,
    repo:    ptr git_repository,
    id:      ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_lookup_prefix*(
    arg_out: ptr ptr git_tag,
    repo:    ptr git_repository,
    id:      ptr git_oid,
    len:     csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_free*(tag: ptr git_tag): void {.git2Proc, importc.}
  
 

proc git_tag_id*(tag: ptr git_tag): ptr git_oid {.git2Proc, importc.}
  
 

proc git_tag_owner*(tag: ptr git_tag): ptr git_repository {.git2Proc, importc.}
  
 

proc git_tag_target*(
    target_out: ptr ptr git_object,
    tag:        ptr git_tag
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_target_id*(tag: ptr git_tag): ptr git_oid {.git2Proc, importc.}
  
 

proc git_tag_target_type*(tag: ptr git_tag): git_object_t {.git2Proc, importc.}
  
 

proc git_tag_name*(tag: ptr git_tag): cstring {.git2Proc, importc.}
  
 

proc git_tag_tagger*(tag: ptr git_tag): ptr git_signature {.git2Proc, importc.}
  
 

proc git_tag_message*(tag: ptr git_tag): cstring {.git2Proc, importc.}
  
 

proc git_tag_create*(
    oid:      ptr git_oid,
    repo:     ptr git_repository,
    tag_name: cstring,
    target:   ptr git_object,
    tagger:   ptr git_signature,
    message:  cstring,
    force:    cint
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_annotation_create*(
    oid:      ptr git_oid,
    repo:     ptr git_repository,
    tag_name: cstring,
    target:   ptr git_object,
    tagger:   ptr git_signature,
    message:  cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_create_from_buffer*(
    oid:    ptr git_oid,
    repo:   ptr git_repository,
    buffer: cstring,
    force:  cint
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_create_lightweight*(
    oid:      ptr git_oid,
    repo:     ptr git_repository,
    tag_name: cstring,
    target:   ptr git_object,
    force:    cint
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_delete*(
    repo:     ptr git_repository,
    tag_name: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_list*(
    tag_names: ptr git_strarray,
    repo:      ptr git_repository
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_list_match*(
    tag_names: ptr git_strarray,
    pattern:   cstring,
    repo:      ptr git_repository
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_foreach*(
    repo:     ptr git_repository,
    callback: git_tag_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_peel*(
    tag_target_out: ptr ptr git_object,
    tag:            ptr git_tag
  ): cint {.git2Proc, importc.}
  
 

proc git_tag_dup*(
    arg_out: ptr ptr git_tag,
    source:  ptr git_tag
  ): cint {.git2Proc, importc.}
  
 

