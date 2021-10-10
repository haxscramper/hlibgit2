import
  ./libgit_config

import
  ./apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

export apply_attr_blame_blob_branch_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_patch_pathspec_proxy_rebase_r

type
  git_pathspec* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_pathspec_match_list* {.bycopy, incompleteStruct, importc.} = object
    
   

proc git_pathspec_new*(
    arg_out:  ptr ptr git_pathspec,
    pathspec: ptr git_strarray
  ): cint {.dynlib: libgitDl, importc.}


proc git_pathspec_free*(
    ps: ptr git_pathspec
  ): void {.dynlib: libgitDl, importc.}


proc git_pathspec_matches_path*(
    ps:    ptr git_pathspec,
    flags: uint32,
    path:  cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_pathspec_match_workdir*(
    arg_out: ptr ptr git_pathspec_match_list,
    repo:    ptr git_repository,
    flags:   uint32,
    ps:      ptr git_pathspec
  ): cint {.dynlib: libgitDl, importc.}


proc git_pathspec_match_index*(
    arg_out: ptr ptr git_pathspec_match_list,
    index:   ptr git_index,
    flags:   uint32,
    ps:      ptr git_pathspec
  ): cint {.dynlib: libgitDl, importc.}


proc git_pathspec_match_tree*(
    arg_out: ptr ptr git_pathspec_match_list,
    tree:    ptr git_tree,
    flags:   uint32,
    ps:      ptr git_pathspec
  ): cint {.dynlib: libgitDl, importc.}


proc git_pathspec_match_diff*(
    arg_out: ptr ptr git_pathspec_match_list,
    diff:    ptr git_diff,
    flags:   uint32,
    ps:      ptr git_pathspec
  ): cint {.dynlib: libgitDl, importc.}


proc git_pathspec_match_list_free*(
    m: ptr git_pathspec_match_list
  ): void {.dynlib: libgitDl, importc.}


proc git_pathspec_match_list_entrycount*(
    m: ptr git_pathspec_match_list
  ): size_t {.dynlib: libgitDl, importc.}


proc git_pathspec_match_list_entry*(
    m:   ptr git_pathspec_match_list,
    pos: size_t
  ): cstring {.dynlib: libgitDl, importc.}


proc git_pathspec_match_list_diff_entry*(
    m:   ptr git_pathspec_match_list,
    pos: size_t
  ): ptr git_diff_delta {.dynlib: libgitDl, importc.}


proc git_pathspec_match_list_failed_entrycount*(
    m: ptr git_pathspec_match_list
  ): size_t {.dynlib: libgitDl, importc.}


proc git_pathspec_match_list_failed_entry*(
    m:   ptr git_pathspec_match_list,
    pos: size_t
  ): cstring {.dynlib: libgitDl, importc.}


