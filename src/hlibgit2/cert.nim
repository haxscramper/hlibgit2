{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  c_git_cert_ssh_raw_type_t* {.size: sizeof(cint).} = enum
    c_GIT_CERT_SSH_RAW_TYPE_UNKNOWN       = 0 ## The raw key is of an unknown type.
    c_GIT_CERT_SSH_RAW_TYPE_RSA           = 1 ## The raw key is an RSA key.
    c_GIT_CERT_SSH_RAW_TYPE_DSS           = 2 ## The raw key is a DSS key.
    c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256 = 3 ## The raw key is a ECDSA 256 key.
    c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384 = 4 ## The raw key is a ECDSA 384 key.
    c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521 = 5 ## The raw key is a ECDSA 521 key.
    c_GIT_CERT_SSH_RAW_TYPE_KEY_ED25519   = 6 ## The raw key is a ED25519 key.

  c_git_cert_ssh_t* {.size: sizeof(cint).} = enum
    c_GIT_CERT_SSH_MD5    = 1 shl 0 ## MD5 is available
    c_GIT_CERT_SSH_SHA1   = 1 shl 1 ## SHA-1 is available
    c_GIT_CERT_SSH_SHA256 = 1 shl 2 ## SHA-256 is available
    c_GIT_CERT_SSH_RAW    = 1 shl 3 ## Raw hostkey is available

  c_git_cert_t* {.size: sizeof(cint).} = enum
    c_GIT_CERT_NONE            = 0
    c_GIT_CERT_X509            = 1
    c_GIT_CERT_HOSTKEY_LIBSSH2 = 2
    c_GIT_CERT_STRARRAY        = 3

  git_cert* {.bycopy, header: "<git2/cert.h>", importc.} = object
    cert_type*: c_git_cert_t

  git_cert_hostkey* {.bycopy, header: "<git2/cert.h>", importc.} = object
    parent*:                     git_cert
    type_f* {.importc: "type".}: c_git_cert_ssh_t          ## The parent cert
    hash_md5*:                   ptr UncheckedArray[uint8]
    hash_sha1*:                  ptr UncheckedArray[uint8]
    hash_sha256*:                ptr UncheckedArray[uint8]
    raw_type*:                   c_git_cert_ssh_raw_type_t
    hostkey*:                    cstring
    hostkey_len*:                csize_t

  git_cert_ssh_raw_type_t* = enum
    GIT_CERT_SSH_RAW_TYPE_UNKNOWN       ## The raw key is of an unknown type.
    GIT_CERT_SSH_RAW_TYPE_RSA           ## The raw key is an RSA key.
    GIT_CERT_SSH_RAW_TYPE_DSS           ## The raw key is a DSS key.
    GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256 ## The raw key is a ECDSA 256 key.
    GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384 ## The raw key is a ECDSA 384 key.
    GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521 ## The raw key is a ECDSA 521 key.
    GIT_CERT_SSH_RAW_TYPE_KEY_ED25519   ## The raw key is a ED25519 key.

  git_cert_ssh_t* {.size: sizeof(cint).} = enum
    GIT_CERT_SSH_MD5    ## MD5 is available
    GIT_CERT_SSH_SHA1   ## SHA-1 is available
    GIT_CERT_SSH_SHA256 ## SHA-256 is available
    GIT_CERT_SSH_RAW    ## Raw hostkey is available

  git_cert_t* = enum
    GIT_CERT_NONE
    GIT_CERT_X509
    GIT_CERT_HOSTKEY_LIBSSH2
    GIT_CERT_STRARRAY

  git_cert_x509* {.bycopy, header: "<git2/cert.h>", importc.} = object
    parent*: git_cert
    data*:   pointer  ## The parent cert
    len*:    csize_t

  git_transport_certificate_check_cb* = proc(cert:    ptr git_cert,
                                             valid:   cint,
                                             host:    cstring,
                                             payload: pointer): cint{.cdecl.}


proc to_c_git_cert_t*(arg: git_cert_t): c_git_cert_t =
  case arg:
    of GIT_CERT_NONE:            c_GIT_CERT_NONE
    of GIT_CERT_X509:            c_GIT_CERT_X509
    of GIT_CERT_HOSTKEY_LIBSSH2: c_GIT_CERT_HOSTKEY_LIBSSH2
    of GIT_CERT_STRARRAY:        c_GIT_CERT_STRARRAY


converter to_git_cert_t*(arg: c_git_cert_t): git_cert_t =
  case arg:
    of c_GIT_CERT_NONE:            GIT_CERT_NONE
    of c_GIT_CERT_X509:            GIT_CERT_X509
    of c_GIT_CERT_HOSTKEY_LIBSSH2: GIT_CERT_HOSTKEY_LIBSSH2
    of c_GIT_CERT_STRARRAY:        GIT_CERT_STRARRAY


converter toCint*(arg: c_git_cert_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_cert_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_cert_t(arg)))

func `+`*(arg: c_git_cert_t, offset: int): c_git_cert_t =
  cast[c_git_cert_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_cert_t): c_git_cert_t =
  cast[c_git_cert_t](ord(arg) + offset)

func `-`*(arg: c_git_cert_t, offset: int): c_git_cert_t =
  cast[c_git_cert_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_cert_t): c_git_cert_t =
  cast[c_git_cert_t](ord(arg) - offset)


proc to_c_git_cert_ssh_t*(arg: git_cert_ssh_t): c_git_cert_ssh_t =
  case arg:
    of GIT_CERT_SSH_MD5:    c_GIT_CERT_SSH_MD5
    of GIT_CERT_SSH_SHA1:   c_GIT_CERT_SSH_SHA1
    of GIT_CERT_SSH_SHA256: c_GIT_CERT_SSH_SHA256
    of GIT_CERT_SSH_RAW:    c_GIT_CERT_SSH_RAW


converter to_git_cert_ssh_t*(arg: c_git_cert_ssh_t): git_cert_ssh_t =
  case arg:
    of c_GIT_CERT_SSH_MD5:    GIT_CERT_SSH_MD5
    of c_GIT_CERT_SSH_SHA1:   GIT_CERT_SSH_SHA1
    of c_GIT_CERT_SSH_SHA256: GIT_CERT_SSH_SHA256
    of c_GIT_CERT_SSH_RAW:    GIT_CERT_SSH_RAW


converter toCint*(arg: c_git_cert_ssh_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_cert_ssh_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_cert_ssh_t(arg)))

func `+`*(arg: c_git_cert_ssh_t, offset: int): c_git_cert_ssh_t =
  cast[c_git_cert_ssh_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_cert_ssh_t): c_git_cert_ssh_t =
  cast[c_git_cert_ssh_t](ord(arg) + offset)

func `-`*(arg: c_git_cert_ssh_t, offset: int): c_git_cert_ssh_t =
  cast[c_git_cert_ssh_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_cert_ssh_t): c_git_cert_ssh_t =
  cast[c_git_cert_ssh_t](ord(arg) - offset)


converter toCint*(args: set[git_cert_ssh_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc to_c_git_cert_ssh_raw_type_t*(
    arg: git_cert_ssh_raw_type_t
  ): c_git_cert_ssh_raw_type_t =
  case arg:
    of GIT_CERT_SSH_RAW_TYPE_UNKNOWN:       c_GIT_CERT_SSH_RAW_TYPE_UNKNOWN
    of GIT_CERT_SSH_RAW_TYPE_RSA:           c_GIT_CERT_SSH_RAW_TYPE_RSA
    of GIT_CERT_SSH_RAW_TYPE_DSS:           c_GIT_CERT_SSH_RAW_TYPE_DSS
    of GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256: c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256
    of GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384: c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384
    of GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521: c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521
    of GIT_CERT_SSH_RAW_TYPE_KEY_ED25519:   c_GIT_CERT_SSH_RAW_TYPE_KEY_ED25519


converter to_git_cert_ssh_raw_type_t*(
    arg: c_git_cert_ssh_raw_type_t
  ): git_cert_ssh_raw_type_t =
  case arg:
    of c_GIT_CERT_SSH_RAW_TYPE_UNKNOWN:       GIT_CERT_SSH_RAW_TYPE_UNKNOWN
    of c_GIT_CERT_SSH_RAW_TYPE_RSA:           GIT_CERT_SSH_RAW_TYPE_RSA
    of c_GIT_CERT_SSH_RAW_TYPE_DSS:           GIT_CERT_SSH_RAW_TYPE_DSS
    of c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256: GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_256
    of c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384: GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_384
    of c_GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521: GIT_CERT_SSH_RAW_TYPE_KEY_ECDSA_521
    of c_GIT_CERT_SSH_RAW_TYPE_KEY_ED25519:   GIT_CERT_SSH_RAW_TYPE_KEY_ED25519


converter toCint*(arg: c_git_cert_ssh_raw_type_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_cert_ssh_raw_type_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_cert_ssh_raw_type_t(arg)))

func `+`*(
    arg:    c_git_cert_ssh_raw_type_t,
    offset: int
  ): c_git_cert_ssh_raw_type_t =
  cast[c_git_cert_ssh_raw_type_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_cert_ssh_raw_type_t
  ): c_git_cert_ssh_raw_type_t =
  cast[c_git_cert_ssh_raw_type_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_cert_ssh_raw_type_t,
    offset: int
  ): c_git_cert_ssh_raw_type_t =
  cast[c_git_cert_ssh_raw_type_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_cert_ssh_raw_type_t
  ): c_git_cert_ssh_raw_type_t =
  cast[c_git_cert_ssh_raw_type_t](ord(arg) - offset)


