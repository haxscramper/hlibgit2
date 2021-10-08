
proc git_libgit2_init*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_libgit2_shutdown*(a0: void): cint {.dynlib: libgitDl, importc.}