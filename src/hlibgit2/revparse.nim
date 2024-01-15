import "./types.nim"

type
  git_revspec* {.bycopy.} = object
    `from` *: ptr git_object
    to     *: ptr git_object
    flags  *: cuint

  c_git_revspec_t* {.size: sizeof(cint).} = enum
    c_GIT_REVSPEC_SINGLE     = 1 shl 0
    c_GIT_REVSPEC_RANGE      = 1 shl 1
    c_GIT_REVSPEC_MERGE_BASE = 1 shl 2

  git_revspec_t* = enum
    GIT_REVSPEC_SINGLE     = 0
    GIT_REVSPEC_RANGE      = 1
    GIT_REVSPEC_MERGE_BASE = 2



converter to_git_revspec_t*(arg: c_git_revspec_t): git_revspec_t =
  case arg:
    of c_GIT_REVSPEC_SINGLE    : GIT_REVSPEC_SINGLE
    of c_GIT_REVSPEC_RANGE     : GIT_REVSPEC_RANGE
    of c_GIT_REVSPEC_MERGE_BASE: GIT_REVSPEC_MERGE_BASE

proc to_c_git_revspec_t*(arg: git_revspec_t): c_git_revspec_t =
  case arg:
    of GIT_REVSPEC_SINGLE    : c_GIT_REVSPEC_SINGLE
    of GIT_REVSPEC_RANGE     : c_GIT_REVSPEC_RANGE
    of GIT_REVSPEC_MERGE_BASE: c_GIT_REVSPEC_MERGE_BASE

converter toCInt*(arg: c_git_revspec_t): cint = cint(ord(arg))

converter toCInt*(arg: git_revspec_t): cint = cint(ord(to_c_git_revspec_t(arg)))

converter toCInt*(args: set[git_revspec_t]): cint =
  for value in items(args):
    case value:
      of GIT_REVSPEC_SINGLE    : result = cint(result or 1)
      of GIT_REVSPEC_RANGE     : result = cint(result or 2)
      of GIT_REVSPEC_MERGE_BASE: result = cint(result or 4)

func `-`*(arg: c_git_revspec_t, offset: int): c_git_revspec_t = cast[c_git_revspec_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_revspec_t): c_git_revspec_t = cast[c_git_revspec_t](ord(arg) - offset)

func `+`*(arg: c_git_revspec_t, offset: int): c_git_revspec_t = cast[c_git_revspec_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_revspec_t): c_git_revspec_t = cast[c_git_revspec_t](ord(arg) + offset)

proc git_revparse_single*(
    `out`: ptr ptr git_object,
    repo: ptr git_repository,
    spec: cstring,
): cint {.importc: "git_revparse_single".}

proc git_revparse_ext*(
    object_out: ptr ptr git_object,
    reference_out: ptr ptr git_reference,
    repo: ptr git_repository,
    spec: cstring,
): cint {.importc: "git_revparse_ext".}

proc git_revparse*(
    revspec: ptr git_revspec,
    repo: ptr git_repository,
    spec: cstring,
): cint {.importc: "git_revparse".}