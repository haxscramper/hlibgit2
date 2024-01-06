import "./libgit2_config.nim" ## From gen file
proc git_libgit2_init*(): cint {.importc: "git_libgit2_init", header: "<global.h>".}

proc git_libgit2_shutdown*(): cint {.importc: "git_libgit2_shutdown", header: "<global.h>".}