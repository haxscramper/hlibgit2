{.push warning[UnusedImport]:off.}

import
  ./cert,
  ./credential,
  ./libgit2_config

type
  git_proxy_options* {.bycopy, header: "<git2/proxy.h>", importc.} = object
    version*: cuint
    type_f* {.importc: "type".}: git_proxy_t
    url*: cstring
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    payload*: pointer
   
  git_proxy_t* = enum
    GIT_PROXY_NONE = 0
    GIT_PROXY_AUTO = 1
    GIT_PROXY_SPECIFIED = 2
   

proc git_proxy_options_init*(
    opts:    ptr git_proxy_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


