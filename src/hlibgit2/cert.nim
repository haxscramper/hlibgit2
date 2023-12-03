import "./libgit2_config.nim" ## From gen file

type
  git_cert_x509* {.importc, bycopy.} = object
    parent *: git_cert
    data   *: pointer
    len    *: csize_t

  c_git_cert_t* {.size: sizeof(cint).} = enum
    c_GIT_CERT_NONE            = 0
    c_GIT_CERT_X509            = 1
    c_GIT_CERT_HOSTKEY_LIBSSH2 = 2
    c_GIT_CERT_STRARRAY        = 3

  git_cert_t* = enum
    GIT_CERT_NONE
    GIT_CERT_X509
    GIT_CERT_HOSTKEY_LIBSSH2
    GIT_CERT_STRARRAY

  c_git_cert_ssh_t* {.size: sizeof(cint).} = enum
    c_GIT_CERT_SSH_MD5    = 1 shl 0
    c_GIT_CERT_SSH_SHA1   = 1 shl 1
    c_GIT_CERT_SSH_SHA256 = 1 shl 2
    c_GIT_CERT_SSH_RAW    = 1 shl 3

  git_cert_ssh_t* = enum
    GIT_CERT_SSH_MD5
    GIT_CERT_SSH_SHA1
    GIT_CERT_SSH_SHA256
    GIT_CERT_SSH_RAW

  c_git_cert_ssh_raw_type_t* {.size: sizeof(cint).} = enum
    c_GIT_CERT_SSH_RAW_TYPE_UNKNOWN       = 0
    c_GIT_CERT_SSH_RAW_TYPE_RSA           = 1
    c_GIT_CERT_SSH_RAW_TYPE_DSS           = 2
    c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256 = 3
    c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384 = 4
    c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521 = 5
    c_GIT_CERT_SSH_RAW_TYPE_KEY_ED25519   = 6

  git_cert_ssh_raw_type_t* = enum
    GIT_CERT_SSH_RAW_TYPE_UNKNOWN
    GIT_CERT_SSH_RAW_TYPE_RSA
    GIT_CERT_SSH_RAW_TYPE_DSS
    GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256
    GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384
    GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521
    GIT_CERT_SSH_RAW_TYPE_KEY_ED25519

  git_transport_certificate_check_cb* = proc (a0: ptr git_cert, a1: cint, a2: cstring, a3: pointer): cint

  git_cert* {.importc, bycopy.} = object
    cert_type *: git_cert_t

  git_cert_hostkey* {.importc, bycopy.} = object
    parent      *: git_cert
    `type`      *: git_cert_ssh_t
    hash_md5    *: array[16, char]
    hash_sha1   *: array[20, char]
    hash_sha256 *: array[32, char]
    raw_type    *: git_cert_ssh_raw_type_t
    hostkey     *: cstring
    hostkey_len *: csize_t



converter toCInt*(arg: c_git_cert_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_cert_t]): cint =
  for value in items(args):
    case value:
      of GIT_CERT_NONE           : result = cint(result or 0)
      of GIT_CERT_X509           : result = cint(result or 1)
      of GIT_CERT_HOSTKEY_LIBSSH2: result = cint(result or 2)
      of GIT_CERT_STRARRAY       : result = cint(result or 3)

func `-`*(arg: c_git_cert_t, offset: int): cint = cast[c_git_cert_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_cert_t): cint = cast[c_git_cert_t](ord(arg) - offset)

func `+`*(arg: c_git_cert_t, offset: int): cint = cast[c_git_cert_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_cert_t): cint = cast[c_git_cert_t](ord(arg) + offset)

converter toCInt*(arg: c_git_cert_ssh_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_cert_ssh_t]): cint =
  for value in items(args):
    case value:
      of GIT_CERT_SSH_MD5   : result = cint(result or 1)
      of GIT_CERT_SSH_SHA1  : result = cint(result or 2)
      of GIT_CERT_SSH_SHA256: result = cint(result or 4)
      of GIT_CERT_SSH_RAW   : result = cint(result or 8)

func `-`*(arg: c_git_cert_ssh_t, offset: int): cint = cast[c_git_cert_ssh_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_cert_ssh_t): cint = cast[c_git_cert_ssh_t](ord(arg) - offset)

func `+`*(arg: c_git_cert_ssh_t, offset: int): cint = cast[c_git_cert_ssh_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_cert_ssh_t): cint = cast[c_git_cert_ssh_t](ord(arg) + offset)

converter toCInt*(arg: c_git_cert_ssh_raw_type_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_cert_ssh_raw_type_t]): cint =
  for value in items(args):
    case value:
      of GIT_CERT_SSH_RAW_TYPE_UNKNOWN      : result = cint(result or 0)
      of GIT_CERT_SSH_RAW_TYPE_RSA          : result = cint(result or 1)
      of GIT_CERT_SSH_RAW_TYPE_DSS          : result = cint(result or 2)
      of GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256: result = cint(result or 3)
      of GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384: result = cint(result or 4)
      of GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521: result = cint(result or 5)
      of GIT_CERT_SSH_RAW_TYPE_KEY_ED25519  : result = cint(result or 6)

func `-`*(arg: c_git_cert_ssh_raw_type_t, offset: int): cint = cast[c_git_cert_ssh_raw_type_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_cert_ssh_raw_type_t): cint = cast[c_git_cert_ssh_raw_type_t](ord(arg) - offset)

func `+`*(arg: c_git_cert_ssh_raw_type_t, offset: int): cint = cast[c_git_cert_ssh_raw_type_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_cert_ssh_raw_type_t): cint = cast[c_git_cert_ssh_raw_type_t](ord(arg) + offset)