{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  git_strarray* {.bycopy, header: "<git2/strarray.h>", importc.} = object
    ## Array of strings 
    strings*: ptr cstring
    count*:   csize_t    
   

proc git_strarray_dispose*(array: ptr git_strarray): void {.git2Proc, importc.}
  
 

proc git_strarray_copy*(
    tgt: ptr git_strarray,
    src: ptr git_strarray
  ): cint {.git2Proc, importc.}
  
 

