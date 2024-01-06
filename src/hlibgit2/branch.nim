import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./buffer.nim"

type
  git_branch_iterator* {.header: "<branch.h>", importc, incompleteStruct.} = object




proc git_branch_create*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    branch_name: cstring,
    target: ptr git_commit,
    force: cint,
): cint {.importc: "git_branch_create", header: "<branch.h>".}

proc git_branch_create_from_annotated*(
    ref_out: ptr ptr git_reference,
    repository: ptr git_repository,
    branch_name: cstring,
    commit: ptr git_annotated_commit,
    force: cint,
): cint {.importc: "git_branch_create_from_annotated", header: "<branch.h>".}

proc git_branch_delete*(branch: ptr git_reference): cint {.importc: "git_branch_delete", header: "<branch.h>".}

proc git_branch_iterator_new*(
    `out`: ptr ptr git_branch_iterator,
    repo: ptr git_repository,
    list_flags: git_branch_t,
): cint {.importc: "git_branch_iterator_new", header: "<branch.h>".}

proc git_branch_next*(
    `out`: ptr ptr git_reference,
    out_type: ptr git_branch_t,
    iter: ptr git_branch_iterator,
): cint {.importc: "git_branch_next", header: "<branch.h>".}

proc git_branch_iterator_free*(iter: ptr git_branch_iterator): void {.importc: "git_branch_iterator_free", header: "<branch.h>".}

proc git_branch_move*(
    `out`: ptr ptr git_reference,
    branch: ptr git_reference,
    new_branch_name: cstring,
    force: cint,
): cint {.importc: "git_branch_move", header: "<branch.h>".}

proc git_branch_lookup*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    branch_name: cstring,
    branch_type: git_branch_t,
): cint {.importc: "git_branch_lookup", header: "<branch.h>".}

proc git_branch_name*(`out`: cstringArray, `ref`: ptr git_reference): cint {.importc: "git_branch_name", header: "<branch.h>".}

proc git_branch_upstream*(`out`: ptr ptr git_reference, branch: ptr git_reference): cint {.importc: "git_branch_upstream", header: "<branch.h>".}

proc git_branch_set_upstream*(branch: ptr git_reference, branch_name: cstring): cint {.importc: "git_branch_set_upstream", header: "<branch.h>".}

proc git_branch_upstream_name*(
    `out`: ptr git_buf,
    repo: ptr git_repository,
    refname: cstring,
): cint {.importc: "git_branch_upstream_name", header: "<branch.h>".}

proc git_branch_is_head*(branch: ptr git_reference): cint {.importc: "git_branch_is_head", header: "<branch.h>".}

proc git_branch_is_checked_out*(branch: ptr git_reference): cint {.importc: "git_branch_is_checked_out", header: "<branch.h>".}

proc git_branch_remote_name*(
    `out`: ptr git_buf,
    repo: ptr git_repository,
    refname: cstring,
): cint {.importc: "git_branch_remote_name", header: "<branch.h>".}

proc git_branch_upstream_remote*(
    buf: ptr git_buf,
    repo: ptr git_repository,
    refname: cstring,
): cint {.importc: "git_branch_upstream_remote", header: "<branch.h>".}

proc git_branch_upstream_merge*(
    buf: ptr git_buf,
    repo: ptr git_repository,
    refname: cstring,
): cint {.importc: "git_branch_upstream_merge", header: "<branch.h>".}

proc git_branch_name_is_valid*(valid: ptr cint, name: cstring): cint {.importc: "git_branch_name_is_valid", header: "<branch.h>".}