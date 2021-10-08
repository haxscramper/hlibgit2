
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_config_entry_free*(a0: ptr git_config_entry): void {.dynlib: libgitDl,
    importc: "git_config_entry_free".}
proc git_config_find_global*(out: ptr git_buf): cint {.dynlib: libgitDl,
    importc: "git_config_find_global".}
proc git_config_find_xdg*(out: ptr git_buf): cint {.dynlib: libgitDl,
    importc: "git_config_find_xdg".}
proc git_config_find_system*(out: ptr git_buf): cint {.dynlib: libgitDl,
    importc: "git_config_find_system".}
proc git_config_find_programdata*(out: ptr git_buf): cint {.dynlib: libgitDl,
    importc: "git_config_find_programdata".}
proc git_config_open_default*(out: ptr ptr git_config): cint {.dynlib: libgitDl,
    importc: "git_config_open_default".}
proc git_config_new*(out: ptr ptr git_config): cint {.dynlib: libgitDl,
    importc: "git_config_new".}
proc git_config_add_file_ondisk*(cfg: ptr git_config; path: cstring;
                                 level: git_config_level_t;
                                 repo: ptr git_repository; force: cint): cint {.
    dynlib: libgitDl, importc: "git_config_add_file_ondisk".}
proc git_config_open_ondisk*(out: ptr ptr git_config; path: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_open_ondisk".}
proc git_config_open_level*(out: ptr ptr git_config; parent: ptr git_config;
                            level: git_config_level_t): cint {.dynlib: libgitDl,
    importc: "git_config_open_level".}
proc git_config_open_global*(out: ptr ptr git_config; config: ptr git_config): cint {.
    dynlib: libgitDl, importc: "git_config_open_global".}
proc git_config_snapshot*(out: ptr ptr git_config; config: ptr git_config): cint {.
    dynlib: libgitDl, importc: "git_config_snapshot".}
proc git_config_free*(cfg: ptr git_config): void {.dynlib: libgitDl,
    importc: "git_config_free".}
proc git_config_get_entry*(out: ptr ptr git_config_entry; cfg: ptr git_config;
                           name: cstring): cint {.dynlib: libgitDl,
    importc: "git_config_get_entry".}
proc git_config_get_int32*(out: ptr int32; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_get_int32".}
proc git_config_get_int64*(out: ptr int64; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_get_int64".}
proc git_config_get_bool*(out: ptr cint; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_get_bool".}
proc git_config_get_path*(out: ptr git_buf; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_get_path".}
proc git_config_get_string*(out: ptr cstring; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_get_string".}
proc git_config_get_string_buf*(out: ptr git_buf; cfg: ptr git_config;
                                name: cstring): cint {.dynlib: libgitDl,
    importc: "git_config_get_string_buf".}
proc git_config_get_multivar_foreach*(cfg: ptr git_config; name: cstring;
                                      regexp: cstring;
                                      callback: git_config_foreach_cb;
                                      payload: pointer): cint {.
    dynlib: libgitDl, importc: "git_config_get_multivar_foreach".}
proc git_config_multivar_iterator_new*(out: ptr ptr git_config_iterator;
                                       cfg: ptr git_config; name: cstring;
                                       regexp: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_multivar_iterator_new".}
proc git_config_next*(entry: ptr ptr git_config_entry;
                      iter: ptr git_config_iterator): cint {.dynlib: libgitDl,
    importc: "git_config_next".}
proc git_config_iterator_free*(iter: ptr git_config_iterator): void {.
    dynlib: libgitDl, importc: "git_config_iterator_free".}
proc git_config_set_int32*(cfg: ptr git_config; name: cstring; value: int32): cint {.
    dynlib: libgitDl, importc: "git_config_set_int32".}
proc git_config_set_int64*(cfg: ptr git_config; name: cstring; value: int64): cint {.
    dynlib: libgitDl, importc: "git_config_set_int64".}
proc git_config_set_bool*(cfg: ptr git_config; name: cstring; value: cint): cint {.
    dynlib: libgitDl, importc: "git_config_set_bool".}
proc git_config_set_string*(cfg: ptr git_config; name: cstring; value: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_set_string".}
proc git_config_set_multivar*(cfg: ptr git_config; name: cstring;
                              regexp: cstring; value: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_set_multivar".}
proc git_config_delete_entry*(cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_delete_entry".}
proc git_config_delete_multivar*(cfg: ptr git_config; name: cstring;
                                 regexp: cstring): cint {.dynlib: libgitDl,
    importc: "git_config_delete_multivar".}
proc git_config_foreach*(cfg: ptr git_config; callback: git_config_foreach_cb;
                         payload: pointer): cint {.dynlib: libgitDl,
    importc: "git_config_foreach".}
proc git_config_iterator_new*(out: ptr ptr git_config_iterator;
                              cfg: ptr git_config): cint {.dynlib: libgitDl,
    importc: "git_config_iterator_new".}
proc git_config_iterator_glob_new*(out: ptr ptr git_config_iterator;
                                   cfg: ptr git_config; regexp: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_iterator_glob_new".}
proc git_config_foreach_match*(cfg: ptr git_config; regexp: cstring;
                               callback: git_config_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc: "git_config_foreach_match".}
proc git_config_get_mapped*(out: ptr cint; cfg: ptr git_config; name: cstring;
                            maps: ptr git_configmap; map_n: size_t): cint {.
    dynlib: libgitDl, importc: "git_config_get_mapped".}
proc git_config_lookup_map_value*(out: ptr cint; maps: ptr git_configmap;
                                  map_n: size_t; value: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_lookup_map_value".}
proc git_config_parse_bool*(out: ptr cint; value: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_parse_bool".}
proc git_config_parse_int32*(out: ptr int32; value: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_parse_int32".}
proc git_config_parse_int64*(out: ptr int64; value: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_parse_int64".}
proc git_config_parse_path*(out: ptr git_buf; value: cstring): cint {.
    dynlib: libgitDl, importc: "git_config_parse_path".}
proc git_config_backend_foreach_match*(backend: ptr git_config_backend;
                                       regexp: cstring;
                                       callback: git_config_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc: "git_config_backend_foreach_match".}
proc git_config_lock*(tx: ptr ptr git_transaction; cfg: ptr git_config): cint {.
    dynlib: libgitDl, importc: "git_config_lock".}