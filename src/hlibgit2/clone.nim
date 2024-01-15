import "./types.nim"
import "./remote.nim"
import "./checkout.nim"

type
  git_clone_options* {.importc, bycopy.} = object
    version               *: cuint
    checkout_opts         *: git_checkout_options
    fetch_opts            *: git_fetch_options
    bare                  *: cint
    local                 *: git_clone_local_t
    checkout_branch       *: cstring
    repository_cb         *: git_repository_create_cb
    repository_cb_payload *: pointer
    remote_cb             *: git_remote_create_cb
    remote_cb_payload     *: pointer

  c_git_clone_local_t* {.size: sizeof(cint).} = enum
    c_GIT_CLONE_LOCAL_AUTO     = 0
    c_GIT_CLONE_LOCAL          = 1
    c_GIT_CLONE_NO_LOCAL       = 2
    c_GIT_CLONE_LOCAL_NO_LINKS = 3

  git_clone_local_t* = enum
    GIT_CLONE_LOCAL_AUTO     = 0
    GIT_CLONE_LOCAL          = 1
    GIT_CLONE_NO_LOCAL       = 2
    GIT_CLONE_LOCAL_NO_LINKS = 3

  git_remote_create_cb* = proc (a0: ptr ptr git_remote, a1: ptr git_repository, a2: cstring, a3: cstring, a4: pointer): cint

  git_repository_create_cb* = proc (a0: ptr ptr git_repository, a1: cstring, a2: cint, a3: pointer): cint



converter to_git_clone_local_t*(arg: c_git_clone_local_t): git_clone_local_t =
  case arg:
    of c_GIT_CLONE_LOCAL_AUTO    : GIT_CLONE_LOCAL_AUTO
    of c_GIT_CLONE_LOCAL         : GIT_CLONE_LOCAL
    of c_GIT_CLONE_NO_LOCAL      : GIT_CLONE_NO_LOCAL
    of c_GIT_CLONE_LOCAL_NO_LINKS: GIT_CLONE_LOCAL_NO_LINKS

proc to_c_git_clone_local_t*(arg: git_clone_local_t): c_git_clone_local_t =
  case arg:
    of GIT_CLONE_LOCAL_AUTO    : c_GIT_CLONE_LOCAL_AUTO
    of GIT_CLONE_LOCAL         : c_GIT_CLONE_LOCAL
    of GIT_CLONE_NO_LOCAL      : c_GIT_CLONE_NO_LOCAL
    of GIT_CLONE_LOCAL_NO_LINKS: c_GIT_CLONE_LOCAL_NO_LINKS

converter toCInt*(arg: c_git_clone_local_t): cint = cint(ord(arg))

converter toCInt*(arg: git_clone_local_t): cint = cint(ord(to_c_git_clone_local_t(arg)))

converter toCInt*(args: set[git_clone_local_t]): cint =
  for value in items(args):
    case value:
      of GIT_CLONE_LOCAL_AUTO    : result = cint(result or 0)
      of GIT_CLONE_LOCAL         : result = cint(result or 1)
      of GIT_CLONE_NO_LOCAL      : result = cint(result or 2)
      of GIT_CLONE_LOCAL_NO_LINKS: result = cint(result or 3)

func `-`*(arg: c_git_clone_local_t, offset: int): cint = cast[c_git_clone_local_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_clone_local_t): cint = cast[c_git_clone_local_t](ord(arg) - offset)

func `+`*(arg: c_git_clone_local_t, offset: int): cint = cast[c_git_clone_local_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_clone_local_t): cint = cast[c_git_clone_local_t](ord(arg) + offset)

proc git_clone_options_init*(opts: ptr git_clone_options, version: cuint): cint {.importc: "git_clone_options_init".}

proc git_clone*(
    `out`: ptr ptr git_repository,
    url: cstring,
    local_path: cstring,
    options: ptr git_clone_options,
): cint {.importc: "git_clone".}