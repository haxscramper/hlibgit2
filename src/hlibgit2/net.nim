import "./oid.nim"

type
  c_git_direction* {.size: sizeof(cint).} = enum
    c_GIT_DIRECTION_FETCH = 0
    c_GIT_DIRECTION_PUSH  = 1

  git_direction* = enum
    GIT_DIRECTION_FETCH = 0
    GIT_DIRECTION_PUSH  = 1

  git_remote_head* {.bycopy.} = object
    local         *: cint
    oid           *: git_oid
    loid          *: git_oid
    name          *: ptr char
    symref_target *: ptr char



converter to_git_direction*(arg: c_git_direction): git_direction =
  case arg:
    of c_GIT_DIRECTION_FETCH: GIT_DIRECTION_FETCH
    of c_GIT_DIRECTION_PUSH : GIT_DIRECTION_PUSH

proc to_c_git_direction*(arg: git_direction): c_git_direction =
  case arg:
    of GIT_DIRECTION_FETCH: c_GIT_DIRECTION_FETCH
    of GIT_DIRECTION_PUSH : c_GIT_DIRECTION_PUSH

converter toCInt*(arg: c_git_direction): cint = cint(ord(arg))

converter toCInt*(arg: git_direction): cint = cint(ord(to_c_git_direction(arg)))

converter toCInt*(args: set[git_direction]): cint =
  for value in items(args):
    case value:
      of GIT_DIRECTION_FETCH: result = cint(result or 0)
      of GIT_DIRECTION_PUSH : result = cint(result or 1)

func `-`*(arg: c_git_direction, offset: int): cint = cast[c_git_direction](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_direction): cint = cast[c_git_direction](ord(arg) - offset)

func `+`*(arg: c_git_direction, offset: int): cint = cast[c_git_direction](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_direction): cint = cast[c_git_direction](ord(arg) + offset)