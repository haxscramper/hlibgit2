type

  git_fetch_negotiation* {.importc, bycopy.} = object
    refs              *: ptr git_remote_head
    refs_len          *: csize_t
    shallow_roots     *: ptr git_oid
    shallow_roots_len *: csize_t
    depth             *: cint
  git_smart_subtransport* {.importc, bycopy.} = object

  git_smart_subtransport_stream* {.importc, bycopy.} = object

  git_smart_subtransport_definition* {.importc, bycopy.} = object
    callback *: git_smart_subtransport_cb
    rpc      *: cuint
    param    *: ptr void
  git_smart_subtransport_cb = proc (a0: ptr git_smart_subtransport, a1: ptr git_transport, a2: ptr void): cint
  c_git_smart_service_t {.size: sizeof(cint).} = enum
    c_GIT_SERVICE_UPLOADPACK_LS  = 1 shl 0
    c_GIT_SERVICE_UPLOADPACK     = 1 shl 1
    c_GIT_SERVICE_RECEIVEPACK_LS = 3
    c_GIT_SERVICE_RECEIVEPACK    = 1 shl 2
  git_smart_service_t = enum
    GIT_SERVICE_UPLOADPACK_LS
    GIT_SERVICE_UPLOADPACK
    GIT_SERVICE_RECEIVEPACK_LS
    GIT_SERVICE_RECEIVEPACK
  git_transport* {.importc, bycopy.} = object




converter toCInt*(arg: c_git_smart_service_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_smart_service_t)): cint =
  for value in items(args):
    case value:
      of GIT_SERVICE_UPLOADPACK_LS: result = cint(result or 1)
      of GIT_SERVICE_UPLOADPACK: result = cint(result or 2)
      of GIT_SERVICE_RECEIVEPACK_LS: result = cint(result or 3)
      of GIT_SERVICE_RECEIVEPACK: result = cint(result or 4)

func `-`*(arg: c_git_smart_service_t, offset: int): cint = cast[c_git_smart_service_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_smart_service_t): cint = cast[c_git_smart_service_t](ord(arg) - offset)

func `+`*(arg: c_git_smart_service_t, offset: int): cint = cast[c_git_smart_service_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_smart_service_t): cint = cast[c_git_smart_service_t](ord(arg) + offset)

proc `git_transport_init`*(opts: ptr git_transport, version: cuint): cint {.git2Proc, importc.}

proc `git_transport_new`*(out: ptr git_transport, owner: ptr git_remote, url: cstring): cint {.git2Proc, importc.}

proc `git_transport_ssh_with_paths`*(out: ptr git_transport, owner: ptr git_remote, payload: ptr void): cint {.git2Proc, importc.}

proc `git_transport_register`*(prefix: cstring, cb: git_transport_cb, param: ptr void): cint {.git2Proc, importc.}

proc `git_transport_unregister`*(prefix: cstring): cint {.git2Proc, importc.}

proc `git_transport_dummy`*(out: ptr git_transport, owner: ptr git_remote, payload: ptr void): cint {.git2Proc, importc.}

proc `git_transport_local`*(out: ptr git_transport, owner: ptr git_remote, payload: ptr void): cint {.git2Proc, importc.}

proc `git_transport_smart`*(out: ptr git_transport, owner: ptr git_remote, payload: ptr void): cint {.git2Proc, importc.}

proc `git_transport_smart_certificate_check`*(transport: ptr git_transport, cert: ptr git_cert, valid: cint, hostname: cstring): cint {.git2Proc, importc.}

proc `git_transport_smart_credentials`*(out: ptr git_credential, transport: ptr git_transport, user: cstring, methods: cint): cint {.git2Proc, importc.}

proc `git_transport_remote_connect_options`*(out: ptr git_remote_connect_options, transport: ptr git_transport): cint {.git2Proc, importc.}

proc `git_smart_subtransport_http`*(out: ptr git_smart_subtransport, owner: ptr git_transport, param: ptr void): cint {.git2Proc, importc.}

proc `git_smart_subtransport_git`*(out: ptr git_smart_subtransport, owner: ptr git_transport, param: ptr void): cint {.git2Proc, importc.}

proc `git_smart_subtransport_ssh`*(out: ptr git_smart_subtransport, owner: ptr git_transport, param: ptr void): cint {.git2Proc, importc.}