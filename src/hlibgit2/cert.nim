{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  c_git_cert_ssh_t* = enum
    c_GIT_CERT_SSH_MD5    = 1 shl 0 ## MD5 is available     
    c_GIT_CERT_SSH_SHA1   = 1 shl 1 ## SHA-1 is available   
    c_GIT_CERT_SSH_SHA256 = 1 shl 2 ## SHA-256 is available 
   
  c_git_cert_t* = enum
    c_GIT_CERT_NONE            = 0      
    c_GIT_CERT_X509            = 1 shl 0
    c_GIT_CERT_HOSTKEY_LIBSSH2 = 1 shl 1
    c_GIT_CERT_STRARRAY        = 3      
   
  git_cert* {.bycopy, header: "<git2/cert.h>", importc.} = object
    cert_type*: c_git_cert_t
   
  git_cert_hostkey* {.bycopy, header: "<git2/cert.h>", importc.} = object
    parent*:                     git_cert                                     
    type_f* {.importc: "type".}: c_git_cert_ssh_t          ## The parent cert 
    hash_md5*:                   ptr UncheckedArray[uint8]                    
    hash_sha1*:                  ptr UncheckedArray[uint8]                    
    hash_sha256*:                ptr UncheckedArray[uint8]                    
   
  git_cert_ssh_t* {.size: sizeof(cint).} = enum
    GIT_CERT_SSH_MD5    ## MD5 is available     
    GIT_CERT_SSH_SHA1   ## SHA-1 is available   
    GIT_CERT_SSH_SHA256 ## SHA-256 is available 
   
  git_cert_t* = enum
    GIT_CERT_NONE           
    GIT_CERT_X509           
    GIT_CERT_HOSTKEY_LIBSSH2
    GIT_CERT_STRARRAY       
   
  git_cert_x509* {.bycopy, header: "<git2/cert.h>", importc.} = object
    parent*: git_cert                    
    data*:   pointer  ## The parent cert 
    len*:    csize_t                     
   
  git_transport_certificate_check_cb* = proc(cert: ptr git_cert, valid: cint, host: cstring, payload: pointer): cint{.cdecl.}
   
  git_transport_certificate_check_cbNim* = proc(cert: ptr git_cert, valid: cint, host: cstring): cint
   

proc to_c_git_cert_t*(arg: git_cert_t): c_git_cert_t = 
  case arg:
    of GIT_CERT_NONE:
      c_GIT_CERT_NONE
    of GIT_CERT_X509:
      c_GIT_CERT_X509
    of GIT_CERT_HOSTKEY_LIBSSH2:
      c_GIT_CERT_HOSTKEY_LIBSSH2
    of GIT_CERT_STRARRAY:
      c_GIT_CERT_STRARRAY
 

converter to_git_cert_t*(arg: c_git_cert_t): git_cert_t = 
  case arg:
    of c_GIT_CERT_NONE:
      GIT_CERT_NONE
    of c_GIT_CERT_X509:
      GIT_CERT_X509
    of c_GIT_CERT_HOSTKEY_LIBSSH2:
      GIT_CERT_HOSTKEY_LIBSSH2
    of c_GIT_CERT_STRARRAY:
      GIT_CERT_STRARRAY
 

converter toCint*(arg: c_git_cert_t): cint = 
  cint(ord(arg))
 
func `+`*(arg: c_git_cert_t, offset: int): c_git_cert_t = 
  c_git_cert_t(ord(arg) + offset)
 
func `+`*(offset: int, arg: c_git_cert_t): c_git_cert_t = 
  c_git_cert_t(ord(arg) + offset)
 
func `-`*(arg: c_git_cert_t, offset: int): c_git_cert_t = 
  c_git_cert_t(ord(arg) - offset)
 
func `-`*(offset: int, arg: c_git_cert_t): c_git_cert_t = 
  c_git_cert_t(ord(arg) - offset)
 

proc to_c_git_cert_ssh_t*(arg: git_cert_ssh_t): c_git_cert_ssh_t = 
  case arg:
    of GIT_CERT_SSH_MD5:
      c_GIT_CERT_SSH_MD5
    of GIT_CERT_SSH_SHA1:
      c_GIT_CERT_SSH_SHA1
    of GIT_CERT_SSH_SHA256:
      c_GIT_CERT_SSH_SHA256
 

converter to_git_cert_ssh_t*(arg: c_git_cert_ssh_t): git_cert_ssh_t = 
  case arg:
    of c_GIT_CERT_SSH_MD5:
      GIT_CERT_SSH_MD5
    of c_GIT_CERT_SSH_SHA1:
      GIT_CERT_SSH_SHA1
    of c_GIT_CERT_SSH_SHA256:
      GIT_CERT_SSH_SHA256
 

converter toCint*(arg: c_git_cert_ssh_t): cint = 
  cint(ord(arg))
 
func `+`*(arg: c_git_cert_ssh_t, offset: int): c_git_cert_ssh_t = 
  c_git_cert_ssh_t(ord(arg) + offset)
 
func `+`*(offset: int, arg: c_git_cert_ssh_t): c_git_cert_ssh_t = 
  c_git_cert_ssh_t(ord(arg) + offset)
 
func `-`*(arg: c_git_cert_ssh_t, offset: int): c_git_cert_ssh_t = 
  c_git_cert_ssh_t(ord(arg) - offset)
 
func `-`*(offset: int, arg: c_git_cert_ssh_t): c_git_cert_ssh_t = 
  c_git_cert_ssh_t(ord(arg) - offset)
 

converter toCint*(args: set[c_git_cert_ssh_t]): cint = 
  cast[cint](args)
 

