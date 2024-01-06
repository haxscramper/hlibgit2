import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./oid.nim"
import "./buffer.nim"

type
  git_note_iterator* {.header: "<notes.h>", importc, incompleteStruct.} = object


  git_note_foreach_cb* = proc (a0: ptr git_oid, a1: ptr git_oid, a2: pointer): cint



proc git_note_iterator_new*(
    `out`: ptr ptr git_note_iterator,
    repo: ptr git_repository,
    notes_ref: cstring,
): cint {.importc: "git_note_iterator_new", header: "<notes.h>".}

proc git_note_commit_iterator_new*(`out`: ptr ptr git_note_iterator, notes_commit: ptr git_commit): cint {.importc: "git_note_commit_iterator_new", header: "<notes.h>".}

proc git_note_iterator_free*(it: ptr git_note_iterator): void {.importc: "git_note_iterator_free", header: "<notes.h>".}

proc git_note_next*(
    note_id: ptr git_oid,
    annotated_id: ptr git_oid,
    it: ptr git_note_iterator,
): cint {.importc: "git_note_next", header: "<notes.h>".}

proc git_note_read*(
    `out`: ptr ptr git_note,
    repo: ptr git_repository,
    notes_ref: cstring,
    oid: ptr git_oid,
): cint {.importc: "git_note_read", header: "<notes.h>".}

proc git_note_commit_read*(
    `out`: ptr ptr git_note,
    repo: ptr git_repository,
    notes_commit: ptr git_commit,
    oid: ptr git_oid,
): cint {.importc: "git_note_commit_read", header: "<notes.h>".}

proc git_note_author*(note: ptr git_note): ptr git_signature {.importc: "git_note_author", header: "<notes.h>".}

proc git_note_committer*(note: ptr git_note): ptr git_signature {.importc: "git_note_committer", header: "<notes.h>".}

proc git_note_message*(note: ptr git_note): cstring {.importc: "git_note_message", header: "<notes.h>".}

proc git_note_id*(note: ptr git_note): ptr git_oid {.importc: "git_note_id", header: "<notes.h>".}

proc git_note_create*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    notes_ref: cstring,
    author: ptr git_signature,
    committer: ptr git_signature,
    oid: ptr git_oid,
    note: cstring,
    force: cint,
): cint {.importc: "git_note_create", header: "<notes.h>".}

proc git_note_commit_create*(
    notes_commit_out: ptr git_oid,
    notes_blob_out: ptr git_oid,
    repo: ptr git_repository,
    parent: ptr git_commit,
    author: ptr git_signature,
    committer: ptr git_signature,
    oid: ptr git_oid,
    note: cstring,
    allow_note_overwrite: cint,
): cint {.importc: "git_note_commit_create", header: "<notes.h>".}

proc git_note_remove*(
    repo: ptr git_repository,
    notes_ref: cstring,
    author: ptr git_signature,
    committer: ptr git_signature,
    oid: ptr git_oid,
): cint {.importc: "git_note_remove", header: "<notes.h>".}

proc git_note_commit_remove*(
    notes_commit_out: ptr git_oid,
    repo: ptr git_repository,
    notes_commit: ptr git_commit,
    author: ptr git_signature,
    committer: ptr git_signature,
    oid: ptr git_oid,
): cint {.importc: "git_note_commit_remove", header: "<notes.h>".}

proc git_note_free*(note: ptr git_note): void {.importc: "git_note_free", header: "<notes.h>".}

proc git_note_default_ref*(`out`: ptr git_buf, repo: ptr git_repository): cint {.importc: "git_note_default_ref", header: "<notes.h>".}

proc git_note_foreach*(
    repo: ptr git_repository,
    notes_ref: cstring,
    note_cb: git_note_foreach_cb,
    payload: pointer,
): cint {.importc: "git_note_foreach", header: "<notes.h>".}