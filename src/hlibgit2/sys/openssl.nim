import "../libgit2_config.nim"
proc git_openssl_set_locking*(): cint {.git2Proc, importc.}