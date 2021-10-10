import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

proc git_odb_new*(arg_out: ptr ptr git_odb): cint {.dynlib: libgitDl, importc.}


proc git_odb_open*(
    arg_out:     ptr ptr git_odb,
    objects_dir: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_add_disk_alternate*(
    odb:  ptr git_odb,
    path: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_free*(db: ptr git_odb): void {.dynlib: libgitDl, importc.}


proc git_odb_read*(
    arg_out: ptr ptr git_odb_object,
    db:      ptr git_odb,
    id:      ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_read_prefix*(
    arg_out:  ptr ptr git_odb_object,
    db:       ptr git_odb,
    short_id: ptr git_oid,
    len:      size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_read_header*(
    len_out:  ptr size_t,
    type_out: ptr git_object_t,
    db:       ptr git_odb,
    id:       ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_exists*(
    db: ptr git_odb,
    id: ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_exists_prefix*(
    arg_out:  ptr git_oid,
    db:       ptr git_odb,
    short_id: ptr git_oid,
    len:      size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_expand_ids*(
    db:    ptr git_odb,
    ids:   ptr git_odb_expand_id,
    count: size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_refresh*(db: ptr git_odb): cint {.dynlib: libgitDl, importc.}


proc git_odb_foreach*(
    db:      ptr git_odb,
    cb:      git_odb_foreach_cb,
    payload: pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_write*(
    arg_out: ptr git_oid,
    odb:     ptr git_odb,
    data:    pointer,
    len:     size_t,
    type_f:  git_object_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_open_wstream*(
    arg_out: ptr ptr git_odb_stream,
    db:      ptr git_odb,
    size:    git_object_size_t,
    type_f:  git_object_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_stream_write*(
    stream: ptr git_odb_stream,
    buffer: cstring,
    len:    size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_stream_finalize_write*(
    arg_out: ptr git_oid,
    stream:  ptr git_odb_stream
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_stream_read*(
    stream: ptr git_odb_stream,
    buffer: cstring,
    len:    size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_stream_free*(
    stream: ptr git_odb_stream
  ): void {.dynlib: libgitDl, importc.}


proc git_odb_open_rstream*(
    arg_out: ptr ptr git_odb_stream,
    len:     ptr size_t,
    type_f:  ptr git_object_t,
    db:      ptr git_odb,
    oid:     ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_write_pack*(
    arg_out:          ptr ptr git_odb_writepack,
    db:               ptr git_odb,
    progress_cb:      git_indexer_progress_cb,
    progress_payload: pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_hash*(
    arg_out: ptr git_oid,
    data:    pointer,
    len:     size_t,
    type_f:  git_object_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_hashfile*(
    arg_out: ptr git_oid,
    path:    cstring,
    type_f:  git_object_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_object_dup*(
    dest:   ptr ptr git_odb_object,
    source: ptr git_odb_object
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_object_free*(
    arg_object: ptr git_odb_object
  ): void {.dynlib: libgitDl, importc.}


proc git_odb_object_id*(
    arg_object: ptr git_odb_object
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_odb_object_data*(
    arg_object: ptr git_odb_object
  ): pointer {.dynlib: libgitDl, importc.}


proc git_odb_object_size*(
    arg_object: ptr git_odb_object
  ): size_t {.dynlib: libgitDl, importc.}


proc git_odb_object_type*(
    arg_object: ptr git_odb_object
  ): git_object_t {.dynlib: libgitDl, importc.}


proc git_odb_add_backend*(
    odb:      ptr git_odb,
    backend:  ptr git_odb_backend,
    priority: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_add_alternate*(
    odb:      ptr git_odb,
    backend:  ptr git_odb_backend,
    priority: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_num_backends*(
    odb: ptr git_odb
  ): size_t {.dynlib: libgitDl, importc.}


proc git_odb_get_backend*(
    arg_out: ptr ptr git_odb_backend,
    odb:     ptr git_odb,
    pos:     size_t
  ): cint {.dynlib: libgitDl, importc.}


