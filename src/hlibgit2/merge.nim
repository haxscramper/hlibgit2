{.push warning[UnusedImport]:off.}

import
  ./checkout,
  ./diff,
  ./index,
  ./libgit2_config,
  ./oid,
  ./oidarray,
  ./types

type
  c_git_merge_analysis_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_ANALYSIS_NONE        = 0 shl 0 ## No merge is possible.  (Unused.)
    c_GIT_MERGE_ANALYSIS_NORMAL      = 1 shl 0
    c_GIT_MERGE_ANALYSIS_UP_TO_DATE  = 1 shl 1
    c_GIT_MERGE_ANALYSIS_FASTFORWARD = 1 shl 2
    c_GIT_MERGE_ANALYSIS_UNBORN      = 1 shl 3

  c_git_merge_file_favor_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_FILE_FAVOR_NORMAL = 0
    c_GIT_MERGE_FILE_FAVOR_OURS   = 1
    c_GIT_MERGE_FILE_FAVOR_THEIRS = 2
    c_GIT_MERGE_FILE_FAVOR_UNION  = 3

  c_git_merge_file_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_FILE_DEFAULT                  = 0 shl 0 ## Defaults
    c_GIT_MERGE_FILE_STYLE_MERGE              = 1 shl 0 ## Create standard conflicted merge files
    c_GIT_MERGE_FILE_STYLE_DIFF3              = 1 shl 1 ## Create diff3-style files
    c_GIT_MERGE_FILE_SIMPLIFY_ALNUM           = 1 shl 2 ## Condense non-alphanumeric regions for simplified diff file
    c_GIT_MERGE_FILE_IGNORE_WHITESPACE        = 1 shl 3 ## Ignore all whitespace
    c_GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = 1 shl 4 ## Ignore changes in amount of whitespace
    c_GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL    = 1 shl 5 ## Ignore whitespace at end of line
    c_GIT_MERGE_FILE_DIFF_PATIENCE            = 1 shl 6 ## Use the "patience diff" algorithm
    c_GIT_MERGE_FILE_DIFF_MINIMAL             = 1 shl 7 ## Take extra time to find minimal diff

  c_git_merge_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_FIND_RENAMES     = 1 shl 0
    c_GIT_MERGE_FAIL_ON_CONFLICT = 1 shl 1
    c_GIT_MERGE_SKIP_REUC        = 1 shl 2
    c_GIT_MERGE_NO_RECURSIVE     = 1 shl 3

  c_git_merge_preference_t* {.size: sizeof(cint).} = enum
    c_GIT_MERGE_PREFERENCE_NONE             = 0 shl 0
    c_GIT_MERGE_PREFERENCE_NO_FASTFORWARD   = 1 shl 0
    c_GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = 1 shl 1

  git_merge_analysis_t* {.size: sizeof(cint).} = enum
    GIT_MERGE_ANALYSIS_NONE        ## No merge is possible.  (Unused.)
    GIT_MERGE_ANALYSIS_NORMAL
    GIT_MERGE_ANALYSIS_UP_TO_DATE
    GIT_MERGE_ANALYSIS_FASTFORWARD
    GIT_MERGE_ANALYSIS_UNBORN

  git_merge_file_favor_t* = enum
    GIT_MERGE_FILE_FAVOR_NORMAL
    GIT_MERGE_FILE_FAVOR_OURS
    GIT_MERGE_FILE_FAVOR_THEIRS
    GIT_MERGE_FILE_FAVOR_UNION

  git_merge_file_flag_t* {.size: sizeof(cint).} = enum
    GIT_MERGE_FILE_DEFAULT                  ## Defaults
    GIT_MERGE_FILE_STYLE_MERGE              ## Create standard conflicted merge files
    GIT_MERGE_FILE_STYLE_DIFF3              ## Create diff3-style files
    GIT_MERGE_FILE_SIMPLIFY_ALNUM           ## Condense non-alphanumeric regions for simplified diff file
    GIT_MERGE_FILE_IGNORE_WHITESPACE        ## Ignore all whitespace
    GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE ## Ignore changes in amount of whitespace
    GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL    ## Ignore whitespace at end of line
    GIT_MERGE_FILE_DIFF_PATIENCE            ## Use the "patience diff" algorithm
    GIT_MERGE_FILE_DIFF_MINIMAL             ## Take extra time to find minimal diff

  git_merge_file_input* {.bycopy, header: "<git2/merge.h>", importc.} = object
    version*:                  cuint
    ptr_f* {.importc: "ptr".}: cstring ## Pointer to the contents of the file.
    size*:                     csize_t ## Size of the contents pointed to in `ptr`.
    path*:                     cstring ## File name of the conflicted file, or `NULL` to not merge the path.
    mode*:                     cuint   ## File mode of the conflicted file, or `0` to not merge the mode.

  git_merge_file_options* {.bycopy, header: "<git2/merge.h>", importc.} = object
    version*:        cuint
    ancestor_label*: cstring
    our_label*:      cstring
    their_label*:    cstring
    favor*:          c_git_merge_file_favor_t ## The file to favor in region conflicts.
    flags*:          uint32                   ## see `git_merge_file_flag_t` above
    marker_size*:    uint16

  git_merge_file_result* {.bycopy, header: "<git2/merge.h>", importc.} = object
    automergeable*:            cuint
    path*:                     cstring
    mode*:                     cuint   ## The mode that the resultant merge file should use.
    ptr_f* {.importc: "ptr".}: cstring ## The contents of the merge.
    len*:                      csize_t ## The length of the merge contents.

  git_merge_flag_t* {.size: sizeof(cint).} = enum
    GIT_MERGE_FIND_RENAMES
    GIT_MERGE_FAIL_ON_CONFLICT
    GIT_MERGE_SKIP_REUC
    GIT_MERGE_NO_RECURSIVE

  git_merge_options* {.bycopy, header: "<git2/merge.h>", importc.} = object
    version*:          cuint
    flags*:            uint32                         ## See `git_merge_flag_t` above
    rename_threshold*: cuint
    target_limit*:     cuint
    metric*:           ptr git_diff_similarity_metric ## Pluggable similarity metric; pass NULL to use internal metric
    recursion_limit*:  cuint
    default_driver*:   cstring
    file_favor*:       c_git_merge_file_favor_t
    file_flags*:       uint32                         ## see `git_merge_file_flag_t` above

  git_merge_preference_t* {.size: sizeof(cint).} = enum
    GIT_MERGE_PREFERENCE_NONE
    GIT_MERGE_PREFERENCE_NO_FASTFORWARD
    GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY


proc git_merge_file_input_init*(
    opts:    ptr git_merge_file_input,
    version: cuint
  ): cint {.git2Proc, importc.}



proc to_c_git_merge_flag_t*(arg: git_merge_flag_t): c_git_merge_flag_t =
  case arg:
    of GIT_MERGE_FIND_RENAMES:     c_GIT_MERGE_FIND_RENAMES
    of GIT_MERGE_FAIL_ON_CONFLICT: c_GIT_MERGE_FAIL_ON_CONFLICT
    of GIT_MERGE_SKIP_REUC:        c_GIT_MERGE_SKIP_REUC
    of GIT_MERGE_NO_RECURSIVE:     c_GIT_MERGE_NO_RECURSIVE


converter to_git_merge_flag_t*(arg: c_git_merge_flag_t): git_merge_flag_t =
  case arg:
    of c_GIT_MERGE_FIND_RENAMES:     GIT_MERGE_FIND_RENAMES
    of c_GIT_MERGE_FAIL_ON_CONFLICT: GIT_MERGE_FAIL_ON_CONFLICT
    of c_GIT_MERGE_SKIP_REUC:        GIT_MERGE_SKIP_REUC
    of c_GIT_MERGE_NO_RECURSIVE:     GIT_MERGE_NO_RECURSIVE


converter toCint*(arg: c_git_merge_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_merge_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_merge_flag_t(arg)))

func `+`*(arg: c_git_merge_flag_t, offset: int): c_git_merge_flag_t =
  cast[c_git_merge_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_merge_flag_t): c_git_merge_flag_t =
  cast[c_git_merge_flag_t](ord(arg) + offset)

func `-`*(arg: c_git_merge_flag_t, offset: int): c_git_merge_flag_t =
  cast[c_git_merge_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_merge_flag_t): c_git_merge_flag_t =
  cast[c_git_merge_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_merge_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc to_c_git_merge_file_favor_t*(
    arg: git_merge_file_favor_t
  ): c_git_merge_file_favor_t =
  case arg:
    of GIT_MERGE_FILE_FAVOR_NORMAL: c_GIT_MERGE_FILE_FAVOR_NORMAL
    of GIT_MERGE_FILE_FAVOR_OURS:   c_GIT_MERGE_FILE_FAVOR_OURS
    of GIT_MERGE_FILE_FAVOR_THEIRS: c_GIT_MERGE_FILE_FAVOR_THEIRS
    of GIT_MERGE_FILE_FAVOR_UNION:  c_GIT_MERGE_FILE_FAVOR_UNION


converter to_git_merge_file_favor_t*(
    arg: c_git_merge_file_favor_t
  ): git_merge_file_favor_t =
  case arg:
    of c_GIT_MERGE_FILE_FAVOR_NORMAL: GIT_MERGE_FILE_FAVOR_NORMAL
    of c_GIT_MERGE_FILE_FAVOR_OURS:   GIT_MERGE_FILE_FAVOR_OURS
    of c_GIT_MERGE_FILE_FAVOR_THEIRS: GIT_MERGE_FILE_FAVOR_THEIRS
    of c_GIT_MERGE_FILE_FAVOR_UNION:  GIT_MERGE_FILE_FAVOR_UNION


converter toCint*(arg: c_git_merge_file_favor_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_merge_file_favor_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_merge_file_favor_t(arg)))

func `+`*(
    arg:    c_git_merge_file_favor_t,
    offset: int
  ): c_git_merge_file_favor_t =
  cast[c_git_merge_file_favor_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_merge_file_favor_t
  ): c_git_merge_file_favor_t =
  cast[c_git_merge_file_favor_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_merge_file_favor_t,
    offset: int
  ): c_git_merge_file_favor_t =
  cast[c_git_merge_file_favor_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_merge_file_favor_t
  ): c_git_merge_file_favor_t =
  cast[c_git_merge_file_favor_t](ord(arg) - offset)


proc to_c_git_merge_file_flag_t*(
    arg: git_merge_file_flag_t
  ): c_git_merge_file_flag_t =
  case arg:
    of GIT_MERGE_FILE_DEFAULT:                  c_GIT_MERGE_FILE_DEFAULT
    of GIT_MERGE_FILE_STYLE_MERGE:              c_GIT_MERGE_FILE_STYLE_MERGE
    of GIT_MERGE_FILE_STYLE_DIFF3:              c_GIT_MERGE_FILE_STYLE_DIFF3
    of GIT_MERGE_FILE_SIMPLIFY_ALNUM:           c_GIT_MERGE_FILE_SIMPLIFY_ALNUM
    of GIT_MERGE_FILE_IGNORE_WHITESPACE:        c_GIT_MERGE_FILE_IGNORE_WHITESPACE
    of GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE: c_GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE
    of GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL:    c_GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL
    of GIT_MERGE_FILE_DIFF_PATIENCE:            c_GIT_MERGE_FILE_DIFF_PATIENCE
    of GIT_MERGE_FILE_DIFF_MINIMAL:             c_GIT_MERGE_FILE_DIFF_MINIMAL


converter to_git_merge_file_flag_t*(
    arg: c_git_merge_file_flag_t
  ): git_merge_file_flag_t =
  case arg:
    of c_GIT_MERGE_FILE_DEFAULT:                  GIT_MERGE_FILE_DEFAULT
    of c_GIT_MERGE_FILE_STYLE_MERGE:              GIT_MERGE_FILE_STYLE_MERGE
    of c_GIT_MERGE_FILE_STYLE_DIFF3:              GIT_MERGE_FILE_STYLE_DIFF3
    of c_GIT_MERGE_FILE_SIMPLIFY_ALNUM:           GIT_MERGE_FILE_SIMPLIFY_ALNUM
    of c_GIT_MERGE_FILE_IGNORE_WHITESPACE:        GIT_MERGE_FILE_IGNORE_WHITESPACE
    of c_GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE: GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE
    of c_GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL:    GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL
    of c_GIT_MERGE_FILE_DIFF_PATIENCE:            GIT_MERGE_FILE_DIFF_PATIENCE
    of c_GIT_MERGE_FILE_DIFF_MINIMAL:             GIT_MERGE_FILE_DIFF_MINIMAL


converter toCint*(arg: c_git_merge_file_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_merge_file_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_merge_file_flag_t(arg)))

func `+`*(arg: c_git_merge_file_flag_t, offset: int): c_git_merge_file_flag_t =
  cast[c_git_merge_file_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_merge_file_flag_t): c_git_merge_file_flag_t =
  cast[c_git_merge_file_flag_t](ord(arg) + offset)

func `-`*(arg: c_git_merge_file_flag_t, offset: int): c_git_merge_file_flag_t =
  cast[c_git_merge_file_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_merge_file_flag_t): c_git_merge_file_flag_t =
  cast[c_git_merge_file_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_merge_file_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_MERGE_FILE_DEFAULT:                  result = cint(result or (0 shl 0))
      of GIT_MERGE_FILE_STYLE_MERGE:              result = cint(result or (1 shl 0))
      of GIT_MERGE_FILE_STYLE_DIFF3:              result = cint(result or (1 shl 1))
      of GIT_MERGE_FILE_SIMPLIFY_ALNUM:           result = cint(result or (1 shl 2))
      of GIT_MERGE_FILE_IGNORE_WHITESPACE:        result = cint(result or (1 shl 3))
      of GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE: result = cint(result or (1 shl 4))
      of GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL:    result = cint(result or (1 shl 5))
      of GIT_MERGE_FILE_DIFF_PATIENCE:            result = cint(result or (1 shl 6))
      of GIT_MERGE_FILE_DIFF_MINIMAL:             result = cint(result or (1 shl 7))


proc git_merge_file_options_init*(
    opts:    ptr git_merge_file_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_merge_options_init*(
    opts:    ptr git_merge_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc to_c_git_merge_analysis_t*(
    arg: git_merge_analysis_t
  ): c_git_merge_analysis_t =
  case arg:
    of GIT_MERGE_ANALYSIS_NONE:        c_GIT_MERGE_ANALYSIS_NONE
    of GIT_MERGE_ANALYSIS_NORMAL:      c_GIT_MERGE_ANALYSIS_NORMAL
    of GIT_MERGE_ANALYSIS_UP_TO_DATE:  c_GIT_MERGE_ANALYSIS_UP_TO_DATE
    of GIT_MERGE_ANALYSIS_FASTFORWARD: c_GIT_MERGE_ANALYSIS_FASTFORWARD
    of GIT_MERGE_ANALYSIS_UNBORN:      c_GIT_MERGE_ANALYSIS_UNBORN


converter to_git_merge_analysis_t*(
    arg: c_git_merge_analysis_t
  ): git_merge_analysis_t =
  case arg:
    of c_GIT_MERGE_ANALYSIS_NONE:        GIT_MERGE_ANALYSIS_NONE
    of c_GIT_MERGE_ANALYSIS_NORMAL:      GIT_MERGE_ANALYSIS_NORMAL
    of c_GIT_MERGE_ANALYSIS_UP_TO_DATE:  GIT_MERGE_ANALYSIS_UP_TO_DATE
    of c_GIT_MERGE_ANALYSIS_FASTFORWARD: GIT_MERGE_ANALYSIS_FASTFORWARD
    of c_GIT_MERGE_ANALYSIS_UNBORN:      GIT_MERGE_ANALYSIS_UNBORN


converter toCint*(arg: c_git_merge_analysis_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_merge_analysis_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_merge_analysis_t(arg)))

func `+`*(arg: c_git_merge_analysis_t, offset: int): c_git_merge_analysis_t =
  cast[c_git_merge_analysis_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_merge_analysis_t): c_git_merge_analysis_t =
  cast[c_git_merge_analysis_t](ord(arg) + offset)

func `-`*(arg: c_git_merge_analysis_t, offset: int): c_git_merge_analysis_t =
  cast[c_git_merge_analysis_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_merge_analysis_t): c_git_merge_analysis_t =
  cast[c_git_merge_analysis_t](ord(arg) - offset)


converter toCint*(args: set[git_merge_analysis_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_MERGE_ANALYSIS_NONE:        result = cint(result or (0 shl 0))
      of GIT_MERGE_ANALYSIS_NORMAL:      result = cint(result or (1 shl 0))
      of GIT_MERGE_ANALYSIS_UP_TO_DATE:  result = cint(result or (1 shl 1))
      of GIT_MERGE_ANALYSIS_FASTFORWARD: result = cint(result or (1 shl 2))
      of GIT_MERGE_ANALYSIS_UNBORN:      result = cint(result or (1 shl 3))


proc to_c_git_merge_preference_t*(
    arg: git_merge_preference_t
  ): c_git_merge_preference_t =
  case arg:
    of GIT_MERGE_PREFERENCE_NONE:             c_GIT_MERGE_PREFERENCE_NONE
    of GIT_MERGE_PREFERENCE_NO_FASTFORWARD:   c_GIT_MERGE_PREFERENCE_NO_FASTFORWARD
    of GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY: c_GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY


converter to_git_merge_preference_t*(
    arg: c_git_merge_preference_t
  ): git_merge_preference_t =
  case arg:
    of c_GIT_MERGE_PREFERENCE_NONE:             GIT_MERGE_PREFERENCE_NONE
    of c_GIT_MERGE_PREFERENCE_NO_FASTFORWARD:   GIT_MERGE_PREFERENCE_NO_FASTFORWARD
    of c_GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY: GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY


converter toCint*(arg: c_git_merge_preference_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_merge_preference_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_merge_preference_t(arg)))

func `+`*(
    arg:    c_git_merge_preference_t,
    offset: int
  ): c_git_merge_preference_t =
  cast[c_git_merge_preference_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_merge_preference_t
  ): c_git_merge_preference_t =
  cast[c_git_merge_preference_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_merge_preference_t,
    offset: int
  ): c_git_merge_preference_t =
  cast[c_git_merge_preference_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_merge_preference_t
  ): c_git_merge_preference_t =
  cast[c_git_merge_preference_t](ord(arg) - offset)


converter toCint*(args: set[git_merge_preference_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_MERGE_PREFERENCE_NONE:             result = cint(result or (0 shl 0))
      of GIT_MERGE_PREFERENCE_NO_FASTFORWARD:   result = cint(result or (1 shl 0))
      of GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY: result = cint(result or (1 shl 1))


proc git_merge_analysis*(
    analysis_out:    ptr c_git_merge_analysis_t,
    preference_out:  ptr c_git_merge_preference_t,
    repo:            ptr git_repository,
    their_heads:     ptr ptr git_annotated_commit,
    their_heads_len: csize_t
  ): cint {.git2Proc, importc.}



proc git_merge_analysis_for_ref*(
    analysis_out:    ptr c_git_merge_analysis_t,
    preference_out:  ptr c_git_merge_preference_t,
    repo:            ptr git_repository,
    our_ref:         ptr git_reference,
    their_heads:     ptr ptr git_annotated_commit,
    their_heads_len: csize_t
  ): cint {.git2Proc, importc.}



proc git_merge_base*(
    arg_out: ptr git_oid,
    repo:    ptr git_repository,
    one:     ptr git_oid,
    two:     ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_merge_bases*(
    arg_out: ptr git_oidarray,
    repo:    ptr git_repository,
    one:     ptr git_oid,
    two:     ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_merge_base_many*(
    arg_out:     ptr git_oid,
    repo:        ptr git_repository,
    length:      csize_t,
    input_array: ptr UncheckedArray[git_oid]
  ): cint {.git2Proc, importc.}



proc git_merge_bases_many*(
    arg_out:     ptr git_oidarray,
    repo:        ptr git_repository,
    length:      csize_t,
    input_array: ptr UncheckedArray[git_oid]
  ): cint {.git2Proc, importc.}



proc git_merge_base_octopus*(
    arg_out:     ptr git_oid,
    repo:        ptr git_repository,
    length:      csize_t,
    input_array: ptr UncheckedArray[git_oid]
  ): cint {.git2Proc, importc.}



proc git_merge_file*(
    arg_out:  ptr git_merge_file_result,
    ancestor: ptr git_merge_file_input,
    ours:     ptr git_merge_file_input,
    theirs:   ptr git_merge_file_input,
    opts:     ptr git_merge_file_options
  ): cint {.git2Proc, importc.}



proc git_merge_file_from_index*(
    arg_out:  ptr git_merge_file_result,
    repo:     ptr git_repository,
    ancestor: ptr git_index_entry,
    ours:     ptr git_index_entry,
    theirs:   ptr git_index_entry,
    opts:     ptr git_merge_file_options
  ): cint {.git2Proc, importc.}



proc git_merge_file_result_free*(
    result: ptr git_merge_file_result
  ): void {.git2Proc, importc.}



proc git_merge_trees*(
    arg_out:       ptr ptr git_index,
    repo:          ptr git_repository,
    ancestor_tree: ptr git_tree,
    our_tree:      ptr git_tree,
    their_tree:    ptr git_tree,
    opts:          ptr git_merge_options
  ): cint {.git2Proc, importc.}



proc git_merge_commits*(
    arg_out:      ptr ptr git_index,
    repo:         ptr git_repository,
    our_commit:   ptr git_commit,
    their_commit: ptr git_commit,
    opts:         ptr git_merge_options
  ): cint {.git2Proc, importc.}



proc git_merge*(
    repo:            ptr git_repository,
    their_heads:     ptr ptr git_annotated_commit,
    their_heads_len: csize_t,
    merge_opts:      ptr git_merge_options,
    checkout_opts:   ptr git_checkout_options
  ): cint {.git2Proc, importc.}



