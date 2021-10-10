import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

proc git_stash_save*(
    arg_out: ptr git_oid,
    repo:    ptr git_repository,
    stasher: ptr git_signature,
    message: cstring,
    flags:   uint32
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_apply_options_init*(
    opts:    ptr git_stash_apply_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_apply*(
    repo:    ptr git_repository,
    index:   size_t,
    options: ptr git_stash_apply_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_foreach*(
    repo:     ptr git_repository,
    callback: git_stash_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_drop*(
    repo:  ptr git_repository,
    index: size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_stash_pop*(
    repo:    ptr git_repository,
    index:   size_t,
    options: ptr git_stash_apply_options
  ): cint {.dynlib: libgitDl, importc.}


