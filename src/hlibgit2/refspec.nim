{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./net,
  ./types

proc git_refspec_parse*(
    refspec:  ptr ptr git_refspec,
    input:    cstring,
    is_fetch: cint
  ): cint {.git2Proc, importc.}
  
 

proc git_refspec_free*(refspec: ptr git_refspec): void {.git2Proc, importc.}
  
 

proc git_refspec_src*(refspec: ptr git_refspec): cstring {.git2Proc, importc.}
  
 

proc git_refspec_dst*(refspec: ptr git_refspec): cstring {.git2Proc, importc.}
  
 

proc git_refspec_string*(
    refspec: ptr git_refspec
  ): cstring {.git2Proc, importc.}
  
 

proc git_refspec_force*(refspec: ptr git_refspec): cint {.git2Proc, importc.}
  
 

proc git_refspec_direction*(
    spec: ptr git_refspec
  ): c_git_direction {.git2Proc, importc.}
  
 

proc git_refspec_src_matches*(
    refspec:  ptr git_refspec,
    refname1: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_refspec_dst_matches*(
    refspec:  ptr git_refspec,
    refname1: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_refspec_transform*(
    arg_out: ptr git_buf,
    spec:    ptr git_refspec,
    name:    cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_refspec_rtransform*(
    arg_out: ptr git_buf,
    spec:    ptr git_refspec,
    name:    cstring
  ): cint {.git2Proc, importc.}
  
 

