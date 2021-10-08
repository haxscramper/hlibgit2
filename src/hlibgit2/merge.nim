
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_merge_file_input_init*(opts: ptr git_merge_file_input; version: cuint): cint {.
    dynlib: libgitDl, importc: "git_merge_file_input_init".}
proc git_merge_file_options_init*(opts: ptr git_merge_file_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc: "git_merge_file_options_init".}
proc git_merge_options_init*(opts: ptr git_merge_options; version: cuint): cint {.
    dynlib: libgitDl, importc: "git_merge_options_init".}
proc git_merge_analysis*(analysis_out: ptr git_merge_analysis_t;
                         preference_out: ptr git_merge_preference_t;
                         repo: ptr git_repository;
                         their_heads: ptr ptr git_annotated_commit;
                         their_heads_len: size_t): cint {.dynlib: libgitDl,
    importc: "git_merge_analysis".}
proc git_merge_analysis_for_ref*(analysis_out: ptr git_merge_analysis_t;
                                 preference_out: ptr git_merge_preference_t;
                                 repo: ptr git_repository;
                                 our_ref: ptr git_reference;
                                 their_heads: ptr ptr git_annotated_commit;
                                 their_heads_len: size_t): cint {.
    dynlib: libgitDl, importc: "git_merge_analysis_for_ref".}
proc git_merge_base*(out: ptr git_oid; repo: ptr git_repository;
                     one: ptr git_oid; two: ptr git_oid): cint {.
    dynlib: libgitDl, importc: "git_merge_base".}
proc git_merge_bases*(out: ptr git_oidarray; repo: ptr git_repository;
                      one: ptr git_oid; two: ptr git_oid): cint {.
    dynlib: libgitDl, importc: "git_merge_bases".}
proc git_merge_base_many*(out: ptr git_oid; repo: ptr git_repository;
                          length: size_t;
                          input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc: "git_merge_base_many".}
proc git_merge_bases_many*(out: ptr git_oidarray; repo: ptr git_repository;
                           length: size_t;
                           input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc: "git_merge_bases_many".}
proc git_merge_base_octopus*(out: ptr git_oid; repo: ptr git_repository;
                             length: size_t;
                             input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc: "git_merge_base_octopus".}
proc git_merge_file*(out: ptr git_merge_file_result;
                     ancestor: ptr git_merge_file_input;
                     ours: ptr git_merge_file_input;
                     theirs: ptr git_merge_file_input;
                     opts: ptr git_merge_file_options): cint {.dynlib: libgitDl,
    importc: "git_merge_file".}
proc git_merge_file_from_index*(out: ptr git_merge_file_result;
                                repo: ptr git_repository;
                                ancestor: ptr git_index_entry;
                                ours: ptr git_index_entry;
                                theirs: ptr git_index_entry;
                                opts: ptr git_merge_file_options): cint {.
    dynlib: libgitDl, importc: "git_merge_file_from_index".}
proc git_merge_file_result_free*(result: ptr git_merge_file_result): void {.
    dynlib: libgitDl, importc: "git_merge_file_result_free".}
proc git_merge_trees*(out: ptr ptr git_index; repo: ptr git_repository;
                      ancestor_tree: ptr git_tree; our_tree: ptr git_tree;
                      their_tree: ptr git_tree; opts: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc: "git_merge_trees".}
proc git_merge_commits*(out: ptr ptr git_index; repo: ptr git_repository;
                        our_commit: ptr git_commit;
                        their_commit: ptr git_commit;
                        opts: ptr git_merge_options): cint {.dynlib: libgitDl,
    importc: "git_merge_commits".}
proc git_merge*(repo: ptr git_repository;
                their_heads: ptr ptr git_annotated_commit;
                their_heads_len: size_t; merge_opts: ptr git_merge_options;
                checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc: "git_merge".}