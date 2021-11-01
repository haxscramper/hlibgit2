{.push warning[UnusedImport]:off.}

import
  ./attr,
  ./blame,
  ./buffer,
  ./checkout,
  ./cherrypick,
  ./clone,
  ./config,
  ./credential,
  ./credential_helpers,
  ./describe,
  ./diff,
  ./errors,
  ./filter,
  ./index,
  ./indexer,
  ./libgit2_config,
  ./merge,
  ./net,
  ./oid,
  ./proxy,
  ./rebase,
  ./remote,
  ./repository,
  ./revert,
  ./revparse,
  ./stash,
  ./status,
  ./strarray,
  ./submodule,
  ./trace,
  ./types,
  ./worktree

type
  git_attr_t* = c_git_attr_value_t
   
  git_commit_signing_cb* = proc(signature: ptr git_buf, signature_field: ptr git_buf, commit_content: cstring, payload: pointer): cint{.cdecl.}
   
  git_commit_signing_cbNim* = proc(signature: ptr git_buf, signature_field: ptr git_buf, commit_content: cstring): cint
   
  git_cred* = git_credential
   
  git_cred_acquire_cb* = git_credential_acquire_cb
   
  git_cred_default* = git_credential_default
   
  git_cred_sign_callback* = git_credential_sign_cb
   
  git_cred_sign_cb* = git_credential_sign_cb
   
  git_cred_ssh_custom* = git_credential_ssh_custom
   
  git_cred_ssh_interactive* = git_credential_ssh_interactive
   
  git_cred_ssh_interactive_callback* = git_credential_ssh_interactive_cb
   
  git_cred_ssh_interactive_cb* = git_credential_ssh_interactive_cb
   
  git_cred_ssh_key* = git_credential_ssh_key
   
  git_cred_username* = git_credential_username
   
  git_cred_userpass_payload* = git_credential_userpass_payload
   
  git_cred_userpass_plaintext* = git_credential_userpass_plaintext
   
  git_cvar_map* = git_configmap
   
  git_headlist_cb* = proc(rhead: ptr git_remote_head, payload: pointer): cint{.cdecl.}
   
  git_headlist_cbNim* = proc(rhead: ptr git_remote_head): cint
   
  git_push_transfer_progress* = git_push_transfer_progress_cb
   
  git_revparse_mode_t* = c_git_revspec_t
   
  git_trace_callback* = git_trace_cb
   
  git_transfer_progress* = git_indexer_progress
   
  git_transfer_progress_cb* = git_indexer_progress_cb
   

proc git_blob_create_fromworkdir1*(
    id:            ptr git_oid,
    repo:          ptr git_repository,
    relative_path: cstring
  ): cint {.git2Proc, importc: "git_blob_create_fromworkdir".}
  
 

proc git_blob_create_fromdisk1*(
    id:   ptr git_oid,
    repo: ptr git_repository,
    path: cstring
  ): cint {.git2Proc, importc: "git_blob_create_fromdisk".}
  
 

proc git_blob_create_fromstream1*(
    arg_out:  ptr ptr git_writestream,
    repo:     ptr git_repository,
    hintpath: cstring
  ): cint {.git2Proc, importc: "git_blob_create_fromstream".}
  
 

proc git_blob_create_fromstream_commit1*(
    arg_out: ptr git_oid,
    stream:  ptr git_writestream
  ): cint {.git2Proc, importc: "git_blob_create_fromstream_commit".}
  
 

proc git_blob_create_frombuffer1*(
    id:     ptr git_oid,
    repo:   ptr git_repository,
    buffer: pointer,
    len:    csize_t
  ): cint {.git2Proc, importc: "git_blob_create_frombuffer".}
  
 

proc git_blob_filtered_content*(
    arg_out:               ptr git_buf,
    blob:                  ptr git_blob,
    as_path:               cstring,
    check_for_binary_data: cint
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_stream_data*(
    filters: ptr git_filter_list,
    data:    ptr git_buf,
    target:  ptr git_writestream
  ): cint {.git2Proc, importc.}
  
 

proc git_filter_list_apply_to_data*(
    arg_out: ptr git_buf,
    filters: ptr git_filter_list,
    arg_in:  ptr git_buf
  ): cint {.git2Proc, importc.}
  
 

proc git_treebuilder_write_with_buffer*(
    oid:  ptr git_oid,
    bld:  ptr git_treebuilder,
    tree: ptr git_buf
  ): cint {.git2Proc, importc.}
  
 

proc git_buf_grow*(
    buffer:      ptr git_buf,
    target_size: csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_buf_set*(
    buffer:  ptr git_buf,
    data:    pointer,
    datalen: csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_buf_is_binary*(buf: ptr git_buf): cint {.git2Proc, importc.}
  
 

proc git_buf_contains_nul*(buf: ptr git_buf): cint {.git2Proc, importc.}
  
 

proc git_buf_free*(buffer: ptr git_buf): void {.git2Proc, importc.}
  
 

proc giterr_last*(a0: void): ptr git_error {.git2Proc, importc.}
  
 

proc giterr_clear*(a0: void): void {.git2Proc, importc.}
  
 

proc giterr_set_str*(
    error_class: cint,
    arg_string:  cstring
  ): void {.git2Proc, importc.}
  
 

proc giterr_set_oom*(a0: void): void {.git2Proc, importc.}
  
 

proc git_index_add_frombuffer1*(
    index:  ptr git_index,
    entry:  ptr git_index_entry,
    buffer: pointer,
    len:    csize_t
  ): cint {.git2Proc, importc: "git_index_add_frombuffer".}
  
 

proc git_object_size*(
    type_f: c_git_object_t
  ): csize_t {.git2Proc, importc: "git_object__size".}
  
 

proc git_remote_is_valid_name*(remote_name: cstring): cint {.git2Proc, importc.}
  
 

proc git_reference_is_valid_name*(refname1: cstring): cint {.git2Proc, importc.}
  
 

proc git_tag_create_frombuffer1*(
    oid:    ptr git_oid,
    repo:   ptr git_repository,
    buffer: cstring,
    force:  cint
  ): cint {.git2Proc, importc: "git_tag_create_frombuffer".}
  
 

proc git_cred_free*(cred: ptr git_credential): void {.git2Proc, importc.}
  
 

proc git_cred_has_username*(
    cred: ptr git_credential
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_get_username*(
    cred: ptr git_credential
  ): cstring {.git2Proc, importc.}
  
 

proc git_cred_userpass_plaintext_new*(
    arg_out:  ptr ptr git_credential,
    username: cstring,
    password: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_default_new*(
    arg_out: ptr ptr git_credential
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_username_new*(
    arg_out:  ptr ptr git_credential,
    username: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_ssh_key_new*(
    arg_out:    ptr ptr git_credential,
    username:   cstring,
    publickey:  cstring,
    privatekey: cstring,
    passphrase: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_ssh_key_memory_new*(
    arg_out:    ptr ptr git_credential,
    username:   cstring,
    publickey:  cstring,
    privatekey: cstring,
    passphrase: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_ssh_interactive_new*(
    arg_out:         ptr ptr git_credential,
    username:        cstring,
    prompt_callback: git_credential_ssh_interactive_cb,
    payload:         pointer
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_ssh_key_from_agent*(
    arg_out:  ptr ptr git_credential,
    username: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_ssh_custom_new*(
    arg_out:       ptr ptr git_credential,
    username:      cstring,
    publickey:     cstring,
    publickey_len: csize_t,
    sign_callback: git_credential_sign_cb,
    payload:       pointer
  ): cint {.git2Proc, importc.}
  
 

proc git_cred_userpass*(
    arg_out:       ptr ptr git_credential,
    url:           cstring,
    user_from_url: cstring,
    allowed_types: cuint,
    payload:       pointer
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_iszero1*(
    id: ptr git_oid
  ): cint {.git2Proc, importc: "git_oid_iszero".}
  
 

proc git_strarray_copy*(
    tgt: ptr git_strarray,
    src: ptr git_strarray
  ): cint {.git2Proc, importc.}
  
 

proc git_strarray_free*(array: ptr git_strarray): void {.git2Proc, importc.}
  
 

proc git_blame_init_options*(
    opts:    ptr git_blame_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_checkout_init_options*(
    opts:    ptr git_checkout_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_cherrypick_init_options*(
    opts:    ptr git_cherrypick_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_clone_init_options*(
    opts:    ptr git_clone_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_describe_init_options*(
    opts:    ptr git_describe_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_describe_init_format_options*(
    opts:    ptr git_describe_format_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_diff_init_options*(
    opts:    ptr git_diff_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_diff_find_init_options*(
    opts:    ptr git_diff_find_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_diff_format_email_init_options*(
    opts:    ptr git_diff_format_email_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_diff_patchid_init_options*(
    opts:    ptr git_diff_patchid_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_fetch_init_options*(
    opts:    ptr git_fetch_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_indexer_init_options*(
    opts:    ptr git_indexer_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_merge_init_options*(
    opts:    ptr git_merge_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_merge_file_init_input*(
    input:   ptr git_merge_file_input,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_merge_file_init_options*(
    opts:    ptr git_merge_file_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_proxy_init_options*(
    opts:    ptr git_proxy_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_push_init_options*(
    opts:    ptr git_push_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_rebase_init_options*(
    opts:    ptr git_rebase_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_remote_create_init_options*(
    opts:    ptr git_remote_create_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_repository_init_init_options*(
    opts:    ptr git_repository_init_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_revert_init_options*(
    opts:    ptr git_revert_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_stash_apply_init_options*(
    opts:    ptr git_stash_apply_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_status_init_options*(
    opts:    ptr git_status_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_submodule_update_init_options*(
    opts:    ptr git_submodule_update_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_worktree_add_init_options*(
    opts:    ptr git_worktree_add_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

proc git_worktree_prune_init_options*(
    opts:    ptr git_worktree_prune_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

