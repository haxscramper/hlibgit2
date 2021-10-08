
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_tag_lookup*(out: ptr ptr git_tag; repo: ptr git_repository;
                     id: ptr git_oid): cint {.dynlib: libgitDl,
    importc: "git_tag_lookup".}
proc git_tag_lookup_prefix*(out: ptr ptr git_tag; repo: ptr git_repository;
                            id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc: "git_tag_lookup_prefix".}
proc git_tag_free*(tag: ptr git_tag): void {.dynlib: libgitDl,
    importc: "git_tag_free".}
proc git_tag_id*(tag: ptr git_tag): ptr git_oid {.dynlib: libgitDl,
    importc: "git_tag_id".}
proc git_tag_owner*(tag: ptr git_tag): ptr git_repository {.dynlib: libgitDl,
    importc: "git_tag_owner".}
proc git_tag_target*(target_out: ptr ptr git_object; tag: ptr git_tag): cint {.
    dynlib: libgitDl, importc: "git_tag_target".}
proc git_tag_target_id*(tag: ptr git_tag): ptr git_oid {.dynlib: libgitDl,
    importc: "git_tag_target_id".}
proc git_tag_target_type*(tag: ptr git_tag): git_object_t {.dynlib: libgitDl,
    importc: "git_tag_target_type".}
proc git_tag_name*(tag: ptr git_tag): cstring {.dynlib: libgitDl,
    importc: "git_tag_name".}
proc git_tag_tagger*(tag: ptr git_tag): ptr git_signature {.dynlib: libgitDl,
    importc: "git_tag_tagger".}
proc git_tag_message*(tag: ptr git_tag): cstring {.dynlib: libgitDl,
    importc: "git_tag_message".}
proc git_tag_create*(oid: ptr git_oid; repo: ptr git_repository;
                     tag_name: cstring; target: ptr git_object;
                     tagger: ptr git_signature; message: cstring; force: cint): cint {.
    dynlib: libgitDl, importc: "git_tag_create".}
proc git_tag_annotation_create*(oid: ptr git_oid; repo: ptr git_repository;
                                tag_name: cstring; target: ptr git_object;
                                tagger: ptr git_signature; message: cstring): cint {.
    dynlib: libgitDl, importc: "git_tag_annotation_create".}
proc git_tag_create_from_buffer*(oid: ptr git_oid; repo: ptr git_repository;
                                 buffer: cstring; force: cint): cint {.
    dynlib: libgitDl, importc: "git_tag_create_from_buffer".}
proc git_tag_create_lightweight*(oid: ptr git_oid; repo: ptr git_repository;
                                 tag_name: cstring; target: ptr git_object;
                                 force: cint): cint {.dynlib: libgitDl,
    importc: "git_tag_create_lightweight".}
proc git_tag_delete*(repo: ptr git_repository; tag_name: cstring): cint {.
    dynlib: libgitDl, importc: "git_tag_delete".}
proc git_tag_list*(tag_names: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc: "git_tag_list".}
proc git_tag_list_match*(tag_names: ptr git_strarray; pattern: cstring;
                         repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc: "git_tag_list_match".}
proc git_tag_foreach*(repo: ptr git_repository; callback: git_tag_foreach_cb;
                      payload: pointer): cint {.dynlib: libgitDl,
    importc: "git_tag_foreach".}
proc git_tag_peel*(tag_target_out: ptr ptr git_object; tag: ptr git_tag): cint {.
    dynlib: libgitDl, importc: "git_tag_peel".}
proc git_tag_dup*(out: ptr ptr git_tag; source: ptr git_tag): cint {.
    dynlib: libgitDl, importc: "git_tag_dup".}