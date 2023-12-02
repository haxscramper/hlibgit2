import "./libgit2_config.nim" ## From gen file
import "./types.nim"
proc git_refdb_compress*(refdb: `ptr` git_refdb): cint {.git2Proc, importc: "git_refdb_compress".}

proc git_refdb_free*(refdb: `ptr` git_refdb): void {.git2Proc, importc: "git_refdb_free".}

proc git_refdb_new*(`out`: `ptr` git_refdb, repo: `ptr` git_repository): cint {.git2Proc, importc: "git_refdb_new".}

proc git_refdb_open*(`out`: `ptr` git_refdb, repo: `ptr` git_repository): cint {.git2Proc, importc: "git_refdb_open".}