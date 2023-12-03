import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./index.nim"
import "./types.nim"
import "./oidarray.nim"
import "./diff.nim"
import "./checkout.nim"

type
  c_git_merge_file_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_FILE_DEFAULT                  = 0
    c_GIT_MERGE_FILE_STYLE_MERGE              = 1
    c_GIT_MERGE_FILE_STYLE_DIFF3              = 2
    c_GIT_MERGE_FILE_SIMPLIFY_ALNUM           = 1 shl 2
    c_GIT_MERGE_FILE_IGNORE_WHITESPACE        = 1 shl 3
    c_GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = 1 shl 4
    c_GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL    = 1 shl 5
    c_GIT_MERGE_FILE_DIFF_PATIENCE            = 1 shl 6
    c_GIT_MERGE_FILE_DIFF_MINIMAL             = 1 shl 7
    c_GIT_MERGE_FILE_STYLE_ZDIFF3             = 1 shl 8
    c_GIT_MERGE_FILE_ACCEPT_CONFLICTS         = 1 shl 9

  git_merge_file_flag_t* = enum
    GIT_MERGE_FILE_DEFAULT
    GIT_MERGE_FILE_STYLE_MERGE
    GIT_MERGE_FILE_STYLE_DIFF3
    GIT_MERGE_FILE_SIMPLIFY_ALNUM
    GIT_MERGE_FILE_IGNORE_WHITESPACE
    GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE
    GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL
    GIT_MERGE_FILE_DIFF_PATIENCE
    GIT_MERGE_FILE_DIFF_MINIMAL
    GIT_MERGE_FILE_STYLE_ZDIFF3
    GIT_MERGE_FILE_ACCEPT_CONFLICTS

  c_git_merge_analysis_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_ANALYSIS_NONE        = 0
    c_GIT_MERGE_ANALYSIS_NORMAL      = 1
    c_GIT_MERGE_ANALYSIS_UP_TO_DATE  = 2
    c_GIT_MERGE_ANALYSIS_FASTFORWARD = 1 shl 2
    c_GIT_MERGE_ANALYSIS_UNBORN      = 1 shl 3

  git_merge_analysis_t* = enum
    GIT_MERGE_ANALYSIS_NONE
    GIT_MERGE_ANALYSIS_NORMAL
    GIT_MERGE_ANALYSIS_UP_TO_DATE
    GIT_MERGE_ANALYSIS_FASTFORWARD
    GIT_MERGE_ANALYSIS_UNBORN

  c_git_merge_preference_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_PREFERENCE_NONE             = 0
    c_GIT_MERGE_PREFERENCE_NO_FASTFORWARD   = 1
    c_GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = 2

  git_merge_preference_t* = enum
    GIT_MERGE_PREFERENCE_NONE
    GIT_MERGE_PREFERENCE_NO_FASTFORWARD
    GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY

  git_merge_file_input* {.importc, bycopy.} = object
    version *: cuint
    `ptr`   *: cstring
    size    *: csize_t
    path    *: cstring
    mode    *: cuint

  git_merge_file_options* {.importc, bycopy.} = object
    version        *: cuint
    ancestor_label *: cstring
    our_label      *: cstring
    their_label    *: cstring
    favor          *: git_merge_file_favor_t
    flags          *: uint32
    marker_size    *: cushort

  git_merge_file_result* {.importc, bycopy.} = object
    automergeable *: cuint
    path          *: cstring
    mode          *: cuint
    `ptr`         *: cstring
    len           *: csize_t

  git_merge_options* {.importc, bycopy.} = object
    version          *: cuint
    flags            *: uint32
    rename_threshold *: cuint
    target_limit     *: cuint
    metric           *: ptr git_diff_similarity_metric
    recursion_limit  *: cuint
    default_driver   *: cstring
    file_favor       *: git_merge_file_favor_t
    file_flags       *: uint32

  c_git_merge_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_FIND_RENAMES     = 1 shl 0
    c_GIT_MERGE_FAIL_ON_CONFLICT = 1 shl 1
    c_GIT_MERGE_SKIP_REUC        = 1 shl 2
    c_GIT_MERGE_NO_RECURSIVE     = 1 shl 3
    c_GIT_MERGE_VIRTUAL_BASE     = 1 shl 4

  git_merge_flag_t* = enum
    GIT_MERGE_FIND_RENAMES
    GIT_MERGE_FAIL_ON_CONFLICT
    GIT_MERGE_SKIP_REUC
    GIT_MERGE_NO_RECURSIVE
    GIT_MERGE_VIRTUAL_BASE

  c_git_merge_file_favor_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_FILE_FAVOR_NORMAL = 0
    c_GIT_MERGE_FILE_FAVOR_OURS   = 1
    c_GIT_MERGE_FILE_FAVOR_THEIRS = 2
    c_GIT_MERGE_FILE_FAVOR_UNION  = 3

  git_merge_file_favor_t* = enum
    GIT_MERGE_FILE_FAVOR_NORMAL
    GIT_MERGE_FILE_FAVOR_OURS
    GIT_MERGE_FILE_FAVOR_THEIRS
    GIT_MERGE_FILE_FAVOR_UNION



converter toCInt*(arg: c_git_merge_file_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_merge_file_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_MERGE_FILE_DEFAULT                 : result = cint(result or 0)
      of GIT_MERGE_FILE_STYLE_MERGE             : result = cint(result or 1)
      of GIT_MERGE_FILE_STYLE_DIFF3             : result = cint(result or 2)
      of GIT_MERGE_FILE_SIMPLIFY_ALNUM          : result = cint(result or 4)
      of GIT_MERGE_FILE_IGNORE_WHITESPACE       : result = cint(result or 8)
      of GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE: result = cint(result or 16)
      of GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL   : result = cint(result or 32)
      of GIT_MERGE_FILE_DIFF_PATIENCE           : result = cint(result or 64)
      of GIT_MERGE_FILE_DIFF_MINIMAL            : result = cint(result or 128)
      of GIT_MERGE_FILE_STYLE_ZDIFF3            : result = cint(result or 256)
      of GIT_MERGE_FILE_ACCEPT_CONFLICTS        : result = cint(result or 512)

func `-`*(arg: c_git_merge_file_flag_t, offset: int): cint = cast[c_git_merge_file_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_merge_file_flag_t): cint = cast[c_git_merge_file_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_merge_file_flag_t, offset: int): cint = cast[c_git_merge_file_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_merge_file_flag_t): cint = cast[c_git_merge_file_flag_t](ord(arg) + offset)

converter toCInt*(arg: c_git_merge_analysis_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_merge_analysis_t]): cint =
  for value in items(args):
    case value:
      of GIT_MERGE_ANALYSIS_NONE       : result = cint(result or 0)
      of GIT_MERGE_ANALYSIS_NORMAL     : result = cint(result or 1)
      of GIT_MERGE_ANALYSIS_UP_TO_DATE : result = cint(result or 2)
      of GIT_MERGE_ANALYSIS_FASTFORWARD: result = cint(result or 4)
      of GIT_MERGE_ANALYSIS_UNBORN     : result = cint(result or 8)

func `-`*(arg: c_git_merge_analysis_t, offset: int): cint = cast[c_git_merge_analysis_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_merge_analysis_t): cint = cast[c_git_merge_analysis_t](ord(arg) - offset)

func `+`*(arg: c_git_merge_analysis_t, offset: int): cint = cast[c_git_merge_analysis_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_merge_analysis_t): cint = cast[c_git_merge_analysis_t](ord(arg) + offset)

converter toCInt*(arg: c_git_merge_preference_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_merge_preference_t]): cint =
  for value in items(args):
    case value:
      of GIT_MERGE_PREFERENCE_NONE            : result = cint(result or 0)
      of GIT_MERGE_PREFERENCE_NO_FASTFORWARD  : result = cint(result or 1)
      of GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY: result = cint(result or 2)

func `-`*(arg: c_git_merge_preference_t, offset: int): cint = cast[c_git_merge_preference_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_merge_preference_t): cint = cast[c_git_merge_preference_t](ord(arg) - offset)

func `+`*(arg: c_git_merge_preference_t, offset: int): cint = cast[c_git_merge_preference_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_merge_preference_t): cint = cast[c_git_merge_preference_t](ord(arg) + offset)

proc git_merge_file_input_init*(opts: ptr git_merge_file_input, version: cuint): cint {.git2Proc, importc: "git_merge_file_input_init".}

proc git_merge_file_options_init*(opts: ptr git_merge_file_options, version: cuint): cint {.git2Proc, importc: "git_merge_file_options_init".}

proc git_merge_options_init*(opts: ptr git_merge_options, version: cuint): cint {.git2Proc, importc: "git_merge_options_init".}

proc git_merge_analysis*(
    analysis_out: ptr git_merge_analysis_t,
    preference_out: ptr git_merge_preference_t,
    repo: ptr git_repository,
    their_heads: ptr ptr git_annotated_commit,
    their_heads_len: csize_t,
): cint {.git2Proc, importc: "git_merge_analysis".}

proc git_merge_analysis_for_ref*(
    analysis_out: ptr git_merge_analysis_t,
    preference_out: ptr git_merge_preference_t,
    repo: ptr git_repository,
    our_ref: ptr git_reference,
    their_heads: ptr ptr git_annotated_commit,
    their_heads_len: csize_t,
): cint {.git2Proc, importc: "git_merge_analysis_for_ref".}

proc git_merge_base*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    one: ptr git_oid,
    two: ptr git_oid,
): cint {.git2Proc, importc: "git_merge_base".}

proc git_merge_bases*(
    `out`: ptr git_oidarray,
    repo: ptr git_repository,
    one: ptr git_oid,
    two: ptr git_oid,
): cint {.git2Proc, importc: "git_merge_bases".}

proc git_merge_base_many*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    length: csize_t,
    input_array: ptr git_oid,
): cint {.git2Proc, importc: "git_merge_base_many".}

proc git_merge_bases_many*(
    `out`: ptr git_oidarray,
    repo: ptr git_repository,
    length: csize_t,
    input_array: ptr git_oid,
): cint {.git2Proc, importc: "git_merge_bases_many".}

proc git_merge_base_octopus*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    length: csize_t,
    input_array: ptr git_oid,
): cint {.git2Proc, importc: "git_merge_base_octopus".}

proc git_merge_file*(
    `out`: ptr git_merge_file_result,
    ancestor: ptr git_merge_file_input,
    ours: ptr git_merge_file_input,
    theirs: ptr git_merge_file_input,
    opts: ptr git_merge_file_options,
): cint {.git2Proc, importc: "git_merge_file".}

proc git_merge_file_from_index*(
    `out`: ptr git_merge_file_result,
    repo: ptr git_repository,
    ancestor: ptr git_index_entry,
    ours: ptr git_index_entry,
    theirs: ptr git_index_entry,
    opts: ptr git_merge_file_options,
): cint {.git2Proc, importc: "git_merge_file_from_index".}

proc git_merge_file_result_free*(result: ptr git_merge_file_result): void {.git2Proc, importc: "git_merge_file_result_free".}

proc git_merge_trees*(
    `out`: ptr ptr git_index,
    repo: ptr git_repository,
    ancestor_tree: ptr git_tree,
    our_tree: ptr git_tree,
    their_tree: ptr git_tree,
    opts: ptr git_merge_options,
): cint {.git2Proc, importc: "git_merge_trees".}

proc git_merge_commits*(
    `out`: ptr ptr git_index,
    repo: ptr git_repository,
    our_commit: ptr git_commit,
    their_commit: ptr git_commit,
    opts: ptr git_merge_options,
): cint {.git2Proc, importc: "git_merge_commits".}

proc git_merge*(
    repo: ptr git_repository,
    their_heads: ptr ptr git_annotated_commit,
    their_heads_len: csize_t,
    merge_opts: ptr git_merge_options,
    checkout_opts: ptr git_checkout_options,
): cint {.git2Proc, importc: "git_merge".}

converter toCInt*(arg: c_git_merge_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_merge_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_MERGE_FIND_RENAMES    : result = cint(result or 1)
      of GIT_MERGE_FAIL_ON_CONFLICT: result = cint(result or 2)
      of GIT_MERGE_SKIP_REUC       : result = cint(result or 4)
      of GIT_MERGE_NO_RECURSIVE    : result = cint(result or 8)
      of GIT_MERGE_VIRTUAL_BASE    : result = cint(result or 16)

func `-`*(arg: c_git_merge_flag_t, offset: int): cint = cast[c_git_merge_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_merge_flag_t): cint = cast[c_git_merge_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_merge_flag_t, offset: int): cint = cast[c_git_merge_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_merge_flag_t): cint = cast[c_git_merge_flag_t](ord(arg) + offset)

converter toCInt*(arg: c_git_merge_file_favor_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_merge_file_favor_t]): cint =
  for value in items(args):
    case value:
      of GIT_MERGE_FILE_FAVOR_NORMAL: result = cint(result or 0)
      of GIT_MERGE_FILE_FAVOR_OURS  : result = cint(result or 1)
      of GIT_MERGE_FILE_FAVOR_THEIRS: result = cint(result or 2)
      of GIT_MERGE_FILE_FAVOR_UNION : result = cint(result or 3)

func `-`*(arg: c_git_merge_file_favor_t, offset: int): cint = cast[c_git_merge_file_favor_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_merge_file_favor_t): cint = cast[c_git_merge_file_favor_t](ord(arg) - offset)

func `+`*(arg: c_git_merge_file_favor_t, offset: int): cint = cast[c_git_merge_file_favor_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_merge_file_favor_t): cint = cast[c_git_merge_file_favor_t](ord(arg) + offset)