import "./libgit2_config.nim" ## From gen file
proc git_libgit2_init*(): cint {.importc: "git_libgit2_init".}

proc git_libgit2_shutdown*(): cint {.importc: "git_libgit2_shutdown".}