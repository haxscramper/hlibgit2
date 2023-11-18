type

  git_diff_format_email_options* {.importc, bycopy.} = object
    version       *: cuint
    flags         *: uint32
    patch_no      *: csize_t
    total_patches *: csize_t
    id            *: ptr git_oid
    summary       *: cstring
    body          *: cstring
    author        *: ptr git_signature
  c_git_diff_format_email_flags_t {.size: sizeof(cint).} = enum
    c_GIT_DIFF_FORMAT_EMAIL_NONE                         = 0 shl 0
    c_GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = 1 shl 0
  git_diff_format_email_flags_t = enum
    GIT_DIFF_FORMAT_EMAIL_NONE
    GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER
  git_commit_signing_cb = proc (a0: ptr git_buf, a1: ptr git_buf, a2: cstring, a3: ptr void): cint
  git_cred_acquire_cb = git_credential_acquire_cb
  git_cred_sign_callback = git_credential_sign_cb
  git_cred_sign_cb = git_credential_sign_cb
  git_cred_ssh_interactive_callback = git_credential_ssh_interactive_cb
  git_cred_ssh_interactive_cb = git_credential_ssh_interactive_cb
  git_trace_callback = git_trace_cb
  git_transfer_progress_cb = git_indexer_progress_cb
  git_push_transfer_progress = git_push_transfer_progress_cb
  git_headlist_cb = proc (a0: ptr git_remote_head, a1: ptr void): cint



converter toCInt*(arg: c_git_diff_format_email_flags_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_diff_format_email_flags_t)): cint =
  for value in items(args):
    case value:
      of GIT_DIFF_FORMAT_EMAIL_NONE: result = cint(result or 0)
      of GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER: result = cint(result or 1)

func `-`*(arg: c_git_diff_format_email_flags_t, offset: int): cint = cast[c_git_diff_format_email_flags_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_format_email_flags_t): cint = cast[c_git_diff_format_email_flags_t](ord(arg) - offset)

func `+`*(arg: c_git_diff_format_email_flags_t, offset: int): cint = cast[c_git_diff_format_email_flags_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_format_email_flags_t): cint = cast[c_git_diff_format_email_flags_t](ord(arg) + offset)

proc `git_blob_create_fromworkdir`*(id: ptr git_oid, repo: ptr git_repository, relative_path: cstring): cint {.git2Proc, importc.}

proc `git_blob_create_fromdisk`*(id: ptr git_oid, repo: ptr git_repository, path: cstring): cint {.git2Proc, importc.}

proc `git_blob_create_fromstream`*(out: ptr git_writestream, repo: ptr git_repository, hintpath: cstring): cint {.git2Proc, importc.}

proc `git_blob_create_fromstream_commit`*(out: ptr git_oid, stream: ptr git_writestream): cint {.git2Proc, importc.}

proc `git_blob_create_frombuffer`*(id: ptr git_oid, repo: ptr git_repository, buffer: ptr const void, len: csize_t): cint {.git2Proc, importc.}

proc `git_blob_filtered_content`*(out: ptr git_buf, blob: ptr git_blob, as_path: cstring, check_for_binary_data: cint): cint {.git2Proc, importc.}

proc `git_filter_list_stream_data`*(filters: ptr git_filter_list, data: ptr git_buf, target: ptr git_writestream): cint {.git2Proc, importc.}

proc `git_filter_list_apply_to_data`*(out: ptr git_buf, filters: ptr git_filter_list, in: ptr git_buf): cint {.git2Proc, importc.}

proc `git_treebuilder_write_with_buffer`*(oid: ptr git_oid, bld: ptr git_treebuilder, tree: ptr git_buf): cint {.git2Proc, importc.}

proc `git_buf_grow`*(buffer: ptr git_buf, target_size: csize_t): cint {.git2Proc, importc.}

proc `git_buf_set`*(buffer: ptr git_buf, data: ptr const void, datalen: csize_t): cint {.git2Proc, importc.}

proc `git_buf_is_binary`*(buf: ptr git_buf): cint {.git2Proc, importc.}

proc `git_buf_contains_nul`*(buf: ptr git_buf): cint {.git2Proc, importc.}

proc `git_buf_free`*(buffer: ptr git_buf): void {.git2Proc, importc.}

proc `git_diff_format_email`*(out: ptr git_buf, diff: ptr git_diff, opts: ptr git_diff_format_email_options): cint {.git2Proc, importc.}

proc `git_diff_commit_as_email`*(out: ptr git_buf, repo: ptr git_repository, commit: ptr git_commit, patch_no: csize_t, total_patches: csize_t, flags: uint32, diff_opts: ptr git_diff_options): cint {.git2Proc, importc.}

proc `git_diff_format_email_options_init`*(opts: ptr git_diff_format_email_options, version: cuint): cint {.git2Proc, importc.}

proc `giterr_last`*(): ptr git_error {.git2Proc, importc.}

proc `giterr_clear`*(): void {.git2Proc, importc.}

proc `giterr_set_str`*(error_class: cint, string: cstring): void {.git2Proc, importc.}

proc `giterr_set_oom`*(): void {.git2Proc, importc.}

proc `git_index_add_frombuffer`*(index: ptr git_index, entry: ptr git_index_entry, buffer: ptr const void, len: csize_t): cint {.git2Proc, importc.}

proc `git_object__size`*(type: git_object_t): csize_t {.git2Proc, importc.}

proc `git_remote_is_valid_name`*(remote_name: cstring): cint {.git2Proc, importc.}

proc `git_reference_is_valid_name`*(refname: cstring): cint {.git2Proc, importc.}

proc `git_tag_create_frombuffer`*(oid: ptr git_oid, repo: ptr git_repository, buffer: cstring, force: cint): cint {.git2Proc, importc.}

proc `git_cred_free`*(cred: ptr git_credential): void {.git2Proc, importc.}

proc `git_cred_has_username`*(cred: ptr git_credential): cint {.git2Proc, importc.}

proc `git_cred_get_username`*(cred: ptr git_credential): cstring {.git2Proc, importc.}

proc `git_cred_userpass_plaintext_new`*(out: ptr git_credential, username: cstring, password: cstring): cint {.git2Proc, importc.}

proc `git_cred_default_new`*(out: ptr git_credential): cint {.git2Proc, importc.}

proc `git_cred_username_new`*(out: ptr git_credential, username: cstring): cint {.git2Proc, importc.}

proc `git_cred_ssh_key_new`*(out: ptr git_credential, username: cstring, publickey: cstring, privatekey: cstring, passphrase: cstring): cint {.git2Proc, importc.}

proc `git_cred_ssh_key_memory_new`*(out: ptr git_credential, username: cstring, publickey: cstring, privatekey: cstring, passphrase: cstring): cint {.git2Proc, importc.}

proc `git_cred_ssh_interactive_new`*(out: ptr git_credential, username: cstring, prompt_callback: git_credential_ssh_interactive_cb, payload: ptr void): cint {.git2Proc, importc.}

proc `git_cred_ssh_key_from_agent`*(out: ptr git_credential, username: cstring): cint {.git2Proc, importc.}

proc `git_cred_ssh_custom_new`*(out: ptr git_credential, username: cstring, publickey: cstring, publickey_len: csize_t, sign_callback: git_credential_sign_cb, payload: ptr void): cint {.git2Proc, importc.}

proc `git_cred_userpass`*(out: ptr git_credential, url: cstring, user_from_url: cstring, allowed_types: cuint, payload: ptr void): cint {.git2Proc, importc.}

proc `git_oid_iszero`*(id: ptr git_oid): cint {.git2Proc, importc.}

proc `git_oidarray_free`*(array: ptr git_oidarray): void {.git2Proc, importc.}

proc `git_strarray_copy`*(tgt: ptr git_strarray, src: ptr git_strarray): cint {.git2Proc, importc.}

proc `git_strarray_free`*(array: ptr git_strarray): void {.git2Proc, importc.}

proc `git_blame_init_options`*(opts: ptr git_blame_options, version: cuint): cint {.git2Proc, importc.}

proc `git_checkout_init_options`*(opts: ptr git_checkout_options, version: cuint): cint {.git2Proc, importc.}

proc `git_cherrypick_init_options`*(opts: ptr git_cherrypick_options, version: cuint): cint {.git2Proc, importc.}

proc `git_clone_init_options`*(opts: ptr git_clone_options, version: cuint): cint {.git2Proc, importc.}

proc `git_describe_init_options`*(opts: ptr git_describe_options, version: cuint): cint {.git2Proc, importc.}

proc `git_describe_init_format_options`*(opts: ptr git_describe_format_options, version: cuint): cint {.git2Proc, importc.}

proc `git_diff_init_options`*(opts: ptr git_diff_options, version: cuint): cint {.git2Proc, importc.}

proc `git_diff_find_init_options`*(opts: ptr git_diff_find_options, version: cuint): cint {.git2Proc, importc.}

proc `git_diff_format_email_init_options`*(opts: ptr git_diff_format_email_options, version: cuint): cint {.git2Proc, importc.}

proc `git_diff_patchid_init_options`*(opts: ptr git_diff_patchid_options, version: cuint): cint {.git2Proc, importc.}

proc `git_fetch_init_options`*(opts: ptr git_fetch_options, version: cuint): cint {.git2Proc, importc.}

proc `git_indexer_init_options`*(opts: ptr git_indexer_options, version: cuint): cint {.git2Proc, importc.}

proc `git_merge_init_options`*(opts: ptr git_merge_options, version: cuint): cint {.git2Proc, importc.}

proc `git_merge_file_init_input`*(input: ptr git_merge_file_input, version: cuint): cint {.git2Proc, importc.}

proc `git_merge_file_init_options`*(opts: ptr git_merge_file_options, version: cuint): cint {.git2Proc, importc.}

proc `git_proxy_init_options`*(opts: ptr git_proxy_options, version: cuint): cint {.git2Proc, importc.}

proc `git_push_init_options`*(opts: ptr git_push_options, version: cuint): cint {.git2Proc, importc.}

proc `git_rebase_init_options`*(opts: ptr git_rebase_options, version: cuint): cint {.git2Proc, importc.}

proc `git_remote_create_init_options`*(opts: ptr git_remote_create_options, version: cuint): cint {.git2Proc, importc.}

proc `git_repository_init_init_options`*(opts: ptr git_repository_init_options, version: cuint): cint {.git2Proc, importc.}

proc `git_revert_init_options`*(opts: ptr git_revert_options, version: cuint): cint {.git2Proc, importc.}

proc `git_stash_apply_init_options`*(opts: ptr git_stash_apply_options, version: cuint): cint {.git2Proc, importc.}

proc `git_status_init_options`*(opts: ptr git_status_options, version: cuint): cint {.git2Proc, importc.}

proc `git_submodule_update_init_options`*(opts: ptr git_submodule_update_options, version: cuint): cint {.git2Proc, importc.}

proc `git_worktree_add_init_options`*(opts: ptr git_worktree_add_options, version: cuint): cint {.git2Proc, importc.}

proc `git_worktree_prune_init_options`*(opts: ptr git_worktree_prune_options, version: cuint): cint {.git2Proc, importc.}