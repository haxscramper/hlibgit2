{.push warning[UnusedImport]:off.}

import
  ./indexer,
  ./libgit2_config,
  ./odb_backend,
  ./oid,
  ./types

type
  git_odb_expand_id* {.bycopy, header: "<git2/odb.h>", importc.} = object
    id*:                         git_oid      ## The object ID to expand 
    length*:                     cushort                                 
    type_f* {.importc: "type".}: git_object_t                            
   
  git_odb_foreach_cb* = proc(id: ptr git_oid, payload: pointer): cint{.cdecl.}
   
  git_odb_foreach_cbNim* = proc(id: ptr git_oid): cint
   

proc git_odb_new*(arg_out: ptr ptr git_odb): cint {.git2Proc, importc.}
  
 

proc git_odb_open*(
    arg_out:     ptr ptr git_odb,
    objects_dir: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_add_disk_alternate*(
    odb:  ptr git_odb,
    path: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_free*(db: ptr git_odb): void {.git2Proc, importc.}
  
 

proc git_odb_read*(
    arg_out: ptr ptr git_odb_object,
    db:      ptr git_odb,
    id:      ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_read_prefix*(
    arg_out:  ptr ptr git_odb_object,
    db:       ptr git_odb,
    short_id: ptr git_oid,
    len:      csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_read_header*(
    len_out:  ptr csize_t,
    type_out: ptr git_object_t,
    db:       ptr git_odb,
    id:       ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_exists*(
    db: ptr git_odb,
    id: ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_exists_prefix*(
    arg_out:  ptr git_oid,
    db:       ptr git_odb,
    short_id: ptr git_oid,
    len:      csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_expand_ids*(
    db:    ptr git_odb,
    ids:   ptr git_odb_expand_id,
    count: csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_refresh*(db: ptr git_odb): cint {.git2Proc, importc.}
  
 

proc git_odb_foreach*(
    db:      ptr git_odb,
    cb:      git_odb_foreach_cb,
    payload: pointer
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_write*(
    arg_out: ptr git_oid,
    odb:     ptr git_odb,
    data:    pointer,
    len:     csize_t,
    type_f:  git_object_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_open_wstream*(
    arg_out: ptr ptr git_odb_stream,
    db:      ptr git_odb,
    size:    git_object_size_t,
    type_f:  git_object_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_stream_write*(
    stream: ptr git_odb_stream,
    buffer: cstring,
    len:    csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_stream_finalize_write*(
    arg_out: ptr git_oid,
    stream:  ptr git_odb_stream
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_stream_read*(
    stream: ptr git_odb_stream,
    buffer: cstring,
    len:    csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_stream_free*(
    stream: ptr git_odb_stream
  ): void {.git2Proc, importc.}
  
 

proc git_odb_open_rstream*(
    arg_out: ptr ptr git_odb_stream,
    len:     ptr csize_t,
    type_f:  ptr git_object_t,
    db:      ptr git_odb,
    oid:     ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_write_pack1*(
    arg_out:          ptr ptr git_odb_writepack,
    db:               ptr git_odb,
    progress_cb:      git_indexer_progress_cb,
    progress_payload: pointer
  ): cint {.git2Proc, importc: "git_odb_write_pack".}
  
 

proc git_odb_hash*(
    arg_out: ptr git_oid,
    data:    pointer,
    len:     csize_t,
    type_f:  git_object_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_hashfile*(
    arg_out: ptr git_oid,
    path:    cstring,
    type_f:  git_object_t
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_object_dup*(
    dest:   ptr ptr git_odb_object,
    source: ptr git_odb_object
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_object_free*(
    arg_object: ptr git_odb_object
  ): void {.git2Proc, importc.}
  
 

proc git_odb_object_id*(
    arg_object: ptr git_odb_object
  ): ptr git_oid {.git2Proc, importc.}
  
 

proc git_odb_object_data*(
    arg_object: ptr git_odb_object
  ): pointer {.git2Proc, importc.}
  
 

proc git_odb_object_size*(
    arg_object: ptr git_odb_object
  ): csize_t {.git2Proc, importc.}
  
 

proc git_odb_object_type*(
    arg_object: ptr git_odb_object
  ): git_object_t {.git2Proc, importc.}
  
 

proc git_odb_add_backend*(
    odb:      ptr git_odb,
    backend:  ptr git_odb_backend,
    priority: cint
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_add_alternate*(
    odb:      ptr git_odb,
    backend:  ptr git_odb_backend,
    priority: cint
  ): cint {.git2Proc, importc.}
  
 

proc git_odb_num_backends*(odb: ptr git_odb): csize_t {.git2Proc, importc.}
  
 

proc git_odb_get_backend*(
    arg_out: ptr ptr git_odb_backend,
    odb:     ptr git_odb,
    pos:     csize_t
  ): cint {.git2Proc, importc.}
  
 

