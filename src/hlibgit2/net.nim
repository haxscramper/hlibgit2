{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid

type
  git_direction* = enum
    GIT_DIRECTION_FETCH = 0
    GIT_DIRECTION_PUSH = 1
   
  git_remote_head* {.bycopy, header: "<git2/net.h>", importc.} = object
    local*: cint
    oid*: git_oid ## available locally 
    loid*: git_oid
    name*: cstring
    symref_target*: cstring
   

