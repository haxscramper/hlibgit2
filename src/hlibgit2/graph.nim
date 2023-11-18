import "../oid.nim"
import "../types.nim"
proc git_graph_ahead_behind*(ahead: ptr csize_t, behind: ptr csize_t, repo: ptr git_repository, local: ptr git_oid, upstream: ptr git_oid): cint {.git2Proc, importc.}

proc git_graph_descendant_of*(repo: ptr git_repository, commit: ptr git_oid, ancestor: ptr git_oid): cint {.git2Proc, importc.}

proc git_graph_reachable_from_any*(repo: ptr git_repository, commit: ptr git_oid, descendant_array: ptr git_oid, length: csize_t): cint {.git2Proc, importc.}