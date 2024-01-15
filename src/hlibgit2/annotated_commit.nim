import "./types.nim"
import "./oid.nim"
proc git_annotated_commit_from_ref*(
    `out`: ptr ptr git_annotated_commit,
    repo: ptr git_repository,
    `ref`: ptr git_reference,
): cint {.importc: "git_annotated_commit_from_ref".}

proc git_annotated_commit_from_fetchhead*(
    `out`: ptr ptr git_annotated_commit,
    repo: ptr git_repository,
    branch_name: cstring,
    remote_url: cstring,
    id: ptr git_oid,
): cint {.importc: "git_annotated_commit_from_fetchhead".}

proc git_annotated_commit_lookup*(
    `out`: ptr ptr git_annotated_commit,
    repo: ptr git_repository,
    id: ptr git_oid,
): cint {.importc: "git_annotated_commit_lookup".}

proc git_annotated_commit_from_revspec*(
    `out`: ptr ptr git_annotated_commit,
    repo: ptr git_repository,
    revspec: cstring,
): cint {.importc: "git_annotated_commit_from_revspec".}

proc git_annotated_commit_id*(commit: ptr git_annotated_commit): ptr git_oid {.importc: "git_annotated_commit_id".}

proc git_annotated_commit_ref*(commit: ptr git_annotated_commit): cstring {.importc: "git_annotated_commit_ref".}

proc git_annotated_commit_free*(commit: ptr git_annotated_commit): void {.importc: "git_annotated_commit_free".}