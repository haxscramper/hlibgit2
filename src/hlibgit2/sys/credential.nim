import "../credential.nim"
import "../libgit2_config.nim"

type
  git_credential* {.importc, bycopy, incompleteStruct.} = object
    credtype *: git_credential_t
    free     *: proc (a0: `ptr` git_credential): void

  git_credential_userpass_plaintext* {.importc, bycopy, incompleteStruct.} = object
    parent   *: git_credential
    username *: `ptr` char
    password *: `ptr` char

  git_credential_username* {.importc, bycopy, incompleteStruct.} = object
    parent   *: git_credential
    username *: array[1, char]

  git_credential_ssh_key* {.importc, bycopy, incompleteStruct.} = object
    parent     *: git_credential
    username   *: `ptr` char
    publickey  *: `ptr` char
    privatekey *: `ptr` char
    passphrase *: `ptr` char

  git_credential_ssh_interactive* {.importc, bycopy, incompleteStruct.} = object
    parent          *: git_credential
    username        *: `ptr` char
    prompt_callback *: git_credential_ssh_interactive_cb
    payload         *: pointer

  git_credential_ssh_custom* {.importc, bycopy, incompleteStruct.} = object
    parent        *: git_credential
    username      *: `ptr` char
    publickey     *: `ptr` char
    publickey_len *: csize_t
    sign_callback *: git_credential_sign_cb
    payload       *: pointer

