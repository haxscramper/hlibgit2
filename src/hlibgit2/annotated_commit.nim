proc `git_annotated_commit_from_ref`*(out: ptr git_annotated_commit, repo: ptr git_repository, ref: ptr git_reference): cint {.git2Proc, importc.}

proc `git_annotated_commit_from_fetchhead`*(out: ptr git_annotated_commit, repo: ptr git_repository, branch_name: cstring, remote_url: cstring, id: ptr git_oid): cint {.git2Proc, importc.}

proc `git_annotated_commit_lookup`*(out: ptr git_annotated_commit, repo: ptr git_repository, id: ptr git_oid): cint {.git2Proc, importc.}

proc `git_annotated_commit_from_revspec`*(out: ptr git_annotated_commit, repo: ptr git_repository, revspec: cstring): cint {.git2Proc, importc.}

proc `git_annotated_commit_id`*(commit: ptr git_annotated_commit): ptr git_oid {.git2Proc, importc.}

proc `git_annotated_commit_ref`*(commit: ptr git_annotated_commit): cstring {.git2Proc, importc.}

proc `git_annotated_commit_free`*(commit: ptr git_annotated_commit): void {.git2Proc, importc.}