{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid

type
  c_git_direction* {.size: sizeof(cint).} = enum
    c_GIT_DIRECTION_FETCH = 0 shl 0
    c_GIT_DIRECTION_PUSH  = 1 shl 0

  git_direction* {.size: sizeof(cint).} = enum
    GIT_DIRECTION_FETCH
    GIT_DIRECTION_PUSH

  git_remote_head* {.bycopy, header: "<git2/net.h>", importc.} = object
    local*:         cint
    oid*:           git_oid ## available locally
    loid*:          git_oid
    name*:          cstring
    symref_target*: cstring


proc to_c_git_direction*(arg: git_direction): c_git_direction =
  case arg:
    of GIT_DIRECTION_FETCH: c_GIT_DIRECTION_FETCH
    of GIT_DIRECTION_PUSH:  c_GIT_DIRECTION_PUSH


converter to_git_direction*(arg: c_git_direction): git_direction =
  case arg:
    of c_GIT_DIRECTION_FETCH: GIT_DIRECTION_FETCH
    of c_GIT_DIRECTION_PUSH:  GIT_DIRECTION_PUSH


converter toCint*(arg: c_git_direction): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_direction): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_direction(arg)))

func `+`*(arg: c_git_direction, offset: int): c_git_direction =
  cast[c_git_direction](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_direction): c_git_direction =
  cast[c_git_direction](ord(arg) + offset)

func `-`*(arg: c_git_direction, offset: int): c_git_direction =
  cast[c_git_direction](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_direction): c_git_direction =
  cast[c_git_direction](ord(arg) - offset)


converter toCint*(args: set[git_direction]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_DIRECTION_FETCH: result = cint(result or (0 shl 0))
      of GIT_DIRECTION_PUSH:  result = cint(result or (1 shl 0))


