import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

type
  git_oid_shorten* {.bycopy, incompleteStruct, importc.} = object
    
   

proc git_oid_fromstr*(
    arg_out: ptr git_oid,
    str:     cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_fromstrp*(
    arg_out: ptr git_oid,
    str:     cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_fromstrn*(
    arg_out: ptr git_oid,
    str:     cstring,
    length:  size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_fromraw*(
    arg_out: ptr git_oid,
    raw:     ptr uchar
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_fmt*(
    arg_out: cstring,
    id:      ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_nfmt*(
    arg_out: cstring,
    n:       size_t,
    id:      ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_pathfmt*(
    arg_out: cstring,
    id:      ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_tostr_s*(oid: ptr git_oid): cstring {.dynlib: libgitDl, importc.}


proc git_oid_tostr*(
    arg_out: cstring,
    n:       size_t,
    id:      ptr git_oid
  ): cstring {.dynlib: libgitDl, importc.}


proc git_oid_cpy*(
    arg_out: ptr git_oid,
    src:     ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_cmp*(
    a: ptr git_oid,
    b: ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_equal*(
    a: ptr git_oid,
    b: ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_ncmp*(
    a:   ptr git_oid,
    b:   ptr git_oid,
    len: size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_streq*(
    id:  ptr git_oid,
    str: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_strcmp*(
    id:  ptr git_oid,
    str: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_is_zero*(id: ptr git_oid): cint {.dynlib: libgitDl, importc.}


proc git_oid_shorten_new*(
    min_length: size_t
  ): ptr git_oid_shorten {.dynlib: libgitDl, importc.}


proc git_oid_shorten_add*(
    os:      ptr git_oid_shorten,
    text_id: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_oid_shorten_free*(
    os: ptr git_oid_shorten
  ): void {.dynlib: libgitDl, importc.}


