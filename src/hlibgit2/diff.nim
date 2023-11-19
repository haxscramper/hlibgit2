import "../buffer.nim"
import "../oid.nim"
import "../strarray.nim"
import "../types.nim"

type
  git_diff* {.importc, bycopy.} = object


  git_diff_file* {.importc, bycopy.} = object
    id        *: git_oid
    path      *: cstring
    size      *: git_object_size_t
    flags     *: uint32
    mode      *: uint16
    id_abbrev *: uint16

  c_git_delta_t {.size: sizeof(cint).} = enum
    c_GIT_DELTA_UNMODIFIED = 0 shl 0
    c_GIT_DELTA_ADDED      = 1 shl 0
    c_GIT_DELTA_DELETED    = 1 shl 1
    c_GIT_DELTA_MODIFIED   = 3
    c_GIT_DELTA_RENAMED    = 1 shl 2
    c_GIT_DELTA_COPIED     = 5
    c_GIT_DELTA_IGNORED    = 6
    c_GIT_DELTA_UNTRACKED  = 7
    c_GIT_DELTA_TYPECHANGE = 1 shl 3
    c_GIT_DELTA_UNREADABLE = 9
    c_GIT_DELTA_CONFLICTED = 10

  git_delta_t = enum
    GIT_DELTA_UNMODIFIED
    GIT_DELTA_ADDED
    GIT_DELTA_DELETED
    GIT_DELTA_MODIFIED
    GIT_DELTA_RENAMED
    GIT_DELTA_COPIED
    GIT_DELTA_IGNORED
    GIT_DELTA_UNTRACKED
    GIT_DELTA_TYPECHANGE
    GIT_DELTA_UNREADABLE
    GIT_DELTA_CONFLICTED

  git_diff_delta* {.importc, bycopy.} = object
    status     *: git_delta_t
    flags      *: uint32
    similarity *: uint16
    nfiles     *: uint16
    old_file   *: git_diff_file
    new_file   *: git_diff_file

  git_diff_options* {.importc, bycopy.} = object
    version           *: cuint
    flags             *: uint32
    ignore_submodules *: git_submodule_ignore_t
    pathspec          *: git_strarray
    notify_cb         *: git_diff_notify_cb
    progress_cb       *: git_diff_progress_cb
    payload           *: ptr void
    context_lines     *: uint32
    interhunk_lines   *: uint32
    oid_type          *: git_oid_t
    id_abbrev         *: uint16
    max_size          *: git_off_t
    old_prefix        *: cstring
    new_prefix        *: cstring

  git_diff_notify_cb = proc (a0: ptr git_diff, a1: ptr git_diff_delta, a2: cstring, a3: ptr void): cint

  git_diff_binary_file* {.importc, bycopy.} = object
    type        *: git_diff_binary_t
    data        *: cstring
    datalen     *: csize_t
    inflatedlen *: csize_t

  c_git_diff_binary_t {.size: sizeof(cint).} = enum
    c_GIT_DIFF_BINARY_NONE    = 0 shl 0
    c_GIT_DIFF_BINARY_LITERAL = 1 shl 0
    c_GIT_DIFF_BINARY_DELTA   = 1 shl 1

  git_diff_binary_t = enum
    GIT_DIFF_BINARY_NONE
    GIT_DIFF_BINARY_LITERAL
    GIT_DIFF_BINARY_DELTA

  git_diff_binary* {.importc, bycopy.} = object
    contains_data *: cuint
    old_file      *: git_diff_binary_file
    new_file      *: git_diff_binary_file

  git_diff_hunk* {.importc, bycopy.} = object
    old_start  *: cint
    old_lines  *: cint
    new_start  *: cint
    new_lines  *: cint
    header_len *: csize_t
    header     *:

  git_diff_line* {.importc, bycopy.} = object
    origin         *: char
    old_lineno     *: cint
    new_lineno     *: cint
    num_lines      *: cint
    content_len    *: csize_t
    content_offset *: git_off_t
    content        *: cstring

  git_diff_similarity_metric* {.importc, bycopy.} = object
    file_signature   *: proc (a0: ptr void, a1: ptr git_diff_file, a2: cstring, a3: ptr void): cint
    buffer_signature *: proc (a0: ptr void, a1: ptr git_diff_file, a2: cstring, a3: csize_t, a4: ptr void): cint
    free_signature   *: proc (a0: ptr void, a1: ptr void): void
    similarity       *: proc (a0: ptr cint, a1: ptr void, a2: ptr void, a3: ptr void): cint
    payload          *: ptr void

  git_diff_progress_cb = proc (a0: ptr git_diff, a1: cstring, a2: cstring, a3: ptr void): cint

  git_diff_find_options* {.importc, bycopy.} = object
    version                       *: cuint
    flags                         *: uint32
    rename_threshold              *: uint16
    rename_from_rewrite_threshold *: uint16
    copy_threshold                *: uint16
    break_rewrite_threshold       *: uint16
    rename_limit                  *: csize_t
    metric                        *: ptr git_diff_similarity_metric

  git_diff_parse_options* {.importc, bycopy.} = object
    version  *: cuint
    oid_type *: git_oid_t

  git_diff_stats* {.importc, bycopy.} = object


  git_diff_patchid_options* {.importc, bycopy.} = object
    version *: cuint

  c_git_diff_option_t {.size: sizeof(cint).} = enum
    c_GIT_DIFF_NORMAL                          = 0 shl 0
    c_GIT_DIFF_REVERSE                         = 1 shl 0
    c_GIT_DIFF_INCLUDE_IGNORED                 = 1 shl 1
    c_GIT_DIFF_RECURSE_IGNORED_DIRS            = 1 shl 2
    c_GIT_DIFF_INCLUDE_UNTRACKED               = 1 shl 3
    c_GIT_DIFF_RECURSE_UNTRACKED_DIRS          = 1 shl 4
    c_GIT_DIFF_INCLUDE_UNMODIFIED              = 1 shl 5
    c_GIT_DIFF_INCLUDE_TYPECHANGE              = 1 shl 6
    c_GIT_DIFF_INCLUDE_TYPECHANGE_TREES        = 1 shl 7
    c_GIT_DIFF_IGNORE_FILEMODE                 = 1 shl 8
    c_GIT_DIFF_IGNORE_SUBMODULES               = 1 shl 9
    c_GIT_DIFF_IGNORE_CASE                     = 1 shl 10
    c_GIT_DIFF_INCLUDE_CASECHANGE              = 1 shl 11
    c_GIT_DIFF_DISABLE_PATHSPEC_MATCH          = 1 shl 12
    c_GIT_DIFF_SKIP_BINARY_CHECK               = 1 shl 13
    c_GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS      = 1 shl 14
    c_GIT_DIFF_UPDATE_INDEX                    = 1 shl 15
    c_GIT_DIFF_INCLUDE_UNREADABLE              = 1 shl 16
    c_GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = 1 shl 17
    c_GIT_DIFF_INDENT_HEURISTIC                = 1 shl 18
    c_GIT_DIFF_IGNORE_BLANK_LINES              = 1 shl 19
    c_GIT_DIFF_FORCE_TEXT                      = 1 shl 20
    c_GIT_DIFF_FORCE_BINARY                    = 1 shl 21
    c_GIT_DIFF_IGNORE_WHITESPACE               = 1 shl 22
    c_GIT_DIFF_IGNORE_WHITESPACE_CHANGE        = 1 shl 23
    c_GIT_DIFF_IGNORE_WHITESPACE_EOL           = 1 shl 24
    c_GIT_DIFF_SHOW_UNTRACKED_CONTENT          = 1 shl 25
    c_GIT_DIFF_SHOW_UNMODIFIED                 = 1 shl 26
    c_GIT_DIFF_PATIENCE                        = 1 shl 28
    c_GIT_DIFF_MINIMAL                         = 1 shl 29
    c_GIT_DIFF_SHOW_BINARY                     = 1 shl 30

  git_diff_option_t = enum
    GIT_DIFF_NORMAL
    GIT_DIFF_REVERSE
    GIT_DIFF_INCLUDE_IGNORED
    GIT_DIFF_RECURSE_IGNORED_DIRS
    GIT_DIFF_INCLUDE_UNTRACKED
    GIT_DIFF_RECURSE_UNTRACKED_DIRS
    GIT_DIFF_INCLUDE_UNMODIFIED
    GIT_DIFF_INCLUDE_TYPECHANGE
    GIT_DIFF_INCLUDE_TYPECHANGE_TREES
    GIT_DIFF_IGNORE_FILEMODE
    GIT_DIFF_IGNORE_SUBMODULES
    GIT_DIFF_IGNORE_CASE
    GIT_DIFF_INCLUDE_CASECHANGE
    GIT_DIFF_DISABLE_PATHSPEC_MATCH
    GIT_DIFF_SKIP_BINARY_CHECK
    GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS
    GIT_DIFF_UPDATE_INDEX
    GIT_DIFF_INCLUDE_UNREADABLE
    GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED
    GIT_DIFF_INDENT_HEURISTIC
    GIT_DIFF_IGNORE_BLANK_LINES
    GIT_DIFF_FORCE_TEXT
    GIT_DIFF_FORCE_BINARY
    GIT_DIFF_IGNORE_WHITESPACE
    GIT_DIFF_IGNORE_WHITESPACE_CHANGE
    GIT_DIFF_IGNORE_WHITESPACE_EOL
    GIT_DIFF_SHOW_UNTRACKED_CONTENT
    GIT_DIFF_SHOW_UNMODIFIED
    GIT_DIFF_PATIENCE
    GIT_DIFF_MINIMAL
    GIT_DIFF_SHOW_BINARY

  c_git_diff_flag_t {.size: sizeof(cint).} = enum
    c_GIT_DIFF_FLAG_BINARY     = 1 shl 0
    c_GIT_DIFF_FLAG_NOT_BINARY = 1 shl 1
    c_GIT_DIFF_FLAG_VALID_ID   = 1 shl 2
    c_GIT_DIFF_FLAG_EXISTS     = 1 shl 3
    c_GIT_DIFF_FLAG_VALID_SIZE = 1 shl 4

  git_diff_flag_t = enum
    GIT_DIFF_FLAG_BINARY
    GIT_DIFF_FLAG_NOT_BINARY
    GIT_DIFF_FLAG_VALID_ID
    GIT_DIFF_FLAG_EXISTS
    GIT_DIFF_FLAG_VALID_SIZE

  c_git_diff_line_t {.size: sizeof(cint).} = enum
    c_GIT_DIFF_LINE_CONTEXT       = 1 shl 5
    c_GIT_DIFF_LINE_ADDITION      = 43
    c_GIT_DIFF_LINE_DELETION      = 45
    c_GIT_DIFF_LINE_CONTEXT_EOFNL = 61
    c_GIT_DIFF_LINE_ADD_EOFNL     = 62
    c_GIT_DIFF_LINE_DEL_EOFNL     = 60
    c_GIT_DIFF_LINE_FILE_HDR      = 70
    c_GIT_DIFF_LINE_HUNK_HDR      = 72
    c_GIT_DIFF_LINE_BINARY        = 66

  git_diff_line_t = enum
    GIT_DIFF_LINE_CONTEXT
    GIT_DIFF_LINE_ADDITION
    GIT_DIFF_LINE_DELETION
    GIT_DIFF_LINE_CONTEXT_EOFNL
    GIT_DIFF_LINE_ADD_EOFNL
    GIT_DIFF_LINE_DEL_EOFNL
    GIT_DIFF_LINE_FILE_HDR
    GIT_DIFF_LINE_HUNK_HDR
    GIT_DIFF_LINE_BINARY

  c_git_diff_find_t {.size: sizeof(cint).} = enum
    c_GIT_DIFF_FIND_BY_CONFIG                  = 0 shl 0
    c_GIT_DIFF_FIND_RENAMES                    = 1 shl 0
    c_GIT_DIFF_FIND_RENAMES_FROM_REWRITES      = 1 shl 1
    c_GIT_DIFF_FIND_COPIES                     = 1 shl 2
    c_GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED     = 1 shl 3
    c_GIT_DIFF_FIND_REWRITES                   = 1 shl 4
    c_GIT_DIFF_BREAK_REWRITES                  = 1 shl 5
    c_GIT_DIFF_FIND_AND_BREAK_REWRITES         = 48
    c_GIT_DIFF_FIND_FOR_UNTRACKED              = 1 shl 6
    c_GIT_DIFF_FIND_ALL                        = 255
    c_GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE  = 0 shl 0
    c_GIT_DIFF_FIND_IGNORE_WHITESPACE          = 1 shl 12
    c_GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE     = 1 shl 13
    c_GIT_DIFF_FIND_EXACT_MATCH_ONLY           = 1 shl 14
    c_GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY = 1 shl 15
    c_GIT_DIFF_FIND_REMOVE_UNMODIFIED          = 1 shl 16

  git_diff_find_t = enum
    GIT_DIFF_FIND_BY_CONFIG
    GIT_DIFF_FIND_RENAMES
    GIT_DIFF_FIND_RENAMES_FROM_REWRITES
    GIT_DIFF_FIND_COPIES
    GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED
    GIT_DIFF_FIND_REWRITES
    GIT_DIFF_BREAK_REWRITES
    GIT_DIFF_FIND_AND_BREAK_REWRITES
    GIT_DIFF_FIND_FOR_UNTRACKED
    GIT_DIFF_FIND_ALL
    GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE
    GIT_DIFF_FIND_IGNORE_WHITESPACE
    GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE
    GIT_DIFF_FIND_EXACT_MATCH_ONLY
    GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY
    GIT_DIFF_FIND_REMOVE_UNMODIFIED

  c_git_diff_format_t {.size: sizeof(cint).} = enum
    c_GIT_DIFF_FORMAT_PATCH        = 1 shl 0
    c_GIT_DIFF_FORMAT_PATCH_HEADER = 1 shl 1
    c_GIT_DIFF_FORMAT_RAW          = 3
    c_GIT_DIFF_FORMAT_NAME_ONLY    = 1 shl 2
    c_GIT_DIFF_FORMAT_NAME_STATUS  = 5
    c_GIT_DIFF_FORMAT_PATCH_ID     = 6

  git_diff_format_t = enum
    GIT_DIFF_FORMAT_PATCH
    GIT_DIFF_FORMAT_PATCH_HEADER
    GIT_DIFF_FORMAT_RAW
    GIT_DIFF_FORMAT_NAME_ONLY
    GIT_DIFF_FORMAT_NAME_STATUS
    GIT_DIFF_FORMAT_PATCH_ID

  c_git_diff_stats_format_t {.size: sizeof(cint).} = enum
    c_GIT_DIFF_STATS_NONE            = 0 shl 0
    c_GIT_DIFF_STATS_FULL            = 1 shl 0
    c_GIT_DIFF_STATS_SHORT           = 1 shl 1
    c_GIT_DIFF_STATS_NUMBER          = 1 shl 2
    c_GIT_DIFF_STATS_INCLUDE_SUMMARY = 1 shl 3

  git_diff_stats_format_t = enum
    GIT_DIFF_STATS_NONE
    GIT_DIFF_STATS_FULL
    GIT_DIFF_STATS_SHORT
    GIT_DIFF_STATS_NUMBER
    GIT_DIFF_STATS_INCLUDE_SUMMARY

  git_diff_file_cb = proc (a0: ptr git_diff_delta, a1: cfloat, a2: ptr void): cint

  git_diff_binary_cb = proc (a0: ptr git_diff_delta, a1: ptr git_diff_binary, a2: ptr void): cint

  git_diff_hunk_cb = proc (a0: ptr git_diff_delta, a1: ptr git_diff_hunk, a2: ptr void): cint

  git_diff_line_cb = proc (a0: ptr git_diff_delta, a1: ptr git_diff_hunk, a2: ptr git_diff_line, a3: ptr void): cint



converter toCInt*(arg: c_git_delta_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_delta_t)): cint =
  for value in items(args):
    case value:
      of GIT_DELTA_UNMODIFIED: result = cint(result or 0)
      of GIT_DELTA_ADDED     : result = cint(result or 1)
      of GIT_DELTA_DELETED   : result = cint(result or 2)
      of GIT_DELTA_MODIFIED  : result = cint(result or 3)
      of GIT_DELTA_RENAMED   : result = cint(result or 4)
      of GIT_DELTA_COPIED    : result = cint(result or 5)
      of GIT_DELTA_IGNORED   : result = cint(result or 6)
      of GIT_DELTA_UNTRACKED : result = cint(result or 7)
      of GIT_DELTA_TYPECHANGE: result = cint(result or 8)
      of GIT_DELTA_UNREADABLE: result = cint(result or 9)
      of GIT_DELTA_CONFLICTED: result = cint(result or 10)

func `-`*(arg: c_git_delta_t, offset: int): cint = cast[c_git_delta_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_delta_t): cint = cast[c_git_delta_t](ord(arg) - offset)

func `+`*(arg: c_git_delta_t, offset: int): cint = cast[c_git_delta_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_delta_t): cint = cast[c_git_delta_t](ord(arg) + offset)

converter toCInt*(arg: c_git_diff_binary_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_diff_binary_t)): cint =
  for value in items(args):
    case value:
      of GIT_DIFF_BINARY_NONE   : result = cint(result or 0)
      of GIT_DIFF_BINARY_LITERAL: result = cint(result or 1)
      of GIT_DIFF_BINARY_DELTA  : result = cint(result or 2)

func `-`*(arg: c_git_diff_binary_t, offset: int): cint = cast[c_git_diff_binary_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_binary_t): cint = cast[c_git_diff_binary_t](ord(arg) - offset)

func `+`*(arg: c_git_diff_binary_t, offset: int): cint = cast[c_git_diff_binary_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_binary_t): cint = cast[c_git_diff_binary_t](ord(arg) + offset)

converter toCInt*(arg: c_git_diff_option_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_diff_option_t)): cint =
  for value in items(args):
    case value:
      of GIT_DIFF_NORMAL                         : result = cint(result or 0)
      of GIT_DIFF_REVERSE                        : result = cint(result or 1)
      of GIT_DIFF_INCLUDE_IGNORED                : result = cint(result or 2)
      of GIT_DIFF_RECURSE_IGNORED_DIRS           : result = cint(result or 4)
      of GIT_DIFF_INCLUDE_UNTRACKED              : result = cint(result or 8)
      of GIT_DIFF_RECURSE_UNTRACKED_DIRS         : result = cint(result or 16)
      of GIT_DIFF_INCLUDE_UNMODIFIED             : result = cint(result or 32)
      of GIT_DIFF_INCLUDE_TYPECHANGE             : result = cint(result or 64)
      of GIT_DIFF_INCLUDE_TYPECHANGE_TREES       : result = cint(result or 128)
      of GIT_DIFF_IGNORE_FILEMODE                : result = cint(result or 256)
      of GIT_DIFF_IGNORE_SUBMODULES              : result = cint(result or 512)
      of GIT_DIFF_IGNORE_CASE                    : result = cint(result or 1024)
      of GIT_DIFF_INCLUDE_CASECHANGE             : result = cint(result or 2048)
      of GIT_DIFF_DISABLE_PATHSPEC_MATCH         : result = cint(result or 4096)
      of GIT_DIFF_SKIP_BINARY_CHECK              : result = cint(result or 8192)
      of GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS     : result = cint(result or 16384)
      of GIT_DIFF_UPDATE_INDEX                   : result = cint(result or 32768)
      of GIT_DIFF_INCLUDE_UNREADABLE             : result = cint(result or 65536)
      of GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED: result = cint(result or 131072)
      of GIT_DIFF_INDENT_HEURISTIC               : result = cint(result or 262144)
      of GIT_DIFF_IGNORE_BLANK_LINES             : result = cint(result or 524288)
      of GIT_DIFF_FORCE_TEXT                     : result = cint(result or 1048576)
      of GIT_DIFF_FORCE_BINARY                   : result = cint(result or 2097152)
      of GIT_DIFF_IGNORE_WHITESPACE              : result = cint(result or 4194304)
      of GIT_DIFF_IGNORE_WHITESPACE_CHANGE       : result = cint(result or 8388608)
      of GIT_DIFF_IGNORE_WHITESPACE_EOL          : result = cint(result or 16777216)
      of GIT_DIFF_SHOW_UNTRACKED_CONTENT         : result = cint(result or 33554432)
      of GIT_DIFF_SHOW_UNMODIFIED                : result = cint(result or 67108864)
      of GIT_DIFF_PATIENCE                       : result = cint(result or 268435456)
      of GIT_DIFF_MINIMAL                        : result = cint(result or 536870912)
      of GIT_DIFF_SHOW_BINARY                    : result = cint(result or 1073741824)

func `-`*(arg: c_git_diff_option_t, offset: int): cint = cast[c_git_diff_option_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_option_t): cint = cast[c_git_diff_option_t](ord(arg) - offset)

func `+`*(arg: c_git_diff_option_t, offset: int): cint = cast[c_git_diff_option_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_option_t): cint = cast[c_git_diff_option_t](ord(arg) + offset)

converter toCInt*(arg: c_git_diff_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_diff_flag_t)): cint =
  for value in items(args):
    case value:
      of GIT_DIFF_FLAG_BINARY    : result = cint(result or 1)
      of GIT_DIFF_FLAG_NOT_BINARY: result = cint(result or 2)
      of GIT_DIFF_FLAG_VALID_ID  : result = cint(result or 4)
      of GIT_DIFF_FLAG_EXISTS    : result = cint(result or 8)
      of GIT_DIFF_FLAG_VALID_SIZE: result = cint(result or 16)

func `-`*(arg: c_git_diff_flag_t, offset: int): cint = cast[c_git_diff_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_flag_t): cint = cast[c_git_diff_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_diff_flag_t, offset: int): cint = cast[c_git_diff_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_flag_t): cint = cast[c_git_diff_flag_t](ord(arg) + offset)

converter toCInt*(arg: c_git_diff_line_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_diff_line_t)): cint =
  for value in items(args):
    case value:
      of GIT_DIFF_LINE_CONTEXT      : result = cint(result or 32)
      of GIT_DIFF_LINE_ADDITION     : result = cint(result or 43)
      of GIT_DIFF_LINE_DELETION     : result = cint(result or 45)
      of GIT_DIFF_LINE_CONTEXT_EOFNL: result = cint(result or 61)
      of GIT_DIFF_LINE_ADD_EOFNL    : result = cint(result or 62)
      of GIT_DIFF_LINE_DEL_EOFNL    : result = cint(result or 60)
      of GIT_DIFF_LINE_FILE_HDR     : result = cint(result or 70)
      of GIT_DIFF_LINE_HUNK_HDR     : result = cint(result or 72)
      of GIT_DIFF_LINE_BINARY       : result = cint(result or 66)

func `-`*(arg: c_git_diff_line_t, offset: int): cint = cast[c_git_diff_line_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_line_t): cint = cast[c_git_diff_line_t](ord(arg) - offset)

func `+`*(arg: c_git_diff_line_t, offset: int): cint = cast[c_git_diff_line_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_line_t): cint = cast[c_git_diff_line_t](ord(arg) + offset)

converter toCInt*(arg: c_git_diff_find_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_diff_find_t)): cint =
  for value in items(args):
    case value:
      of GIT_DIFF_FIND_BY_CONFIG                 : result = cint(result or 0)
      of GIT_DIFF_FIND_RENAMES                   : result = cint(result or 1)
      of GIT_DIFF_FIND_RENAMES_FROM_REWRITES     : result = cint(result or 2)
      of GIT_DIFF_FIND_COPIES                    : result = cint(result or 4)
      of GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED    : result = cint(result or 8)
      of GIT_DIFF_FIND_REWRITES                  : result = cint(result or 16)
      of GIT_DIFF_BREAK_REWRITES                 : result = cint(result or 32)
      of GIT_DIFF_FIND_AND_BREAK_REWRITES        : result = cint(result or 48)
      of GIT_DIFF_FIND_FOR_UNTRACKED             : result = cint(result or 64)
      of GIT_DIFF_FIND_ALL                       : result = cint(result or 255)
      of GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE : result = cint(result or 0)
      of GIT_DIFF_FIND_IGNORE_WHITESPACE         : result = cint(result or 4096)
      of GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE    : result = cint(result or 8192)
      of GIT_DIFF_FIND_EXACT_MATCH_ONLY          : result = cint(result or 16384)
      of GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY: result = cint(result or 32768)
      of GIT_DIFF_FIND_REMOVE_UNMODIFIED         : result = cint(result or 65536)

func `-`*(arg: c_git_diff_find_t, offset: int): cint = cast[c_git_diff_find_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_find_t): cint = cast[c_git_diff_find_t](ord(arg) - offset)

func `+`*(arg: c_git_diff_find_t, offset: int): cint = cast[c_git_diff_find_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_find_t): cint = cast[c_git_diff_find_t](ord(arg) + offset)

converter toCInt*(arg: c_git_diff_format_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_diff_format_t)): cint =
  for value in items(args):
    case value:
      of GIT_DIFF_FORMAT_PATCH       : result = cint(result or 1)
      of GIT_DIFF_FORMAT_PATCH_HEADER: result = cint(result or 2)
      of GIT_DIFF_FORMAT_RAW         : result = cint(result or 3)
      of GIT_DIFF_FORMAT_NAME_ONLY   : result = cint(result or 4)
      of GIT_DIFF_FORMAT_NAME_STATUS : result = cint(result or 5)
      of GIT_DIFF_FORMAT_PATCH_ID    : result = cint(result or 6)

func `-`*(arg: c_git_diff_format_t, offset: int): cint = cast[c_git_diff_format_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_format_t): cint = cast[c_git_diff_format_t](ord(arg) - offset)

func `+`*(arg: c_git_diff_format_t, offset: int): cint = cast[c_git_diff_format_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_format_t): cint = cast[c_git_diff_format_t](ord(arg) + offset)

converter toCInt*(arg: c_git_diff_stats_format_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_diff_stats_format_t)): cint =
  for value in items(args):
    case value:
      of GIT_DIFF_STATS_NONE           : result = cint(result or 0)
      of GIT_DIFF_STATS_FULL           : result = cint(result or 1)
      of GIT_DIFF_STATS_SHORT          : result = cint(result or 2)
      of GIT_DIFF_STATS_NUMBER         : result = cint(result or 4)
      of GIT_DIFF_STATS_INCLUDE_SUMMARY: result = cint(result or 8)

func `-`*(arg: c_git_diff_stats_format_t, offset: int): cint = cast[c_git_diff_stats_format_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_stats_format_t): cint = cast[c_git_diff_stats_format_t](ord(arg) - offset)

func `+`*(arg: c_git_diff_stats_format_t, offset: int): cint = cast[c_git_diff_stats_format_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_stats_format_t): cint = cast[c_git_diff_stats_format_t](ord(arg) + offset)

proc git_diff_options_init*(opts: ptr git_diff_options, version: cuint): cint {.git2Proc, importc.}

proc git_diff_find_options_init*(opts: ptr git_diff_find_options, version: cuint): cint {.git2Proc, importc.}

proc git_diff_free*(diff: ptr git_diff): void {.git2Proc, importc.}

proc git_diff_tree_to_tree*(diff: ptr git_diff, repo: ptr git_repository, old_tree: ptr git_tree, new_tree: ptr git_tree, opts: ptr git_diff_options): cint {.git2Proc, importc.}

proc git_diff_tree_to_index*(diff: ptr git_diff, repo: ptr git_repository, old_tree: ptr git_tree, index: ptr git_index, opts: ptr git_diff_options): cint {.git2Proc, importc.}

proc git_diff_index_to_workdir*(diff: ptr git_diff, repo: ptr git_repository, index: ptr git_index, opts: ptr git_diff_options): cint {.git2Proc, importc.}

proc git_diff_tree_to_workdir*(diff: ptr git_diff, repo: ptr git_repository, old_tree: ptr git_tree, opts: ptr git_diff_options): cint {.git2Proc, importc.}

proc git_diff_tree_to_workdir_with_index*(diff: ptr git_diff, repo: ptr git_repository, old_tree: ptr git_tree, opts: ptr git_diff_options): cint {.git2Proc, importc.}

proc git_diff_index_to_index*(diff: ptr git_diff, repo: ptr git_repository, old_index: ptr git_index, new_index: ptr git_index, opts: ptr git_diff_options): cint {.git2Proc, importc.}

proc git_diff_merge*(onto: ptr git_diff, from: ptr git_diff): cint {.git2Proc, importc.}

proc git_diff_find_similar*(diff: ptr git_diff, options: ptr git_diff_find_options): cint {.git2Proc, importc.}

proc git_diff_num_deltas*(diff: ptr git_diff): csize_t {.git2Proc, importc.}

proc git_diff_num_deltas_of_type*(diff: ptr git_diff, type: git_delta_t): csize_t {.git2Proc, importc.}

proc git_diff_get_delta*(diff: ptr git_diff, idx: csize_t): ptr git_diff_delta {.git2Proc, importc.}

proc git_diff_is_sorted_icase*(diff: ptr git_diff): cint {.git2Proc, importc.}

proc git_diff_foreach*(diff: ptr git_diff, file_cb: git_diff_file_cb, binary_cb: git_diff_binary_cb, hunk_cb: git_diff_hunk_cb, line_cb: git_diff_line_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_diff_status_char*(status: git_delta_t): char {.git2Proc, importc.}

proc git_diff_print*(diff: ptr git_diff, format: git_diff_format_t, print_cb: git_diff_line_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_diff_to_buf*(out: ptr git_buf, diff: ptr git_diff, format: git_diff_format_t): cint {.git2Proc, importc.}

proc git_diff_blobs*(old_blob: ptr git_blob, old_as_path: cstring, new_blob: ptr git_blob, new_as_path: cstring, options: ptr git_diff_options, file_cb: git_diff_file_cb, binary_cb: git_diff_binary_cb, hunk_cb: git_diff_hunk_cb, line_cb: git_diff_line_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_diff_blob_to_buffer*(old_blob: ptr git_blob, old_as_path: cstring, buffer: cstring, buffer_len: csize_t, buffer_as_path: cstring, options: ptr git_diff_options, file_cb: git_diff_file_cb, binary_cb: git_diff_binary_cb, hunk_cb: git_diff_hunk_cb, line_cb: git_diff_line_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_diff_buffers*(old_buffer: ptr const void, old_len: csize_t, old_as_path: cstring, new_buffer: ptr const void, new_len: csize_t, new_as_path: cstring, options: ptr git_diff_options, file_cb: git_diff_file_cb, binary_cb: git_diff_binary_cb, hunk_cb: git_diff_hunk_cb, line_cb: git_diff_line_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_diff_from_buffer*(out: ptr git_diff, content: cstring, content_len: csize_t): cint {.git2Proc, importc.}

proc git_diff_get_stats*(out: ptr git_diff_stats, diff: ptr git_diff): cint {.git2Proc, importc.}

proc git_diff_stats_files_changed*(stats: ptr git_diff_stats): csize_t {.git2Proc, importc.}

proc git_diff_stats_insertions*(stats: ptr git_diff_stats): csize_t {.git2Proc, importc.}

proc git_diff_stats_deletions*(stats: ptr git_diff_stats): csize_t {.git2Proc, importc.}

proc git_diff_stats_to_buf*(out: ptr git_buf, stats: ptr git_diff_stats, format: git_diff_stats_format_t, width: csize_t): cint {.git2Proc, importc.}

proc git_diff_stats_free*(stats: ptr git_diff_stats): void {.git2Proc, importc.}

proc git_diff_patchid_options_init*(opts: ptr git_diff_patchid_options, version: cuint): cint {.git2Proc, importc.}

proc git_diff_patchid*(out: ptr git_oid, diff: ptr git_diff, opts: ptr git_diff_patchid_options): cint {.git2Proc, importc.}