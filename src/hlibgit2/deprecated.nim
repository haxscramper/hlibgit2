
import
  . / stash

import
  . / oid

import
  . / blame

import
  . / trace

import
  . / indexer

import
  . / config

import
  . / submodule

import
  . / worktree

import
  . / proxy

import
  . / index

import
  . / remote

import
  . / net

import
  . / types

import
  . / merge

import
  . / credential_helpers

import
  . / rebase

import
  . / status

import
  . / describe

import
  . / attr

import
  . / strarray

import
  . / credential

import
  . / clone

import
  . / cherrypick

import
  . / diff

import
  . / checkout

import
  . / repository

import
  . / errors

import
  . / revert

import
  . / buffer

type
  git_attr_t* = git_attr_value_t
  git_cvar_map* = git_configmap
  git_cred* = git_credential
  git_cred_userpass_plaintext* = git_credential_userpass_plaintext
  git_cred_username* = git_credential_username
  git_cred_default* = git_credential_default
  git_cred_ssh_key* = git_credential_ssh_key
  git_cred_ssh_interactive* = git_credential_ssh_interactive
  git_cred_ssh_custom* = git_credential_ssh_custom
  git_cred_acquire_cb* = git_credential_acquire_cb
  git_cred_sign_callback* = git_credential_sign_cb
  git_cred_sign_cb* = git_credential_sign_cb
  git_cred_ssh_interactive_callback* = git_credential_ssh_interactive_cb
  git_cred_ssh_interactive_cb* = git_credential_ssh_interactive_cb
  git_cred_userpass_payload* = git_credential_userpass_payload
  git_trace_callback* = git_trace_cb
  git_transfer_progress* = git_indexer_progress
  git_transfer_progress_cb* = git_indexer_progress_cb
  git_push_transfer_progress* = git_push_transfer_progress_cb
  git_headlist_cb* = proc (rhead: ptr git_remote_head; payload: pointer): cint {.
      cdecl.}
  git_headlist_cbNim* = proc (rhead: ptr git_remote_head): cint
proc git_blob_create_fromworkdir*(id: ptr git_oid; repo: ptr git_repository;
                                  relative_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_fromdisk*(id: ptr git_oid; repo: ptr git_repository;
                               path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_fromstream*(out: ptr ptr git_writestream;
                                 repo: ptr git_repository; hintpath: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_fromstream_commit*(out: ptr git_oid;
                                        stream: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_frombuffer*(id: ptr git_oid; repo: ptr git_repository;
                                 buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_filtered_content*(out: ptr git_buf; blob: ptr git_blob;
                                as_path: cstring; check_for_binary_data: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_free*(buffer: ptr git_buf): void {.dynlib: libgitDl, importc.}
proc giterr_last*(a0: void): ptr git_error {.dynlib: libgitDl, importc.}
proc giterr_clear*(a0: void): void {.dynlib: libgitDl, importc.}
proc giterr_set_str*(error_class: cint; string: cstring): void {.
    dynlib: libgitDl, importc.}
proc giterr_set_oom*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_index_add_frombuffer*(index: ptr git_index; entry: ptr git_index_entry;
                               buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_size*(type: git_object_t): size_t {.dynlib: libgitDl,
    importc: "git_object__size".}
proc git_tag_create_frombuffer*(oid: ptr git_oid; repo: ptr git_repository;
                                buffer: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_free*(cred: ptr git_credential): void {.dynlib: libgitDl, importc.}
proc git_cred_has_username*(cred: ptr git_credential): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_get_username*(cred: ptr git_credential): cstring {.
    dynlib: libgitDl, importc.}
proc git_cred_userpass_plaintext_new*(out: ptr ptr git_credential;
                                      username: cstring; password: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_default_new*(out: ptr ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_username_new*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_key_new*(out: ptr ptr git_credential; username: cstring;
                           publickey: cstring; privatekey: cstring;
                           passphrase: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_ssh_key_memory_new*(out: ptr ptr git_credential;
                                  username: cstring; publickey: cstring;
                                  privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_interactive_new*(out: ptr ptr git_credential;
                                   username: cstring; prompt_callback: git_credential_ssh_interactive_cb;
                                   payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_ssh_key_from_agent*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_custom_new*(out: ptr ptr git_credential; username: cstring;
                              publickey: cstring; publickey_len: size_t;
                              sign_callback: git_credential_sign_cb;
                              payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_userpass*(out: ptr ptr git_credential; url: cstring;
                        user_from_url: cstring; allowed_types: cuint;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_oid_iszero*(id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_strarray_copy*(tgt: ptr git_strarray; src: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_strarray_free*(array: ptr git_strarray): void {.dynlib: libgitDl,
    importc.}
proc git_blame_init_options*(opts: ptr git_blame_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_init_options*(opts: ptr git_checkout_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_cherrypick_init_options*(opts: ptr git_cherrypick_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_clone_init_options*(opts: ptr git_clone_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_init_options*(opts: ptr git_describe_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_init_format_options*(opts: ptr git_describe_format_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_init_options*(opts: ptr git_diff_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_init_options*(opts: ptr git_diff_find_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_format_email_init_options*(
    opts: ptr git_diff_format_email_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_patchid_init_options*(opts: ptr git_diff_patchid_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_fetch_init_options*(opts: ptr git_fetch_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_init_options*(opts: ptr git_indexer_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_init_options*(opts: ptr git_merge_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_init_input*(input: ptr git_merge_file_input; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_init_options*(opts: ptr git_merge_file_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_proxy_init_options*(opts: ptr git_proxy_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_push_init_options*(opts: ptr git_push_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_init_options*(opts: ptr git_rebase_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_init_options*(opts: ptr git_remote_create_options;
                                     version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_init_init_options*(opts: ptr git_repository_init_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_revert_init_options*(opts: ptr git_revert_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_apply_init_options*(opts: ptr git_stash_apply_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_status_init_options*(opts: ptr git_status_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update_init_options*(opts: ptr git_submodule_update_options;
                                        version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_add_init_options*(opts: ptr git_worktree_add_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_prune_init_options*(opts: ptr git_worktree_prune_options;
                                      version: cuint): cint {.dynlib: libgitDl,
    importc.}