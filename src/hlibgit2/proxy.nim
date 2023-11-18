type

  git_proxy_options* {.importc, bycopy.} = object
    version           *: cuint
    type              *: git_proxy_t
    url               *: cstring
    credentials       *: git_credential_acquire_cb
    certificate_check *: git_transport_certificate_check_cb
    payload           *: ptr void
  c_git_proxy_t {.size: sizeof(cint).} = enum
    c_GIT_PROXY_NONE      = 0 shl 0
    c_GIT_PROXY_AUTO      = 1 shl 0
    c_GIT_PROXY_SPECIFIED = 1 shl 1
  git_proxy_t = enum
    GIT_PROXY_NONE
    GIT_PROXY_AUTO
    GIT_PROXY_SPECIFIED



proc `git_proxy_options_init`*(opts: ptr git_proxy_options, version: cuint): cint {.git2Proc, importc.}

converter toCInt*(arg: c_git_proxy_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_proxy_t)): cint =
  for value in items(args):
    case value:
      of GIT_PROXY_NONE: result = cint(result or 0)
      of GIT_PROXY_AUTO: result = cint(result or 1)
      of GIT_PROXY_SPECIFIED: result = cint(result or 2)

func `-`*(arg: c_git_proxy_t, offset: int): cint = cast[c_git_proxy_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_proxy_t): cint = cast[c_git_proxy_t](ord(arg) - offset)

func `+`*(arg: c_git_proxy_t, offset: int): cint = cast[c_git_proxy_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_proxy_t): cint = cast[c_git_proxy_t](ord(arg) + offset)