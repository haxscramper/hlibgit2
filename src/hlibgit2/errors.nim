
import
  . / config

import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_error_last*(a0: void): ptr git_error {.dynlib: libgitDl, importc.}
proc git_error_clear*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_error_set_str*(error_class: cint; arg_string: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_error_set_oom*(a0: void): void {.dynlib: libgitDl, importc.}