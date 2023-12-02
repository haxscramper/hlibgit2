import "./libgit2_config.nim" ## From gen file
import "./credential.nim"

type
  git_credential_userpass_payload* {.importc, bycopy.} = object
    username *: cstring
    password *: cstring



proc git_credential_userpass*(`out`: `ptr` git_credential, url: cstring, user_from_url: cstring, allowed_types: cuint, payload: pointer): cint {.git2Proc, importc: "git_credential_userpass".}