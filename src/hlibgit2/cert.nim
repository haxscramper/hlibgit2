{.push warning[UnusedImport]:off.}

import
  ./libgit_config

type
  git_cert* {.bycopy, header: "<git2/cert.h>", importc.} = object
    cert_type*: git_cert_t
   
  git_cert_hostkey* {.bycopy, header: "<git2/cert.h>", importc.} = object
    parent*: git_cert
    type_f* {.importc: "type".}: git_cert_ssh_t ## The parent cert 
    hash_md5*: ptr UncheckedArray[uint8]
    hash_sha1*: ptr UncheckedArray[uint8]
    hash_sha256*: ptr UncheckedArray[uint8]
   
  git_cert_ssh_t* = enum
    GIT_CERT_SSH_MD5 = 1 ## MD5 is available 
    GIT_CERT_SSH_SHA1 = 2 ## SHA-1 is available 
    GIT_CERT_SSH_SHA256 = 4 ## SHA-256 is available 
   
  git_cert_t* = enum
    GIT_CERT_NONE = 0
    GIT_CERT_X509 = 1
    GIT_CERT_HOSTKEY_LIBSSH2 = 2
    GIT_CERT_STRARRAY = 3
   
  git_cert_x509* {.bycopy, header: "<git2/cert.h>", importc.} = object
    parent*: git_cert
    data*: pointer ## The parent cert 
    len*: csize_t
   
  git_transport_certificate_check_cb* = proc(cert: ptr git_cert, valid: cint, host: cstring, payload: pointer): cint{.cdecl.}
   
  git_transport_certificate_check_cbNim* = proc(cert: ptr git_cert, valid: cint, host: cstring): cint
   

