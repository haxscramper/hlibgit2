import "../../remote.nim"

type
  c_git_remote_capability_t {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_CAPABILITY_TIP_OID       = 1 shl 0
    c_GIT_REMOTE_CAPABILITY_REACHABLE_OID = 1 shl 1

  git_remote_capability_t = enum
    GIT_REMOTE_CAPABILITY_TIP_OID
    GIT_REMOTE_CAPABILITY_REACHABLE_OID



converter toCInt*(arg: c_git_remote_capability_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_remote_capability_t)): cint =
  for value in items(args):
    case value:
      of GIT_REMOTE_CAPABILITY_TIP_OID      : result = cint(result or 1)
      of GIT_REMOTE_CAPABILITY_REACHABLE_OID: result = cint(result or 2)

func `-`*(arg: c_git_remote_capability_t, offset: int): cint = cast[c_git_remote_capability_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_remote_capability_t): cint = cast[c_git_remote_capability_t](ord(arg) - offset)

func `+`*(arg: c_git_remote_capability_t, offset: int): cint = cast[c_git_remote_capability_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_remote_capability_t): cint = cast[c_git_remote_capability_t](ord(arg) + offset)

proc git_remote_connect_options_dispose*(opts: ptr git_remote_connect_options): void {.git2Proc, importc.}