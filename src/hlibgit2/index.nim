import "../oid.nim"
import "../strarray.nim"
import "../types.nim"

type
  git_index_time* {.importc, bycopy.} = object
    seconds     *: int32
    nanoseconds *: uint32

  git_index_entry* {.importc, bycopy.} = object
    ctime          *: git_index_time
    mtime          *: git_index_time
    dev            *: uint32
    ino            *: uint32
    mode           *: uint32
    uid            *: uint32
    gid            *: uint32
    file_size      *: uint32
    id             *: git_oid
    flags          *: uint16
    flags_extended *: uint16
    path           *: cstring

  c_git_index_entry_flag_t {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ENTRY_EXTENDED = 1 shl 14
    c_GIT_INDEX_ENTRY_VALID    = 1 shl 15

  git_index_entry_flag_t = enum
    GIT_INDEX_ENTRY_EXTENDED
    GIT_INDEX_ENTRY_VALID

  c_git_index_entry_extended_flag_t {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ENTRY_INTENT_TO_ADD  = 1 shl 13
    c_GIT_INDEX_ENTRY_SKIP_WORKTREE  = 1 shl 14
    c_GIT_INDEX_ENTRY_EXTENDED_FLAGS = 24576
    c_GIT_INDEX_ENTRY_UPTODATE       = 1 shl 2

  git_index_entry_extended_flag_t = enum
    GIT_INDEX_ENTRY_INTENT_TO_ADD
    GIT_INDEX_ENTRY_SKIP_WORKTREE
    GIT_INDEX_ENTRY_EXTENDED_FLAGS
    GIT_INDEX_ENTRY_UPTODATE

  c_git_index_capability_t {.size: sizeof(cint).} = enum
    c_GIT_INDEX_CAPABILITY_IGNORE_CASE = 1 shl 0
    c_GIT_INDEX_CAPABILITY_NO_FILEMODE = 1 shl 1
    c_GIT_INDEX_CAPABILITY_NO_SYMLINKS = 1 shl 2
    c_GIT_INDEX_CAPABILITY_FROM_OWNER  = -1

  git_index_capability_t = enum
    GIT_INDEX_CAPABILITY_IGNORE_CASE
    GIT_INDEX_CAPABILITY_NO_FILEMODE
    GIT_INDEX_CAPABILITY_NO_SYMLINKS
    GIT_INDEX_CAPABILITY_FROM_OWNER

  c_git_index_add_option_t {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ADD_DEFAULT                = 0 shl 0
    c_GIT_INDEX_ADD_FORCE                  = 1 shl 0
    c_GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 1 shl 1
    c_GIT_INDEX_ADD_CHECK_PATHSPEC         = 1 shl 2

  git_index_add_option_t = enum
    GIT_INDEX_ADD_DEFAULT
    GIT_INDEX_ADD_FORCE
    GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH
    GIT_INDEX_ADD_CHECK_PATHSPEC

  c_git_index_stage_t {.size: sizeof(cint).} = enum
    c_GIT_INDEX_STAGE_ANY      = -1
    c_GIT_INDEX_STAGE_NORMAL   = 0 shl 0
    c_GIT_INDEX_STAGE_ANCESTOR = 1 shl 0
    c_GIT_INDEX_STAGE_OURS     = 1 shl 1
    c_GIT_INDEX_STAGE_THEIRS   = 3

  git_index_stage_t = enum
    GIT_INDEX_STAGE_ANY
    GIT_INDEX_STAGE_NORMAL
    GIT_INDEX_STAGE_ANCESTOR
    GIT_INDEX_STAGE_OURS
    GIT_INDEX_STAGE_THEIRS

  git_index_matched_path_cb = proc (a0: cstring, a1: cstring, a2: ptr void): cint



converter toCInt*(arg: c_git_index_entry_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_index_entry_flag_t)): cint =
  for value in items(args):
    case value:
      of GIT_INDEX_ENTRY_EXTENDED: result = cint(result or 16384)
      of GIT_INDEX_ENTRY_VALID   : result = cint(result or 32768)

func `-`*(arg: c_git_index_entry_flag_t, offset: int): cint = cast[c_git_index_entry_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_entry_flag_t): cint = cast[c_git_index_entry_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_index_entry_flag_t, offset: int): cint = cast[c_git_index_entry_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_entry_flag_t): cint = cast[c_git_index_entry_flag_t](ord(arg) + offset)

converter toCInt*(arg: c_git_index_entry_extended_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_index_entry_extended_flag_t)): cint =
  for value in items(args):
    case value:
      of GIT_INDEX_ENTRY_INTENT_TO_ADD : result = cint(result or 8192)
      of GIT_INDEX_ENTRY_SKIP_WORKTREE : result = cint(result or 16384)
      of GIT_INDEX_ENTRY_EXTENDED_FLAGS: result = cint(result or 24576)
      of GIT_INDEX_ENTRY_UPTODATE      : result = cint(result or 4)

func `-`*(arg: c_git_index_entry_extended_flag_t, offset: int): cint = cast[c_git_index_entry_extended_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_entry_extended_flag_t): cint = cast[c_git_index_entry_extended_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_index_entry_extended_flag_t, offset: int): cint = cast[c_git_index_entry_extended_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_entry_extended_flag_t): cint = cast[c_git_index_entry_extended_flag_t](ord(arg) + offset)

converter toCInt*(arg: c_git_index_capability_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_index_capability_t)): cint =
  for value in items(args):
    case value:
      of GIT_INDEX_CAPABILITY_IGNORE_CASE: result = cint(result or 1)
      of GIT_INDEX_CAPABILITY_NO_FILEMODE: result = cint(result or 2)
      of GIT_INDEX_CAPABILITY_NO_SYMLINKS: result = cint(result or 4)
      of GIT_INDEX_CAPABILITY_FROM_OWNER : result = cint(result or -1)

func `-`*(arg: c_git_index_capability_t, offset: int): cint = cast[c_git_index_capability_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_capability_t): cint = cast[c_git_index_capability_t](ord(arg) - offset)

func `+`*(arg: c_git_index_capability_t, offset: int): cint = cast[c_git_index_capability_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_capability_t): cint = cast[c_git_index_capability_t](ord(arg) + offset)

converter toCInt*(arg: c_git_index_add_option_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_index_add_option_t)): cint =
  for value in items(args):
    case value:
      of GIT_INDEX_ADD_DEFAULT               : result = cint(result or 0)
      of GIT_INDEX_ADD_FORCE                 : result = cint(result or 1)
      of GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH: result = cint(result or 2)
      of GIT_INDEX_ADD_CHECK_PATHSPEC        : result = cint(result or 4)

func `-`*(arg: c_git_index_add_option_t, offset: int): cint = cast[c_git_index_add_option_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_add_option_t): cint = cast[c_git_index_add_option_t](ord(arg) - offset)

func `+`*(arg: c_git_index_add_option_t, offset: int): cint = cast[c_git_index_add_option_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_add_option_t): cint = cast[c_git_index_add_option_t](ord(arg) + offset)

converter toCInt*(arg: c_git_index_stage_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_index_stage_t)): cint =
  for value in items(args):
    case value:
      of GIT_INDEX_STAGE_ANY     : result = cint(result or -1)
      of GIT_INDEX_STAGE_NORMAL  : result = cint(result or 0)
      of GIT_INDEX_STAGE_ANCESTOR: result = cint(result or 1)
      of GIT_INDEX_STAGE_OURS    : result = cint(result or 2)
      of GIT_INDEX_STAGE_THEIRS  : result = cint(result or 3)

func `-`*(arg: c_git_index_stage_t, offset: int): cint = cast[c_git_index_stage_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_stage_t): cint = cast[c_git_index_stage_t](ord(arg) - offset)

func `+`*(arg: c_git_index_stage_t, offset: int): cint = cast[c_git_index_stage_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_stage_t): cint = cast[c_git_index_stage_t](ord(arg) + offset)

proc git_index_open*(out: ptr git_index, index_path: cstring): cint {.git2Proc, importc.}

proc git_index_new*(out: ptr git_index): cint {.git2Proc, importc.}

proc git_index_free*(index: ptr git_index): void {.git2Proc, importc.}

proc git_index_owner*(index: ptr git_index): ptr git_repository {.git2Proc, importc.}

proc git_index_caps*(index: ptr git_index): cint {.git2Proc, importc.}

proc git_index_set_caps*(index: ptr git_index, caps: cint): cint {.git2Proc, importc.}

proc git_index_version*(index: ptr git_index): cuint {.git2Proc, importc.}

proc git_index_set_version*(index: ptr git_index, version: cuint): cint {.git2Proc, importc.}

proc git_index_read*(index: ptr git_index, force: cint): cint {.git2Proc, importc.}

proc git_index_write*(index: ptr git_index): cint {.git2Proc, importc.}

proc git_index_path*(index: ptr git_index): cstring {.git2Proc, importc.}

proc git_index_checksum*(index: ptr git_index): ptr git_oid {.git2Proc, importc.}

proc git_index_read_tree*(index: ptr git_index, tree: ptr git_tree): cint {.git2Proc, importc.}

proc git_index_write_tree*(out: ptr git_oid, index: ptr git_index): cint {.git2Proc, importc.}

proc git_index_write_tree_to*(out: ptr git_oid, index: ptr git_index, repo: ptr git_repository): cint {.git2Proc, importc.}

proc git_index_entrycount*(index: ptr git_index): csize_t {.git2Proc, importc.}

proc git_index_clear*(index: ptr git_index): cint {.git2Proc, importc.}

proc git_index_get_byindex*(index: ptr git_index, n: csize_t): ptr git_index_entry {.git2Proc, importc.}

proc git_index_get_bypath*(index: ptr git_index, path: cstring, stage: cint): ptr git_index_entry {.git2Proc, importc.}

proc git_index_remove*(index: ptr git_index, path: cstring, stage: cint): cint {.git2Proc, importc.}

proc git_index_remove_directory*(index: ptr git_index, dir: cstring, stage: cint): cint {.git2Proc, importc.}

proc git_index_add*(index: ptr git_index, source_entry: ptr git_index_entry): cint {.git2Proc, importc.}

proc git_index_entry_stage*(entry: ptr git_index_entry): cint {.git2Proc, importc.}

proc git_index_entry_is_conflict*(entry: ptr git_index_entry): cint {.git2Proc, importc.}

proc git_index_iterator_new*(iterator_out: ptr git_index_iterator, index: ptr git_index): cint {.git2Proc, importc.}

proc git_index_iterator_next*(out: ptr git_index_entry, iterator: ptr git_index_iterator): cint {.git2Proc, importc.}

proc git_index_iterator_free*(iterator: ptr git_index_iterator): void {.git2Proc, importc.}

proc git_index_add_bypath*(index: ptr git_index, path: cstring): cint {.git2Proc, importc.}

proc git_index_add_from_buffer*(index: ptr git_index, entry: ptr git_index_entry, buffer: ptr const void, len: csize_t): cint {.git2Proc, importc.}

proc git_index_remove_bypath*(index: ptr git_index, path: cstring): cint {.git2Proc, importc.}

proc git_index_add_all*(index: ptr git_index, pathspec: ptr git_strarray, flags: cuint, callback: git_index_matched_path_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_index_remove_all*(index: ptr git_index, pathspec: ptr git_strarray, callback: git_index_matched_path_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_index_update_all*(index: ptr git_index, pathspec: ptr git_strarray, callback: git_index_matched_path_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_index_find*(at_pos: ptr csize_t, index: ptr git_index, path: cstring): cint {.git2Proc, importc.}

proc git_index_find_prefix*(at_pos: ptr csize_t, index: ptr git_index, prefix: cstring): cint {.git2Proc, importc.}

proc git_index_conflict_add*(index: ptr git_index, ancestor_entry: ptr git_index_entry, our_entry: ptr git_index_entry, their_entry: ptr git_index_entry): cint {.git2Proc, importc.}

proc git_index_conflict_get*(ancestor_out: ptr git_index_entry, our_out: ptr git_index_entry, their_out: ptr git_index_entry, index: ptr git_index, path: cstring): cint {.git2Proc, importc.}

proc git_index_conflict_remove*(index: ptr git_index, path: cstring): cint {.git2Proc, importc.}

proc git_index_conflict_cleanup*(index: ptr git_index): cint {.git2Proc, importc.}

proc git_index_has_conflicts*(index: ptr git_index): cint {.git2Proc, importc.}

proc git_index_conflict_iterator_new*(iterator_out: ptr git_index_conflict_iterator, index: ptr git_index): cint {.git2Proc, importc.}

proc git_index_conflict_next*(ancestor_out: ptr git_index_entry, our_out: ptr git_index_entry, their_out: ptr git_index_entry, iterator: ptr git_index_conflict_iterator): cint {.git2Proc, importc.}

proc git_index_conflict_iterator_free*(iterator: ptr git_index_conflict_iterator): void {.git2Proc, importc.}