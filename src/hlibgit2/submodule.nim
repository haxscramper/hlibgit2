import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

proc git_submodule_update_options_init*(
    opts:    ptr git_submodule_update_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_update*(
    submodule: ptr git_submodule,
    init:      cint,
    options:   ptr git_submodule_update_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_lookup*(
    arg_out: ptr ptr git_submodule,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_free*(
    submodule: ptr git_submodule
  ): void {.dynlib: libgitDl, importc.}


proc git_submodule_foreach*(
    repo:     ptr git_repository,
    callback: git_submodule_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_add_setup*(
    arg_out:     ptr ptr git_submodule,
    repo:        ptr git_repository,
    url:         cstring,
    path:        cstring,
    use_gitlink: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_clone*(
    arg_out:   ptr ptr git_repository,
    submodule: ptr git_submodule,
    opts:      ptr git_submodule_update_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_add_finalize*(
    submodule: ptr git_submodule
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_add_to_index*(
    submodule:   ptr git_submodule,
    write_index: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_owner*(
    submodule: ptr git_submodule
  ): ptr git_repository {.dynlib: libgitDl, importc.}


proc git_submodule_name*(
    submodule: ptr git_submodule
  ): cstring {.dynlib: libgitDl, importc.}


proc git_submodule_path*(
    submodule: ptr git_submodule
  ): cstring {.dynlib: libgitDl, importc.}


proc git_submodule_url*(
    submodule: ptr git_submodule
  ): cstring {.dynlib: libgitDl, importc.}


proc git_submodule_resolve_url*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository,
    url:     cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_branch*(
    submodule: ptr git_submodule
  ): cstring {.dynlib: libgitDl, importc.}


proc git_submodule_set_branch*(
    repo:   ptr git_repository,
    name:   cstring,
    branch: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_set_url*(
    repo: ptr git_repository,
    name: cstring,
    url:  cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_index_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_submodule_head_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_submodule_wd_id*(
    submodule: ptr git_submodule
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_submodule_ignore*(
    submodule: ptr git_submodule
  ): git_submodule_ignore_t {.dynlib: libgitDl, importc.}


proc git_submodule_set_ignore*(
    repo:   ptr git_repository,
    name:   cstring,
    ignore: git_submodule_ignore_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_update_strategy*(
    submodule: ptr git_submodule
  ): git_submodule_update_t {.dynlib: libgitDl, importc.}


proc git_submodule_set_update*(
    repo:   ptr git_repository,
    name:   cstring,
    update: git_submodule_update_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_fetch_recurse_submodules*(
    submodule: ptr git_submodule
  ): git_submodule_recurse_t {.dynlib: libgitDl, importc.}


proc git_submodule_set_fetch_recurse_submodules*(
    repo:                     ptr git_repository,
    name:                     cstring,
    fetch_recurse_submodules: git_submodule_recurse_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_init*(
    submodule: ptr git_submodule,
    overwrite: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_repo_init*(
    arg_out:     ptr ptr git_repository,
    sm:          ptr git_submodule,
    use_gitlink: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_sync*(
    submodule: ptr git_submodule
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_open*(
    repo:      ptr ptr git_repository,
    submodule: ptr git_submodule
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_reload*(
    submodule: ptr git_submodule,
    force:     cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_status*(
    status: ptr cuint,
    repo:   ptr git_repository,
    name:   cstring,
    ignore: git_submodule_ignore_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_submodule_location*(
    location_status: ptr cuint,
    submodule:       ptr git_submodule
  ): cint {.dynlib: libgitDl, importc.}


