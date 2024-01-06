import "./libgit2_config.nim" ## From gen file
import "./types.nim"
proc git_ignore_add_rule*(repo: ptr git_repository, rules: cstring): cint {.importc: "git_ignore_add_rule".}

proc git_ignore_clear_internal_rules*(repo: ptr git_repository): cint {.importc: "git_ignore_clear_internal_rules".}

proc git_ignore_path_is_ignored*(
    ignored: ptr cint,
    repo: ptr git_repository,
    path: cstring,
): cint {.importc: "git_ignore_path_is_ignored".}