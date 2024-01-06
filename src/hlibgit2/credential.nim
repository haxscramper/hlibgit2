import "./libgit2_config.nim" ## From gen file

type
  git_credential* {.header: "<sys/credential.h>", importc, bycopy.} = object
    credtype *: git_credential_t
    free     *: proc (a0: ptr git_credential): void

  git_credential_userpass_plaintext* {.header: "<sys/credential.h>", importc, bycopy.} = object
    parent   *: git_credential
    username *: ptr char
    password *: ptr char

  git_credential_username* {.header: "<sys/credential.h>", importc, bycopy.} = object
    parent   *: git_credential
    username *: array[1, char]

  git_credential_ssh_key* {.header: "<sys/credential.h>", importc, bycopy.} = object
    parent     *: git_credential
    username   *: ptr char
    publickey  *: ptr char
    privatekey *: ptr char
    passphrase *: ptr char

  git_credential_ssh_interactive* {.header: "<sys/credential.h>", importc, bycopy.} = object
    parent          *: git_credential
    username        *: ptr char
    prompt_callback *: git_credential_ssh_interactive_cb
    payload         *: pointer

  git_credential_ssh_custom* {.header: "<sys/credential.h>", importc, bycopy.} = object
    parent        *: git_credential
    username      *: ptr char
    publickey     *: ptr char
    publickey_len *: csize_t
    sign_callback *: git_credential_sign_cb
    payload       *: pointer

  LIBSSH2_SESSION* {.header: "<credential.h>", importc, incompleteStruct.} = object


  LIBSSH2_USERAUTH_KBDINT_PROMPT* {.header: "<credential.h>", importc, incompleteStruct.} = object


  LIBSSH2_USERAUTH_KBDINT_RESPONSE* {.header: "<credential.h>", importc, incompleteStruct.} = object


  c_git_credential_t* {.size: sizeof(cint).} = enum
    c_GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1 shl 0
    c_GIT_CREDENTIAL_SSH_KEY            = 1 shl 1
    c_GIT_CREDENTIAL_SSH_CUSTOM         = 1 shl 2
    c_GIT_CREDENTIAL_DEFAULT            = 1 shl 3
    c_GIT_CREDENTIAL_SSH_INTERACTIVE    = 1 shl 4
    c_GIT_CREDENTIAL_USERNAME           = 1 shl 5
    c_GIT_CREDENTIAL_SSH_MEMORY         = 1 shl 6

  git_credential_t* = enum
    GIT_CREDENTIAL_USERPASS_PLAINTEXT = 0
    GIT_CREDENTIAL_SSH_KEY            = 1
    GIT_CREDENTIAL_SSH_CUSTOM         = 2
    GIT_CREDENTIAL_DEFAULT            = 3
    GIT_CREDENTIAL_SSH_INTERACTIVE    = 4
    GIT_CREDENTIAL_USERNAME           = 5
    GIT_CREDENTIAL_SSH_MEMORY         = 6

  git_credential_acquire_cb* = proc (a0: ptr ptr git_credential, a1: cstring, a2: cstring, a3: cuint, a4: pointer): cint

  git_credential_ssh_interactive_cb* = proc (a0: cstring, a1: cint, a2: cstring, a3: cint, a4: cint, a5: ptr LIBSSH2_USERAUTH_KBDINT_PROMPT, a6: ptr LIBSSH2_USERAUTH_KBDINT_RESPONSE, a7: ptr pointer): void

  git_credential_sign_cb* = proc (a0: ptr LIBSSH2_SESSION, a1: cstringArray, a2: ptr csize_t, a3: cstring, a4: csize_t, a5: ptr pointer): cint



converter to_git_credential_t*(arg: c_git_credential_t): git_credential_t =
  case arg:
    of c_GIT_CREDENTIAL_USERPASS_PLAINTEXT: GIT_CREDENTIAL_USERPASS_PLAINTEXT
    of c_GIT_CREDENTIAL_SSH_KEY           : GIT_CREDENTIAL_SSH_KEY
    of c_GIT_CREDENTIAL_SSH_CUSTOM        : GIT_CREDENTIAL_SSH_CUSTOM
    of c_GIT_CREDENTIAL_DEFAULT           : GIT_CREDENTIAL_DEFAULT
    of c_GIT_CREDENTIAL_SSH_INTERACTIVE   : GIT_CREDENTIAL_SSH_INTERACTIVE
    of c_GIT_CREDENTIAL_USERNAME          : GIT_CREDENTIAL_USERNAME
    of c_GIT_CREDENTIAL_SSH_MEMORY        : GIT_CREDENTIAL_SSH_MEMORY

proc to_c_git_credential_t*(arg: git_credential_t): c_git_credential_t =
  case arg:
    of GIT_CREDENTIAL_USERPASS_PLAINTEXT: c_GIT_CREDENTIAL_USERPASS_PLAINTEXT
    of GIT_CREDENTIAL_SSH_KEY           : c_GIT_CREDENTIAL_SSH_KEY
    of GIT_CREDENTIAL_SSH_CUSTOM        : c_GIT_CREDENTIAL_SSH_CUSTOM
    of GIT_CREDENTIAL_DEFAULT           : c_GIT_CREDENTIAL_DEFAULT
    of GIT_CREDENTIAL_SSH_INTERACTIVE   : c_GIT_CREDENTIAL_SSH_INTERACTIVE
    of GIT_CREDENTIAL_USERNAME          : c_GIT_CREDENTIAL_USERNAME
    of GIT_CREDENTIAL_SSH_MEMORY        : c_GIT_CREDENTIAL_SSH_MEMORY

converter toCInt*(arg: c_git_credential_t): cint = cint(ord(arg))

converter toCInt*(arg: git_credential_t): cint = cint(ord(to_c_git_credential_t(arg)))

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

proc git_credential_free*(cred: ptr git_credential): void {.importc: "git_credential_free", header: "<credential.h>".}

proc git_credential_has_username*(cred: ptr git_credential): cint {.importc: "git_credential_has_username", header: "<credential.h>".}

proc git_credential_get_username*(cred: ptr git_credential): cstring {.importc: "git_credential_get_username", header: "<credential.h>".}

proc git_credential_userpass_plaintext_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    password: cstring,
): cint {.importc: "git_credential_userpass_plaintext_new", header: "<credential.h>".}

proc git_credential_default_new*(`out`: ptr ptr git_credential): cint {.importc: "git_credential_default_new", header: "<credential.h>".}

proc git_credential_username_new*(`out`: ptr ptr git_credential, username: cstring): cint {.importc: "git_credential_username_new", header: "<credential.h>".}

proc git_credential_ssh_key_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    publickey: cstring,
    privatekey: cstring,
    passphrase: cstring,
): cint {.importc: "git_credential_ssh_key_new", header: "<credential.h>".}

proc git_credential_ssh_key_memory_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    publickey: cstring,
    privatekey: cstring,
    passphrase: cstring,
): cint {.importc: "git_credential_ssh_key_memory_new", header: "<credential.h>".}

proc git_credential_ssh_interactive_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    prompt_callback: git_credential_ssh_interactive_cb,
    payload: pointer,
): cint {.importc: "git_credential_ssh_interactive_new", header: "<credential.h>".}

proc git_credential_ssh_key_from_agent*(`out`: ptr ptr git_credential, username: cstring): cint {.importc: "git_credential_ssh_key_from_agent", header: "<credential.h>".}

proc git_credential_ssh_custom_new*(
    `out`: ptr ptr git_credential,
    username: cstring,
    publickey: cstring,
    publickey_len: csize_t,
    sign_callback: git_credential_sign_cb,
    payload: pointer,
): cint {.importc: "git_credential_ssh_custom_new", header: "<credential.h>".}