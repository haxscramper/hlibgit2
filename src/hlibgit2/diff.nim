import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

type
  git_diff* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_diff_stats* {.bycopy, incompleteStruct, importc.} = object
    
   

proc git_diff_options_init*(
    opts:    ptr git_diff_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_find_options_init*(
    opts:    ptr git_diff_find_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_free*(diff: ptr git_diff): void {.dynlib: libgitDl, importc.}


proc git_diff_tree_to_tree*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    new_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_tree_to_index*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    index:    ptr git_index,
    opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_index_to_workdir*(
    diff:  ptr ptr git_diff,
    repo:  ptr git_repository,
    index: ptr git_index,
    opts:  ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_tree_to_workdir*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_tree_to_workdir_with_index*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_index_to_index*(
    diff:      ptr ptr git_diff,
    repo:      ptr git_repository,
    old_index: ptr git_index,
    new_index: ptr git_index,
    opts:      ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_merge*(
    onto:     ptr git_diff,
    arg_from: ptr git_diff
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_find_similar*(
    diff:    ptr git_diff,
    options: ptr git_diff_find_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_num_deltas*(
    diff: ptr git_diff
  ): size_t {.dynlib: libgitDl, importc.}


proc git_diff_num_deltas_of_type*(
    diff:   ptr git_diff,
    type_f: git_delta_t
  ): size_t {.dynlib: libgitDl, importc.}


proc git_diff_get_delta*(
    diff: ptr git_diff,
    idx:  size_t
  ): ptr git_diff_delta {.dynlib: libgitDl, importc.}


proc git_diff_is_sorted_icase*(
    diff: ptr git_diff
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_foreach*(
    diff:      ptr git_diff,
    file_cb:   git_diff_file_cb,
    binary_cb: git_diff_binary_cb,
    hunk_cb:   git_diff_hunk_cb,
    line_cb:   git_diff_line_cb,
    payload:   pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_status_char*(
    status: git_delta_t
  ): char {.dynlib: libgitDl, importc.}


proc git_diff_print*(
    diff:     ptr git_diff,
    format:   git_diff_format_t,
    print_cb: git_diff_line_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_to_buf*(
    arg_out: ptr git_buf,
    diff:    ptr git_diff,
    format:  git_diff_format_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_blobs*(
    old_blob:    ptr git_blob,
    old_as_path: cstring,
    new_blob:    ptr git_blob,
    new_as_path: cstring,
    options:     ptr git_diff_options,
    file_cb:     git_diff_file_cb,
    binary_cb:   git_diff_binary_cb,
    hunk_cb:     git_diff_hunk_cb,
    line_cb:     git_diff_line_cb,
    payload:     pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_blob_to_buffer*(
    old_blob:       ptr git_blob,
    old_as_path:    cstring,
    buffer:         cstring,
    buffer_len:     size_t,
    buffer_as_path: cstring,
    options:        ptr git_diff_options,
    file_cb:        git_diff_file_cb,
    binary_cb:      git_diff_binary_cb,
    hunk_cb:        git_diff_hunk_cb,
    line_cb:        git_diff_line_cb,
    payload:        pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_buffers*(
    old_buffer:  pointer,
    old_len:     size_t,
    old_as_path: cstring,
    new_buffer:  pointer,
    new_len:     size_t,
    new_as_path: cstring,
    options:     ptr git_diff_options,
    file_cb:     git_diff_file_cb,
    binary_cb:   git_diff_binary_cb,
    hunk_cb:     git_diff_hunk_cb,
    line_cb:     git_diff_line_cb,
    payload:     pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_from_buffer*(
    arg_out:     ptr ptr git_diff,
    content:     cstring,
    content_len: size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_get_stats*(
    arg_out: ptr ptr git_diff_stats,
    diff:    ptr git_diff
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_stats_files_changed*(
    stats: ptr git_diff_stats
  ): size_t {.dynlib: libgitDl, importc.}


proc git_diff_stats_insertions*(
    stats: ptr git_diff_stats
  ): size_t {.dynlib: libgitDl, importc.}


proc git_diff_stats_deletions*(
    stats: ptr git_diff_stats
  ): size_t {.dynlib: libgitDl, importc.}


proc git_diff_stats_to_buf*(
    arg_out: ptr git_buf,
    stats:   ptr git_diff_stats,
    format:  git_diff_stats_format_t,
    width:   size_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_stats_free*(
    stats: ptr git_diff_stats
  ): void {.dynlib: libgitDl, importc.}


proc git_diff_format_email*(
    arg_out: ptr git_buf,
    diff:    ptr git_diff,
    opts:    ptr git_diff_format_email_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_commit_as_email*(
    arg_out:       ptr git_buf,
    repo:          ptr git_repository,
    commit:        ptr git_commit,
    patch_no:      size_t,
    total_patches: size_t,
    flags:         uint32,
    diff_opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_format_email_options_init*(
    opts:    ptr git_diff_format_email_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_patchid_options_init*(
    opts:    ptr git_diff_patchid_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_patchid*(
    arg_out: ptr git_oid,
    diff:    ptr git_diff,
    opts:    ptr git_diff_patchid_options
  ): cint {.dynlib: libgitDl, importc.}


