{.push warning[UnusedImport]:off.}

import
  ./credential,
  ./libgit2_config

type
  git_credential_userpass_payload* {.bycopy,
                                     header: "<git2/credential_helpers.h>",
                                     importc.} = object
    username*: cstring
    password*: cstring
   

proc git_credential_userpass*(
    arg_out:       ptr ptr git_credential,
    url:           cstring,
    user_from_url: cstring,
    allowed_types: cuint,
    payload:       pointer
  ): cint {.git2Proc, importc.}
  
 

