import
  ./libgit_config

import
  ./apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r





proc git_odb_backend_pack*(
    arg_out:     ptr ptr git_odb_backend,
    objects_dir: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_backend_loose*(
    arg_out:           ptr ptr git_odb_backend,
    objects_dir:       cstring,
    compression_level: cint,
    do_fsync:          cint,
    dir_mode:          cuint,
    file_mode:         cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_odb_backend_one_pack*(
    arg_out:    ptr ptr git_odb_backend,
    index_file: cstring
  ): cint {.dynlib: libgitDl, importc.}


