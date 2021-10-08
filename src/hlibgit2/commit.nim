
import
  . / config

import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_commit_lookup*(commit: ptr ptr git_commit; repo: ptr git_repository;
                        id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_commit_lookup_prefix*(commit: ptr ptr git_commit;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_commit_free*(commit: ptr git_commit): void {.dynlib: libgitDl, importc.}
proc git_commit_id*(commit: ptr git_commit): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_commit_owner*(commit: ptr git_commit): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_commit_message_encoding*(commit: ptr git_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_commit_message*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_message_raw*(commit: ptr git_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_commit_summary*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_body*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_time*(commit: ptr git_commit): git_time_t {.dynlib: libgitDl,
    importc.}
proc git_commit_time_offset*(commit: ptr git_commit): cint {.dynlib: libgitDl,
    importc.}
proc git_commit_committer*(commit: ptr git_commit): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_commit_author*(commit: ptr git_commit): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_commit_committer_with_mailmap*(arg_out: ptr ptr git_signature;
                                        commit: ptr git_commit;
                                        mailmap: ptr git_mailmap): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_author_with_mailmap*(arg_out: ptr ptr git_signature;
                                     commit: ptr git_commit;
                                     mailmap: ptr git_mailmap): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_raw_header*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_tree*(tree_out: ptr ptr git_tree; commit: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_tree_id*(commit: ptr git_commit): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_commit_parentcount*(commit: ptr git_commit): cuint {.dynlib: libgitDl,
    importc.}
proc git_commit_parent*(arg_out: ptr ptr git_commit; commit: ptr git_commit;
                        n: cuint): cint {.dynlib: libgitDl, importc.}
proc git_commit_parent_id*(commit: ptr git_commit; n: cuint): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_commit_nth_gen_ancestor*(ancestor: ptr ptr git_commit;
                                  commit: ptr git_commit; n: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_header_field*(arg_out: ptr git_buf; commit: ptr git_commit;
                              field: cstring): cint {.dynlib: libgitDl, importc.}
proc git_commit_extract_signature*(signature: ptr git_buf;
                                   signed_data: ptr git_buf;
                                   repo: ptr git_repository;
                                   commit_id: ptr git_oid; field: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create*(id: ptr git_oid; repo: ptr git_repository;
                        update_ref: cstring; author: ptr git_signature;
                        committer: ptr git_signature; message_encoding: cstring;
                        message: cstring; tree: ptr git_tree;
                        parent_count: size_t;
                        parents: ptr UncheckedArray[ptr git_commit]): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_v*(id: ptr git_oid; repo: ptr git_repository;
                          update_ref: cstring; author: ptr git_signature;
                          committer: ptr git_signature;
                          message_encoding: cstring; message: cstring;
                          tree: ptr git_tree; parent_count: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_amend*(id: ptr git_oid; commit_to_amend: ptr git_commit;
                       update_ref: cstring; author: ptr git_signature;
                       committer: ptr git_signature; message_encoding: cstring;
                       message: cstring; tree: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_buffer*(arg_out: ptr git_buf; repo: ptr git_repository;
                               author: ptr git_signature;
                               committer: ptr git_signature;
                               message_encoding: cstring; message: cstring;
                               tree: ptr git_tree; parent_count: size_t;
                               parents: ptr UncheckedArray[ptr git_commit]): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_with_signature*(arg_out: ptr git_oid;
                                       repo: ptr git_repository;
                                       commit_content: cstring;
                                       signature: cstring;
                                       signature_field: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_dup*(arg_out: ptr ptr git_commit; source: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}