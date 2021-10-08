
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_reset*(repo: ptr git_repository; target: ptr git_object;
                reset_type: git_reset_t; checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_reset_from_annotated*(repo: ptr git_repository;
                               commit: ptr git_annotated_commit;
                               reset_type: git_reset_t;
                               checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_reset_default*(repo: ptr git_repository; target: ptr git_object;
                        pathspecs: ptr git_strarray): cint {.dynlib: libgitDl,
    importc.}