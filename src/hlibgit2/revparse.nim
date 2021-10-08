
import
  . / config

import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_revparse_single*(arg_out: ptr ptr git_object; repo: ptr git_repository;
                          spec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_revparse_ext*(object_out: ptr ptr git_object;
                       reference_out: ptr ptr git_reference;
                       repo: ptr git_repository; spec: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revparse*(revspec: ptr git_revspec; repo: ptr git_repository;
                   spec: cstring): cint {.dynlib: libgitDl, importc.}