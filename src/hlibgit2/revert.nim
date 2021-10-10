import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

proc git_revert_options_init*(
    opts:    ptr git_revert_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_revert_commit*(
    arg_out:       ptr ptr git_index,
    repo:          ptr git_repository,
    revert_commit: ptr git_commit,
    our_commit:    ptr git_commit,
    mainline:      cuint,
    merge_options: ptr git_merge_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_revert*(
    repo:       ptr git_repository,
    commit:     ptr git_commit,
    given_opts: ptr git_revert_options
  ): cint {.dynlib: libgitDl, importc.}


