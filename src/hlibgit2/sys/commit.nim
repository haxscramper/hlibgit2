import "../libgit2_config.nim" ## From gen file
import "../types.nim"
import "../oid.nim"

type
  git_commit_parent_callback* = proc (a0: csize_t, a1: pointer): ptr git_oid



proc git_commit_create_from_ids*(
    id: ptr git_oid,
    repo: ptr git_repository,
    update_ref: cstring,
    author: ptr git_signature,
    committer: ptr git_signature,
    message_encoding: cstring,
    message: cstring,
    tree: ptr git_oid,
    parent_count: csize_t,
    parents: ptr ptr git_oid,
): cint {.importc: "git_commit_create_from_ids".}

proc git_commit_create_from_callback*(
    id: ptr git_oid,
    repo: ptr git_repository,
    update_ref: cstring,
    author: ptr git_signature,
    committer: ptr git_signature,
    message_encoding: cstring,
    message: cstring,
    tree: ptr git_oid,
    parent_cb: git_commit_parent_callback,
    parent_payload: pointer,
): cint {.importc: "git_commit_create_from_callback".}