import "../libgit2_config.nim" ## From gen file
import "../types.nim"
proc git_repository_new*(`out`: ptr ptr git_repository): cint {.importc: "git_repository_new".}

proc git_repository_cleanup*(repo: ptr git_repository): cint {.importc: "git_repository__cleanup".}

proc git_repository_reinit_filesystem*(repo: ptr git_repository, recurse_submodules: cint): cint {.importc: "git_repository_reinit_filesystem".}

proc git_repository_set_config*(repo: ptr git_repository, config: ptr git_config): cint {.importc: "git_repository_set_config".}

proc git_repository_set_odb*(repo: ptr git_repository, odb: ptr git_odb): cint {.importc: "git_repository_set_odb".}

proc git_repository_set_refdb*(repo: ptr git_repository, refdb: ptr git_refdb): cint {.importc: "git_repository_set_refdb".}

proc git_repository_set_index*(repo: ptr git_repository, index: ptr git_index): cint {.importc: "git_repository_set_index".}

proc git_repository_set_bare*(repo: ptr git_repository): cint {.importc: "git_repository_set_bare".}

proc git_repository_submodule_cache_all*(repo: ptr git_repository): cint {.importc: "git_repository_submodule_cache_all".}

proc git_repository_submodule_cache_clear*(repo: ptr git_repository): cint {.importc: "git_repository_submodule_cache_clear".}