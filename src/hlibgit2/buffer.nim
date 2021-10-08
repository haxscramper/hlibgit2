
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_buf_dispose*(buffer: ptr git_buf): void {.dynlib: libgitDl,
    importc: "git_buf_dispose".}
proc git_buf_grow*(buffer: ptr git_buf; target_size: size_t): cint {.
    dynlib: libgitDl, importc: "git_buf_grow".}
proc git_buf_set*(buffer: ptr git_buf; data: pointer; datalen: size_t): cint {.
    dynlib: libgitDl, importc: "git_buf_set".}
proc git_buf_is_binary*(buf: ptr git_buf): cint {.dynlib: libgitDl,
    importc: "git_buf_is_binary".}
proc git_buf_contains_nul*(buf: ptr git_buf): cint {.dynlib: libgitDl,
    importc: "git_buf_contains_nul".}