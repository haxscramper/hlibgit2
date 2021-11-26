{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./types

proc git_refdb_new*(
    arg_out: ptr ptr git_refdb,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_refdb_open*(
    arg_out: ptr ptr git_refdb,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_refdb_compress*(refdb: ptr git_refdb): cint {.git2Proc, importc.}



proc git_refdb_free*(refdb: ptr git_refdb): void {.git2Proc, importc.}



