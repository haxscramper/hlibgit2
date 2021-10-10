import
  ./libgit_config

import
  ./apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r





proc git_worktree_list*(
    arg_out: ptr git_strarray,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_lookup*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_open_from_repository*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_free*(
    wt: ptr git_worktree
  ): void {.dynlib: libgitDl, importc.}


proc git_worktree_validate*(
    wt: ptr git_worktree
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_add_options_init*(
    opts:    ptr git_worktree_add_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_add*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository,
    name:    cstring,
    path:    cstring,
    opts:    ptr git_worktree_add_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_lock*(
    wt:     ptr git_worktree,
    reason: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_unlock*(
    wt: ptr git_worktree
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_is_locked*(
    reason: ptr git_buf,
    wt:     ptr git_worktree
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_name*(
    wt: ptr git_worktree
  ): cstring {.dynlib: libgitDl, importc.}


proc git_worktree_path*(
    wt: ptr git_worktree
  ): cstring {.dynlib: libgitDl, importc.}


proc git_worktree_prune_options_init*(
    opts:    ptr git_worktree_prune_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_is_prunable*(
    wt:   ptr git_worktree,
    opts: ptr git_worktree_prune_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_worktree_prune*(
    wt:   ptr git_worktree,
    opts: ptr git_worktree_prune_options
  ): cint {.dynlib: libgitDl, importc.}


