
import
  . / config

import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_attr_value*(attr: cstring): git_attr_value_t {.dynlib: libgitDl,
    importc.}
proc git_attr_get*(value_out: ptr cstring; repo: ptr git_repository;
                   flags: uint32; path: cstring; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_get_many*(values_out: ptr cstring; repo: ptr git_repository;
                        flags: uint32; path: cstring; num_attr: size_t;
                        names: ptr cstring): cint {.dynlib: libgitDl, importc.}
proc git_attr_foreach*(repo: ptr git_repository; flags: uint32; path: cstring;
                       callback: git_attr_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_cache_flush*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_attr_add_macro*(repo: ptr git_repository; name: cstring;
                         values: cstring): cint {.dynlib: libgitDl, importc.}