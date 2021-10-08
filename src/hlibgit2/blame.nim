
import
  . / config

import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_blame_options_init*(opts: ptr git_blame_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_get_hunk_count*(blame: ptr git_blame): uint32 {.dynlib: libgitDl,
    importc.}
proc git_blame_get_hunk_byindex*(blame: ptr git_blame; index: uint32): ptr git_blame_hunk {.
    dynlib: libgitDl, importc.}
proc git_blame_get_hunk_byline*(blame: ptr git_blame; lineno: size_t): ptr git_blame_hunk {.
    dynlib: libgitDl, importc.}
proc git_blame_file*(arg_out: ptr ptr git_blame; repo: ptr git_repository;
                     path: cstring; options: ptr git_blame_options): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_buffer*(arg_out: ptr ptr git_blame; reference: ptr git_blame;
                       buffer: cstring; buffer_len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_free*(blame: ptr git_blame): void {.dynlib: libgitDl, importc.}