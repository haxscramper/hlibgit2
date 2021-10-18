{.push warning[UnusedImport]:off.}

import
  ./cert,
  ./credential,
  ./libgit2_config

type
  c_git_proxy_t* = enum
    c_GIT_PROXY_NONE      = 0      
    c_GIT_PROXY_AUTO      = 1 shl 0
    c_GIT_PROXY_SPECIFIED = 1 shl 1
   
  git_proxy_options* {.bycopy, header: "<git2/proxy.h>", importc.} = object
    version*:                    cuint                             
    type_f* {.importc: "type".}: c_git_proxy_t                     
    url*:                        cstring                           
    credentials*:                git_credential_acquire_cb         
    certificate_check*:          git_transport_certificate_check_cb
    payload*:                    pointer                           
   
  git_proxy_t* = enum
    GIT_PROXY_NONE     
    GIT_PROXY_AUTO     
    GIT_PROXY_SPECIFIED
   

proc to_c_git_proxy_t*(arg: git_proxy_t): c_git_proxy_t = 
  case arg:
    of GIT_PROXY_NONE:
      c_GIT_PROXY_NONE
    of GIT_PROXY_AUTO:
      c_GIT_PROXY_AUTO
    of GIT_PROXY_SPECIFIED:
      c_GIT_PROXY_SPECIFIED
 

converter to_git_proxy_t*(arg: c_git_proxy_t): git_proxy_t = 
  case arg:
    of c_GIT_PROXY_NONE:
      GIT_PROXY_NONE
    of c_GIT_PROXY_AUTO:
      GIT_PROXY_AUTO
    of c_GIT_PROXY_SPECIFIED:
      GIT_PROXY_SPECIFIED
 

converter toCint*(arg: c_git_proxy_t): cint = 
  cint(ord(arg))
 
func `+`*(arg: c_git_proxy_t, offset: int): c_git_proxy_t = 
  c_git_proxy_t(ord(arg) + offset)
 
func `+`*(offset: int, arg: c_git_proxy_t): c_git_proxy_t = 
  c_git_proxy_t(ord(arg) + offset)
 
func `-`*(arg: c_git_proxy_t, offset: int): c_git_proxy_t = 
  c_git_proxy_t(ord(arg) - offset)
 
func `-`*(offset: int, arg: c_git_proxy_t): c_git_proxy_t = 
  c_git_proxy_t(ord(arg) - offset)
 

proc git_proxy_options_init*(
    opts:    ptr git_proxy_options,
    version: cuint
  ): cint {.git2Proc, importc.}
  
 

