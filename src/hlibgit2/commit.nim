import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./oid.nim"
import "./buffer.nim"

type
  git_commit_create_cb* = proc (a0: ptr git_oid, a1: ptr git_signature, a2: ptr git_signature, a3: cstring, a4: cstring, a5: ptr git_tree, a6: csize_t, a7: ptr ptr git_commit, a8: pointer): cint



proc git_commit_lookup*(
    commit: ptr ptr git_commit,
    repo: ptr git_repository,
    id: ptr git_oid,
): cint {.importc: "git_commit_lookup", header: "<commit.h>".}

proc git_commit_lookup_prefix*(
    commit: ptr ptr git_commit,
    repo: ptr git_repository,
    id: ptr git_oid,
    len: csize_t,
): cint {.importc: "git_commit_lookup_prefix", header: "<commit.h>".}

proc git_commit_free*(commit: ptr git_commit): void {.importc: "git_commit_free", header: "<commit.h>".}

proc git_commit_id*(commit: ptr git_commit): ptr git_oid {.importc: "git_commit_id", header: "<commit.h>".}

proc git_commit_owner*(commit: ptr git_commit): ptr git_repository {.importc: "git_commit_owner", header: "<commit.h>".}

proc git_commit_message_encoding*(commit: ptr git_commit): cstring {.importc: "git_commit_message_encoding", header: "<commit.h>".}

proc git_commit_message*(commit: ptr git_commit): cstring {.importc: "git_commit_message", header: "<commit.h>".}

proc git_commit_message_raw*(commit: ptr git_commit): cstring {.importc: "git_commit_message_raw", header: "<commit.h>".}

proc git_commit_summary*(commit: ptr git_commit): cstring {.importc: "git_commit_summary", header: "<commit.h>".}

proc git_commit_body*(commit: ptr git_commit): cstring {.importc: "git_commit_body", header: "<commit.h>".}

proc git_commit_time*(commit: ptr git_commit): git_time_t {.importc: "git_commit_time", header: "<commit.h>".}

proc git_commit_time_offset*(commit: ptr git_commit): cint {.importc: "git_commit_time_offset", header: "<commit.h>".}

proc git_commit_committer*(commit: ptr git_commit): ptr git_signature {.importc: "git_commit_committer", header: "<commit.h>".}

proc git_commit_author*(commit: ptr git_commit): ptr git_signature {.importc: "git_commit_author", header: "<commit.h>".}

proc git_commit_committer_with_mailmap*(
    `out`: ptr ptr git_signature,
    commit: ptr git_commit,
    mailmap: ptr git_mailmap,
): cint {.importc: "git_commit_committer_with_mailmap", header: "<commit.h>".}

proc git_commit_author_with_mailmap*(
    `out`: ptr ptr git_signature,
    commit: ptr git_commit,
    mailmap: ptr git_mailmap,
): cint {.importc: "git_commit_author_with_mailmap", header: "<commit.h>".}

proc git_commit_raw_header*(commit: ptr git_commit): cstring {.importc: "git_commit_raw_header", header: "<commit.h>".}

proc git_commit_tree*(tree_out: ptr ptr git_tree, commit: ptr git_commit): cint {.importc: "git_commit_tree", header: "<commit.h>".}

proc git_commit_tree_id*(commit: ptr git_commit): ptr git_oid {.importc: "git_commit_tree_id", header: "<commit.h>".}

proc git_commit_parentcount*(commit: ptr git_commit): cuint {.importc: "git_commit_parentcount", header: "<commit.h>".}

proc git_commit_parent*(
    `out`: ptr ptr git_commit,
    commit: ptr git_commit,
    n: cuint,
): cint {.importc: "git_commit_parent", header: "<commit.h>".}

proc git_commit_parent_id*(commit: ptr git_commit, n: cuint): ptr git_oid {.importc: "git_commit_parent_id", header: "<commit.h>".}

proc git_commit_nth_gen_ancestor*(
    ancestor: ptr ptr git_commit,
    commit: ptr git_commit,
    n: cuint,
): cint {.importc: "git_commit_nth_gen_ancestor", header: "<commit.h>".}

proc git_commit_header_field*(
    `out`: ptr git_buf,
    commit: ptr git_commit,
    field: cstring,
): cint {.importc: "git_commit_header_field", header: "<commit.h>".}

proc git_commit_extract_signature*(
    signature: ptr git_buf,
    signed_data: ptr git_buf,
    repo: ptr git_repository,
    commit_id: ptr git_oid,
    field: cstring,
): cint {.importc: "git_commit_extract_signature", header: "<commit.h>".}

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
): cint {.importc: "git_commit_create", header: "<commit.h>".}

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
): cint {.importc: "git_commit_create_v", header: "<commit.h>".}

proc git_commit_amend*(
    id: ptr git_oid,
    commit_to_amend: ptr git_commit,
    update_ref: cstring,
    author: ptr git_signature,
    committer: ptr git_signature,
    message_encoding: cstring,
    message: cstring,
    tree: ptr git_tree,
): cint {.importc: "git_commit_amend", header: "<commit.h>".}

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
): cint {.importc: "git_commit_create_buffer", header: "<commit.h>".}

proc git_commit_create_with_signature*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    commit_content: cstring,
    signature: cstring,
    signature_field: cstring,
): cint {.importc: "git_commit_create_with_signature", header: "<commit.h>".}

proc git_commit_dup*(`out`: ptr ptr git_commit, source: ptr git_commit): cint {.importc: "git_commit_dup", header: "<commit.h>".}