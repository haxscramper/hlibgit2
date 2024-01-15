import "./types.nim"
import "./strarray.nim"
import "./checkout.nim"

type
  c_git_reset_t* {.size: sizeof(cint).} = enum
    c_GIT_RESET_SOFT  = 1 shl 0
    c_GIT_RESET_MIXED = 1 shl 1
    c_GIT_RESET_HARD  = 3

  git_reset_t* = enum
    GIT_RESET_SOFT  = 0
    GIT_RESET_MIXED = 1
    GIT_RESET_HARD  = 2



proc git_reset_default*(
    repo: ptr git_repository,
    target: ptr git_object,
    pathspecs: ptr git_strarray,
): cint {.importc: "git_reset_default".}

converter to_git_reset_t*(arg: c_git_reset_t): git_reset_t =
  case arg:
    of c_GIT_RESET_SOFT : GIT_RESET_SOFT
    of c_GIT_RESET_MIXED: GIT_RESET_MIXED
    of c_GIT_RESET_HARD : GIT_RESET_HARD

proc to_c_git_reset_t*(arg: git_reset_t): c_git_reset_t =
  case arg:
    of GIT_RESET_SOFT : c_GIT_RESET_SOFT
    of GIT_RESET_MIXED: c_GIT_RESET_MIXED
    of GIT_RESET_HARD : c_GIT_RESET_HARD

converter toCInt*(arg: c_git_reset_t): cint = cint(ord(arg))

converter toCInt*(arg: git_reset_t): cint = cint(ord(to_c_git_reset_t(arg)))

converter toCInt*(args: set[git_reset_t]): cint =
  for value in items(args):
    case value:
      of GIT_RESET_SOFT : result = cint(result or 1)
      of GIT_RESET_MIXED: result = cint(result or 2)
      of GIT_RESET_HARD : result = cint(result or 3)

func `-`*(arg: c_git_reset_t, offset: int): cint = cast[c_git_reset_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_reset_t): cint = cast[c_git_reset_t](ord(arg) - offset)

func `+`*(arg: c_git_reset_t, offset: int): cint = cast[c_git_reset_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_reset_t): cint = cast[c_git_reset_t](ord(arg) + offset)

proc git_reset*(
    repo: ptr git_repository,
    target: ptr git_object,
    reset_type: git_reset_t,
    checkout_opts: ptr git_checkout_options,
): cint {.importc: "git_reset".}

proc git_reset_from_annotated*(
    repo: ptr git_repository,
    commit: ptr git_annotated_commit,
    reset_type: git_reset_t,
    checkout_opts: ptr git_checkout_options,
): cint {.importc: "git_reset_from_annotated".}