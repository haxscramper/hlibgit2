import "../libgit2_config.nim" ## From gen file
proc git_openssl_set_locking*(): cint {.git2Proc, importc: "git_openssl_set_locking".}