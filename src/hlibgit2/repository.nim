
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_repository_open*(out: ptr ptr git_repository; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_from_worktree*(out: ptr ptr git_repository;
                                        wt: ptr git_worktree): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_wrap_odb*(out: ptr ptr git_repository; odb: ptr git_odb): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_discover*(out: ptr git_buf; start_path: cstring;
                              across_fs: cint; ceiling_dirs: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_ext*(out: ptr ptr git_repository; path: cstring;
                              flags: cuint; ceiling_dirs: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_bare*(out: ptr ptr git_repository; bare_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_free*(repo: ptr git_repository): void {.dynlib: libgitDl,
    importc.}
proc git_repository_init*(out: ptr ptr git_repository; path: cstring;
                          is_bare: cuint): cint {.dynlib: libgitDl, importc.}
proc git_repository_init_options_init*(opts: ptr git_repository_init_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_init_ext*(out: ptr ptr git_repository; repo_path: cstring;
                              opts: ptr git_repository_init_options): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head*(out: ptr ptr git_reference; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_for_worktree*(out: ptr ptr git_reference;
                                       repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_detached*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_detached_for_worktree*(repo: ptr git_repository;
    name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_repository_head_unborn*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_is_empty*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_item_path*(out: ptr git_buf; repo: ptr git_repository;
                               item: git_repository_item_t): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_path*(repo: ptr git_repository): cstring {.dynlib: libgitDl,
    importc.}
proc git_repository_workdir*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_commondir*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_set_workdir*(repo: ptr git_repository; workdir: cstring;
                                 update_gitlink: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_is_bare*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_is_worktree*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_config*(out: ptr ptr git_config; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_config_snapshot*(out: ptr ptr git_config;
                                     repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_odb*(out: ptr ptr git_odb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_refdb*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_index*(out: ptr ptr git_index; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_message*(out: ptr git_buf; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_message_remove*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_state_cleanup*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_fetchhead_foreach*(repo: ptr git_repository; callback: git_repository_fetchhead_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_mergehead_foreach*(repo: ptr git_repository; callback: git_repository_mergehead_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_hashfile*(out: ptr git_oid; repo: ptr git_repository;
                              path: cstring; type: git_object_t;
                              as_path: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_head*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_set_head_detached*(repo: ptr git_repository;
                                       commitish: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_set_head_detached_from_annotated*(repo: ptr git_repository;
    commitish: ptr git_annotated_commit): cint {.dynlib: libgitDl, importc.}
proc git_repository_detach_head*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_state*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_namespace*(repo: ptr git_repository; nmspace: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_get_namespace*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_is_shallow*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_ident*(name: ptr cstring; email: ptr cstring;
                           repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_ident*(repo: ptr git_repository; name: cstring;
                               email: cstring): cint {.dynlib: libgitDl, importc.}