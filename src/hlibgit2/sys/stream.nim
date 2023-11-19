
type
  git_stream_registration* {.importc, bycopy.} = object
    version *: cint
    init    *: proc (a0: ptr git_stream, a1: cstring, a2: cstring): cint
    wrap    *: proc (a0: ptr git_stream, a1: ptr git_stream, a2: cstring): cint

  c_git_stream_t {.size: sizeof(cint).} = enum
    c_GIT_STREAM_STANDARD = 1 shl 0
    c_GIT_STREAM_TLS      = 1 shl 1

  git_stream_t = enum
    GIT_STREAM_STANDARD
    GIT_STREAM_TLS

  git_stream_cb = proc (a0: ptr git_stream, a1: cstring, a2: cstring): cint

  git_stream* {.importc, bycopy.} = object
    version         *: cint
    encrypted       *: cint
    proxy_support   *: cint
    timeout         *: cint
    connect_timeout *: cint
    connect         *: proc (a0: ptr git_stream): cint
    certificate     *: proc (a0: ptr git_cert, a1: ptr git_stream): cint
    set_proxy       *: proc (a0: ptr git_stream, a1: ptr git_proxy_options): cint
    read            *: proc (a0: ptr git_stream, a1: ptr void, a2: csize_t): csize_t
    write           *: proc (a0: ptr git_stream, a1: cstring, a2: csize_t, a3: cint): csize_t
    close           *: proc (a0: ptr git_stream): cint
    free            *: proc (a0: ptr git_stream): void



converter toCInt*(arg: c_git_stream_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_stream_t)): cint =
  for value in items(args):
    case value:
      of GIT_STREAM_STANDARD: result = cint(result or 1)
      of GIT_STREAM_TLS     : result = cint(result or 2)

func `-`*(arg: c_git_stream_t, offset: int): cint = cast[c_git_stream_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_stream_t): cint = cast[c_git_stream_t](ord(arg) - offset)

func `+`*(arg: c_git_stream_t, offset: int): cint = cast[c_git_stream_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_stream_t): cint = cast[c_git_stream_t](ord(arg) + offset)

proc git_stream_register*(type: git_stream_t, registration: ptr git_stream_registration): cint {.git2Proc, importc.}

proc git_stream_register_tls*(ctor: git_stream_cb): cint {.git2Proc, importc.}