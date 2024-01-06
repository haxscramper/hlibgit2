import "./libgit2_config.nim" ## From gen file

type
  git_credential* {.bycopy, incompleteStruct.} = object
    credtype *: git_credential_t
    free     *: proc (a0: ptr git_credential): void

  git_credential_userpass_plaintext* {.bycopy, incompleteStruct.} = object
    parent   *: git_credential
    username *: ptr char
    password *: ptr char

  git_credential_username* {.bycopy, incompleteStruct.} = object
    parent   *: git_credential
    username *: array[1, char]

  git_credential_ssh_key* {.bycopy, incompleteStruct.} = object
    parent     *: git_credential
    username   *: ptr char
    publickey  *: ptr char
    privatekey *: ptr char
    passphrase *: ptr char

  git_credential_ssh_interactive* {.bycopy, incompleteStruct.} = object
    parent          *: git_credential
    username        *: ptr char
    prompt_callback *: git_credential_ssh_interactive_cb
    payload         *: pointer

  git_credential_ssh_custom* {.bycopy, incompleteStruct.} = object
    parent        *: git_credential
    username      *: ptr char
    publickey     *: ptr char
    publickey_len *: csize_t
    sign_callback *: git_credential_sign_cb
    payload       *: pointer

  LIBSSH2_SESSION* {.bycopy, incompleteStruct.} = object


  LIBSSH2_USERAUTH_KBDINT_PROMPT* {.bycopy, incompleteStruct.} = object


  LIBSSH2_USERAUTH_KBDINT_RESPONSE* {.bycopy, incompleteStruct.} = object


  c_git_credential_t* {.size: sizeof(cint).} = enum
    c_GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1 shl 0
    c_GIT_CREDENTIAL_SSH_KEY            = 1 shl 1
    c_GIT_CREDENTIAL_SSH_CUSTOM         = 1 shl 2
    c_GIT_CREDENTIAL_DEFAULT            = 1 shl 3
    c_GIT_CREDENTIAL_SSH_INTERACTIVE    = 1 shl 4
    c_GIT_CREDENTIAL_USERNAME           = 1 shl 5
    c_GIT_CREDENTIAL_SSH_MEMORY         = 1 shl 6

  git_credential_t* = enum
    GIT_CREDENTIAL_USERPASS_PLAINTEXT
    GIT_CREDENTIAL_SSH_KEY
    GIT_CREDENTIAL_SSH_CUSTOM
    GIT_CREDENTIAL_DEFAULT
    GIT_CREDENTIAL_SSH_INTERACTIVE
    GIT_CREDENTIAL_USERNAME
    GIT_CREDENTIAL_SSH_MEMORY

  git_credential_acquire_cb* = proc (a0: ptr ptr git_credential, a1: cstring, a2: cstring, a3: cuint, a4: pointer): cint

  git_credential_ssh_interactive_cb* = proc (a0: cstring, a1: cint, a2: cstring, a3: cint, a4: cint, a5: ptr LIBSSH2_USERAUTH_KBDINT_PROMPT, a6: ptr LIBSSH2_USERAUTH_KBDINT_RESPONSE, a7: ptr pointer): void

  git_credential_sign_cb* = proc (a0: ptr LIBSSH2_SESSION, a1: cstringArray, a2: ptr csize_t, a3: cstring, a4: csize_t, a5: ptr pointer): cint



converter toCInt*(arg: c_git_credential_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_credential_t]): cint =
  for value in items(args):
    case value:
      of GIT_CREDENTIAL_USERPASS_PLAINTEXT: result = cint(result or 1)
      of GIT_CREDENTIAL_SSH_KEY           : result = cint(result or 2)
      of GIT_CREDENTIAL_SSH_CUSTOM        : result = cint(result or 4)
      of GIT_CREDENTIAL_DEFAULT           : result = cint(result or 8)
      of GIT_CREDENTIAL_SSH_INTERACTIVE   : result = cint(result or 16)
      of GIT_CREDENTIAL_USERNAME          : result = cint(result or 32)
      of GIT_CREDENTIAL_SSH_MEMORY        : result = cint(result or 64)

func `-`*(arg: c_git_credential_t, offset: int): cint = cast[c_git_credential_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_credential_t): cint = cast[c_git_credential_t](ord(arg) - offset)

func `+`*(arg: c_git_credential_t, offset: int): cint = cast[c_git_credential_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_credential_t): cint = cast[c_git_credential_t](ord(arg) + offset)

proc git_credential_free*(cred: ptr git_credential): void {.git2Proc, importc: "git_credential_free".}

proc git_credential_has_username*(cred: ptr git_credential): cint {.git2Proc, importc: "git_credential_has_username".}

proc git_credential_get_username*(cred: ptr git_credential): cstring {.git2Proc, importc: "git_credential_get_username".}

proc git_credential_userpass_plaintext_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    password: cstring,
): cint {.git2Proc, importc: "git_credential_userpass_plaintext_new".}

proc git_credential_default_new*(`out`: ptr ptr git_credential): cint {.git2Proc, importc: "git_credential_default_new".}

proc git_credential_username_new*(`out`: ptr ptr git_credential, username: cstring): cint {.git2Proc, importc: "git_credential_username_new".}

proc git_credential_ssh_key_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    publickey: cstring,
    privatekey: cstring,
    passphrase: cstring,
): cint {.git2Proc, importc: "git_credential_ssh_key_new".}

proc git_credential_ssh_key_memory_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    publickey: cstring,
    privatekey: cstring,
    passphrase: cstring,
): cint {.git2Proc, importc: "git_credential_ssh_key_memory_new".}

proc git_credential_ssh_interactive_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    prompt_callback: git_credential_ssh_interactive_cb,
    payload: pointer,
): cint {.git2Proc, importc: "git_credential_ssh_interactive_new".}

proc git_credential_ssh_key_from_agent*(`out`: ptr ptr git_credential, username: cstring): cint {.git2Proc, importc: "git_credential_ssh_key_from_agent".}

proc git_credential_ssh_custom_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    publickey: cstring,
    publickey_len: csize_t,
    sign_callback: git_credential_sign_cb,
    payload: pointer,
): cint {.git2Proc, importc: "git_credential_ssh_custom_new".}