
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_indexer_options_init*(opts: ptr git_indexer_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_new*(out: ptr ptr git_indexer; path: cstring; mode: cuint;
                      odb: ptr git_odb; opts: ptr git_indexer_options): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_append*(idx: ptr git_indexer; data: pointer; size: size_t;
                         stats: ptr git_indexer_progress): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_commit*(idx: ptr git_indexer; stats: ptr git_indexer_progress): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_hash*(idx: ptr git_indexer): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_indexer_free*(idx: ptr git_indexer): void {.dynlib: libgitDl, importc.}