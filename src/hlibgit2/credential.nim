{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  hlibssh2/libssh2,
  hlibssh2/libssh2_config

type
  LIBSSH2_SESSION1* = LIBSSH2_SESSION
   
  LIBSSH2_USERAUTH_KBDINT_PROMPT1* = LIBSSH2_USERAUTH_KBDINT_PROMPT
   
  LIBSSH2_USERAUTH_KBDINT_RESPONSE1* = LIBSSH2_USERAUTH_KBDINT_RESPONSE
   
  c_git_credential_t* = enum
    c_GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1 
    c_GIT_CREDENTIAL_SSH_KEY            = 2 
    c_GIT_CREDENTIAL_SSH_CUSTOM         = 4 
    c_GIT_CREDENTIAL_DEFAULT            = 8 
    c_GIT_CREDENTIAL_SSH_INTERACTIVE    = 16
    c_GIT_CREDENTIAL_USERNAME           = 32
    c_GIT_CREDENTIAL_SSH_MEMORY         = 64
   
  git_credential* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_acquire_cb* = proc(arg_out: ptr ptr git_credential, url: cstring, username_from_url: cstring, allowed_types: cuint, payload: pointer): cint{.cdecl.}
   
  git_credential_acquire_cbNim* = proc(arg_out: ptr ptr git_credential, url: cstring, username_from_url: cstring, allowed_types: cuint): cint
   
  git_credential_default* = git_credential
   
  git_credential_sign_cb* = proc(session: ptr LIBSSH2_SESSION1, sig: ptr ptr uint8, sig_len: ptr csize_t, data: ptr uint8, data_len: csize_t, abstract: ptr pointer): cint{.cdecl.}
   
  git_credential_ssh_custom* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_ssh_interactive* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_ssh_interactive_cb* = proc(name: cstring, name_len: cint, instruction: cstring, instruction_len: cint, num_prompts: cint, prompts: ptr LIBSSH2_USERAUTH_KBDINT_PROMPT1, responses: ptr LIBSSH2_USERAUTH_KBDINT_RESPONSE1, abstract: ptr pointer): void{.cdecl.}
   
  git_credential_ssh_key* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_t* = enum
    GIT_CREDENTIAL_USERPASS_PLAINTEXT
    GIT_CREDENTIAL_SSH_KEY           
    GIT_CREDENTIAL_SSH_CUSTOM        
    GIT_CREDENTIAL_DEFAULT           
    GIT_CREDENTIAL_SSH_INTERACTIVE   
    GIT_CREDENTIAL_USERNAME          
    GIT_CREDENTIAL_SSH_MEMORY        
   
  git_credential_username* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_credential_userpass_plaintext* {.bycopy, incompleteStruct, importc.} = object
    
   

proc to_c_git_credential_t*(arg: git_credential_t): c_git_credential_t = 
  case arg:
    of GIT_CREDENTIAL_USERPASS_PLAINTEXT:
      c_GIT_CREDENTIAL_USERPASS_PLAINTEXT
    of GIT_CREDENTIAL_SSH_KEY:
      c_GIT_CREDENTIAL_SSH_KEY
    of GIT_CREDENTIAL_SSH_CUSTOM:
      c_GIT_CREDENTIAL_SSH_CUSTOM
    of GIT_CREDENTIAL_DEFAULT:
      c_GIT_CREDENTIAL_DEFAULT
    of GIT_CREDENTIAL_SSH_INTERACTIVE:
      c_GIT_CREDENTIAL_SSH_INTERACTIVE
    of GIT_CREDENTIAL_USERNAME:
      c_GIT_CREDENTIAL_USERNAME
    of GIT_CREDENTIAL_SSH_MEMORY:
      c_GIT_CREDENTIAL_SSH_MEMORY
 

converter to_git_credential_t*(arg: c_git_credential_t): git_credential_t = 
  case arg:
    of c_GIT_CREDENTIAL_USERPASS_PLAINTEXT:
      GIT_CREDENTIAL_USERPASS_PLAINTEXT
    of c_GIT_CREDENTIAL_SSH_KEY:
      GIT_CREDENTIAL_SSH_KEY
    of c_GIT_CREDENTIAL_SSH_CUSTOM:
      GIT_CREDENTIAL_SSH_CUSTOM
    of c_GIT_CREDENTIAL_DEFAULT:
      GIT_CREDENTIAL_DEFAULT
    of c_GIT_CREDENTIAL_SSH_INTERACTIVE:
      GIT_CREDENTIAL_SSH_INTERACTIVE
    of c_GIT_CREDENTIAL_USERNAME:
      GIT_CREDENTIAL_USERNAME
    of c_GIT_CREDENTIAL_SSH_MEMORY:
      GIT_CREDENTIAL_SSH_MEMORY
 

converter toCint*(arg: c_git_credential_t): cint = 
  cint(ord(arg))
 
func `+`*(arg: c_git_credential_t, offset: int): c_git_credential_t = 
  c_git_credential_t(ord(arg) + offset)
 
func `+`*(offset: int, arg: c_git_credential_t): c_git_credential_t = 
  c_git_credential_t(ord(arg) + offset)
 
func `-`*(arg: c_git_credential_t, offset: int): c_git_credential_t = 
  c_git_credential_t(ord(arg) - offset)
 
func `-`*(offset: int, arg: c_git_credential_t): c_git_credential_t = 
  c_git_credential_t(ord(arg) - offset)
 

proc git_credential_free*(cred: ptr git_credential): void {.git2Proc, importc.}
  
 

proc git_credential_has_username*(
    cred: ptr git_credential
  ): cint {.git2Proc, importc.}
  
 

proc git_credential_get_username*(
    cred: ptr git_credential
  ): cstring {.git2Proc, importc.}
  
 

proc git_credential_userpass_plaintext_new*(
    arg_out:  ptr ptr git_credential,
    username: cstring,
    password: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_credential_default_new*(
    arg_out: ptr ptr git_credential
  ): cint {.git2Proc, importc.}
  
 

proc git_credential_username_new*(
    arg_out:  ptr ptr git_credential,
    username: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_credential_ssh_key_new*(
    arg_out:    ptr ptr git_credential,
    username:   cstring,
    publickey:  cstring,
    privatekey: cstring,
    passphrase: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_credential_ssh_key_memory_new*(
    arg_out:    ptr ptr git_credential,
    username:   cstring,
    publickey:  cstring,
    privatekey: cstring,
    passphrase: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_credential_ssh_interactive_new*(
    arg_out:         ptr ptr git_credential,
    username:        cstring,
    prompt_callback: git_credential_ssh_interactive_cb,
    payload:         pointer
  ): cint {.git2Proc, importc.}
  
 

proc git_credential_ssh_key_from_agent*(
    arg_out:  ptr ptr git_credential,
    username: cstring
  ): cint {.git2Proc, importc.}
  
 

proc git_credential_ssh_custom_new*(
    arg_out:       ptr ptr git_credential,
    username:      cstring,
    publickey:     cstring,
    publickey_len: csize_t,
    sign_callback: git_credential_sign_cb,
    payload:       pointer
  ): cint {.git2Proc, importc.}
  
 

