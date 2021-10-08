
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_blob_lookup*(blob: ptr ptr git_blob; repo: ptr git_repository;
                      id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_blob_lookup_prefix*(blob: ptr ptr git_blob; repo: ptr git_repository;
                             id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_free*(blob: ptr git_blob): void {.dynlib: libgitDl, importc.}
proc git_blob_id*(blob: ptr git_blob): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_blob_owner*(blob: ptr git_blob): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_blob_rawcontent*(blob: ptr git_blob): pointer {.dynlib: libgitDl,
    importc.}
proc git_blob_rawsize*(blob: ptr git_blob): git_object_size_t {.
    dynlib: libgitDl, importc.}
proc git_blob_filter_options_init*(opts: ptr git_blob_filter_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_blob_filter*(out: ptr git_buf; blob: ptr git_blob; as_path: cstring;
                      opts: ptr git_blob_filter_options): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_workdir*(id: ptr git_oid; repo: ptr git_repository;
                                   relative_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_disk*(id: ptr git_oid; repo: ptr git_repository;
                                path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_from_stream*(out: ptr ptr git_writestream;
                                  repo: ptr git_repository; hintpath: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_stream_commit*(out: ptr git_oid;
    stream: ptr git_writestream): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_from_buffer*(id: ptr git_oid; repo: ptr git_repository;
                                  buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_is_binary*(blob: ptr git_blob): cint {.dynlib: libgitDl, importc.}
proc git_blob_dup*(out: ptr ptr git_blob; source: ptr git_blob): cint {.
    dynlib: libgitDl, importc.}