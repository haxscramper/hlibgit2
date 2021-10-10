import
  ./libgit_config

import
  ./apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r





proc git_note_iterator_new*(
    arg_out:   ptr ptr git_note_iterator,
    repo:      ptr git_repository,
    notes_ref: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_commit_iterator_new*(
    arg_out:      ptr ptr git_note_iterator,
    notes_commit: ptr git_commit
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_iterator_free*(
    it: ptr git_note_iterator
  ): void {.dynlib: libgitDl, importc.}


proc git_note_next*(
    note_id:      ptr git_oid,
    annotated_id: ptr git_oid,
    it:           ptr git_note_iterator
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_read*(
    arg_out:   ptr ptr git_note,
    repo:      ptr git_repository,
    notes_ref: cstring,
    oid:       ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_commit_read*(
    arg_out:      ptr ptr git_note,
    repo:         ptr git_repository,
    notes_commit: ptr git_commit,
    oid:          ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_author*(
    note: ptr git_note
  ): ptr git_signature {.dynlib: libgitDl, importc.}


proc git_note_committer*(
    note: ptr git_note
  ): ptr git_signature {.dynlib: libgitDl, importc.}


proc git_note_message*(
    note: ptr git_note
  ): cstring {.dynlib: libgitDl, importc.}


proc git_note_id*(note: ptr git_note): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_note_create*(
    arg_out:   ptr git_oid,
    repo:      ptr git_repository,
    notes_ref: cstring,
    author:    ptr git_signature,
    committer: ptr git_signature,
    oid:       ptr git_oid,
    note:      cstring,
    force:     cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_commit_create*(
    notes_commit_out:     ptr git_oid,
    notes_blob_out:       ptr git_oid,
    repo:                 ptr git_repository,
    parent:               ptr git_commit,
    author:               ptr git_signature,
    committer:            ptr git_signature,
    oid:                  ptr git_oid,
    note:                 cstring,
    allow_note_overwrite: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_remove*(
    repo:      ptr git_repository,
    notes_ref: cstring,
    author:    ptr git_signature,
    committer: ptr git_signature,
    oid:       ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_commit_remove*(
    notes_commit_out: ptr git_oid,
    repo:             ptr git_repository,
    notes_commit:     ptr git_commit,
    author:           ptr git_signature,
    committer:        ptr git_signature,
    oid:              ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_free*(note: ptr git_note): void {.dynlib: libgitDl, importc.}


proc git_note_default_ref*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_note_foreach*(
    repo:      ptr git_repository,
    notes_ref: cstring,
    note_cb:   git_note_foreach_cb,
    payload:   pointer
  ): cint {.dynlib: libgitDl, importc.}


