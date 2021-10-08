
import
  . / config

import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_credential_free*(cred: ptr git_credential): void {.dynlib: libgitDl,
    importc.}
proc git_credential_has_username*(cred: ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_get_username*(cred: ptr git_credential): cstring {.
    dynlib: libgitDl, importc.}
proc git_credential_userpass_plaintext_new*(arg_out: ptr ptr git_credential;
    username: cstring; password: cstring): cint {.dynlib: libgitDl, importc.}
proc git_credential_default_new*(arg_out: ptr ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_username_new*(arg_out: ptr ptr git_credential;
                                  username: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_credential_ssh_key_new*(arg_out: ptr ptr git_credential;
                                 username: cstring; publickey: cstring;
                                 privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_key_memory_new*(arg_out: ptr ptr git_credential;
                                        username: cstring; publickey: cstring;
                                        privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_interactive_new*(arg_out: ptr ptr git_credential;
    username: cstring; prompt_callback: git_credential_ssh_interactive_cb;
    payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_credential_ssh_key_from_agent*(arg_out: ptr ptr git_credential;
                                        username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_custom_new*(arg_out: ptr ptr git_credential;
                                    username: cstring; publickey: cstring;
                                    publickey_len: size_t;
                                    sign_callback: git_credential_sign_cb;
                                    payload: pointer): cint {.dynlib: libgitDl,
    importc.}