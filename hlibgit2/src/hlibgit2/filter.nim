import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./buffer.nim"
import "./types.nim"

type
  git_filter_options* {.bycopy.} = object
    version        *: cuint
    flags          *: uint32
    commit_id      *: ptr git_oid
    attr_commit_id *: git_oid

  git_filter_list* {.bycopy, incompleteStruct.} = object


  c_git_filter_mode_t* {.size: sizeof(cint).} = enum
    c_GIT_FILTER_TO_WORKTREE = 0
    c_GIT_FILTER_TO_ODB      = 1

  git_filter_mode_t* = enum
    GIT_FILTER_TO_WORKTREE
    GIT_FILTER_SMUDGE
    GIT_FILTER_TO_ODB
    GIT_FILTER_CLEAN

  c_git_filter_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_FILTER_DEFAULT                = 0
    c_GIT_FILTER_ALLOW_UNSAFE           = 1
    c_GIT_FILTER_NO_SYSTEM_ATTRIBUTES   = 2
    c_GIT_FILTER_ATTRIBUTES_FROM_HEAD   = 1 shl 2
    c_GIT_FILTER_ATTRIBUTES_FROM_COMMIT = 1 shl 3

  git_filter_flag_t* = enum
    GIT_FILTER_DEFAULT
    GIT_FILTER_ALLOW_UNSAFE
    GIT_FILTER_NO_SYSTEM_ATTRIBUTES
    GIT_FILTER_ATTRIBUTES_FROM_HEAD
    GIT_FILTER_ATTRIBUTES_FROM_COMMIT



converter toCInt*(arg: c_git_filter_mode_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_filter_mode_t]): cint =
  for value in items(args):
    case value:
      of GIT_FILTER_TO_WORKTREE: result = cint(result or 0)
      of GIT_FILTER_SMUDGE     : result = cint(result or 0)
      of GIT_FILTER_TO_ODB     : result = cint(result or 1)
      of GIT_FILTER_CLEAN      : result = cint(result or 1)

func `-`*(arg: c_git_filter_mode_t, offset: int): cint = cast[c_git_filter_mode_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_filter_mode_t): cint = cast[c_git_filter_mode_t](ord(arg) - offset)

func `+`*(arg: c_git_filter_mode_t, offset: int): cint = cast[c_git_filter_mode_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_filter_mode_t): cint = cast[c_git_filter_mode_t](ord(arg) + offset)

converter toCInt*(arg: c_git_filter_flag_t): cint = cint(ord(arg))

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
): cint {.git2Proc, importc: "git_filter_list_load".}

proc git_filter_list_load_ext*(
    filters: ptr ptr git_filter_list,
    repo: ptr git_repository,
    blob: ptr git_blob,
    path: cstring,
    mode: git_filter_mode_t,
    opts: ptr git_filter_options,
): cint {.git2Proc, importc: "git_filter_list_load_ext".}

proc git_filter_list_contains*(filters: ptr git_filter_list, name: cstring): cint {.git2Proc, importc: "git_filter_list_contains".}

proc git_filter_list_apply_to_buffer*(
    `out`: ptr git_buf,
    filters: ptr git_filter_list,
    `in`: cstring,
    in_len: csize_t,
): cint {.git2Proc, importc: "git_filter_list_apply_to_buffer".}

proc git_filter_list_apply_to_file*(
    `out`: ptr git_buf,
    filters: ptr git_filter_list,
    repo: ptr git_repository,
    path: cstring,
): cint {.git2Proc, importc: "git_filter_list_apply_to_file".}

proc git_filter_list_apply_to_blob*(
    `out`: ptr git_buf,
    filters: ptr git_filter_list,
    blob: ptr git_blob,
): cint {.git2Proc, importc: "git_filter_list_apply_to_blob".}

proc git_filter_list_stream_buffer*(
    filters: ptr git_filter_list,
    buffer: cstring,
    len: csize_t,
    target: ptr git_writestream,
): cint {.git2Proc, importc: "git_filter_list_stream_buffer".}

proc git_filter_list_stream_file*(
    filters: ptr git_filter_list,
    repo: ptr git_repository,
    path: cstring,
    target: ptr git_writestream,
): cint {.git2Proc, importc: "git_filter_list_stream_file".}

proc git_filter_list_stream_blob*(
    filters: ptr git_filter_list,
    blob: ptr git_blob,
    target: ptr git_writestream,
): cint {.git2Proc, importc: "git_filter_list_stream_blob".}

proc git_filter_list_free*(filters: ptr git_filter_list): void {.git2Proc, importc: "git_filter_list_free".}