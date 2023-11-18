import "../../types.nim"
proc git_repository_new*(out: ptr git_repository): cint {.git2Proc, importc.}

proc git_repository__cleanup*(repo: ptr git_repository): cint {.git2Proc, importc.}

proc git_repository_reinit_filesystem*(repo: ptr git_repository, recurse_submodules: cint): cint {.git2Proc, importc.}

proc git_repository_set_config*(repo: ptr git_repository, config: ptr git_config): cint {.git2Proc, importc.}

proc git_repository_set_odb*(repo: ptr git_repository, odb: ptr git_odb): cint {.git2Proc, importc.}

proc git_repository_set_refdb*(repo: ptr git_repository, refdb: ptr git_refdb): cint {.git2Proc, importc.}

proc git_repository_set_index*(repo: ptr git_repository, index: ptr git_index): cint {.git2Proc, importc.}

proc git_repository_set_bare*(repo: ptr git_repository): cint {.git2Proc, importc.}

proc git_repository_submodule_cache_all*(repo: ptr git_repository): cint {.git2Proc, importc.}

proc git_repository_submodule_cache_clear*(repo: ptr git_repository): cint {.git2Proc, importc.}