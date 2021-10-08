
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_packbuilder_new*(out: ptr ptr git_packbuilder; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_set_threads*(pb: ptr git_packbuilder; n: cuint): cuint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert*(pb: ptr git_packbuilder; id: ptr git_oid;
                             name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_packbuilder_insert_tree*(pb: ptr git_packbuilder; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_commit*(pb: ptr git_packbuilder; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_walk*(pb: ptr git_packbuilder; walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_recur*(pb: ptr git_packbuilder; id: ptr git_oid;
                                   name: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_packbuilder_write_buf*(buf: ptr git_buf; pb: ptr git_packbuilder): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_write*(pb: ptr git_packbuilder; path: cstring; mode: cuint;
                            progress_cb: git_indexer_progress_cb;
                            progress_cb_payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_hash*(pb: ptr git_packbuilder): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_foreach*(pb: ptr git_packbuilder;
                              cb: git_packbuilder_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_object_count*(pb: ptr git_packbuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_written*(pb: ptr git_packbuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_set_callbacks*(pb: ptr git_packbuilder;
                                    progress_cb: git_packbuilder_progress;
                                    progress_cb_payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_free*(pb: ptr git_packbuilder): void {.dynlib: libgitDl,
    importc.}