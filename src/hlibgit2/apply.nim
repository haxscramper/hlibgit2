
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_apply_options_init*(opts: ptr git_apply_options; version: cuint): cint {.
    dynlib: libgitDl, importc: "git_apply_options_init".}
proc git_apply_to_tree*(out: ptr ptr git_index; repo: ptr git_repository;
                        preimage: ptr git_tree; diff: ptr git_diff;
                        options: ptr git_apply_options): cint {.
    dynlib: libgitDl, importc: "git_apply_to_tree".}
proc git_apply*(repo: ptr git_repository; diff: ptr git_diff;
                location: git_apply_location_t; options: ptr git_apply_options): cint {.
    dynlib: libgitDl, importc: "git_apply".}