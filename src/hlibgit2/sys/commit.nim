type

  git_commit_parent_callback = proc (a0: csize_t, a1: ptr void): ptr git_oid



proc `git_commit_create_from_ids`*(id: ptr git_oid, repo: ptr git_repository, update_ref: cstring, author: ptr git_signature, committer: ptr git_signature, message_encoding: cstring, message: cstring, tree: ptr git_oid, parent_count: csize_t, parents: ptr git_oid): cint {.git2Proc, importc.}

proc `git_commit_create_from_callback`*(id: ptr git_oid, repo: ptr git_repository, update_ref: cstring, author: ptr git_signature, committer: ptr git_signature, message_encoding: cstring, message: cstring, tree: ptr git_oid, parent_cb: git_commit_parent_callback, parent_payload: ptr void): cint {.git2Proc, importc.}