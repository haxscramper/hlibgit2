import "./libgit2_config.nim" ## From gen file
import "./types.nim"
proc git_refdb_compress*(refdb: ptr git_refdb): cint {.importc: "git_refdb_compress", header: "<refdb.h>".}

proc git_refdb_free*(refdb: ptr git_refdb): void {.importc: "git_refdb_free", header: "<refdb.h>".}

proc git_refdb_new*(`out`: ptr ptr git_refdb, repo: ptr git_repository): cint {.importc: "git_refdb_new", header: "<refdb.h>".}

proc git_refdb_open*(`out`: ptr ptr git_refdb, repo: ptr git_repository): cint {.importc: "git_refdb_open", header: "<refdb.h>".}