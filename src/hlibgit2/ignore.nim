proc `git_ignore_add_rule`*(repo: ptr git_repository, rules: cstring): cint {.git2Proc, importc.}

proc `git_ignore_clear_internal_rules`*(repo: ptr git_repository): cint {.git2Proc, importc.}

proc `git_ignore_path_is_ignored`*(ignored: ptr cint, repo: ptr git_repository, path: cstring): cint {.git2Proc, importc.}