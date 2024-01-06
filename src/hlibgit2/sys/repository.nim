import "../libgit2_config.nim" ## From gen file
import "../types.nim"
proc git_repository_new*(`out`: ptr ptr git_repository): cint {.importc: "git_repository_new", header: "<sys/repository.h>".}

proc git_repository_cleanup*(repo: ptr git_repository): cint {.importc: "git_repository__cleanup", header: "<sys/repository.h>".}

proc git_repository_reinit_filesystem*(repo: ptr git_repository, recurse_submodules: cint): cint {.importc: "git_repository_reinit_filesystem", header: "<sys/repository.h>".}

proc git_repository_set_config*(repo: ptr git_repository, config: ptr git_config): cint {.importc: "git_repository_set_config", header: "<sys/repository.h>".}

proc git_repository_set_odb*(repo: ptr git_repository, odb: ptr git_odb): cint {.importc: "git_repository_set_odb", header: "<sys/repository.h>".}

proc git_repository_set_refdb*(repo: ptr git_repository, refdb: ptr git_refdb): cint {.importc: "git_repository_set_refdb", header: "<sys/repository.h>".}

proc git_repository_set_index*(repo: ptr git_repository, index: ptr git_index): cint {.importc: "git_repository_set_index", header: "<sys/repository.h>".}

proc git_repository_set_bare*(repo: ptr git_repository): cint {.importc: "git_repository_set_bare", header: "<sys/repository.h>".}

proc git_repository_submodule_cache_all*(repo: ptr git_repository): cint {.importc: "git_repository_submodule_cache_all", header: "<sys/repository.h>".}

proc git_repository_submodule_cache_clear*(repo: ptr git_repository): cint {.importc: "git_repository_submodule_cache_clear", header: "<sys/repository.h>".}