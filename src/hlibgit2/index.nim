{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./strarray,
  ./types

type
  c_git_index_add_option_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ADD_DEFAULT                = 0 shl 0
    c_GIT_INDEX_ADD_FORCE                  = 1 shl 0
    c_GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 1 shl 1
    c_GIT_INDEX_ADD_CHECK_PATHSPEC         = 1 shl 2

  c_git_index_capability_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_CAPABILITY_FROM_OWNER  = -1
    c_GIT_INDEX_CAPABILITY_IGNORE_CASE = 1
    c_GIT_INDEX_CAPABILITY_NO_FILEMODE = 2
    c_GIT_INDEX_CAPABILITY_NO_SYMLINKS = 4

  c_git_index_entry_extended_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ENTRY_UPTODATE       = 4
    c_GIT_INDEX_ENTRY_INTENT_TO_ADD  = 8192
    c_GIT_INDEX_ENTRY_SKIP_WORKTREE  = 16384
    c_GIT_INDEX_ENTRY_EXTENDED_FLAGS = 24576

  c_git_index_entry_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_ENTRY_EXTENDED = 0 shl 0

  c_git_index_stage_t* {.size: sizeof(cint).} = enum
    c_GIT_INDEX_STAGE_ANY      = -1
    c_GIT_INDEX_STAGE_NORMAL   = 0  ## A normal staged file in the index.
    c_GIT_INDEX_STAGE_ANCESTOR = 1  ## The ancestor side of a conflict.
    c_GIT_INDEX_STAGE_OURS     = 2  ## The "ours" side of a conflict.
    c_GIT_INDEX_STAGE_THEIRS   = 3  ## The "theirs" side of a conflict.

  git_index_add_option_t* {.size: sizeof(cint).} = enum
    GIT_INDEX_ADD_DEFAULT
    GIT_INDEX_ADD_FORCE
    GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH
    GIT_INDEX_ADD_CHECK_PATHSPEC

  git_index_capability_t* = enum
    GIT_INDEX_CAPABILITY_FROM_OWNER
    GIT_INDEX_CAPABILITY_IGNORE_CASE
    GIT_INDEX_CAPABILITY_NO_FILEMODE
    GIT_INDEX_CAPABILITY_NO_SYMLINKS

  git_index_entry* {.bycopy, header: "<git2/index.h>", importc.} = object
    ctime*:          git_index_time
    mtime*:          git_index_time
    dev*:            uint32
    ino*:            uint32
    mode*:           uint32
    uid*:            uint32
    gid*:            uint32
    file_size*:      uint32
    id*:             git_oid
    flags*:          uint16
    flags_extended*: uint16
    path*:           cstring

  git_index_entry_extended_flag_t* = enum
    GIT_INDEX_ENTRY_UPTODATE
    GIT_INDEX_ENTRY_INTENT_TO_ADD
    GIT_INDEX_ENTRY_SKIP_WORKTREE
    GIT_INDEX_ENTRY_EXTENDED_FLAGS

  git_index_entry_flag_t* {.size: sizeof(cint).} = enum
    GIT_INDEX_ENTRY_EXTENDED

  git_index_matched_path_cb* = proc(path:             cstring,
                                    matched_pathspec: cstring,
                                    payload:          pointer): cint{.cdecl.}

  git_index_stage_t* = enum
    GIT_INDEX_STAGE_ANY
    GIT_INDEX_STAGE_NORMAL   ## A normal staged file in the index.
    GIT_INDEX_STAGE_ANCESTOR ## The ancestor side of a conflict.
    GIT_INDEX_STAGE_OURS     ## The "ours" side of a conflict.
    GIT_INDEX_STAGE_THEIRS   ## The "theirs" side of a conflict.

  git_index_time* {.bycopy, header: "<git2/index.h>", importc.} = object
    ## Time structure used in a git index entry
    seconds*:     int32
    nanoseconds*: uint32 ## nsec should not be stored as time_t compatible


proc to_c_git_index_entry_flag_t*(
    arg: git_index_entry_flag_t
  ): c_git_index_entry_flag_t =
  case arg:
    of GIT_INDEX_ENTRY_EXTENDED: c_GIT_INDEX_ENTRY_EXTENDED


converter to_git_index_entry_flag_t*(
    arg: c_git_index_entry_flag_t
  ): git_index_entry_flag_t =
  case arg:
    of c_GIT_INDEX_ENTRY_EXTENDED: GIT_INDEX_ENTRY_EXTENDED


converter toCint*(arg: c_git_index_entry_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_index_entry_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_index_entry_flag_t(arg)))

func `+`*(
    arg:    c_git_index_entry_flag_t,
    offset: int
  ): c_git_index_entry_flag_t =
  cast[c_git_index_entry_flag_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_index_entry_flag_t
  ): c_git_index_entry_flag_t =
  cast[c_git_index_entry_flag_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_index_entry_flag_t,
    offset: int
  ): c_git_index_entry_flag_t =
  cast[c_git_index_entry_flag_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_index_entry_flag_t
  ): c_git_index_entry_flag_t =
  cast[c_git_index_entry_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_index_entry_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_INDEX_ENTRY_EXTENDED: result = cint(result or (0 shl 0))


proc to_c_git_index_entry_extended_flag_t*(
    arg: git_index_entry_extended_flag_t
  ): c_git_index_entry_extended_flag_t =
  case arg:
    of GIT_INDEX_ENTRY_UPTODATE:       c_GIT_INDEX_ENTRY_UPTODATE
    of GIT_INDEX_ENTRY_INTENT_TO_ADD:  c_GIT_INDEX_ENTRY_INTENT_TO_ADD
    of GIT_INDEX_ENTRY_SKIP_WORKTREE:  c_GIT_INDEX_ENTRY_SKIP_WORKTREE
    of GIT_INDEX_ENTRY_EXTENDED_FLAGS: c_GIT_INDEX_ENTRY_EXTENDED_FLAGS


converter to_git_index_entry_extended_flag_t*(
    arg: c_git_index_entry_extended_flag_t
  ): git_index_entry_extended_flag_t =
  case arg:
    of c_GIT_INDEX_ENTRY_UPTODATE:       GIT_INDEX_ENTRY_UPTODATE
    of c_GIT_INDEX_ENTRY_INTENT_TO_ADD:  GIT_INDEX_ENTRY_INTENT_TO_ADD
    of c_GIT_INDEX_ENTRY_SKIP_WORKTREE:  GIT_INDEX_ENTRY_SKIP_WORKTREE
    of c_GIT_INDEX_ENTRY_EXTENDED_FLAGS: GIT_INDEX_ENTRY_EXTENDED_FLAGS


converter toCint*(arg: c_git_index_entry_extended_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_index_entry_extended_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_index_entry_extended_flag_t(arg)))

func `+`*(
    arg:    c_git_index_entry_extended_flag_t,
    offset: int
  ): c_git_index_entry_extended_flag_t =
  cast[c_git_index_entry_extended_flag_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_index_entry_extended_flag_t
  ): c_git_index_entry_extended_flag_t =
  cast[c_git_index_entry_extended_flag_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_index_entry_extended_flag_t,
    offset: int
  ): c_git_index_entry_extended_flag_t =
  cast[c_git_index_entry_extended_flag_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_index_entry_extended_flag_t
  ): c_git_index_entry_extended_flag_t =
  cast[c_git_index_entry_extended_flag_t](ord(arg) - offset)


proc to_c_git_index_capability_t*(
    arg: git_index_capability_t
  ): c_git_index_capability_t =
  case arg:
    of GIT_INDEX_CAPABILITY_FROM_OWNER:  c_GIT_INDEX_CAPABILITY_FROM_OWNER
    of GIT_INDEX_CAPABILITY_IGNORE_CASE: c_GIT_INDEX_CAPABILITY_IGNORE_CASE
    of GIT_INDEX_CAPABILITY_NO_FILEMODE: c_GIT_INDEX_CAPABILITY_NO_FILEMODE
    of GIT_INDEX_CAPABILITY_NO_SYMLINKS: c_GIT_INDEX_CAPABILITY_NO_SYMLINKS


converter to_git_index_capability_t*(
    arg: c_git_index_capability_t
  ): git_index_capability_t =
  case arg:
    of c_GIT_INDEX_CAPABILITY_FROM_OWNER:  GIT_INDEX_CAPABILITY_FROM_OWNER
    of c_GIT_INDEX_CAPABILITY_IGNORE_CASE: GIT_INDEX_CAPABILITY_IGNORE_CASE
    of c_GIT_INDEX_CAPABILITY_NO_FILEMODE: GIT_INDEX_CAPABILITY_NO_FILEMODE
    of c_GIT_INDEX_CAPABILITY_NO_SYMLINKS: GIT_INDEX_CAPABILITY_NO_SYMLINKS


converter toCint*(arg: c_git_index_capability_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_index_capability_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_index_capability_t(arg)))

func `+`*(
    arg:    c_git_index_capability_t,
    offset: int
  ): c_git_index_capability_t =
  cast[c_git_index_capability_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_index_capability_t
  ): c_git_index_capability_t =
  cast[c_git_index_capability_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_index_capability_t,
    offset: int
  ): c_git_index_capability_t =
  cast[c_git_index_capability_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_index_capability_t
  ): c_git_index_capability_t =
  cast[c_git_index_capability_t](ord(arg) - offset)


proc to_c_git_index_add_option_t*(
    arg: git_index_add_option_t
  ): c_git_index_add_option_t =
  case arg:
    of GIT_INDEX_ADD_DEFAULT:                c_GIT_INDEX_ADD_DEFAULT
    of GIT_INDEX_ADD_FORCE:                  c_GIT_INDEX_ADD_FORCE
    of GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH: c_GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH
    of GIT_INDEX_ADD_CHECK_PATHSPEC:         c_GIT_INDEX_ADD_CHECK_PATHSPEC


converter to_git_index_add_option_t*(
    arg: c_git_index_add_option_t
  ): git_index_add_option_t =
  case arg:
    of c_GIT_INDEX_ADD_DEFAULT:                GIT_INDEX_ADD_DEFAULT
    of c_GIT_INDEX_ADD_FORCE:                  GIT_INDEX_ADD_FORCE
    of c_GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH: GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH
    of c_GIT_INDEX_ADD_CHECK_PATHSPEC:         GIT_INDEX_ADD_CHECK_PATHSPEC


converter toCint*(arg: c_git_index_add_option_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_index_add_option_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_index_add_option_t(arg)))

func `+`*(
    arg:    c_git_index_add_option_t,
    offset: int
  ): c_git_index_add_option_t =
  cast[c_git_index_add_option_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_index_add_option_t
  ): c_git_index_add_option_t =
  cast[c_git_index_add_option_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_index_add_option_t,
    offset: int
  ): c_git_index_add_option_t =
  cast[c_git_index_add_option_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_index_add_option_t
  ): c_git_index_add_option_t =
  cast[c_git_index_add_option_t](ord(arg) - offset)


converter toCint*(args: set[git_index_add_option_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_INDEX_ADD_DEFAULT:                result = cint(result or (0 shl 0))
      of GIT_INDEX_ADD_FORCE:                  result = cint(result or (1 shl 0))
      of GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH: result = cint(result or (1 shl 1))
      of GIT_INDEX_ADD_CHECK_PATHSPEC:         result = cint(result or (1 shl 2))


proc to_c_git_index_stage_t*(arg: git_index_stage_t): c_git_index_stage_t =
  case arg:
    of GIT_INDEX_STAGE_ANY:      c_GIT_INDEX_STAGE_ANY
    of GIT_INDEX_STAGE_NORMAL:   c_GIT_INDEX_STAGE_NORMAL
    of GIT_INDEX_STAGE_ANCESTOR: c_GIT_INDEX_STAGE_ANCESTOR
    of GIT_INDEX_STAGE_OURS:     c_GIT_INDEX_STAGE_OURS
    of GIT_INDEX_STAGE_THEIRS:   c_GIT_INDEX_STAGE_THEIRS


converter to_git_index_stage_t*(arg: c_git_index_stage_t): git_index_stage_t =
  case arg:
    of c_GIT_INDEX_STAGE_ANY:      GIT_INDEX_STAGE_ANY
    of c_GIT_INDEX_STAGE_NORMAL:   GIT_INDEX_STAGE_NORMAL
    of c_GIT_INDEX_STAGE_ANCESTOR: GIT_INDEX_STAGE_ANCESTOR
    of c_GIT_INDEX_STAGE_OURS:     GIT_INDEX_STAGE_OURS
    of c_GIT_INDEX_STAGE_THEIRS:   GIT_INDEX_STAGE_THEIRS


converter toCint*(arg: c_git_index_stage_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_index_stage_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_index_stage_t(arg)))

func `+`*(arg: c_git_index_stage_t, offset: int): c_git_index_stage_t =
  cast[c_git_index_stage_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_index_stage_t): c_git_index_stage_t =
  cast[c_git_index_stage_t](ord(arg) + offset)

func `-`*(arg: c_git_index_stage_t, offset: int): c_git_index_stage_t =
  cast[c_git_index_stage_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_index_stage_t): c_git_index_stage_t =
  cast[c_git_index_stage_t](ord(arg) - offset)


proc git_index_open*(
    arg_out:    ptr ptr git_index,
    index_path: cstring
  ): cint {.git2Proc, importc.}



proc git_index_new*(arg_out: ptr ptr git_index): cint {.git2Proc, importc.}



proc git_index_free*(index: ptr git_index): void {.git2Proc, importc.}



proc git_index_owner*(
    index: ptr git_index
  ): ptr git_repository {.git2Proc, importc.}



proc git_index_caps*(index: ptr git_index): cint {.git2Proc, importc.}



proc git_index_set_caps*(
    index: ptr git_index,
    caps:  cint
  ): cint {.git2Proc, importc.}



proc git_index_version*(index: ptr git_index): cuint {.git2Proc, importc.}



proc git_index_set_version*(
    index:   ptr git_index,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_index_read*(
    index: ptr git_index,
    force: cint
  ): cint {.git2Proc, importc.}



proc git_index_write*(index: ptr git_index): cint {.git2Proc, importc.}



proc git_index_path*(index: ptr git_index): cstring {.git2Proc, importc.}



proc git_index_checksum*(
    index: ptr git_index
  ): ptr git_oid {.git2Proc, importc.}



proc git_index_read_tree*(
    index: ptr git_index,
    tree:  ptr git_tree
  ): cint {.git2Proc, importc.}



proc git_index_write_tree*(
    arg_out: ptr git_oid,
    index:   ptr git_index
  ): cint {.git2Proc, importc.}



proc git_index_write_tree_to*(
    arg_out: ptr git_oid,
    index:   ptr git_index,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_index_entrycount*(index: ptr git_index): csize_t {.git2Proc, importc.}



proc git_index_clear*(index: ptr git_index): cint {.git2Proc, importc.}



proc git_index_get_byindex*(
    index: ptr git_index,
    n:     csize_t
  ): ptr git_index_entry {.git2Proc, importc.}



proc git_index_get_bypath*(
    index: ptr git_index,
    path:  cstring,
    stage: cint
  ): ptr git_index_entry {.git2Proc, importc.}



proc git_index_remove*(
    index: ptr git_index,
    path:  cstring,
    stage: cint
  ): cint {.git2Proc, importc.}



proc git_index_remove_directory*(
    index: ptr git_index,
    dir:   cstring,
    stage: cint
  ): cint {.git2Proc, importc.}



proc git_index_add*(
    index:        ptr git_index,
    source_entry: ptr git_index_entry
  ): cint {.git2Proc, importc.}



proc git_index_entry_stage*(
    entry: ptr git_index_entry
  ): cint {.git2Proc, importc.}



proc git_index_entry_is_conflict*(
    entry: ptr git_index_entry
  ): cint {.git2Proc, importc.}



proc git_index_iterator_new*(
    iterator_out: ptr ptr git_index_iterator,
    index:        ptr git_index
  ): cint {.git2Proc, importc.}



proc git_index_iterator_next*(
    arg_out:      ptr ptr git_index_entry,
    arg_iterator: ptr git_index_iterator
  ): cint {.git2Proc, importc.}



proc git_index_iterator_free*(
    arg_iterator: ptr git_index_iterator
  ): void {.git2Proc, importc.}



proc git_index_add_bypath*(
    index: ptr git_index,
    path:  cstring
  ): cint {.git2Proc, importc.}



proc git_index_add_from_buffer*(
    index:  ptr git_index,
    entry:  ptr git_index_entry,
    buffer: pointer,
    len:    csize_t
  ): cint {.git2Proc, importc.}



proc git_index_remove_bypath*(
    index: ptr git_index,
    path:  cstring
  ): cint {.git2Proc, importc.}



proc git_index_add_all*(
    index:    ptr git_index,
    pathspec: ptr git_strarray,
    flags:    cuint,
    callback: git_index_matched_path_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_index_remove_all*(
    index:    ptr git_index,
    pathspec: ptr git_strarray,
    callback: git_index_matched_path_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_index_update_all*(
    index:    ptr git_index,
    pathspec: ptr git_strarray,
    callback: git_index_matched_path_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_index_find*(
    at_pos: ptr csize_t,
    index:  ptr git_index,
    path:   cstring
  ): cint {.git2Proc, importc.}



proc git_index_find_prefix*(
    at_pos: ptr csize_t,
    index:  ptr git_index,
    prefix: cstring
  ): cint {.git2Proc, importc.}



proc git_index_conflict_add*(
    index:          ptr git_index,
    ancestor_entry: ptr git_index_entry,
    our_entry:      ptr git_index_entry,
    their_entry:    ptr git_index_entry
  ): cint {.git2Proc, importc.}



proc git_index_conflict_get*(
    ancestor_out: ptr ptr git_index_entry,
    our_out:      ptr ptr git_index_entry,
    their_out:    ptr ptr git_index_entry,
    index:        ptr git_index,
    path:         cstring
  ): cint {.git2Proc, importc.}



proc git_index_conflict_remove*(
    index: ptr git_index,
    path:  cstring
  ): cint {.git2Proc, importc.}



proc git_index_conflict_cleanup*(
    index: ptr git_index
  ): cint {.git2Proc, importc.}



proc git_index_has_conflicts*(index: ptr git_index): cint {.git2Proc, importc.}



proc git_index_conflict_iterator_new*(
    iterator_out: ptr ptr git_index_conflict_iterator,
    index:        ptr git_index
  ): cint {.git2Proc, importc.}



proc git_index_conflict_next*(
    ancestor_out: ptr ptr git_index_entry,
    our_out:      ptr ptr git_index_entry,
    their_out:    ptr ptr git_index_entry,
    arg_iterator: ptr git_index_conflict_iterator
  ): cint {.git2Proc, importc.}



proc git_index_conflict_iterator_free*(
    arg_iterator: ptr git_index_conflict_iterator
  ): void {.git2Proc, importc.}



