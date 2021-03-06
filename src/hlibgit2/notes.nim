{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./oid,
  ./types

type
  git_note_foreach_cb* = proc(blob_id:             ptr git_oid,
                              annotated_object_id: ptr git_oid,
                              payload:             pointer): cint{.cdecl.}

  git_note_iterator* = git_iterator


proc git_note_iterator_new*(
    arg_out:   ptr ptr git_note_iterator,
    repo:      ptr git_repository,
    notes_ref: cstring
  ): cint {.git2Proc, importc.}



proc git_note_commit_iterator_new*(
    arg_out:      ptr ptr git_note_iterator,
    notes_commit: ptr git_commit
  ): cint {.git2Proc, importc.}



proc git_note_iterator_free*(
    it: ptr git_note_iterator
  ): void {.git2Proc, importc.}



proc git_note_next*(
    note_id:      ptr git_oid,
    annotated_id: ptr git_oid,
    it:           ptr git_note_iterator
  ): cint {.git2Proc, importc.}



proc git_note_read*(
    arg_out:   ptr ptr git_note,
    repo:      ptr git_repository,
    notes_ref: cstring,
    oid:       ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_note_commit_read*(
    arg_out:      ptr ptr git_note,
    repo:         ptr git_repository,
    notes_commit: ptr git_commit,
    oid:          ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_note_author*(
    note: ptr git_note
  ): ptr git_signature {.git2Proc, importc.}



proc git_note_committer*(
    note: ptr git_note
  ): ptr git_signature {.git2Proc, importc.}



proc git_note_message*(note: ptr git_note): cstring {.git2Proc, importc.}



proc git_note_id*(note: ptr git_note): ptr git_oid {.git2Proc, importc.}



proc git_note_create*(
    arg_out:   ptr git_oid,
    repo:      ptr git_repository,
    notes_ref: cstring,
    author:    ptr git_signature,
    committer: ptr git_signature,
    oid:       ptr git_oid,
    note:      cstring,
    force:     cint
  ): cint {.git2Proc, importc.}



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
  ): cint {.git2Proc, importc.}



proc git_note_remove*(
    repo:      ptr git_repository,
    notes_ref: cstring,
    author:    ptr git_signature,
    committer: ptr git_signature,
    oid:       ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_note_commit_remove*(
    notes_commit_out: ptr git_oid,
    repo:             ptr git_repository,
    notes_commit:     ptr git_commit,
    author:           ptr git_signature,
    committer:        ptr git_signature,
    oid:              ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_note_free*(note: ptr git_note): void {.git2Proc, importc.}



proc git_note_default_ref*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_note_foreach*(
    repo:      ptr git_repository,
    notes_ref: cstring,
    note_cb:   git_note_foreach_cb,
    payload:   pointer
  ): cint {.git2Proc, importc.}



