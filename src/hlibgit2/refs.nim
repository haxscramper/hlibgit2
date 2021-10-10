import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

proc git_reference_lookup*(
    arg_out: ptr ptr git_reference,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_name_to_id*(
    arg_out: ptr git_oid,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_dwim*(
    arg_out:   ptr ptr git_reference,
    repo:      ptr git_repository,
    shorthand: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_symbolic_create_matching*(
    arg_out:       ptr ptr git_reference,
    repo:          ptr git_repository,
    name:          cstring,
    target:        cstring,
    force:         cint,
    current_value: cstring,
    log_message:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_symbolic_create*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    target:      cstring,
    force:       cint,
    log_message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_create*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    id:          ptr git_oid,
    force:       cint,
    log_message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_create_matching*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    id:          ptr git_oid,
    force:       cint,
    current_id:  ptr git_oid,
    log_message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_target*(
    arg_ref: ptr git_reference
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_reference_target_peel*(
    arg_ref: ptr git_reference
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_reference_symbolic_target*(
    arg_ref: ptr git_reference
  ): cstring {.dynlib: libgitDl, importc.}


proc git_reference_type*(
    arg_ref: ptr git_reference
  ): git_reference_t {.dynlib: libgitDl, importc.}


proc git_reference_name*(
    arg_ref: ptr git_reference
  ): cstring {.dynlib: libgitDl, importc.}


proc git_reference_resolve*(
    arg_out: ptr ptr git_reference,
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_owner*(
    arg_ref: ptr git_reference
  ): ptr git_repository {.dynlib: libgitDl, importc.}


proc git_reference_symbolic_set_target*(
    arg_out:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    target:      cstring,
    log_message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_set_target*(
    arg_out:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    id:          ptr git_oid,
    log_message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_rename*(
    new_ref:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    new_name:    cstring,
    force:       cint,
    log_message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_delete*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_remove*(
    repo: ptr git_repository,
    name: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_list*(
    array: ptr git_strarray,
    repo:  ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_foreach*(
    repo:     ptr git_repository,
    callback: git_reference_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_foreach_name*(
    repo:     ptr git_repository,
    callback: git_reference_foreach_name_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_dup*(
    dest:   ptr ptr git_reference,
    source: ptr git_reference
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_free*(
    arg_ref: ptr git_reference
  ): void {.dynlib: libgitDl, importc.}


proc git_reference_cmp*(
    ref1: ptr git_reference,
    ref2: ptr git_reference
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_iterator_new*(
    arg_out: ptr ptr git_reference_iterator,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_iterator_glob_new*(
    arg_out: ptr ptr git_reference_iterator,
    repo:    ptr git_repository,
    glob:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_next*(
    arg_out: ptr ptr git_reference,
    iter:    ptr git_reference_iterator
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_next_name*(
    arg_out: ptr cstring,
    iter:    ptr git_reference_iterator
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_iterator_free*(
    iter: ptr git_reference_iterator
  ): void {.dynlib: libgitDl, importc.}


proc git_reference_foreach_glob*(
    repo:     ptr git_repository,
    glob:     cstring,
    callback: git_reference_foreach_name_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_has_log*(
    repo:    ptr git_repository,
    refname: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_ensure_log*(
    repo:    ptr git_repository,
    refname: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_is_branch*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_is_remote*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_is_tag*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_is_note*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_normalize_name*(
    buffer_out:  cstring,
    buffer_size: size_t,
    name:        cstring,
    flags:       cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_peel*(
    arg_out:  ptr ptr git_object,
    arg_ref:  ptr git_reference,
    arg_type: git_object_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_is_valid_name*(
    refname: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_reference_shorthand*(
    arg_ref: ptr git_reference
  ): cstring {.dynlib: libgitDl, importc.}


