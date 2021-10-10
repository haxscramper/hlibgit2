import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

type
  git_describe_result* {.bycopy, incompleteStruct, importc.} = object
    
   

proc git_describe_options_init*(
    opts:    ptr git_describe_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_describe_format_options_init*(
    opts:    ptr git_describe_format_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_describe_commit*(
    result:     ptr ptr git_describe_result,
    committish: ptr git_object,
    opts:       ptr git_describe_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_describe_workdir*(
    arg_out: ptr ptr git_describe_result,
    repo:    ptr git_repository,
    opts:    ptr git_describe_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_describe_format*(
    arg_out: ptr git_buf,
    result:  ptr git_describe_result,
    opts:    ptr git_describe_format_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_describe_result_free*(
    result: ptr git_describe_result
  ): void {.dynlib: libgitDl, importc.}


