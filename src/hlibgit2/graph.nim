import
  ./libgit_config

import
  ./oid





proc git_graph_ahead_behind*(
    ahead:    ptr size_t,
    behind:   ptr size_t,
    repo:     ptr git_repository,
    local:    ptr git_oid,
    upstream: ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_graph_descendant_of*(
    repo:     ptr git_repository,
    commit:   ptr git_oid,
    ancestor: ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


