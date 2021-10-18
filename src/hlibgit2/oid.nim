{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  git_oid* {.bycopy, header: "<git2/oid.h>", importc.} = object
    ## Size (in bytes) of a raw/binary oid 
    ## Size (in bytes) of a hex formatted oid 
    ## Unique identity of any object (commit, tree, blob, tag). 
    id*: ptr UncheckedArray[uint8] ## raw binary formatted id 
   
  git_oid_shorten* {.bycopy, incompleteStruct, header: "<git2/oid.h>", importc.} = object
    
   

proc git_oid_fromstr*(
    arg_out: ptr git_oid,
    str:     cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_fromstrp*(
    arg_out: ptr git_oid,
    str:     cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_fromstrn*(
    arg_out: ptr git_oid,
    str:     cstring,
    length:  csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_fromraw*(
    arg_out: ptr git_oid,
    raw:     ptr uint8
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_fmt*(arg_out: cstring, id: ptr git_oid): cint {.git2Proc, importc.}
  
 

proc git_oid_nfmt*(
    arg_out: cstring,
    n:       csize_t,
    id:      ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_pathfmt*(
    arg_out: cstring,
    id:      ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_tostr_s*(oid: ptr git_oid): cstring {.git2Proc, importc.}
  
 

proc git_oid_tostr*(
    arg_out: cstring,
    n:       csize_t,
    id:      ptr git_oid
  ): cstring {.git2Proc, importc.}
  
 

proc git_oid_cpy*(
    arg_out: ptr git_oid,
    src:     ptr git_oid
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_cmp*(a: ptr git_oid, b: ptr git_oid): cint {.git2Proc, importc.}
  
 

proc git_oid_equal*(a: ptr git_oid, b: ptr git_oid): cint {.git2Proc, importc.}
  
 

proc git_oid_ncmp*(
    a:   ptr git_oid,
    b:   ptr git_oid,
    len: csize_t
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_streq*(id: ptr git_oid, str: cstring): cint {.git2Proc, importc.}
  
 

proc git_oid_strcmp*(id: ptr git_oid, str: cstring): cint {.git2Proc, importc.}
  
 

proc git_oid_is_zero*(id: ptr git_oid): cint {.git2Proc, importc.}
  
 

proc git_oid_shorten_new*(
    min_length: csize_t
  ): ptr git_oid_shorten {.git2Proc, importc.}
  
 

proc git_oid_shorten_add*(
    os:      ptr git_oid_shorten,
    text_id: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_oid_shorten_free*(os: ptr git_oid_shorten): void {.git2Proc, importc.}
  
 

