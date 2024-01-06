import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./oid.nim"
proc git_annotated_commit_from_ref*(
    `out`: ptr ptr git_annotated_commit,
    repo: ptr git_repository,
    `ref`: ptr git_reference,
): cint {.importc: "git_annotated_commit_from_ref", header: "<annotated_commit.h>".}

proc git_annotated_commit_from_fetchhead*(
    `out`: ptr ptr git_annotated_commit,
    repo: ptr git_repository,
    branch_name: cstring,
    remote_url: cstring,
    id: ptr git_oid,
): cint {.importc: "git_annotated_commit_from_fetchhead", header: "<annotated_commit.h>".}

proc git_annotated_commit_lookup*(
    `out`: ptr ptr git_annotated_commit,
    repo: ptr git_repository,
    id: ptr git_oid,
): cint {.importc: "git_annotated_commit_lookup", header: "<annotated_commit.h>".}

proc git_annotated_commit_from_revspec*(
    `out`: ptr ptr git_annotated_commit,
    repo: ptr git_repository,
    revspec: cstring,
): cint {.importc: "git_annotated_commit_from_revspec", header: "<annotated_commit.h>".}

proc git_annotated_commit_id*(commit: ptr git_annotated_commit): ptr git_oid {.importc: "git_annotated_commit_id", header: "<annotated_commit.h>".}

proc git_annotated_commit_ref*(commit: ptr git_annotated_commit): cstring {.importc: "git_annotated_commit_ref", header: "<annotated_commit.h>".}

proc git_annotated_commit_free*(commit: ptr git_annotated_commit): void {.importc: "git_annotated_commit_free", header: "<annotated_commit.h>".}