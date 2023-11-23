import "./buffer.nim"
import "./libgit2_config.nim"
import "./types.nim"

type
  git_branch_iterator* {.importc, bycopy, incompleteStruct.} = object




proc git_branch_create*(`out`: `ptr` git_reference, repo: `ptr` git_repository, branch_name: cstring, target: `ptr` git_commit, force: cint): cint {.git2Proc, importc.}

proc git_branch_create_from_annotated*(ref_out: `ptr` git_reference, repository: `ptr` git_repository, branch_name: cstring, commit: `ptr` git_annotated_commit, force: cint): cint {.git2Proc, importc.}

proc git_branch_delete*(branch: `ptr` git_reference): cint {.git2Proc, importc.}

proc git_branch_iterator_new*(`out`: `ptr` git_branch_iterator, repo: `ptr` git_repository, list_flags: git_branch_t): cint {.git2Proc, importc.}

proc git_branch_next*(`out`: `ptr` git_reference, out_type: `ptr` git_branch_t, iter: `ptr` git_branch_iterator): cint {.git2Proc, importc.}

proc git_branch_iterator_free*(iter: `ptr` git_branch_iterator): void {.git2Proc, importc.}

proc git_branch_move*(`out`: `ptr` git_reference, branch: `ptr` git_reference, new_branch_name: cstring, force: cint): cint {.git2Proc, importc.}

proc git_branch_lookup*(`out`: `ptr` git_reference, repo: `ptr` git_repository, branch_name: cstring, branch_type: git_branch_t): cint {.git2Proc, importc.}

proc git_branch_name*(`out`: cstring, `ref`: `ptr` git_reference): cint {.git2Proc, importc.}

proc git_branch_upstream*(`out`: `ptr` git_reference, branch: `ptr` git_reference): cint {.git2Proc, importc.}

proc git_branch_set_upstream*(branch: `ptr` git_reference, branch_name: cstring): cint {.git2Proc, importc.}

proc git_branch_upstream_name*(`out`: `ptr` git_buf, repo: `ptr` git_repository, refname: cstring): cint {.git2Proc, importc.}

proc git_branch_is_head*(branch: `ptr` git_reference): cint {.git2Proc, importc.}

proc git_branch_is_checked_out*(branch: `ptr` git_reference): cint {.git2Proc, importc.}

proc git_branch_remote_name*(`out`: `ptr` git_buf, repo: `ptr` git_repository, refname: cstring): cint {.git2Proc, importc.}

proc git_branch_upstream_remote*(buf: `ptr` git_buf, repo: `ptr` git_repository, refname: cstring): cint {.git2Proc, importc.}

proc git_branch_upstream_merge*(buf: `ptr` git_buf, repo: `ptr` git_repository, refname: cstring): cint {.git2Proc, importc.}

proc git_branch_name_is_valid*(valid: `ptr` cint, name: cstring): cint {.git2Proc, importc.}