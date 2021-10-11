{.push warning[UnusedImport]:off.}

import
  ./libgit_config

type
  LIBSSH2_SESSION* = LIBSSH2_SESSION
   
  LIBSSH2_USERAUTH_KBDINT_PROMPT* = LIBSSH2_USERAUTH_KBDINT_PROMPT
   
  LIBSSH2_USERAUTH_KBDINT_RESPONSE* = LIBSSH2_USERAUTH_KBDINT_RESPONSE
   
  git_credential* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_acquire_cb* = proc(arg_out: ptr ptr git_credential, url: cstring, username_from_url: cstring, allowed_types: cuint, payload: pointer): cint{.cdecl.}
   
  git_credential_acquire_cbNim* = proc(arg_out: ptr ptr git_credential, url: cstring, username_from_url: cstring, allowed_types: cuint): cint
   
  git_credential_default* = git_credential
   
  git_credential_sign_cb* = proc(session: ptr LIBSSH2_SESSION, sig: ptr ptr uint8, sig_len: ptr csize_t, data: ptr uint8, data_len: csize_t, abstract: ptr pointer): cint{.cdecl.}
   
  git_credential_ssh_custom* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_ssh_interactive* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_ssh_interactive_cb* = proc(name: cstring, name_len: cint, instruction: cstring, instruction_len: cint, num_prompts: cint, prompts: ptr LIBSSH2_USERAUTH_KBDINT_PROMPT, responses: ptr LIBSSH2_USERAUTH_KBDINT_RESPONSE, abstract: ptr pointer): void{.cdecl.}
   
  git_credential_ssh_key* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_t* = enum
    GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1
    GIT_CREDENTIAL_SSH_KEY = 2
    GIT_CREDENTIAL_SSH_CUSTOM = 4
    GIT_CREDENTIAL_DEFAULT = 8
    GIT_CREDENTIAL_SSH_INTERACTIVE = 16
    GIT_CREDENTIAL_USERNAME = 32
    GIT_CREDENTIAL_SSH_MEMORY = 64
   
  git_credential_username* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_userpass_plaintext* {.bycopy, incompleteStruct, importc.} = object
    
   

proc git_credential_free*(
    cred: ptr git_credential
  ): void {.dynlib: libgitDl, importc.}


proc git_credential_has_username*(
    cred: ptr git_credential
  ): cint {.dynlib: libgitDl, importc.}


proc git_credential_get_username*(
    cred: ptr git_credential
  ): cstring {.dynlib: libgitDl, importc.}


proc git_credential_userpass_plaintext_new*(
    arg_out:  ptr ptr git_credential,
    username: cstring,
    password: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_credential_default_new*(
    arg_out: ptr ptr git_credential
  ): cint {.dynlib: libgitDl, importc.}


proc git_credential_username_new*(
    arg_out:  ptr ptr git_credential,
    username: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_credential_ssh_key_new*(
    arg_out:    ptr ptr git_credential,
    username:   cstring,
    publickey:  cstring,
    privatekey: cstring,
    passphrase: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_credential_ssh_key_memory_new*(
    arg_out:    ptr ptr git_credential,
    username:   cstring,
    publickey:  cstring,
    privatekey: cstring,
    passphrase: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_credential_ssh_interactive_new*(
    arg_out:         ptr ptr git_credential,
    username:        cstring,
    prompt_callback: git_credential_ssh_interactive_cb,
    payload:         pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_credential_ssh_key_from_agent*(
    arg_out:  ptr ptr git_credential,
    username: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_credential_ssh_custom_new*(
    arg_out:       ptr ptr git_credential,
    username:      cstring,
    publickey:     cstring,
    publickey_len: csize_t,
    sign_callback: git_credential_sign_cb,
    payload:       pointer
  ): cint {.dynlib: libgitDl, importc.}


