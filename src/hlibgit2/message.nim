import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

proc git_message_prettify*(
    arg_out:        ptr git_buf,
    message:        cstring,
    strip_comments: cint,
    comment_char:   char
  ): cint {.dynlib: libgitDl, importc.}


proc git_message_trailers*(
    arr:     ptr git_message_trailer_array,
    message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_message_trailer_array_free*(
    arr: ptr git_message_trailer_array
  ): void {.dynlib: libgitDl, importc.}


