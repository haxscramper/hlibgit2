import "./types.nim"
import "./oid.nim"
import "./buffer.nim"

type
  git_filter_options* {.importc, bycopy.} = object
    version        *: cuint
    flags          *: uint32
    commit_id      *: ptr git_oid
    attr_commit_id *: git_oid

  git_filter_list* {.importc, incompleteStruct.} = object


  c_git_filter_mode_t* {.size: sizeof(cint).} = enum
    c_GIT_FILTER_TO_WORKTREE = 0
    c_GIT_FILTER_TO_ODB      = 1

  git_filter_mode_t* = enum
    GIT_FILTER_TO_WORKTREE = 0
    GIT_FILTER_TO_ODB      = 1

  c_git_filter_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_FILTER_DEFAULT                = 0
    c_GIT_FILTER_ALLOW_UNSAFE           = 1
    c_GIT_FILTER_NO_SYSTEM_ATTRIBUTES   = 2
    c_GIT_FILTER_ATTRIBUTES_FROM_HEAD   = 1 shl 2
    c_GIT_FILTER_ATTRIBUTES_FROM_COMMIT = 1 shl 3

  git_filter_flag_t* = enum
    GIT_FILTER_DEFAULT                = 0
    GIT_FILTER_ALLOW_UNSAFE           = 1
    GIT_FILTER_NO_SYSTEM_ATTRIBUTES   = 2
    GIT_FILTER_ATTRIBUTES_FROM_HEAD   = 3
    GIT_FILTER_ATTRIBUTES_FROM_COMMIT = 4



converter to_git_filter_mode_t*(arg: c_git_filter_mode_t): git_filter_mode_t =
  case arg:
    of c_GIT_FILTER_TO_WORKTREE: GIT_FILTER_TO_WORKTREE
    of c_GIT_FILTER_TO_ODB     : GIT_FILTER_TO_ODB

proc to_c_git_filter_mode_t*(arg: git_filter_mode_t): c_git_filter_mode_t =
  case arg:
    of GIT_FILTER_TO_WORKTREE: c_GIT_FILTER_TO_WORKTREE
    of GIT_FILTER_TO_ODB     : c_GIT_FILTER_TO_ODB

converter toCInt*(arg: c_git_filter_mode_t): cint = cint(ord(arg))

converter toCInt*(arg: git_filter_mode_t): cint = cint(ord(to_c_git_filter_mode_t(arg)))

converter toCInt*(args: set[git_filter_mode_t]): cint =
  for value in items(args):
    case value:
      of GIT_FILTER_TO_WORKTREE: result = cint(result or 0)
      of GIT_FILTER_TO_ODB     : result = cint(result or 1)

func `-`*(arg: c_git_filter_mode_t, offset: int): cint = cast[c_git_filter_mode_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_filter_mode_t): cint = cast[c_git_filter_mode_t](ord(arg) - offset)

func `+`*(arg: c_git_filter_mode_t, offset: int): cint = cast[c_git_filter_mode_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_filter_mode_t): cint = cast[c_git_filter_mode_t](ord(arg) + offset)

converter to_git_filter_flag_t*(arg: c_git_filter_flag_t): git_filter_flag_t =
  case arg:
    of c_GIT_FILTER_DEFAULT               : GIT_FILTER_DEFAULT
    of c_GIT_FILTER_ALLOW_UNSAFE          : GIT_FILTER_ALLOW_UNSAFE
    of c_GIT_FILTER_NO_SYSTEM_ATTRIBUTES  : GIT_FILTER_NO_SYSTEM_ATTRIBUTES
    of c_GIT_FILTER_ATTRIBUTES_FROM_HEAD  : GIT_FILTER_ATTRIBUTES_FROM_HEAD
    of c_GIT_FILTER_ATTRIBUTES_FROM_COMMIT: GIT_FILTER_ATTRIBUTES_FROM_COMMIT

proc to_c_git_filter_flag_t*(arg: git_filter_flag_t): c_git_filter_flag_t =
  case arg:
    of GIT_FILTER_DEFAULT               : c_GIT_FILTER_DEFAULT
    of GIT_FILTER_ALLOW_UNSAFE          : c_GIT_FILTER_ALLOW_UNSAFE
    of GIT_FILTER_NO_SYSTEM_ATTRIBUTES  : c_GIT_FILTER_NO_SYSTEM_ATTRIBUTES
    of GIT_FILTER_ATTRIBUTES_FROM_HEAD  : c_GIT_FILTER_ATTRIBUTES_FROM_HEAD
    of GIT_FILTER_ATTRIBUTES_FROM_COMMIT: c_GIT_FILTER_ATTRIBUTES_FROM_COMMIT

converter toCInt*(arg: c_git_filter_flag_t): cint = cint(ord(arg))

converter toCInt*(arg: git_filter_flag_t): cint = cint(ord(to_c_git_filter_flag_t(arg)))

converter toCInt*(args: set[git_filter_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_FILTER_DEFAULT               : result = cint(result or 0)
      of GIT_FILTER_ALLOW_UNSAFE          : result = cint(result or 1)
      of GIT_FILTER_NO_SYSTEM_ATTRIBUTES  : result = cint(result or 2)
      of GIT_FILTER_ATTRIBUTES_FROM_HEAD  : result = cint(result or 4)
      of GIT_FILTER_ATTRIBUTES_FROM_COMMIT: result = cint(result or 8)

func `-`*(arg: c_git_filter_flag_t, offset: int): cint = cast[c_git_filter_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_filter_flag_t): cint = cast[c_git_filter_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_filter_flag_t, offset: int): cint = cast[c_git_filter_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_filter_flag_t): cint = cast[c_git_filter_flag_t](ord(arg) + offset)

proc git_filter_list_load*(
    filters: ptr ptr git_filter_list,
    repo: ptr git_repository,
    blob: ptr git_blob,
    path: cstring,
    mode: git_filter_mode_t,
    flags: uint32,
): cint {.importc: "git_filter_list_load".}

proc git_filter_list_load_ext*(
    filters: ptr ptr git_filter_list,
    repo: ptr git_repository,
    blob: ptr git_blob,
    path: cstring,
    mode: git_filter_mode_t,
    opts: ptr git_filter_options,
): cint {.importc: "git_filter_list_load_ext".}

proc git_filter_list_contains*(filters: ptr git_filter_list, name: cstring): cint {.importc: "git_filter_list_contains".}

proc git_filter_list_apply_to_buffer*(
    `out`: ptr git_buf,
    filters: ptr git_filter_list,
    `in`: cstring,
    in_len: csize_t,
): cint {.importc: "git_filter_list_apply_to_buffer".}

proc git_filter_list_apply_to_file*(
    `out`: ptr git_buf,
    filters: ptr git_filter_list,
    repo: ptr git_repository,
    path: cstring,
): cint {.importc: "git_filter_list_apply_to_file".}

proc git_filter_list_apply_to_blob*(
    `out`: ptr git_buf,
    filters: ptr git_filter_list,
    blob: ptr git_blob,
): cint {.importc: "git_filter_list_apply_to_blob".}

proc git_filter_list_stream_buffer*(
    filters: ptr git_filter_list,
    buffer: cstring,
    len: csize_t,
    target: ptr git_writestream,
): cint {.importc: "git_filter_list_stream_buffer".}

proc git_filter_list_stream_file*(
    filters: ptr git_filter_list,
    repo: ptr git_repository,
    path: cstring,
    target: ptr git_writestream,
): cint {.importc: "git_filter_list_stream_file".}

proc git_filter_list_stream_blob*(
    filters: ptr git_filter_list,
    blob: ptr git_blob,
    target: ptr git_writestream,
): cint {.importc: "git_filter_list_stream_blob".}

proc git_filter_list_free*(filters: ptr git_filter_list): void {.importc: "git_filter_list_free".}