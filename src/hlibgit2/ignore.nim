{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./types

proc git_ignore_add_rule*(
    repo:  ptr git_repository,
    rules: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_ignore_clear_internal_rules*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_ignore_path_is_ignored*(
    ignored: ptr cint,
    repo:    ptr git_repository,
    path:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


