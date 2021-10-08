
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_rebase_options_init*(opts: ptr git_rebase_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_init*(out: ptr ptr git_rebase; repo: ptr git_repository;
                      branch: ptr git_annotated_commit;
                      upstream: ptr git_annotated_commit;
                      onto: ptr git_annotated_commit;
                      opts: ptr git_rebase_options): cint {.dynlib: libgitDl,
    importc.}
proc git_rebase_open*(out: ptr ptr git_rebase; repo: ptr git_repository;
                      opts: ptr git_rebase_options): cint {.dynlib: libgitDl,
    importc.}
proc git_rebase_orig_head_name*(rebase: ptr git_rebase): cstring {.
    dynlib: libgitDl, importc.}
proc git_rebase_orig_head_id*(rebase: ptr git_rebase): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_rebase_onto_name*(rebase: ptr git_rebase): cstring {.dynlib: libgitDl,
    importc.}
proc git_rebase_onto_id*(rebase: ptr git_rebase): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_entrycount*(rebase: ptr git_rebase): size_t {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_current*(rebase: ptr git_rebase): size_t {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_byindex*(rebase: ptr git_rebase; idx: size_t): ptr git_rebase_operation {.
    dynlib: libgitDl, importc.}
proc git_rebase_next*(operation: ptr ptr git_rebase_operation;
                      rebase: ptr git_rebase): cint {.dynlib: libgitDl, importc.}
proc git_rebase_inmemory_index*(index: ptr ptr git_index; rebase: ptr git_rebase): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_commit*(id: ptr git_oid; rebase: ptr git_rebase;
                        author: ptr git_signature; committer: ptr git_signature;
                        message_encoding: cstring; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_abort*(rebase: ptr git_rebase): cint {.dynlib: libgitDl, importc.}
proc git_rebase_finish*(rebase: ptr git_rebase; signature: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_free*(rebase: ptr git_rebase): void {.dynlib: libgitDl, importc.}