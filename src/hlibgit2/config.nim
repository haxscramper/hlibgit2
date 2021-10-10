import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

type
  git_config_iterator* {.bycopy, incompleteStruct, importc.} = object
    
   

proc git_config_entry_free*(
    a0: ptr git_config_entry
  ): void {.dynlib: libgitDl, importc.}


proc git_config_find_global*(
    arg_out: ptr git_buf
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_find_xdg*(
    arg_out: ptr git_buf
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_find_system*(
    arg_out: ptr git_buf
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_find_programdata*(
    arg_out: ptr git_buf
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_open_default*(
    arg_out: ptr ptr git_config
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_new*(
    arg_out: ptr ptr git_config
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_add_file_ondisk*(
    cfg:   ptr git_config,
    path:  cstring,
    level: git_config_level_t,
    repo:  ptr git_repository,
    force: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_open_ondisk*(
    arg_out: ptr ptr git_config,
    path:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_open_level*(
    arg_out: ptr ptr git_config,
    parent:  ptr git_config,
    level:   git_config_level_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_open_global*(
    arg_out: ptr ptr git_config,
    config:  ptr git_config
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_snapshot*(
    arg_out: ptr ptr git_config,
    config:  ptr git_config
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_free*(cfg: ptr git_config): void {.dynlib: libgitDl, importc.}


proc git_config_get_entry*(
    arg_out: ptr ptr git_config_entry,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_get_int32*(
    arg_out: ptr int32,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_get_int64*(
    arg_out: ptr int64,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_get_bool*(
    arg_out: ptr cint,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_get_path*(
    arg_out: ptr git_buf,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_get_string*(
    arg_out: ptr cstring,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_get_string_buf*(
    arg_out: ptr git_buf,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_get_multivar_foreach*(
    cfg:      ptr git_config,
    name:     cstring,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_multivar_iterator_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config,
    name:    cstring,
    regexp:  cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_next*(
    entry: ptr ptr git_config_entry,
    iter:  ptr git_config_iterator
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_iterator_free*(
    iter: ptr git_config_iterator
  ): void {.dynlib: libgitDl, importc.}


proc git_config_set_int32*(
    cfg:   ptr git_config,
    name:  cstring,
    value: int32
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_set_int64*(
    cfg:   ptr git_config,
    name:  cstring,
    value: int64
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_set_bool*(
    cfg:   ptr git_config,
    name:  cstring,
    value: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_set_string*(
    cfg:   ptr git_config,
    name:  cstring,
    value: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_set_multivar*(
    cfg:    ptr git_config,
    name:   cstring,
    regexp: cstring,
    value:  cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_delete_entry*(
    cfg:  ptr git_config,
    name: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_delete_multivar*(
    cfg:    ptr git_config,
    name:   cstring,
    regexp: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_foreach*(
    cfg:      ptr git_config,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_iterator_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_iterator_glob_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config,
    regexp:  cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_foreach_match*(
    cfg:      ptr git_config,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_get_mapped*(
    arg_out: ptr cint,
    cfg:     ptr git_config,
    name:    cstring,
    maps:    ptr git_configmap,
    map_n:   size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_lookup_map_value*(
    arg_out: ptr cint,
    maps:    ptr git_configmap,
    map_n:   size_t,
    value:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_parse_bool*(
    arg_out: ptr cint,
    value:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_parse_int32*(
    arg_out: ptr int32,
    value:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_parse_int64*(
    arg_out: ptr int64,
    value:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_parse_path*(
    arg_out: ptr git_buf,
    value:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_backend_foreach_match*(
    backend:  ptr git_config_backend,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_config_lock*(
    tx:  ptr ptr git_transaction,
    cfg: ptr git_config
  ): cint {.dynlib: libgitDl, importc.}


