import "../cert.nim"
import "../proxy.nim"

type
  git_stream* {.bycopy.} = object
    version         *: cint
    encrypted       *: cuint
    proxy_support   *: cuint
    timeout         *: cint
    connect_timeout *: cint
    connect         *: proc (a0: ptr git_stream): cint
    certificate     *: proc (a0: ptr ptr git_cert, a1: ptr git_stream): cint
    set_proxy       *: proc (a0: ptr git_stream, a1: ptr git_proxy_options): cint
    read            *: proc (a0: ptr git_stream, a1: pointer, a2: csize_t): csize_t
    write           *: proc (a0: ptr git_stream, a1: cstring, a2: csize_t, a3: cint): csize_t
    close           *: proc (a0: ptr git_stream): cint
    free            *: proc (a0: ptr git_stream): void

  git_stream_registration* {.bycopy.} = object
    version *: cint
    init    *: proc (a0: ptr ptr git_stream, a1: cstring, a2: cstring): cint
    wrap    *: proc (a0: ptr ptr git_stream, a1: ptr git_stream, a2: cstring): cint

  c_git_stream_t* {.size: sizeof(cint).} = enum
    c_GIT_STREAM_STANDARD = 1 shl 0
    c_GIT_STREAM_TLS      = 1 shl 1

  git_stream_t* = enum
    GIT_STREAM_STANDARD = 0
    GIT_STREAM_TLS      = 1

  git_stream_cb* = proc (a0: ptr ptr git_stream, a1: cstring, a2: cstring): cint



proc git_stream_register*(`type`: git_stream_t, registration: ptr git_stream_registration): cint {.importc: "git_stream_register".}

proc git_stream_register_tls*(ctor: git_stream_cb): cint {.importc: "git_stream_register_tls".}

converter to_git_stream_t*(arg: c_git_stream_t): git_stream_t =
  case arg:
    of c_GIT_STREAM_STANDARD: GIT_STREAM_STANDARD
    of c_GIT_STREAM_TLS     : GIT_STREAM_TLS

proc to_c_git_stream_t*(arg: git_stream_t): c_git_stream_t =
  case arg:
    of GIT_STREAM_STANDARD: c_GIT_STREAM_STANDARD
    of GIT_STREAM_TLS     : c_GIT_STREAM_TLS

converter toCInt*(arg: c_git_stream_t): cint = cint(ord(arg))

converter toCInt*(arg: git_stream_t): cint = cint(ord(to_c_git_stream_t(arg)))

converter toCInt*(args: set[git_stream_t]): cint =
  for value in items(args):
    case value:
      of GIT_STREAM_STANDARD: result = cint(result or 1)
      of GIT_STREAM_TLS     : result = cint(result or 2)

func `-`*(arg: c_git_stream_t, offset: int): c_git_stream_t = cast[c_git_stream_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_stream_t): c_git_stream_t = cast[c_git_stream_t](ord(arg) - offset)

func `+`*(arg: c_git_stream_t, offset: int): c_git_stream_t = cast[c_git_stream_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_stream_t): c_git_stream_t = cast[c_git_stream_t](ord(arg) + offset)