
import
  . / config

import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_index_open*(arg_out: ptr ptr git_index; index_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_new*(arg_out: ptr ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_free*(index: ptr git_index): void {.dynlib: libgitDl, importc.}
proc git_index_owner*(index: ptr git_index): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_index_caps*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_set_caps*(index: ptr git_index; caps: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_version*(index: ptr git_index): cuint {.dynlib: libgitDl, importc.}
proc git_index_set_version*(index: ptr git_index; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_read*(index: ptr git_index; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_path*(index: ptr git_index): cstring {.dynlib: libgitDl, importc.}
proc git_index_checksum*(index: ptr git_index): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_index_read_tree*(index: ptr git_index; tree: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write_tree*(arg_out: ptr git_oid; index: ptr git_index): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write_tree_to*(arg_out: ptr git_oid; index: ptr git_index;
                              repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entrycount*(index: ptr git_index): size_t {.dynlib: libgitDl,
    importc.}
proc git_index_clear*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_get_byindex*(index: ptr git_index; n: size_t): ptr git_index_entry {.
    dynlib: libgitDl, importc.}
proc git_index_get_bypath*(index: ptr git_index; path: cstring; stage: cint): ptr git_index_entry {.
    dynlib: libgitDl, importc.}
proc git_index_remove*(index: ptr git_index; path: cstring; stage: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_remove_directory*(index: ptr git_index; dir: cstring; stage: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add*(index: ptr git_index; source_entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entry_stage*(entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entry_is_conflict*(entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_iterator_new*(iterator_out: ptr ptr git_index_iterator;
                             index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_iterator_next*(arg_out: ptr ptr git_index_entry;
                              arg_iterator: ptr git_index_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_index_iterator_free*(arg_iterator: ptr git_index_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_index_add_bypath*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add_from_buffer*(index: ptr git_index;
                                entry: ptr git_index_entry; buffer: pointer;
                                len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_index_remove_bypath*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add_all*(index: ptr git_index; pathspec: ptr git_strarray;
                        flags: cuint; callback: git_index_matched_path_cb;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_index_remove_all*(index: ptr git_index; pathspec: ptr git_strarray;
                           callback: git_index_matched_path_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_index_update_all*(index: ptr git_index; pathspec: ptr git_strarray;
                           callback: git_index_matched_path_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_index_find*(at_pos: ptr size_t; index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_find_prefix*(at_pos: ptr size_t; index: ptr git_index;
                            prefix: cstring): cint {.dynlib: libgitDl, importc.}
proc git_index_conflict_add*(index: ptr git_index;
                             ancestor_entry: ptr git_index_entry;
                             our_entry: ptr git_index_entry;
                             their_entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_get*(ancestor_out: ptr ptr git_index_entry;
                             our_out: ptr ptr git_index_entry;
                             their_out: ptr ptr git_index_entry;
                             index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_remove*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_cleanup*(index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_has_conflicts*(index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_conflict_iterator_new*(iterator_out: ptr ptr git_index_conflict_iterator;
                                      index: ptr git_index): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_next*(ancestor_out: ptr ptr git_index_entry;
                              our_out: ptr ptr git_index_entry;
                              their_out: ptr ptr git_index_entry;
                              arg_iterator: ptr git_index_conflict_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_iterator_free*(arg_iterator: ptr git_index_conflict_iterator): void {.
    dynlib: libgitDl, importc.}