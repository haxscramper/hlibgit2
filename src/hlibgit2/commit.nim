{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./oid,
  ./types

type
  git_commit_signing_cb* = proc(signature: ptr git_buf, signature_field: ptr git_buf, commit_content: cstring, payload: pointer): cint{.cdecl.}
   
  git_commit_signing_cbNim* = proc(signature: ptr git_buf, signature_field: ptr git_buf, commit_content: cstring): cint
   

proc git_commit_lookup*(
    commit: ptr ptr git_commit,
    repo:   ptr git_repository,
    id:     ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_lookup_prefix*(
    commit: ptr ptr git_commit,
    repo:   ptr git_repository,
    id:     ptr git_oid,
    len:    csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_free*(commit: ptr git_commit): void {.git2Proc, importc.}
  
 

proc git_commit_id*(commit: ptr git_commit): ptr git_oid {.git2Proc, importc.}
  
 

proc git_commit_owner*(
    commit: ptr git_commit
  ): ptr git_repository {.git2Proc, importc.}
  
 

proc git_commit_message_encoding*(
    commit: ptr git_commit
  ): cstring {.git2Proc, importc.}
  
 

proc git_commit_message*(commit: ptr git_commit): cstring {.git2Proc, importc.}
  
 

proc git_commit_message_raw*(
    commit: ptr git_commit
  ): cstring {.git2Proc, importc.}
  
 

proc git_commit_summary*(commit: ptr git_commit): cstring {.git2Proc, importc.}
  
 

proc git_commit_body*(commit: ptr git_commit): cstring {.git2Proc, importc.}
  
 

proc git_commit_time*(commit: ptr git_commit): git_time_t {.git2Proc, importc.}
  
 

proc git_commit_time_offset*(commit: ptr git_commit): cint {.git2Proc, importc.}
  
 

proc git_commit_committer*(
    commit: ptr git_commit
  ): ptr git_signature {.git2Proc, importc.}
  
 

proc git_commit_author*(
    commit: ptr git_commit
  ): ptr git_signature {.git2Proc, importc.}
  
 

proc git_commit_committer_with_mailmap*(
    arg_out: ptr ptr git_signature,
    commit:  ptr git_commit,
    mailmap: ptr git_mailmap
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_author_with_mailmap*(
    arg_out: ptr ptr git_signature,
    commit:  ptr git_commit,
    mailmap: ptr git_mailmap
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_raw_header*(
    commit: ptr git_commit
  ): cstring {.git2Proc, importc.}
  
 

proc git_commit_tree*(
    tree_out: ptr ptr git_tree,
    commit:   ptr git_commit
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_tree_id*(
    commit: ptr git_commit
  ): ptr git_oid {.git2Proc, importc.}
  
 

proc git_commit_parentcount*(
    commit: ptr git_commit
  ): cuint {.git2Proc, importc.}
  
 

proc git_commit_parent*(
    arg_out: ptr ptr git_commit,
    commit:  ptr git_commit,
    n:       cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_parent_id*(
    commit: ptr git_commit,
    n:      cuint
  ): ptr git_oid {.git2Proc, importc.}
  
 

proc git_commit_nth_gen_ancestor*(
    ancestor: ptr ptr git_commit,
    commit:   ptr git_commit,
    n:        cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_header_field*(
    arg_out: ptr git_buf,
    commit:  ptr git_commit,
    field:   cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_extract_signature*(
    signature:   ptr git_buf,
    signed_data: ptr git_buf,
    repo:        ptr git_repository,
    commit_id:   ptr git_oid,
    field:       cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_create*(
    id:               ptr git_oid,
    repo:             ptr git_repository,
    update_ref:       cstring,
    author:           ptr git_signature,
    committer:        ptr git_signature,
    message_encoding: cstring,
    message:          cstring,
    tree:             ptr git_tree,
    parent_count:     csize_t,
    parents:          ptr UncheckedArray[ptr git_commit]
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_create_v*(
    id:               ptr git_oid,
    repo:             ptr git_repository,
    update_ref:       cstring,
    author:           ptr git_signature,
    committer:        ptr git_signature,
    message_encoding: cstring,
    message:          cstring,
    tree:             ptr git_tree,
    parent_count:     csize_t
  ): cint {.git2Proc, importc, varargs.}
  
 

proc git_commit_amend*(
    id:               ptr git_oid,
    commit_to_amend:  ptr git_commit,
    update_ref:       cstring,
    author:           ptr git_signature,
    committer:        ptr git_signature,
    message_encoding: cstring,
    message:          cstring,
    tree:             ptr git_tree
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_create_buffer*(
    arg_out:          ptr git_buf,
    repo:             ptr git_repository,
    author:           ptr git_signature,
    committer:        ptr git_signature,
    message_encoding: cstring,
    message:          cstring,
    tree:             ptr git_tree,
    parent_count:     csize_t,
    parents:          ptr UncheckedArray[ptr git_commit]
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_create_with_signature*(
    arg_out:         ptr git_oid,
    repo:            ptr git_repository,
    commit_content:  cstring,
    signature:       cstring,
    signature_field: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_commit_dup*(
    arg_out: ptr ptr git_commit,
    source:  ptr git_commit
  ): cint {.git2Proc, importc.}
  
 

