import
  ./libgit_config

import
  ./apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r





proc git_remote_create*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring,
    url:     cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_create_options_init*(
    opts:    ptr git_remote_create_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_create_with_opts*(
    arg_out: ptr ptr git_remote,
    url:     cstring,
    opts:    ptr git_remote_create_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_create_with_fetchspec*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring,
    url:     cstring,
    fetch:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_create_anonymous*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    url:     cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_create_detached*(
    arg_out: ptr ptr git_remote,
    url:     cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_lookup*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_dup*(
    dest:   ptr ptr git_remote,
    source: ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_owner*(
    remote: ptr git_remote
  ): ptr git_repository {.dynlib: libgitDl, importc.}


proc git_remote_name*(
    remote: ptr git_remote
  ): cstring {.dynlib: libgitDl, importc.}


proc git_remote_url*(
    remote: ptr git_remote
  ): cstring {.dynlib: libgitDl, importc.}


proc git_remote_pushurl*(
    remote: ptr git_remote
  ): cstring {.dynlib: libgitDl, importc.}


proc git_remote_set_url*(
    repo:   ptr git_repository,
    remote: cstring,
    url:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_set_pushurl*(
    repo:   ptr git_repository,
    remote: cstring,
    url:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_add_fetch*(
    repo:    ptr git_repository,
    remote:  cstring,
    refspec: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_get_fetch_refspecs*(
    array:  ptr git_strarray,
    remote: ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_add_push*(
    repo:    ptr git_repository,
    remote:  cstring,
    refspec: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_get_push_refspecs*(
    array:  ptr git_strarray,
    remote: ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_refspec_count*(
    remote: ptr git_remote
  ): size_t {.dynlib: libgitDl, importc.}


proc git_remote_get_refspec*(
    remote: ptr git_remote,
    n:      size_t
  ): ptr git_refspec {.dynlib: libgitDl, importc.}


proc git_remote_connect*(
    remote:         ptr git_remote,
    direction:      git_direction,
    callbacks:      ptr git_remote_callbacks,
    proxy_opts:     ptr git_proxy_options,
    custom_headers: ptr git_strarray
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_ls*(
    arg_out: ptr ptr ptr git_remote_head,
    size:    ptr size_t,
    remote:  ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_connected*(
    remote: ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_stop*(
    remote: ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_disconnect*(
    remote: ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_free*(
    remote: ptr git_remote
  ): void {.dynlib: libgitDl, importc.}


proc git_remote_list*(
    arg_out: ptr git_strarray,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_init_callbacks*(
    opts:    ptr git_remote_callbacks,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_fetch_options_init*(
    opts:    ptr git_fetch_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_push_options_init*(
    opts:    ptr git_push_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_download*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_fetch_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_upload*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_push_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_update_tips*(
    remote:           ptr git_remote,
    callbacks:        ptr git_remote_callbacks,
    update_fetchhead: cint,
    download_tags:    git_remote_autotag_option_t,
    reflog_message:   cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_fetch*(
    remote:         ptr git_remote,
    refspecs:       ptr git_strarray,
    opts:           ptr git_fetch_options,
    reflog_message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_prune*(
    remote:    ptr git_remote,
    callbacks: ptr git_remote_callbacks
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_push*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_push_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_stats*(
    remote: ptr git_remote
  ): ptr git_indexer_progress {.dynlib: libgitDl, importc.}


proc git_remote_autotag*(
    remote: ptr git_remote
  ): git_remote_autotag_option_t {.dynlib: libgitDl, importc.}


proc git_remote_set_autotag*(
    repo:   ptr git_repository,
    remote: cstring,
    value:  git_remote_autotag_option_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_prune_refs*(
    remote: ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_rename*(
    problems: ptr git_strarray,
    repo:     ptr git_repository,
    name:     cstring,
    new_name: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_is_valid_name*(
    remote_name: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_delete*(
    repo: ptr git_repository,
    name: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_remote_default_branch*(
    arg_out: ptr git_buf,
    remote:  ptr git_remote
  ): cint {.dynlib: libgitDl, importc.}


