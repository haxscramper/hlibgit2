{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

proc git_libgit2_init*(a0: void): cint {.git2Proc, importc.}



proc git_libgit2_shutdown*(a0: void): cint {.git2Proc, importc.}



