import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./buffer.nim"
import "./types.nim"

type
  git_commit_create_cb* = proc (a0: ptr git_oid, a1: ptr git_signature, a2: ptr git_signature, a3: cstring, a4: cstring, a5: ptr git_tree, a6: csize_t, a7: ptr ptr git_commit, a8: pointer): cint



proc git_commit_lookup*(
    commit: ptr ptr git_commit,
    repo: ptr git_repository,
    id: ptr git_oid,
): cint {.git2Proc, importc: "git_commit_lookup".}

proc git_commit_lookup_prefix*(
    commit: ptr ptr git_commit,
    repo: ptr git_repository,
    id: ptr git_oid,
    len: csize_t,
): cint {.git2Proc, importc: "git_commit_lookup_prefix".}

proc git_commit_free*(commit: ptr git_commit): void {.git2Proc, importc: "git_commit_free".}

proc git_commit_id*(commit: ptr git_commit): ptr git_oid {.git2Proc, importc: "git_commit_id".}

proc git_commit_owner*(commit: ptr git_commit): ptr git_repository {.git2Proc, importc: "git_commit_owner".}

proc git_commit_message_encoding*(commit: ptr git_commit): cstring {.git2Proc, importc: "git_commit_message_encoding".}

proc git_commit_message*(commit: ptr git_commit): cstring {.git2Proc, importc: "git_commit_message".}

proc git_commit_message_raw*(commit: ptr git_commit): cstring {.git2Proc, importc: "git_commit_message_raw".}

proc git_commit_summary*(commit: ptr git_commit): cstring {.git2Proc, importc: "git_commit_summary".}

proc git_commit_body*(commit: ptr git_commit): cstring {.git2Proc, importc: "git_commit_body".}

proc git_commit_time*(commit: ptr git_commit): git_time_t {.git2Proc, importc: "git_commit_time".}

proc git_commit_time_offset*(commit: ptr git_commit): cint {.git2Proc, importc: "git_commit_time_offset".}

proc git_commit_committer*(commit: ptr git_commit): ptr git_signature {.git2Proc, importc: "git_commit_committer".}

proc git_commit_author*(commit: ptr git_commit): ptr git_signature {.git2Proc, importc: "git_commit_author".}

proc git_commit_committer_with_mailmap*(
    `out`: ptr ptr git_signature,
    commit: ptr git_commit,
    mailmap: ptr git_mailmap,
): cint {.git2Proc, importc: "git_commit_committer_with_mailmap".}

proc git_commit_author_with_mailmap*(
    `out`: ptr ptr git_signature,
    commit: ptr git_commit,
    mailmap: ptr git_mailmap,
): cint {.git2Proc, importc: "git_commit_author_with_mailmap".}

proc git_commit_raw_header*(commit: ptr git_commit): cstring {.git2Proc, importc: "git_commit_raw_header".}

proc git_commit_tree*(tree_out: ptr ptr git_tree, commit: ptr git_commit): cint {.git2Proc, importc: "git_commit_tree".}

proc git_commit_tree_id*(commit: ptr git_commit): ptr git_oid {.git2Proc, importc: "git_commit_tree_id".}

proc git_commit_parentcount*(commit: ptr git_commit): cuint {.git2Proc, importc: "git_commit_parentcount".}

proc git_commit_parent*(
    `out`: ptr ptr git_commit,
    commit: ptr git_commit,
    n: cuint,
): cint {.git2Proc, importc: "git_commit_parent".}

proc git_commit_parent_id*(commit: ptr git_commit, n: cuint): ptr git_oid {.git2Proc, importc: "git_commit_parent_id".}

proc git_commit_nth_gen_ancestor*(
    ancestor: ptr ptr git_commit,
    commit: ptr git_commit,
    n: cuint,
): cint {.git2Proc, importc: "git_commit_nth_gen_ancestor".}

proc git_commit_header_field*(
    `out`: ptr git_buf,
    commit: ptr git_commit,
    field: cstring,
): cint {.git2Proc, importc: "git_commit_header_field".}

proc git_commit_extract_signature*(
    signature: ptr git_buf,
    signed_data: ptr git_buf,
    repo: ptr git_repository,
    commit_id: ptr git_oid,
    field: cstring,
): cint {.git2Proc, importc: "git_commit_extract_signature".}

proc git_commit_create*(
    id: ptr git_oid,
    repo: ptr git_repository,
    update_ref: cstring,
    author: ptr git_signature,
    committer: ptr git_signature,
    message_encoding: cstring,
    message: cstring,
    tree: ptr git_tree,
    parent_count: csize_t,
    parents: ptr ptr git_commit,
): cint {.git2Proc, importc: "git_commit_create".}

proc git_commit_create_v*(
    id: ptr git_oid,
    repo: ptr git_repository,
    update_ref: cstring,
    author: ptr git_signature,
    committer: ptr git_signature,
    message_encoding: cstring,
    message: cstring,
    tree: ptr git_tree,
    parent_count: csize_t,
): cint {.git2Proc, importc: "git_commit_create_v".}

proc git_commit_amend*(
    id: ptr git_oid,
    commit_to_amend: ptr git_commit,
    update_ref: cstring,
    author: ptr git_signature,
    committer: ptr git_signature,
    message_encoding: cstring,
    message: cstring,
    tree: ptr git_tree,
): cint {.git2Proc, importc: "git_commit_amend".}

proc git_commit_create_buffer*(
    `out`: ptr git_buf,
    repo: ptr git_repository,
    author: ptr git_signature,
    committer: ptr git_signature,
    message_encoding: cstring,
    message: cstring,
    tree: ptr git_tree,
    parent_count: csize_t,
    parents: ptr ptr git_commit,
): cint {.git2Proc, importc: "git_commit_create_buffer".}

proc git_commit_create_with_signature*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    commit_content: cstring,
    signature: cstring,
    signature_field: cstring,
): cint {.git2Proc, importc: "git_commit_create_with_signature".}

proc git_commit_dup*(`out`: ptr ptr git_commit, source: ptr git_commit): cint {.git2Proc, importc: "git_commit_dup".}