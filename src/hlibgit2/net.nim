type

  git_remote_head* {.importc, bycopy.} = object
    local         *: cint
    oid           *: git_oid
    loid          *: git_oid
    name          *: ptr char
    symref_target *: ptr char
  c_git_direction {.size: sizeof(cint).} = enum
    c_GIT_DIRECTION_FETCH = 0 shl 0
    c_GIT_DIRECTION_PUSH  = 1 shl 0
  git_direction = enum
    GIT_DIRECTION_FETCH
    GIT_DIRECTION_PUSH



converter toCInt*(arg: c_git_direction): cint = cint(ord(arg))

converter toCInt*(args: set(git_direction)): cint =
  for value in items(args):
    case value:
      of GIT_DIRECTION_FETCH: result = cint(result or 0)
      of GIT_DIRECTION_PUSH: result = cint(result or 1)

func `-`*(arg: c_git_direction, offset: int): cint = cast[c_git_direction](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_direction): cint = cast[c_git_direction](ord(arg) - offset)

func `+`*(arg: c_git_direction, offset: int): cint = cast[c_git_direction](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_direction): cint = cast[c_git_direction](ord(arg) + offset)