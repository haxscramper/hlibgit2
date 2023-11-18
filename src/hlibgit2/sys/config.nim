import "../../config.nim"
import "../../types.nim"
proc git_config_init_backend*(backend: ptr git_config_backend, version: cuint): cint {.git2Proc, importc.}

proc git_config_add_backend*(cfg: ptr git_config, file: ptr git_config_backend, level: git_config_level_t, repo: ptr git_repository, force: cint): cint {.git2Proc, importc.}