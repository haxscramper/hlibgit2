
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_reference_lookup*(out: ptr ptr git_reference; repo: ptr git_repository;
                           name: cstring): cint {.dynlib: libgitDl,
    importc: "git_reference_lookup".}
proc git_reference_name_to_id*(out: ptr git_oid; repo: ptr git_repository;
                               name: cstring): cint {.dynlib: libgitDl,
    importc: "git_reference_name_to_id".}
proc git_reference_dwim*(out: ptr ptr git_reference; repo: ptr git_repository;
                         shorthand: cstring): cint {.dynlib: libgitDl,
    importc: "git_reference_dwim".}
proc git_reference_symbolic_create_matching*(out: ptr ptr git_reference;
    repo: ptr git_repository; name: cstring; target: cstring; force: cint;
    current_value: cstring; log_message: cstring): cint {.dynlib: libgitDl,
    importc: "git_reference_symbolic_create_matching".}
proc git_reference_symbolic_create*(out: ptr ptr git_reference;
                                    repo: ptr git_repository; name: cstring;
                                    target: cstring; force: cint;
                                    log_message: cstring): cint {.
    dynlib: libgitDl, importc: "git_reference_symbolic_create".}
proc git_reference_create*(out: ptr ptr git_reference; repo: ptr git_repository;
                           name: cstring; id: ptr git_oid; force: cint;
                           log_message: cstring): cint {.dynlib: libgitDl,
    importc: "git_reference_create".}
proc git_reference_create_matching*(out: ptr ptr git_reference;
                                    repo: ptr git_repository; name: cstring;
                                    id: ptr git_oid; force: cint;
                                    current_id: ptr git_oid;
                                    log_message: cstring): cint {.
    dynlib: libgitDl, importc: "git_reference_create_matching".}
proc git_reference_target*(ref: ptr git_reference): ptr git_oid {.
    dynlib: libgitDl, importc: "git_reference_target".}
proc git_reference_target_peel*(ref: ptr git_reference): ptr git_oid {.
    dynlib: libgitDl, importc: "git_reference_target_peel".}
proc git_reference_symbolic_target*(ref: ptr git_reference): cstring {.
    dynlib: libgitDl, importc: "git_reference_symbolic_target".}
proc git_reference_type*(ref: ptr git_reference): git_reference_t {.
    dynlib: libgitDl, importc: "git_reference_type".}
proc git_reference_name*(ref: ptr git_reference): cstring {.dynlib: libgitDl,
    importc: "git_reference_name".}
proc git_reference_resolve*(out: ptr ptr git_reference; ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc: "git_reference_resolve".}
proc git_reference_owner*(ref: ptr git_reference): ptr git_repository {.
    dynlib: libgitDl, importc: "git_reference_owner".}
proc git_reference_symbolic_set_target*(out: ptr ptr git_reference;
                                        ref: ptr git_reference; target: cstring;
                                        log_message: cstring): cint {.
    dynlib: libgitDl, importc: "git_reference_symbolic_set_target".}
proc git_reference_set_target*(out: ptr ptr git_reference;
                               ref: ptr git_reference; id: ptr git_oid;
                               log_message: cstring): cint {.dynlib: libgitDl,
    importc: "git_reference_set_target".}
proc git_reference_rename*(new_ref: ptr ptr git_reference;
                           ref: ptr git_reference; new_name: cstring;
                           force: cint; log_message: cstring): cint {.
    dynlib: libgitDl, importc: "git_reference_rename".}
proc git_reference_delete*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc: "git_reference_delete".}
proc git_reference_remove*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc: "git_reference_remove".}
proc git_reference_list*(array: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc: "git_reference_list".}
proc git_reference_foreach*(repo: ptr git_repository;
                            callback: git_reference_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc: "git_reference_foreach".}
proc git_reference_foreach_name*(repo: ptr git_repository;
                                 callback: git_reference_foreach_name_cb;
                                 payload: pointer): cint {.dynlib: libgitDl,
    importc: "git_reference_foreach_name".}
proc git_reference_dup*(dest: ptr ptr git_reference; source: ptr git_reference): cint {.
    dynlib: libgitDl, importc: "git_reference_dup".}
proc git_reference_free*(ref: ptr git_reference): void {.dynlib: libgitDl,
    importc: "git_reference_free".}
proc git_reference_cmp*(ref1: ptr git_reference; ref2: ptr git_reference): cint {.
    dynlib: libgitDl, importc: "git_reference_cmp".}
proc git_reference_iterator_new*(out: ptr ptr git_reference_iterator;
                                 repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc: "git_reference_iterator_new".}
proc git_reference_iterator_glob_new*(out: ptr ptr git_reference_iterator;
                                      repo: ptr git_repository; glob: cstring): cint {.
    dynlib: libgitDl, importc: "git_reference_iterator_glob_new".}
proc git_reference_next*(out: ptr ptr git_reference;
                         iter: ptr git_reference_iterator): cint {.
    dynlib: libgitDl, importc: "git_reference_next".}
proc git_reference_next_name*(out: ptr cstring; iter: ptr git_reference_iterator): cint {.
    dynlib: libgitDl, importc: "git_reference_next_name".}
proc git_reference_iterator_free*(iter: ptr git_reference_iterator): void {.
    dynlib: libgitDl, importc: "git_reference_iterator_free".}
proc git_reference_foreach_glob*(repo: ptr git_repository; glob: cstring;
                                 callback: git_reference_foreach_name_cb;
                                 payload: pointer): cint {.dynlib: libgitDl,
    importc: "git_reference_foreach_glob".}
proc git_reference_has_log*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc: "git_reference_has_log".}
proc git_reference_ensure_log*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc: "git_reference_ensure_log".}
proc git_reference_is_branch*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc: "git_reference_is_branch".}
proc git_reference_is_remote*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc: "git_reference_is_remote".}
proc git_reference_is_tag*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc: "git_reference_is_tag".}
proc git_reference_is_note*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc: "git_reference_is_note".}
proc git_reference_normalize_name*(buffer_out: cstring; buffer_size: size_t;
                                   name: cstring; flags: cuint): cint {.
    dynlib: libgitDl, importc: "git_reference_normalize_name".}
proc git_reference_peel*(out: ptr ptr git_object; ref: ptr git_reference;
                         type: git_object_t): cint {.dynlib: libgitDl,
    importc: "git_reference_peel".}
proc git_reference_is_valid_name*(refname: cstring): cint {.dynlib: libgitDl,
    importc: "git_reference_is_valid_name".}
proc git_reference_shorthand*(ref: ptr git_reference): cstring {.
    dynlib: libgitDl, importc: "git_reference_shorthand".}