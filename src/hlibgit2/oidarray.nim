{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid

type
  git_oidarray* {.bycopy, header: "<git2/oidarray.h>", importc.} = object
    ## Array of object ids 
    ids*: ptr git_oid
    count*: csize_t
   

proc git_oidarray_free*(
    array: ptr git_oidarray
  ): void {.dynlib: libgit2Dl, importc.}


