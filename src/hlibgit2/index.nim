import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./strarray.nim"
import "./oid.nim"

type
  git_index_time* {.header: "<index.h>", importc, bycopy.} = object
    seconds     *: int32
    nanoseconds *: uint32

  git_index_entry* {.header: "<index.h>", importc, bycopy.} = object
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

  c_git_index_entry_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ENTRY_EXTENDED = 1 shl 14
    c_GIT_INDEX_ENTRY_VALID    = 1 shl 15

  git_index_entry_flag_t* = enum
    GIT_INDEX_ENTRY_EXTENDED = 0
    GIT_INDEX_ENTRY_VALID    = 1

  c_git_index_entry_extended_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ENTRY_UPTODATE       = 1 shl 2
    c_GIT_INDEX_ENTRY_INTENT_TO_ADD  = 1 shl 13
    c_GIT_INDEX_ENTRY_SKIP_WORKTREE  = 1 shl 14
    c_GIT_INDEX_ENTRY_EXTENDED_FLAGS = 24576

  git_index_entry_extended_flag_t* = enum
    GIT_INDEX_ENTRY_UPTODATE       = 0
    GIT_INDEX_ENTRY_INTENT_TO_ADD  = 1
    GIT_INDEX_ENTRY_SKIP_WORKTREE  = 2
    GIT_INDEX_ENTRY_EXTENDED_FLAGS = 3

  c_git_index_capability_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_CAPABILITY_FROM_OWNER  = -1
    c_GIT_INDEX_CAPABILITY_IGNORE_CASE = 1
    c_GIT_INDEX_CAPABILITY_NO_FILEMODE = 2
    c_GIT_INDEX_CAPABILITY_NO_SYMLINKS = 1 shl 2

  git_index_capability_t* = enum
    GIT_INDEX_CAPABILITY_FROM_OWNER  = 0
    GIT_INDEX_CAPABILITY_IGNORE_CASE = 1
    GIT_INDEX_CAPABILITY_NO_FILEMODE = 2
    GIT_INDEX_CAPABILITY_NO_SYMLINKS = 3

  c_git_index_add_option_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ADD_DEFAULT                = 0
    c_GIT_INDEX_ADD_FORCE                  = 1
    c_GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 2
    c_GIT_INDEX_ADD_CHECK_PATHSPEC         = 1 shl 2

  git_index_add_option_t* = enum
    GIT_INDEX_ADD_DEFAULT                = 0
    GIT_INDEX_ADD_FORCE                  = 1
    GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 2
    GIT_INDEX_ADD_CHECK_PATHSPEC         = 3

  c_git_index_stage_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_STAGE_ANY      = -1
    c_GIT_INDEX_STAGE_NORMAL   = 0 shl 0
    c_GIT_INDEX_STAGE_ANCESTOR = 1 shl 0
    c_GIT_INDEX_STAGE_OURS     = 1 shl 1
    c_GIT_INDEX_STAGE_THEIRS   = 3

  git_index_stage_t* = enum
    GIT_INDEX_STAGE_ANY      = 0
    GIT_INDEX_STAGE_NORMAL   = 1
    GIT_INDEX_STAGE_ANCESTOR = 2
    GIT_INDEX_STAGE_OURS     = 3
    GIT_INDEX_STAGE_THEIRS   = 4

  git_index_matched_path_cb* = proc (a0: cstring, a1: cstring, a2: pointer): cint



proc git_index_conflict_iterator_free*(`iterator`: ptr git_index_conflict_iterator): void {.importc: "git_index_conflict_iterator_free", header: "<index.h>".}

converter to_git_index_entry_flag_t*(arg: c_git_index_entry_flag_t): git_index_entry_flag_t =
  case arg:
    of c_GIT_INDEX_ENTRY_EXTENDED: GIT_INDEX_ENTRY_EXTENDED
    of c_GIT_INDEX_ENTRY_VALID   : GIT_INDEX_ENTRY_VALID

proc to_c_git_index_entry_flag_t*(arg: git_index_entry_flag_t): c_git_index_entry_flag_t =
  case arg:
    of GIT_INDEX_ENTRY_EXTENDED: c_GIT_INDEX_ENTRY_EXTENDED
    of GIT_INDEX_ENTRY_VALID   : c_GIT_INDEX_ENTRY_VALID

converter toCInt*(arg: c_git_index_entry_flag_t): cint = cint(ord(arg))

converter toCInt*(arg: git_index_entry_flag_t): cint = cint(ord(to_c_git_index_entry_flag_t(arg)))

converter toCInt*(args: set[git_index_entry_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_INDEX_ENTRY_EXTENDED: result = cint(result or 16384)
      of GIT_INDEX_ENTRY_VALID   : result = cint(result or 32768)

func `-`*(arg: c_git_index_entry_flag_t, offset: int): cint = cast[c_git_index_entry_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_entry_flag_t): cint = cast[c_git_index_entry_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_index_entry_flag_t, offset: int): cint = cast[c_git_index_entry_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_entry_flag_t): cint = cast[c_git_index_entry_flag_t](ord(arg) + offset)

converter to_git_index_entry_extended_flag_t*(arg: c_git_index_entry_extended_flag_t): git_index_entry_extended_flag_t =
  case arg:
    of c_GIT_INDEX_ENTRY_UPTODATE      : GIT_INDEX_ENTRY_UPTODATE
    of c_GIT_INDEX_ENTRY_INTENT_TO_ADD : GIT_INDEX_ENTRY_INTENT_TO_ADD
    of c_GIT_INDEX_ENTRY_SKIP_WORKTREE : GIT_INDEX_ENTRY_SKIP_WORKTREE
    of c_GIT_INDEX_ENTRY_EXTENDED_FLAGS: GIT_INDEX_ENTRY_EXTENDED_FLAGS

proc to_c_git_index_entry_extended_flag_t*(arg: git_index_entry_extended_flag_t): c_git_index_entry_extended_flag_t =
  case arg:
    of GIT_INDEX_ENTRY_UPTODATE      : c_GIT_INDEX_ENTRY_UPTODATE
    of GIT_INDEX_ENTRY_INTENT_TO_ADD : c_GIT_INDEX_ENTRY_INTENT_TO_ADD
    of GIT_INDEX_ENTRY_SKIP_WORKTREE : c_GIT_INDEX_ENTRY_SKIP_WORKTREE
    of GIT_INDEX_ENTRY_EXTENDED_FLAGS: c_GIT_INDEX_ENTRY_EXTENDED_FLAGS

converter toCInt*(arg: c_git_index_entry_extended_flag_t): cint = cint(ord(arg))

converter toCInt*(arg: git_index_entry_extended_flag_t): cint = cint(ord(to_c_git_index_entry_extended_flag_t(arg)))

converter toCInt*(args: set[git_index_entry_extended_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_INDEX_ENTRY_UPTODATE      : result = cint(result or 4)
      of GIT_INDEX_ENTRY_INTENT_TO_ADD : result = cint(result or 8192)
      of GIT_INDEX_ENTRY_SKIP_WORKTREE : result = cint(result or 16384)
      of GIT_INDEX_ENTRY_EXTENDED_FLAGS: result = cint(result or 24576)

func `-`*(arg: c_git_index_entry_extended_flag_t, offset: int): cint = cast[c_git_index_entry_extended_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_entry_extended_flag_t): cint = cast[c_git_index_entry_extended_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_index_entry_extended_flag_t, offset: int): cint = cast[c_git_index_entry_extended_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_entry_extended_flag_t): cint = cast[c_git_index_entry_extended_flag_t](ord(arg) + offset)

converter to_git_index_capability_t*(arg: c_git_index_capability_t): git_index_capability_t =
  case arg:
    of c_GIT_INDEX_CAPABILITY_FROM_OWNER : GIT_INDEX_CAPABILITY_FROM_OWNER
    of c_GIT_INDEX_CAPABILITY_IGNORE_CASE: GIT_INDEX_CAPABILITY_IGNORE_CASE
    of c_GIT_INDEX_CAPABILITY_NO_FILEMODE: GIT_INDEX_CAPABILITY_NO_FILEMODE
    of c_GIT_INDEX_CAPABILITY_NO_SYMLINKS: GIT_INDEX_CAPABILITY_NO_SYMLINKS

proc to_c_git_index_capability_t*(arg: git_index_capability_t): c_git_index_capability_t =
  case arg:
    of GIT_INDEX_CAPABILITY_FROM_OWNER : c_GIT_INDEX_CAPABILITY_FROM_OWNER
    of GIT_INDEX_CAPABILITY_IGNORE_CASE: c_GIT_INDEX_CAPABILITY_IGNORE_CASE
    of GIT_INDEX_CAPABILITY_NO_FILEMODE: c_GIT_INDEX_CAPABILITY_NO_FILEMODE
    of GIT_INDEX_CAPABILITY_NO_SYMLINKS: c_GIT_INDEX_CAPABILITY_NO_SYMLINKS

converter toCInt*(arg: c_git_index_capability_t): cint = cint(ord(arg))

converter toCInt*(arg: git_index_capability_t): cint = cint(ord(to_c_git_index_capability_t(arg)))

converter toCInt*(args: set[git_index_capability_t]): cint =
  for value in items(args):
    case value:
      of GIT_INDEX_CAPABILITY_FROM_OWNER : result = cint(result or -1)
      of GIT_INDEX_CAPABILITY_IGNORE_CASE: result = cint(result or 1)
      of GIT_INDEX_CAPABILITY_NO_FILEMODE: result = cint(result or 2)
      of GIT_INDEX_CAPABILITY_NO_SYMLINKS: result = cint(result or 4)

func `-`*(arg: c_git_index_capability_t, offset: int): cint = cast[c_git_index_capability_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_capability_t): cint = cast[c_git_index_capability_t](ord(arg) - offset)

func `+`*(arg: c_git_index_capability_t, offset: int): cint = cast[c_git_index_capability_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_capability_t): cint = cast[c_git_index_capability_t](ord(arg) + offset)

converter to_git_index_add_option_t*(arg: c_git_index_add_option_t): git_index_add_option_t =
  case arg:
    of c_GIT_INDEX_ADD_DEFAULT               : GIT_INDEX_ADD_DEFAULT
    of c_GIT_INDEX_ADD_FORCE                 : GIT_INDEX_ADD_FORCE
    of c_GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH: GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH
    of c_GIT_INDEX_ADD_CHECK_PATHSPEC        : GIT_INDEX_ADD_CHECK_PATHSPEC

proc to_c_git_index_add_option_t*(arg: git_index_add_option_t): c_git_index_add_option_t =
  case arg:
    of GIT_INDEX_ADD_DEFAULT               : c_GIT_INDEX_ADD_DEFAULT
    of GIT_INDEX_ADD_FORCE                 : c_GIT_INDEX_ADD_FORCE
    of GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH: c_GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH
    of GIT_INDEX_ADD_CHECK_PATHSPEC        : c_GIT_INDEX_ADD_CHECK_PATHSPEC

converter toCInt*(arg: c_git_index_add_option_t): cint = cint(ord(arg))

converter toCInt*(arg: git_index_add_option_t): cint = cint(ord(to_c_git_index_add_option_t(arg)))

converter toCInt*(args: set[git_index_add_option_t]): cint =
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

converter to_git_index_stage_t*(arg: c_git_index_stage_t): git_index_stage_t =
  case arg:
    of c_GIT_INDEX_STAGE_ANY     : GIT_INDEX_STAGE_ANY
    of c_GIT_INDEX_STAGE_NORMAL  : GIT_INDEX_STAGE_NORMAL
    of c_GIT_INDEX_STAGE_ANCESTOR: GIT_INDEX_STAGE_ANCESTOR
    of c_GIT_INDEX_STAGE_OURS    : GIT_INDEX_STAGE_OURS
    of c_GIT_INDEX_STAGE_THEIRS  : GIT_INDEX_STAGE_THEIRS

proc to_c_git_index_stage_t*(arg: git_index_stage_t): c_git_index_stage_t =
  case arg:
    of GIT_INDEX_STAGE_ANY     : c_GIT_INDEX_STAGE_ANY
    of GIT_INDEX_STAGE_NORMAL  : c_GIT_INDEX_STAGE_NORMAL
    of GIT_INDEX_STAGE_ANCESTOR: c_GIT_INDEX_STAGE_ANCESTOR
    of GIT_INDEX_STAGE_OURS    : c_GIT_INDEX_STAGE_OURS
    of GIT_INDEX_STAGE_THEIRS  : c_GIT_INDEX_STAGE_THEIRS

converter toCInt*(arg: c_git_index_stage_t): cint = cint(ord(arg))

converter toCInt*(arg: git_index_stage_t): cint = cint(ord(to_c_git_index_stage_t(arg)))

converter toCInt*(args: set[git_index_stage_t]): cint =
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

proc git_index_open*(`out`: ptr ptr git_index, index_path: cstring): cint {.importc: "git_index_open", header: "<index.h>".}

proc git_index_new*(`out`: ptr ptr git_index): cint {.importc: "git_index_new", header: "<index.h>".}

proc git_index_free*(index: ptr git_index): void {.importc: "git_index_free", header: "<index.h>".}

proc git_index_owner*(index: ptr git_index): ptr git_repository {.importc: "git_index_owner", header: "<index.h>".}

proc git_index_caps*(index: ptr git_index): cint {.importc: "git_index_caps", header: "<index.h>".}

proc git_index_set_caps*(index: ptr git_index, caps: cint): cint {.importc: "git_index_set_caps", header: "<index.h>".}

proc git_index_version*(index: ptr git_index): cuint {.importc: "git_index_version", header: "<index.h>".}

proc git_index_set_version*(index: ptr git_index, version: cuint): cint {.importc: "git_index_set_version", header: "<index.h>".}

proc git_index_read*(index: ptr git_index, force: cint): cint {.importc: "git_index_read", header: "<index.h>".}

proc git_index_write*(index: ptr git_index): cint {.importc: "git_index_write", header: "<index.h>".}

proc git_index_path*(index: ptr git_index): cstring {.importc: "git_index_path", header: "<index.h>".}

proc git_index_checksum*(index: ptr git_index): ptr git_oid {.importc: "git_index_checksum", header: "<index.h>".}

proc git_index_read_tree*(index: ptr git_index, tree: ptr git_tree): cint {.importc: "git_index_read_tree", header: "<index.h>".}

proc git_index_write_tree*(`out`: ptr git_oid, index: ptr git_index): cint {.importc: "git_index_write_tree", header: "<index.h>".}

proc git_index_write_tree_to*(
    `out`: ptr git_oid,
    index: ptr git_index,
    repo: ptr git_repository,
): cint {.importc: "git_index_write_tree_to", header: "<index.h>".}

proc git_index_entrycount*(index: ptr git_index): csize_t {.importc: "git_index_entrycount", header: "<index.h>".}

proc git_index_clear*(index: ptr git_index): cint {.importc: "git_index_clear", header: "<index.h>".}

proc git_index_get_byindex*(index: ptr git_index, n: csize_t): ptr git_index_entry {.importc: "git_index_get_byindex", header: "<index.h>".}

proc git_index_get_bypath*(
    index: ptr git_index,
    path: cstring,
    stage: cint,
): ptr git_index_entry {.importc: "git_index_get_bypath", header: "<index.h>".}

proc git_index_remove*(
    index: ptr git_index,
    path: cstring,
    stage: cint,
): cint {.importc: "git_index_remove", header: "<index.h>".}

proc git_index_remove_directory*(
    index: ptr git_index,
    dir: cstring,
    stage: cint,
): cint {.importc: "git_index_remove_directory", header: "<index.h>".}

proc git_index_add*(index: ptr git_index, source_entry: ptr git_index_entry): cint {.importc: "git_index_add", header: "<index.h>".}

proc git_index_entry_stage*(entry: ptr git_index_entry): cint {.importc: "git_index_entry_stage", header: "<index.h>".}

proc git_index_entry_is_conflict*(entry: ptr git_index_entry): cint {.importc: "git_index_entry_is_conflict", header: "<index.h>".}

proc git_index_iterator_new*(iterator_out: ptr ptr git_index_iterator, index: ptr git_index): cint {.importc: "git_index_iterator_new", header: "<index.h>".}

proc git_index_iterator_next*(`out`: ptr ptr git_index_entry, `iterator`: ptr git_index_iterator): cint {.importc: "git_index_iterator_next", header: "<index.h>".}

proc git_index_iterator_free*(`iterator`: ptr git_index_iterator): void {.importc: "git_index_iterator_free", header: "<index.h>".}

proc git_index_add_bypath*(index: ptr git_index, path: cstring): cint {.importc: "git_index_add_bypath", header: "<index.h>".}

proc git_index_add_from_buffer*(
    index: ptr git_index,
    entry: ptr git_index_entry,
    buffer: pointer,
    len: csize_t,
): cint {.importc: "git_index_add_from_buffer", header: "<index.h>".}

proc git_index_remove_bypath*(index: ptr git_index, path: cstring): cint {.importc: "git_index_remove_bypath", header: "<index.h>".}

proc git_index_add_all*(
    index: ptr git_index,
    pathspec: ptr git_strarray,
    flags: cuint,
    callback: git_index_matched_path_cb,
    payload: pointer,
): cint {.importc: "git_index_add_all", header: "<index.h>".}

proc git_index_remove_all*(
    index: ptr git_index,
    pathspec: ptr git_strarray,
    callback: git_index_matched_path_cb,
    payload: pointer,
): cint {.importc: "git_index_remove_all", header: "<index.h>".}

proc git_index_update_all*(
    index: ptr git_index,
    pathspec: ptr git_strarray,
    callback: git_index_matched_path_cb,
    payload: pointer,
): cint {.importc: "git_index_update_all", header: "<index.h>".}

proc git_index_find*(
    at_pos: ptr csize_t,
    index: ptr git_index,
    path: cstring,
): cint {.importc: "git_index_find", header: "<index.h>".}

proc git_index_find_prefix*(
    at_pos: ptr csize_t,
    index: ptr git_index,
    prefix: cstring,
): cint {.importc: "git_index_find_prefix", header: "<index.h>".}

proc git_index_conflict_add*(
    index: ptr git_index,
    ancestor_entry: ptr git_index_entry,
    our_entry: ptr git_index_entry,
    their_entry: ptr git_index_entry,
): cint {.importc: "git_index_conflict_add", header: "<index.h>".}

proc git_index_conflict_get*(
    ancestor_out: ptr ptr git_index_entry,
    our_out: ptr ptr git_index_entry,
    their_out: ptr ptr git_index_entry,
    index: ptr git_index,
    path: cstring,
): cint {.importc: "git_index_conflict_get", header: "<index.h>".}

proc git_index_conflict_remove*(index: ptr git_index, path: cstring): cint {.importc: "git_index_conflict_remove", header: "<index.h>".}

proc git_index_conflict_cleanup*(index: ptr git_index): cint {.importc: "git_index_conflict_cleanup", header: "<index.h>".}

proc git_index_has_conflicts*(index: ptr git_index): cint {.importc: "git_index_has_conflicts", header: "<index.h>".}

proc git_index_conflict_iterator_new*(iterator_out: ptr ptr git_index_conflict_iterator, index: ptr git_index): cint {.importc: "git_index_conflict_iterator_new", header: "<index.h>".}

proc git_index_conflict_next*(
    ancestor_out: ptr ptr git_index_entry,
    our_out: ptr ptr git_index_entry,
    their_out: ptr ptr git_index_entry,
    `iterator`: ptr git_index_conflict_iterator,
): cint {.importc: "git_index_conflict_next", header: "<index.h>".}