
import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_oid_fromstr*(out: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc: "git_oid_fromstr".}
proc git_oid_fromstrp*(out: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc: "git_oid_fromstrp".}
proc git_oid_fromstrn*(out: ptr git_oid; str: cstring; length: size_t): cint {.
    dynlib: libgitDl, importc: "git_oid_fromstrn".}
proc git_oid_fromraw*(out: ptr git_oid; raw: ptr uchar): cint {.
    dynlib: libgitDl, importc: "git_oid_fromraw".}
proc git_oid_fmt*(out: cstring; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc: "git_oid_fmt".}
proc git_oid_nfmt*(out: cstring; n: size_t; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc: "git_oid_nfmt".}
proc git_oid_pathfmt*(out: cstring; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc: "git_oid_pathfmt".}
proc git_oid_tostr_s*(oid: ptr git_oid): cstring {.dynlib: libgitDl,
    importc: "git_oid_tostr_s".}
proc git_oid_tostr*(out: cstring; n: size_t; id: ptr git_oid): cstring {.
    dynlib: libgitDl, importc: "git_oid_tostr".}
proc git_oid_cpy*(out: ptr git_oid; src: ptr git_oid): cint {.dynlib: libgitDl,
    importc: "git_oid_cpy".}
proc git_oid_cmp*(a: ptr git_oid; b: ptr git_oid): cint {.dynlib: libgitDl,
    importc: "git_oid_cmp".}
proc git_oid_equal*(a: ptr git_oid; b: ptr git_oid): cint {.dynlib: libgitDl,
    importc: "git_oid_equal".}
proc git_oid_ncmp*(a: ptr git_oid; b: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc: "git_oid_ncmp".}
proc git_oid_streq*(id: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc: "git_oid_streq".}
proc git_oid_strcmp*(id: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc: "git_oid_strcmp".}
proc git_oid_is_zero*(id: ptr git_oid): cint {.dynlib: libgitDl,
    importc: "git_oid_is_zero".}
proc git_oid_shorten_new*(min_length: size_t): ptr git_oid_shorten {.
    dynlib: libgitDl, importc: "git_oid_shorten_new".}
proc git_oid_shorten_add*(os: ptr git_oid_shorten; text_id: cstring): cint {.
    dynlib: libgitDl, importc: "git_oid_shorten_add".}
proc git_oid_shorten_free*(os: ptr git_oid_shorten): void {.dynlib: libgitDl,
    importc: "git_oid_shorten_free".}