{.push warning[UnusedImport]:off.}

import
  ./libgit_config

type
  git_strarray* {.bycopy, header: "<git2/strarray.h>", importc.} = object
    ## Array of strings 
    strings*: ptr cstring
    count*: csize_t
   

proc git_strarray_dispose*(
    array: ptr git_strarray
  ): void {.dynlib: libgitDl, importc.}


proc git_strarray_copy*(
    tgt: ptr git_strarray,
    src: ptr git_strarray
  ): cint {.dynlib: libgitDl, importc.}


