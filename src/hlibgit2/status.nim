import
  ./libgit_config

import
  ./apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r





proc git_status_options_init*(
    opts:    ptr git_status_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_status_foreach*(
    repo:     ptr git_repository,
    callback: git_status_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_status_foreach_ext*(
    repo:     ptr git_repository,
    opts:     ptr git_status_options,
    callback: git_status_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_status_file*(
    status_flags: ptr cuint,
    repo:         ptr git_repository,
    path:         cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_status_list_new*(
    arg_out: ptr ptr git_status_list,
    repo:    ptr git_repository,
    opts:    ptr git_status_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_status_list_entrycount*(
    statuslist: ptr git_status_list
  ): size_t {.dynlib: libgitDl, importc.}


proc git_status_byindex*(
    statuslist: ptr git_status_list,
    idx:        size_t
  ): ptr git_status_entry {.dynlib: libgitDl, importc.}


proc git_status_list_free*(
    statuslist: ptr git_status_list
  ): void {.dynlib: libgitDl, importc.}


proc git_status_should_ignore*(
    ignored: ptr cint,
    repo:    ptr git_repository,
    path:    cstring
  ): cint {.dynlib: libgitDl, importc.}


