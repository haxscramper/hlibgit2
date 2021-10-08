
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_cherrypick_options_init*(opts: ptr git_cherrypick_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_cherrypick_commit*(out: ptr ptr git_index; repo: ptr git_repository;
                            cherrypick_commit: ptr git_commit;
                            our_commit: ptr git_commit; mainline: cuint;
                            merge_options: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_cherrypick*(repo: ptr git_repository; commit: ptr git_commit;
                     cherrypick_options: ptr git_cherrypick_options): cint {.
    dynlib: libgitDl, importc.}