{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./oid,
  ./strarray,
  ./types

type
  c_git_delta_t* {.size: sizeof(cint).} = enum
    c_GIT_DELTA_UNMODIFIED = 0
    c_GIT_DELTA_ADDED      = 1  ## no changes
    c_GIT_DELTA_DELETED    = 2  ## entry does not exist in old version
    c_GIT_DELTA_MODIFIED   = 3  ## entry does not exist in new version
    c_GIT_DELTA_RENAMED    = 4  ## entry content changed between old and new
    c_GIT_DELTA_COPIED     = 5  ## entry was renamed between old and new
    c_GIT_DELTA_IGNORED    = 6  ## entry was copied from another old entry
    c_GIT_DELTA_UNTRACKED  = 7  ## entry is ignored item in workdir
    c_GIT_DELTA_TYPECHANGE = 8  ## entry is untracked item in workdir
    c_GIT_DELTA_UNREADABLE = 9  ## type of entry changed between old and new
    c_GIT_DELTA_CONFLICTED = 10 ## entry is unreadable

  c_git_diff_binary_t* {.size: sizeof(cint).} = enum
    c_GIT_DIFF_BINARY_NONE    = 0 shl 0 ## There is no binary delta.
    c_GIT_DIFF_BINARY_LITERAL = 1 shl 0 ## The binary data is the literal contents of the file.
    c_GIT_DIFF_BINARY_DELTA   = 1 shl 1 ## The binary data is the delta from one side to the other.

  c_git_diff_find_t* {.size: sizeof(cint).} = enum
    c_GIT_DIFF_FIND_BY_CONFIG                  = 0     ## Obey `diff.renames`. Overridden by any other GIT_DIFF_FIND_... flag.
    c_GIT_DIFF_FIND_RENAMES                    = 1     ## Look for renames? (`--find-renames`)
    c_GIT_DIFF_FIND_RENAMES_FROM_REWRITES      = 2     ## Consider old side of MODIFIED for renames? (`--break-rewrites=N`)
    c_GIT_DIFF_FIND_COPIES                     = 4     ## Look for copies? (a la `--find-copies`).
    c_GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED     = 8
    c_GIT_DIFF_FIND_REWRITES                   = 16    ## Mark significant rewrites for split (`--break-rewrites=/M`)
    c_GIT_DIFF_BREAK_REWRITES                  = 32    ## Actually split large rewrites into delete/add pairs
    c_GIT_DIFF_FIND_AND_BREAK_REWRITES         = 48    ## Mark rewrites for split and break into delete/add pairs
    c_GIT_DIFF_FIND_FOR_UNTRACKED              = 64
    c_GIT_DIFF_FIND_IGNORE_WHITESPACE          = 4096  ## Measure similarity ignoring all whitespace
    c_GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE     = 8192  ## Measure similarity including all data
    c_GIT_DIFF_FIND_EXACT_MATCH_ONLY           = 16384 ## Measure similarity only by comparing SHAs (fast and cheap)
    c_GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY = 32768
    c_GIT_DIFF_FIND_REMOVE_UNMODIFIED          = 65536

  c_git_diff_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_DIFF_FLAG_BINARY     = 1 shl 0
    c_GIT_DIFF_FLAG_NOT_BINARY = 1 shl 1 ## file(s) treated as binary data
    c_GIT_DIFF_FLAG_VALID_ID   = 1 shl 2 ## file(s) treated as text data
    c_GIT_DIFF_FLAG_EXISTS     = 1 shl 3 ## `id` value is known correct

  c_git_diff_format_email_flags_t* {.size: sizeof(cint).} = enum
    c_GIT_DIFF_FORMAT_EMAIL_NONE                         = 0 shl 0 ## Normal patch, the default
    c_GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = 1 shl 0 ## Don't insert "[PATCH]" in the subject header

  c_git_diff_format_t* {.size: sizeof(cint).} = enum
    c_GIT_DIFF_FORMAT_PATCH        = 1
    c_GIT_DIFF_FORMAT_PATCH_HEADER = 2 ## full git diff
    c_GIT_DIFF_FORMAT_RAW          = 3 ## just the file headers of patch
    c_GIT_DIFF_FORMAT_NAME_ONLY    = 4 ## like git diff --raw
    c_GIT_DIFF_FORMAT_NAME_STATUS  = 5 ## like git diff --name-only
    c_GIT_DIFF_FORMAT_PATCH_ID     = 6 ## like git diff --name-status

  c_git_diff_line_t* {.size: sizeof(cint).} = enum
    c_GIT_DIFF_LINE_CONTEXT = 39 ## These values will be sent to `git_diff_line_cb` along with the line

  c_git_diff_option_t* {.size: sizeof(cint).} = enum
    c_GIT_DIFF_NORMAL                          = 0 shl 0  ## Normal diff, the default
    c_GIT_DIFF_REVERSE                         = 1 shl 0  ## Reverse the sides of the diff
    c_GIT_DIFF_INCLUDE_IGNORED                 = 1 shl 1  ## Include ignored files in the diff
    c_GIT_DIFF_RECURSE_IGNORED_DIRS            = 1 shl 2
    c_GIT_DIFF_INCLUDE_UNTRACKED               = 1 shl 3  ## Include untracked files in the diff
    c_GIT_DIFF_RECURSE_UNTRACKED_DIRS          = 1 shl 4
    c_GIT_DIFF_INCLUDE_UNMODIFIED              = 1 shl 5  ## Include unmodified files in the diff
    c_GIT_DIFF_INCLUDE_TYPECHANGE              = 1 shl 6
    c_GIT_DIFF_INCLUDE_TYPECHANGE_TREES        = 1 shl 7
    c_GIT_DIFF_IGNORE_FILEMODE                 = 1 shl 8  ## Ignore file mode changes
    c_GIT_DIFF_IGNORE_SUBMODULES               = 1 shl 9  ## Treat all submodules as unmodified
    c_GIT_DIFF_IGNORE_CASE                     = 1 shl 10 ## Use case insensitive filename comparisons
    c_GIT_DIFF_INCLUDE_CASECHANGE              = 1 shl 11
    c_GIT_DIFF_DISABLE_PATHSPEC_MATCH          = 1 shl 12
    c_GIT_DIFF_SKIP_BINARY_CHECK               = 1 shl 13
    c_GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS      = 1 shl 14
    c_GIT_DIFF_UPDATE_INDEX                    = 1 shl 15
    c_GIT_DIFF_INCLUDE_UNREADABLE              = 1 shl 16 ## Include unreadable files in the diff
    c_GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = 1 shl 17 ## Include unreadable files in the diff
    c_GIT_DIFF_INDENT_HEURISTIC                = 1 shl 18
    c_GIT_DIFF_FORCE_TEXT                      = 1 shl 20 ## Treat all files as text, disabling binary attributes & detection
    c_GIT_DIFF_FORCE_BINARY                    = 1 shl 21 ## Treat all files as binary, disabling text diffs
    c_GIT_DIFF_IGNORE_WHITESPACE               = 1 shl 22 ## Ignore all whitespace
    c_GIT_DIFF_IGNORE_WHITESPACE_CHANGE        = 1 shl 23 ## Ignore changes in amount of whitespace
    c_GIT_DIFF_IGNORE_WHITESPACE_EOL           = 1 shl 24 ## Ignore whitespace at end of line
    c_GIT_DIFF_SHOW_UNTRACKED_CONTENT          = 1 shl 25
    c_GIT_DIFF_SHOW_UNMODIFIED                 = 1 shl 26
    c_GIT_DIFF_PATIENCE                        = 1 shl 28 ## Use the "patience diff" algorithm
    c_GIT_DIFF_MINIMAL                         = 1 shl 29 ## Take extra time to find minimal diff
    c_GIT_DIFF_SHOW_BINARY                     = 1 shl 30
    c_GIT_DIFF_IGNORE_BLANK_LINES              = 1 shl 31 ## Ignore blank lines

  c_git_diff_stats_format_t* {.size: sizeof(cint).} = enum
    c_GIT_DIFF_STATS_NONE            = 0 shl 0 ## No stats
    c_GIT_DIFF_STATS_FULL            = 1 shl 0 ## Full statistics, equivalent of `--stat`
    c_GIT_DIFF_STATS_SHORT           = 1 shl 1 ## Short statistics, equivalent of `--shortstat`
    c_GIT_DIFF_STATS_NUMBER          = 1 shl 2 ## Number statistics, equivalent of `--numstat`
    c_GIT_DIFF_STATS_INCLUDE_SUMMARY = 1 shl 3 ## Extended header information such as creations, renames and mode changes, equivalent of `--summary`

  git_delta_t* = enum
    GIT_DELTA_UNMODIFIED
    GIT_DELTA_ADDED      ## no changes
    GIT_DELTA_DELETED    ## entry does not exist in old version
    GIT_DELTA_MODIFIED   ## entry does not exist in new version
    GIT_DELTA_RENAMED    ## entry content changed between old and new
    GIT_DELTA_COPIED     ## entry was renamed between old and new
    GIT_DELTA_IGNORED    ## entry was copied from another old entry
    GIT_DELTA_UNTRACKED  ## entry is ignored item in workdir
    GIT_DELTA_TYPECHANGE ## entry is untracked item in workdir
    GIT_DELTA_UNREADABLE ## type of entry changed between old and new
    GIT_DELTA_CONFLICTED ## entry is unreadable

  git_diff* {.bycopy, incompleteStruct, header: "<git2/diff.h>", importc.} = object


  git_diff_binary* {.bycopy, header: "<git2/diff.h>", importc.} = object
    contains_data*: cuint
    old_file*:      git_diff_binary_file
    new_file*:      git_diff_binary_file ## The contents of the old file.
                                         ## The contents of the new file.

  git_diff_binary_cb* = proc(delta:   ptr git_diff_delta,
                             binary:  ptr git_diff_binary,
                             payload: pointer): cint{.cdecl.}

  git_diff_binary_file* {.bycopy, header: "<git2/diff.h>", importc.} = object
    ## The contents of one of the files in a binary diff.
    type_f* {.importc: "type".}: c_git_diff_binary_t ## The type of binary data for this file.
    data*:                       cstring             ## The binary data, deflated.
    datalen*:                    csize_t             ## The length of the binary data.
    inflatedlen*:                csize_t             ## The length of the binary data after inflation.

  git_diff_binary_t* {.size: sizeof(cint).} = enum
    GIT_DIFF_BINARY_NONE    ## There is no binary delta.
    GIT_DIFF_BINARY_LITERAL ## The binary data is the literal contents of the file.
    GIT_DIFF_BINARY_DELTA   ## The binary data is the delta from one side to the other.

  git_diff_delta* {.bycopy, header: "<git2/diff.h>", importc.} = object
    status*:     c_git_delta_t
    flags*:      uint32
    similarity*: uint16        ## git_diff_flag_t values
    nfiles*:     uint16        ## for RENAMED and COPIED, value 0-100
    old_file*:   git_diff_file ## number of files in this delta
    new_file*:   git_diff_file

  git_diff_file* {.bycopy, header: "<git2/diff.h>", importc.} = object
    ## entry in the index is conflicted
    id*:        git_oid
    path*:      cstring
    size*:      git_object_size_t
    flags*:     uint32
    mode*:      uint16
    id_abbrev*: uint16

  git_diff_file_cb* = proc(delta:    ptr git_diff_delta,
                           progress: cfloat,
                           payload:  pointer): cint{.cdecl.}

  git_diff_find_options* {.bycopy, header: "<git2/diff.h>", importc.} = object
    version*:                       cuint
    flags*:                         uint32
    rename_threshold*:              uint16
    rename_from_rewrite_threshold*: uint16
    copy_threshold*:                uint16
    break_rewrite_threshold*:       uint16
    rename_limit*:                  csize_t
    metric*:                        ptr git_diff_similarity_metric

  git_diff_find_t* = enum
    GIT_DIFF_FIND_BY_CONFIG                  ## Obey `diff.renames`. Overridden by any other GIT_DIFF_FIND_... flag.
    GIT_DIFF_FIND_RENAMES                    ## Look for renames? (`--find-renames`)
    GIT_DIFF_FIND_RENAMES_FROM_REWRITES      ## Consider old side of MODIFIED for renames? (`--break-rewrites=N`)
    GIT_DIFF_FIND_COPIES                     ## Look for copies? (a la `--find-copies`).
    GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED
    GIT_DIFF_FIND_REWRITES                   ## Mark significant rewrites for split (`--break-rewrites=/M`)
    GIT_DIFF_BREAK_REWRITES                  ## Actually split large rewrites into delete/add pairs
    GIT_DIFF_FIND_AND_BREAK_REWRITES         ## Mark rewrites for split and break into delete/add pairs
    GIT_DIFF_FIND_FOR_UNTRACKED
    GIT_DIFF_FIND_IGNORE_WHITESPACE          ## Measure similarity ignoring all whitespace
    GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE     ## Measure similarity including all data
    GIT_DIFF_FIND_EXACT_MATCH_ONLY           ## Measure similarity only by comparing SHAs (fast and cheap)
    GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY
    GIT_DIFF_FIND_REMOVE_UNMODIFIED

  git_diff_flag_t* {.size: sizeof(cint).} = enum
    GIT_DIFF_FLAG_BINARY
    GIT_DIFF_FLAG_NOT_BINARY ## file(s) treated as binary data
    GIT_DIFF_FLAG_VALID_ID   ## file(s) treated as text data
    GIT_DIFF_FLAG_EXISTS     ## `id` value is known correct

  git_diff_format_email_flags_t* {.size: sizeof(cint).} = enum
    GIT_DIFF_FORMAT_EMAIL_NONE                         ## Normal patch, the default
    GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER ## Don't insert "[PATCH]" in the subject header

  git_diff_format_email_options* {.bycopy, header: "<git2/diff.h>", importc.} = object
    version*:       cuint
    flags*:         uint32            ## see `git_diff_format_email_flags_t` above
    patch_no*:      csize_t           ## This patch number
    total_patches*: csize_t           ## Total number of patches in this series
    id*:            ptr git_oid       ## id to use for the commit
    summary*:       cstring           ## Summary of the change
    body*:          cstring           ## Commit message's body
    author*:        ptr git_signature ## Author of the change

  git_diff_format_t* = enum
    GIT_DIFF_FORMAT_PATCH
    GIT_DIFF_FORMAT_PATCH_HEADER ## full git diff
    GIT_DIFF_FORMAT_RAW          ## just the file headers of patch
    GIT_DIFF_FORMAT_NAME_ONLY    ## like git diff --raw
    GIT_DIFF_FORMAT_NAME_STATUS  ## like git diff --name-only
    GIT_DIFF_FORMAT_PATCH_ID     ## like git diff --name-status

  git_diff_hunk* {.bycopy, header: "<git2/diff.h>", importc.} = object
    old_start*:  cint
    old_lines*:  cint                     ## Starting line number in old_file
    new_start*:  cint                     ## Number of lines in old_file
    new_lines*:  cint                     ## Starting line number in new_file
    header_len*: csize_t                  ## Number of lines in new_file
    header*:     ptr UncheckedArray[char] ## Number of bytes in header text
                                          ## Header text, NUL-byte terminated

  git_diff_hunk_cb* = proc(delta:   ptr git_diff_delta,
                           hunk:    ptr git_diff_hunk,
                           payload: pointer): cint{.cdecl.}

  git_diff_line* {.bycopy, header: "<git2/diff.h>", importc.} = object
    ## For "Binary files x and y differ"
    origin*:         char
    old_lineno*:     cint      ## A git_diff_line_t value
    new_lineno*:     cint      ## Line number in old file or -1 for added line
    num_lines*:      cint      ## Line number in new file or -1 for deleted line
    content_len*:    csize_t   ## Number of newline characters in content
    content_offset*: git_off_t ## Number of bytes of data
    content*:        cstring   ## Offset in the original file to the content
                               ## Pointer to diff text, not NUL-byte terminated

  git_diff_line_cb* = proc(delta:   ptr git_diff_delta,
                           hunk:    ptr git_diff_hunk,
                           line:    ptr git_diff_line,
                           payload: pointer): cint{.cdecl.}

  git_diff_line_t* = enum
    GIT_DIFF_LINE_CONTEXT ## These values will be sent to `git_diff_line_cb` along with the line

  git_diff_notify_cb* = proc(diff_so_far:      ptr git_diff,
                             delta_to_add:     ptr git_diff_delta,
                             matched_pathspec: cstring,
                             payload:          pointer): cint{.cdecl.}

  git_diff_option_t* {.size: sizeof(cint).} = enum
    GIT_DIFF_NORMAL                          ## Normal diff, the default
    GIT_DIFF_REVERSE                         ## Reverse the sides of the diff
    GIT_DIFF_INCLUDE_IGNORED                 ## Include ignored files in the diff
    GIT_DIFF_RECURSE_IGNORED_DIRS
    GIT_DIFF_INCLUDE_UNTRACKED               ## Include untracked files in the diff
    GIT_DIFF_RECURSE_UNTRACKED_DIRS
    GIT_DIFF_INCLUDE_UNMODIFIED              ## Include unmodified files in the diff
    GIT_DIFF_INCLUDE_TYPECHANGE
    GIT_DIFF_INCLUDE_TYPECHANGE_TREES
    GIT_DIFF_IGNORE_FILEMODE                 ## Ignore file mode changes
    GIT_DIFF_IGNORE_SUBMODULES               ## Treat all submodules as unmodified
    GIT_DIFF_IGNORE_CASE                     ## Use case insensitive filename comparisons
    GIT_DIFF_INCLUDE_CASECHANGE
    GIT_DIFF_DISABLE_PATHSPEC_MATCH
    GIT_DIFF_SKIP_BINARY_CHECK
    GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS
    GIT_DIFF_UPDATE_INDEX
    GIT_DIFF_INCLUDE_UNREADABLE              ## Include unreadable files in the diff
    GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED ## Include unreadable files in the diff
    GIT_DIFF_INDENT_HEURISTIC
    GIT_DIFF_FORCE_TEXT                      ## Treat all files as text, disabling binary attributes & detection
    GIT_DIFF_FORCE_BINARY                    ## Treat all files as binary, disabling text diffs
    GIT_DIFF_IGNORE_WHITESPACE               ## Ignore all whitespace
    GIT_DIFF_IGNORE_WHITESPACE_CHANGE        ## Ignore changes in amount of whitespace
    GIT_DIFF_IGNORE_WHITESPACE_EOL           ## Ignore whitespace at end of line
    GIT_DIFF_SHOW_UNTRACKED_CONTENT
    GIT_DIFF_SHOW_UNMODIFIED
    GIT_DIFF_PATIENCE                        ## Use the "patience diff" algorithm
    GIT_DIFF_MINIMAL                         ## Take extra time to find minimal diff
    GIT_DIFF_SHOW_BINARY
    GIT_DIFF_IGNORE_BLANK_LINES              ## Ignore blank lines

  git_diff_options* {.bycopy, header: "<git2/diff.h>", importc.} = object
    version*:           cuint
    flags*:             uint32                   ## version for the struct
    ignore_submodules*: c_git_submodule_ignore_t ## options controlling which files are in the diff
                                                 ## Overrides the submodule ignore setting for all submodules in the diff.
    pathspec*:          git_strarray
    notify_cb*:         git_diff_notify_cb
    progress_cb*:       git_diff_progress_cb
    payload*:           pointer                  ## The payload to pass to the callback functions.
    context_lines*:     uint32                   ## options controlling how to diff text is generated
    interhunk_lines*:   uint32
    id_abbrev*:         uint16
    max_size*:          git_off_t
    old_prefix*:        cstring
    new_prefix*:        cstring

  git_diff_patchid_options* {.bycopy, header: "<git2/diff.h>", importc.} = object
    version*: cuint

  git_diff_progress_cb* = proc(diff_so_far: ptr git_diff,
                               old_path:    cstring,
                               new_path:    cstring,
                               payload:     pointer): cint{.cdecl.}

  git_diff_similarity_metric* {.bycopy, header: "<git2/diff.h>", importc.} = object
    file_signature*:   proc(arg_out:  ptr pointer,
                            file:     ptr git_diff_file,
                            fullpath: cstring,
                            payload:  pointer): cint{.cdecl.}
    buffer_signature*: proc(arg_out: ptr pointer,
                            file:    ptr git_diff_file,
                            buf:     cstring,
                            buflen:  csize_t,
                            payload: pointer): cint{.cdecl.}
    free_signature*:   proc(sig:     pointer,
                            payload: pointer): void{.cdecl.}
    similarity*:       proc(score:   ptr cint,
                            siga:    pointer,
                            sigb:    pointer,
                            payload: pointer): cint{.cdecl.}
    payload*:          pointer

  git_diff_stats* {.bycopy, incompleteStruct, header: "<git2/diff.h>", importc.} = object


  git_diff_stats_format_t* {.size: sizeof(cint).} = enum
    GIT_DIFF_STATS_NONE            ## No stats
    GIT_DIFF_STATS_FULL            ## Full statistics, equivalent of `--stat`
    GIT_DIFF_STATS_SHORT           ## Short statistics, equivalent of `--shortstat`
    GIT_DIFF_STATS_NUMBER          ## Number statistics, equivalent of `--numstat`
    GIT_DIFF_STATS_INCLUDE_SUMMARY ## Extended header information such as creations, renames and mode changes, equivalent of `--summary`


proc to_c_git_diff_option_t*(arg: git_diff_option_t): c_git_diff_option_t =
  case arg:
    of GIT_DIFF_NORMAL:                          c_GIT_DIFF_NORMAL
    of GIT_DIFF_REVERSE:                         c_GIT_DIFF_REVERSE
    of GIT_DIFF_INCLUDE_IGNORED:                 c_GIT_DIFF_INCLUDE_IGNORED
    of GIT_DIFF_RECURSE_IGNORED_DIRS:            c_GIT_DIFF_RECURSE_IGNORED_DIRS
    of GIT_DIFF_INCLUDE_UNTRACKED:               c_GIT_DIFF_INCLUDE_UNTRACKED
    of GIT_DIFF_RECURSE_UNTRACKED_DIRS:          c_GIT_DIFF_RECURSE_UNTRACKED_DIRS
    of GIT_DIFF_INCLUDE_UNMODIFIED:              c_GIT_DIFF_INCLUDE_UNMODIFIED
    of GIT_DIFF_INCLUDE_TYPECHANGE:              c_GIT_DIFF_INCLUDE_TYPECHANGE
    of GIT_DIFF_INCLUDE_TYPECHANGE_TREES:        c_GIT_DIFF_INCLUDE_TYPECHANGE_TREES
    of GIT_DIFF_IGNORE_FILEMODE:                 c_GIT_DIFF_IGNORE_FILEMODE
    of GIT_DIFF_IGNORE_SUBMODULES:               c_GIT_DIFF_IGNORE_SUBMODULES
    of GIT_DIFF_IGNORE_CASE:                     c_GIT_DIFF_IGNORE_CASE
    of GIT_DIFF_INCLUDE_CASECHANGE:              c_GIT_DIFF_INCLUDE_CASECHANGE
    of GIT_DIFF_DISABLE_PATHSPEC_MATCH:          c_GIT_DIFF_DISABLE_PATHSPEC_MATCH
    of GIT_DIFF_SKIP_BINARY_CHECK:               c_GIT_DIFF_SKIP_BINARY_CHECK
    of GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS:      c_GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS
    of GIT_DIFF_UPDATE_INDEX:                    c_GIT_DIFF_UPDATE_INDEX
    of GIT_DIFF_INCLUDE_UNREADABLE:              c_GIT_DIFF_INCLUDE_UNREADABLE
    of GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED: c_GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED
    of GIT_DIFF_INDENT_HEURISTIC:                c_GIT_DIFF_INDENT_HEURISTIC
    of GIT_DIFF_FORCE_TEXT:                      c_GIT_DIFF_FORCE_TEXT
    of GIT_DIFF_FORCE_BINARY:                    c_GIT_DIFF_FORCE_BINARY
    of GIT_DIFF_IGNORE_WHITESPACE:               c_GIT_DIFF_IGNORE_WHITESPACE
    of GIT_DIFF_IGNORE_WHITESPACE_CHANGE:        c_GIT_DIFF_IGNORE_WHITESPACE_CHANGE
    of GIT_DIFF_IGNORE_WHITESPACE_EOL:           c_GIT_DIFF_IGNORE_WHITESPACE_EOL
    of GIT_DIFF_SHOW_UNTRACKED_CONTENT:          c_GIT_DIFF_SHOW_UNTRACKED_CONTENT
    of GIT_DIFF_SHOW_UNMODIFIED:                 c_GIT_DIFF_SHOW_UNMODIFIED
    of GIT_DIFF_PATIENCE:                        c_GIT_DIFF_PATIENCE
    of GIT_DIFF_MINIMAL:                         c_GIT_DIFF_MINIMAL
    of GIT_DIFF_SHOW_BINARY:                     c_GIT_DIFF_SHOW_BINARY
    of GIT_DIFF_IGNORE_BLANK_LINES:              c_GIT_DIFF_IGNORE_BLANK_LINES


converter to_git_diff_option_t*(arg: c_git_diff_option_t): git_diff_option_t =
  case arg:
    of c_GIT_DIFF_NORMAL:                          GIT_DIFF_NORMAL
    of c_GIT_DIFF_REVERSE:                         GIT_DIFF_REVERSE
    of c_GIT_DIFF_INCLUDE_IGNORED:                 GIT_DIFF_INCLUDE_IGNORED
    of c_GIT_DIFF_RECURSE_IGNORED_DIRS:            GIT_DIFF_RECURSE_IGNORED_DIRS
    of c_GIT_DIFF_INCLUDE_UNTRACKED:               GIT_DIFF_INCLUDE_UNTRACKED
    of c_GIT_DIFF_RECURSE_UNTRACKED_DIRS:          GIT_DIFF_RECURSE_UNTRACKED_DIRS
    of c_GIT_DIFF_INCLUDE_UNMODIFIED:              GIT_DIFF_INCLUDE_UNMODIFIED
    of c_GIT_DIFF_INCLUDE_TYPECHANGE:              GIT_DIFF_INCLUDE_TYPECHANGE
    of c_GIT_DIFF_INCLUDE_TYPECHANGE_TREES:        GIT_DIFF_INCLUDE_TYPECHANGE_TREES
    of c_GIT_DIFF_IGNORE_FILEMODE:                 GIT_DIFF_IGNORE_FILEMODE
    of c_GIT_DIFF_IGNORE_SUBMODULES:               GIT_DIFF_IGNORE_SUBMODULES
    of c_GIT_DIFF_IGNORE_CASE:                     GIT_DIFF_IGNORE_CASE
    of c_GIT_DIFF_INCLUDE_CASECHANGE:              GIT_DIFF_INCLUDE_CASECHANGE
    of c_GIT_DIFF_DISABLE_PATHSPEC_MATCH:          GIT_DIFF_DISABLE_PATHSPEC_MATCH
    of c_GIT_DIFF_SKIP_BINARY_CHECK:               GIT_DIFF_SKIP_BINARY_CHECK
    of c_GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS:      GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS
    of c_GIT_DIFF_UPDATE_INDEX:                    GIT_DIFF_UPDATE_INDEX
    of c_GIT_DIFF_INCLUDE_UNREADABLE:              GIT_DIFF_INCLUDE_UNREADABLE
    of c_GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED: GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED
    of c_GIT_DIFF_INDENT_HEURISTIC:                GIT_DIFF_INDENT_HEURISTIC
    of c_GIT_DIFF_FORCE_TEXT:                      GIT_DIFF_FORCE_TEXT
    of c_GIT_DIFF_FORCE_BINARY:                    GIT_DIFF_FORCE_BINARY
    of c_GIT_DIFF_IGNORE_WHITESPACE:               GIT_DIFF_IGNORE_WHITESPACE
    of c_GIT_DIFF_IGNORE_WHITESPACE_CHANGE:        GIT_DIFF_IGNORE_WHITESPACE_CHANGE
    of c_GIT_DIFF_IGNORE_WHITESPACE_EOL:           GIT_DIFF_IGNORE_WHITESPACE_EOL
    of c_GIT_DIFF_SHOW_UNTRACKED_CONTENT:          GIT_DIFF_SHOW_UNTRACKED_CONTENT
    of c_GIT_DIFF_SHOW_UNMODIFIED:                 GIT_DIFF_SHOW_UNMODIFIED
    of c_GIT_DIFF_PATIENCE:                        GIT_DIFF_PATIENCE
    of c_GIT_DIFF_MINIMAL:                         GIT_DIFF_MINIMAL
    of c_GIT_DIFF_SHOW_BINARY:                     GIT_DIFF_SHOW_BINARY
    of c_GIT_DIFF_IGNORE_BLANK_LINES:              GIT_DIFF_IGNORE_BLANK_LINES


converter toCint*(arg: c_git_diff_option_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_diff_option_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_diff_option_t(arg)))

func `+`*(arg: c_git_diff_option_t, offset: int): c_git_diff_option_t =
  cast[c_git_diff_option_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_option_t): c_git_diff_option_t =
  cast[c_git_diff_option_t](ord(arg) + offset)

func `-`*(arg: c_git_diff_option_t, offset: int): c_git_diff_option_t =
  cast[c_git_diff_option_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_option_t): c_git_diff_option_t =
  cast[c_git_diff_option_t](ord(arg) - offset)


converter toCint*(args: set[git_diff_option_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_DIFF_NORMAL:                          result = cint(result or (0 shl 0))
      of GIT_DIFF_REVERSE:                         result = cint(result or (1 shl 0))
      of GIT_DIFF_INCLUDE_IGNORED:                 result = cint(result or (1 shl 1))
      of GIT_DIFF_RECURSE_IGNORED_DIRS:            result = cint(result or (1 shl 2))
      of GIT_DIFF_INCLUDE_UNTRACKED:               result = cint(result or (1 shl 3))
      of GIT_DIFF_RECURSE_UNTRACKED_DIRS:          result = cint(result or (1 shl 4))
      of GIT_DIFF_INCLUDE_UNMODIFIED:              result = cint(result or (1 shl 5))
      of GIT_DIFF_INCLUDE_TYPECHANGE:              result = cint(result or (1 shl 6))
      of GIT_DIFF_INCLUDE_TYPECHANGE_TREES:        result = cint(result or (1 shl 7))
      of GIT_DIFF_IGNORE_FILEMODE:                 result = cint(result or (1 shl 8))
      of GIT_DIFF_IGNORE_SUBMODULES:               result = cint(result or (1 shl 9))
      of GIT_DIFF_IGNORE_CASE:                     result = cint(result or (1 shl 10))
      of GIT_DIFF_INCLUDE_CASECHANGE:              result = cint(result or (1 shl 11))
      of GIT_DIFF_DISABLE_PATHSPEC_MATCH:          result = cint(result or (1 shl 12))
      of GIT_DIFF_SKIP_BINARY_CHECK:               result = cint(result or (1 shl 13))
      of GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS:      result = cint(result or (1 shl 14))
      of GIT_DIFF_UPDATE_INDEX:                    result = cint(result or (1 shl 15))
      of GIT_DIFF_INCLUDE_UNREADABLE:              result = cint(result or (1 shl 16))
      of GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED: result = cint(result or (1 shl 17))
      of GIT_DIFF_INDENT_HEURISTIC:                result = cint(result or (1 shl 18))
      of GIT_DIFF_FORCE_TEXT:                      result = cint(result or (1 shl 20))
      of GIT_DIFF_FORCE_BINARY:                    result = cint(result or (1 shl 21))
      of GIT_DIFF_IGNORE_WHITESPACE:               result = cint(result or (1 shl 22))
      of GIT_DIFF_IGNORE_WHITESPACE_CHANGE:        result = cint(result or (1 shl 23))
      of GIT_DIFF_IGNORE_WHITESPACE_EOL:           result = cint(result or (1 shl 24))
      of GIT_DIFF_SHOW_UNTRACKED_CONTENT:          result = cint(result or (1 shl 25))
      of GIT_DIFF_SHOW_UNMODIFIED:                 result = cint(result or (1 shl 26))
      of GIT_DIFF_PATIENCE:                        result = cint(result or (1 shl 28))
      of GIT_DIFF_MINIMAL:                         result = cint(result or (1 shl 29))
      of GIT_DIFF_SHOW_BINARY:                     result = cint(result or (1 shl 30))
      of GIT_DIFF_IGNORE_BLANK_LINES:              result = cint(result or (1 shl 31))


proc to_c_git_diff_flag_t*(arg: git_diff_flag_t): c_git_diff_flag_t =
  case arg:
    of GIT_DIFF_FLAG_BINARY:     c_GIT_DIFF_FLAG_BINARY
    of GIT_DIFF_FLAG_NOT_BINARY: c_GIT_DIFF_FLAG_NOT_BINARY
    of GIT_DIFF_FLAG_VALID_ID:   c_GIT_DIFF_FLAG_VALID_ID
    of GIT_DIFF_FLAG_EXISTS:     c_GIT_DIFF_FLAG_EXISTS


converter to_git_diff_flag_t*(arg: c_git_diff_flag_t): git_diff_flag_t =
  case arg:
    of c_GIT_DIFF_FLAG_BINARY:     GIT_DIFF_FLAG_BINARY
    of c_GIT_DIFF_FLAG_NOT_BINARY: GIT_DIFF_FLAG_NOT_BINARY
    of c_GIT_DIFF_FLAG_VALID_ID:   GIT_DIFF_FLAG_VALID_ID
    of c_GIT_DIFF_FLAG_EXISTS:     GIT_DIFF_FLAG_EXISTS


converter toCint*(arg: c_git_diff_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_diff_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_diff_flag_t(arg)))

func `+`*(arg: c_git_diff_flag_t, offset: int): c_git_diff_flag_t =
  cast[c_git_diff_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_flag_t): c_git_diff_flag_t =
  cast[c_git_diff_flag_t](ord(arg) + offset)

func `-`*(arg: c_git_diff_flag_t, offset: int): c_git_diff_flag_t =
  cast[c_git_diff_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_flag_t): c_git_diff_flag_t =
  cast[c_git_diff_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_diff_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc to_c_git_delta_t*(arg: git_delta_t): c_git_delta_t =
  case arg:
    of GIT_DELTA_UNMODIFIED: c_GIT_DELTA_UNMODIFIED
    of GIT_DELTA_ADDED:      c_GIT_DELTA_ADDED
    of GIT_DELTA_DELETED:    c_GIT_DELTA_DELETED
    of GIT_DELTA_MODIFIED:   c_GIT_DELTA_MODIFIED
    of GIT_DELTA_RENAMED:    c_GIT_DELTA_RENAMED
    of GIT_DELTA_COPIED:     c_GIT_DELTA_COPIED
    of GIT_DELTA_IGNORED:    c_GIT_DELTA_IGNORED
    of GIT_DELTA_UNTRACKED:  c_GIT_DELTA_UNTRACKED
    of GIT_DELTA_TYPECHANGE: c_GIT_DELTA_TYPECHANGE
    of GIT_DELTA_UNREADABLE: c_GIT_DELTA_UNREADABLE
    of GIT_DELTA_CONFLICTED: c_GIT_DELTA_CONFLICTED


converter to_git_delta_t*(arg: c_git_delta_t): git_delta_t =
  case arg:
    of c_GIT_DELTA_UNMODIFIED: GIT_DELTA_UNMODIFIED
    of c_GIT_DELTA_ADDED:      GIT_DELTA_ADDED
    of c_GIT_DELTA_DELETED:    GIT_DELTA_DELETED
    of c_GIT_DELTA_MODIFIED:   GIT_DELTA_MODIFIED
    of c_GIT_DELTA_RENAMED:    GIT_DELTA_RENAMED
    of c_GIT_DELTA_COPIED:     GIT_DELTA_COPIED
    of c_GIT_DELTA_IGNORED:    GIT_DELTA_IGNORED
    of c_GIT_DELTA_UNTRACKED:  GIT_DELTA_UNTRACKED
    of c_GIT_DELTA_TYPECHANGE: GIT_DELTA_TYPECHANGE
    of c_GIT_DELTA_UNREADABLE: GIT_DELTA_UNREADABLE
    of c_GIT_DELTA_CONFLICTED: GIT_DELTA_CONFLICTED


converter toCint*(arg: c_git_delta_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_delta_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_delta_t(arg)))

func `+`*(arg: c_git_delta_t, offset: int): c_git_delta_t =
  cast[c_git_delta_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_delta_t): c_git_delta_t =
  cast[c_git_delta_t](ord(arg) + offset)

func `-`*(arg: c_git_delta_t, offset: int): c_git_delta_t =
  cast[c_git_delta_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_delta_t): c_git_delta_t =
  cast[c_git_delta_t](ord(arg) - offset)


proc git_diff_options_init*(
    opts:    ptr git_diff_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc to_c_git_diff_binary_t*(arg: git_diff_binary_t): c_git_diff_binary_t =
  case arg:
    of GIT_DIFF_BINARY_NONE:    c_GIT_DIFF_BINARY_NONE
    of GIT_DIFF_BINARY_LITERAL: c_GIT_DIFF_BINARY_LITERAL
    of GIT_DIFF_BINARY_DELTA:   c_GIT_DIFF_BINARY_DELTA


converter to_git_diff_binary_t*(arg: c_git_diff_binary_t): git_diff_binary_t =
  case arg:
    of c_GIT_DIFF_BINARY_NONE:    GIT_DIFF_BINARY_NONE
    of c_GIT_DIFF_BINARY_LITERAL: GIT_DIFF_BINARY_LITERAL
    of c_GIT_DIFF_BINARY_DELTA:   GIT_DIFF_BINARY_DELTA


converter toCint*(arg: c_git_diff_binary_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_diff_binary_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_diff_binary_t(arg)))

func `+`*(arg: c_git_diff_binary_t, offset: int): c_git_diff_binary_t =
  cast[c_git_diff_binary_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_binary_t): c_git_diff_binary_t =
  cast[c_git_diff_binary_t](ord(arg) + offset)

func `-`*(arg: c_git_diff_binary_t, offset: int): c_git_diff_binary_t =
  cast[c_git_diff_binary_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_binary_t): c_git_diff_binary_t =
  cast[c_git_diff_binary_t](ord(arg) - offset)


converter toCint*(args: set[git_diff_binary_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_DIFF_BINARY_NONE:    result = cint(result or (0 shl 0))
      of GIT_DIFF_BINARY_LITERAL: result = cint(result or (1 shl 0))
      of GIT_DIFF_BINARY_DELTA:   result = cint(result or (1 shl 1))


proc to_c_git_diff_line_t*(arg: git_diff_line_t): c_git_diff_line_t =
  case arg:
    of GIT_DIFF_LINE_CONTEXT: c_GIT_DIFF_LINE_CONTEXT


converter to_git_diff_line_t*(arg: c_git_diff_line_t): git_diff_line_t =
  case arg:
    of c_GIT_DIFF_LINE_CONTEXT: GIT_DIFF_LINE_CONTEXT


converter toCint*(arg: c_git_diff_line_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_diff_line_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_diff_line_t(arg)))

func `+`*(arg: c_git_diff_line_t, offset: int): c_git_diff_line_t =
  cast[c_git_diff_line_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_line_t): c_git_diff_line_t =
  cast[c_git_diff_line_t](ord(arg) + offset)

func `-`*(arg: c_git_diff_line_t, offset: int): c_git_diff_line_t =
  cast[c_git_diff_line_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_line_t): c_git_diff_line_t =
  cast[c_git_diff_line_t](ord(arg) - offset)


proc to_c_git_diff_find_t*(arg: git_diff_find_t): c_git_diff_find_t =
  case arg:
    of GIT_DIFF_FIND_BY_CONFIG:                  c_GIT_DIFF_FIND_BY_CONFIG
    of GIT_DIFF_FIND_RENAMES:                    c_GIT_DIFF_FIND_RENAMES
    of GIT_DIFF_FIND_RENAMES_FROM_REWRITES:      c_GIT_DIFF_FIND_RENAMES_FROM_REWRITES
    of GIT_DIFF_FIND_COPIES:                     c_GIT_DIFF_FIND_COPIES
    of GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED:     c_GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED
    of GIT_DIFF_FIND_REWRITES:                   c_GIT_DIFF_FIND_REWRITES
    of GIT_DIFF_BREAK_REWRITES:                  c_GIT_DIFF_BREAK_REWRITES
    of GIT_DIFF_FIND_AND_BREAK_REWRITES:         c_GIT_DIFF_FIND_AND_BREAK_REWRITES
    of GIT_DIFF_FIND_FOR_UNTRACKED:              c_GIT_DIFF_FIND_FOR_UNTRACKED
    of GIT_DIFF_FIND_IGNORE_WHITESPACE:          c_GIT_DIFF_FIND_IGNORE_WHITESPACE
    of GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE:     c_GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE
    of GIT_DIFF_FIND_EXACT_MATCH_ONLY:           c_GIT_DIFF_FIND_EXACT_MATCH_ONLY
    of GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY: c_GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY
    of GIT_DIFF_FIND_REMOVE_UNMODIFIED:          c_GIT_DIFF_FIND_REMOVE_UNMODIFIED


converter to_git_diff_find_t*(arg: c_git_diff_find_t): git_diff_find_t =
  case arg:
    of c_GIT_DIFF_FIND_BY_CONFIG:                  GIT_DIFF_FIND_BY_CONFIG
    of c_GIT_DIFF_FIND_RENAMES:                    GIT_DIFF_FIND_RENAMES
    of c_GIT_DIFF_FIND_RENAMES_FROM_REWRITES:      GIT_DIFF_FIND_RENAMES_FROM_REWRITES
    of c_GIT_DIFF_FIND_COPIES:                     GIT_DIFF_FIND_COPIES
    of c_GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED:     GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED
    of c_GIT_DIFF_FIND_REWRITES:                   GIT_DIFF_FIND_REWRITES
    of c_GIT_DIFF_BREAK_REWRITES:                  GIT_DIFF_BREAK_REWRITES
    of c_GIT_DIFF_FIND_AND_BREAK_REWRITES:         GIT_DIFF_FIND_AND_BREAK_REWRITES
    of c_GIT_DIFF_FIND_FOR_UNTRACKED:              GIT_DIFF_FIND_FOR_UNTRACKED
    of c_GIT_DIFF_FIND_IGNORE_WHITESPACE:          GIT_DIFF_FIND_IGNORE_WHITESPACE
    of c_GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE:     GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE
    of c_GIT_DIFF_FIND_EXACT_MATCH_ONLY:           GIT_DIFF_FIND_EXACT_MATCH_ONLY
    of c_GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY: GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY
    of c_GIT_DIFF_FIND_REMOVE_UNMODIFIED:          GIT_DIFF_FIND_REMOVE_UNMODIFIED


converter toCint*(arg: c_git_diff_find_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_diff_find_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_diff_find_t(arg)))

func `+`*(arg: c_git_diff_find_t, offset: int): c_git_diff_find_t =
  cast[c_git_diff_find_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_find_t): c_git_diff_find_t =
  cast[c_git_diff_find_t](ord(arg) + offset)

func `-`*(arg: c_git_diff_find_t, offset: int): c_git_diff_find_t =
  cast[c_git_diff_find_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_find_t): c_git_diff_find_t =
  cast[c_git_diff_find_t](ord(arg) - offset)


proc git_diff_find_options_init*(
    opts:    ptr git_diff_find_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_diff_free*(diff: ptr git_diff): void {.git2Proc, importc.}



proc git_diff_tree_to_tree*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    new_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.git2Proc, importc.}



proc git_diff_tree_to_index*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    index:    ptr git_index,
    opts:     ptr git_diff_options
  ): cint {.git2Proc, importc.}



proc git_diff_index_to_workdir*(
    diff:  ptr ptr git_diff,
    repo:  ptr git_repository,
    index: ptr git_index,
    opts:  ptr git_diff_options
  ): cint {.git2Proc, importc.}



proc git_diff_tree_to_workdir*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.git2Proc, importc.}



proc git_diff_tree_to_workdir_with_index*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.git2Proc, importc.}



proc git_diff_index_to_index*(
    diff:      ptr ptr git_diff,
    repo:      ptr git_repository,
    old_index: ptr git_index,
    new_index: ptr git_index,
    opts:      ptr git_diff_options
  ): cint {.git2Proc, importc.}



proc git_diff_merge*(
    onto:     ptr git_diff,
    arg_from: ptr git_diff
  ): cint {.git2Proc, importc.}



proc git_diff_find_similar*(
    diff:    ptr git_diff,
    options: ptr git_diff_find_options
  ): cint {.git2Proc, importc.}



proc git_diff_num_deltas*(diff: ptr git_diff): csize_t {.git2Proc, importc.}



proc git_diff_num_deltas_of_type*(
    diff:   ptr git_diff,
    type_f: c_git_delta_t
  ): csize_t {.git2Proc, importc.}



proc git_diff_get_delta*(
    diff: ptr git_diff,
    idx:  csize_t
  ): ptr git_diff_delta {.git2Proc, importc.}



proc git_diff_is_sorted_icase*(diff: ptr git_diff): cint {.git2Proc, importc.}



proc git_diff_foreach*(
    diff:      ptr git_diff,
    file_cb:   git_diff_file_cb,
    binary_cb: git_diff_binary_cb,
    hunk_cb:   git_diff_hunk_cb,
    line_cb:   git_diff_line_cb,
    payload:   pointer
  ): cint {.git2Proc, importc.}



proc git_diff_status_char*(status: c_git_delta_t): char {.git2Proc, importc.}



proc to_c_git_diff_format_t*(arg: git_diff_format_t): c_git_diff_format_t =
  case arg:
    of GIT_DIFF_FORMAT_PATCH:        c_GIT_DIFF_FORMAT_PATCH
    of GIT_DIFF_FORMAT_PATCH_HEADER: c_GIT_DIFF_FORMAT_PATCH_HEADER
    of GIT_DIFF_FORMAT_RAW:          c_GIT_DIFF_FORMAT_RAW
    of GIT_DIFF_FORMAT_NAME_ONLY:    c_GIT_DIFF_FORMAT_NAME_ONLY
    of GIT_DIFF_FORMAT_NAME_STATUS:  c_GIT_DIFF_FORMAT_NAME_STATUS
    of GIT_DIFF_FORMAT_PATCH_ID:     c_GIT_DIFF_FORMAT_PATCH_ID


converter to_git_diff_format_t*(arg: c_git_diff_format_t): git_diff_format_t =
  case arg:
    of c_GIT_DIFF_FORMAT_PATCH:        GIT_DIFF_FORMAT_PATCH
    of c_GIT_DIFF_FORMAT_PATCH_HEADER: GIT_DIFF_FORMAT_PATCH_HEADER
    of c_GIT_DIFF_FORMAT_RAW:          GIT_DIFF_FORMAT_RAW
    of c_GIT_DIFF_FORMAT_NAME_ONLY:    GIT_DIFF_FORMAT_NAME_ONLY
    of c_GIT_DIFF_FORMAT_NAME_STATUS:  GIT_DIFF_FORMAT_NAME_STATUS
    of c_GIT_DIFF_FORMAT_PATCH_ID:     GIT_DIFF_FORMAT_PATCH_ID


converter toCint*(arg: c_git_diff_format_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_diff_format_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_diff_format_t(arg)))

func `+`*(arg: c_git_diff_format_t, offset: int): c_git_diff_format_t =
  cast[c_git_diff_format_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_diff_format_t): c_git_diff_format_t =
  cast[c_git_diff_format_t](ord(arg) + offset)

func `-`*(arg: c_git_diff_format_t, offset: int): c_git_diff_format_t =
  cast[c_git_diff_format_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_diff_format_t): c_git_diff_format_t =
  cast[c_git_diff_format_t](ord(arg) - offset)


proc git_diff_print*(
    diff:     ptr git_diff,
    format:   c_git_diff_format_t,
    print_cb: git_diff_line_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_diff_to_buf*(
    arg_out: ptr git_buf,
    diff:    ptr git_diff,
    format:  c_git_diff_format_t
  ): cint {.git2Proc, importc.}



proc git_diff_blobs*(
    old_blob:    ptr git_blob,
    old_as_path: cstring,
    new_blob:    ptr git_blob,
    new_as_path: cstring,
    options:     ptr git_diff_options,
    file_cb:     git_diff_file_cb,
    binary_cb:   git_diff_binary_cb,
    hunk_cb:     git_diff_hunk_cb,
    line_cb:     git_diff_line_cb,
    payload:     pointer
  ): cint {.git2Proc, importc.}



proc git_diff_blob_to_buffer*(
    old_blob:       ptr git_blob,
    old_as_path:    cstring,
    buffer:         cstring,
    buffer_len:     csize_t,
    buffer_as_path: cstring,
    options:        ptr git_diff_options,
    file_cb:        git_diff_file_cb,
    binary_cb:      git_diff_binary_cb,
    hunk_cb:        git_diff_hunk_cb,
    line_cb:        git_diff_line_cb,
    payload:        pointer
  ): cint {.git2Proc, importc.}



proc git_diff_buffers*(
    old_buffer:  pointer,
    old_len:     csize_t,
    old_as_path: cstring,
    new_buffer:  pointer,
    new_len:     csize_t,
    new_as_path: cstring,
    options:     ptr git_diff_options,
    file_cb:     git_diff_file_cb,
    binary_cb:   git_diff_binary_cb,
    hunk_cb:     git_diff_hunk_cb,
    line_cb:     git_diff_line_cb,
    payload:     pointer
  ): cint {.git2Proc, importc.}



proc git_diff_from_buffer*(
    arg_out:     ptr ptr git_diff,
    content:     cstring,
    content_len: csize_t
  ): cint {.git2Proc, importc.}



proc to_c_git_diff_stats_format_t*(
    arg: git_diff_stats_format_t
  ): c_git_diff_stats_format_t =
  case arg:
    of GIT_DIFF_STATS_NONE:            c_GIT_DIFF_STATS_NONE
    of GIT_DIFF_STATS_FULL:            c_GIT_DIFF_STATS_FULL
    of GIT_DIFF_STATS_SHORT:           c_GIT_DIFF_STATS_SHORT
    of GIT_DIFF_STATS_NUMBER:          c_GIT_DIFF_STATS_NUMBER
    of GIT_DIFF_STATS_INCLUDE_SUMMARY: c_GIT_DIFF_STATS_INCLUDE_SUMMARY


converter to_git_diff_stats_format_t*(
    arg: c_git_diff_stats_format_t
  ): git_diff_stats_format_t =
  case arg:
    of c_GIT_DIFF_STATS_NONE:            GIT_DIFF_STATS_NONE
    of c_GIT_DIFF_STATS_FULL:            GIT_DIFF_STATS_FULL
    of c_GIT_DIFF_STATS_SHORT:           GIT_DIFF_STATS_SHORT
    of c_GIT_DIFF_STATS_NUMBER:          GIT_DIFF_STATS_NUMBER
    of c_GIT_DIFF_STATS_INCLUDE_SUMMARY: GIT_DIFF_STATS_INCLUDE_SUMMARY


converter toCint*(arg: c_git_diff_stats_format_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_diff_stats_format_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_diff_stats_format_t(arg)))

func `+`*(
    arg:    c_git_diff_stats_format_t,
    offset: int
  ): c_git_diff_stats_format_t =
  cast[c_git_diff_stats_format_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_diff_stats_format_t
  ): c_git_diff_stats_format_t =
  cast[c_git_diff_stats_format_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_diff_stats_format_t,
    offset: int
  ): c_git_diff_stats_format_t =
  cast[c_git_diff_stats_format_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_diff_stats_format_t
  ): c_git_diff_stats_format_t =
  cast[c_git_diff_stats_format_t](ord(arg) - offset)


converter toCint*(args: set[git_diff_stats_format_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_DIFF_STATS_NONE:            result = cint(result or (0 shl 0))
      of GIT_DIFF_STATS_FULL:            result = cint(result or (1 shl 0))
      of GIT_DIFF_STATS_SHORT:           result = cint(result or (1 shl 1))
      of GIT_DIFF_STATS_NUMBER:          result = cint(result or (1 shl 2))
      of GIT_DIFF_STATS_INCLUDE_SUMMARY: result = cint(result or (1 shl 3))


proc git_diff_get_stats*(
    arg_out: ptr ptr git_diff_stats,
    diff:    ptr git_diff
  ): cint {.git2Proc, importc.}



proc git_diff_stats_files_changed*(
    stats: ptr git_diff_stats
  ): csize_t {.git2Proc, importc.}



proc git_diff_stats_insertions*(
    stats: ptr git_diff_stats
  ): csize_t {.git2Proc, importc.}



proc git_diff_stats_deletions*(
    stats: ptr git_diff_stats
  ): csize_t {.git2Proc, importc.}



proc git_diff_stats_to_buf*(
    arg_out: ptr git_buf,
    stats:   ptr git_diff_stats,
    format:  c_git_diff_stats_format_t,
    width:   csize_t
  ): cint {.git2Proc, importc.}



proc git_diff_stats_free*(stats: ptr git_diff_stats): void {.git2Proc, importc.}



proc to_c_git_diff_format_email_flags_t*(
    arg: git_diff_format_email_flags_t
  ): c_git_diff_format_email_flags_t =
  case arg:
    of GIT_DIFF_FORMAT_EMAIL_NONE:                         c_GIT_DIFF_FORMAT_EMAIL_NONE
    of GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER: c_GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER


converter to_git_diff_format_email_flags_t*(
    arg: c_git_diff_format_email_flags_t
  ): git_diff_format_email_flags_t =
  case arg:
    of c_GIT_DIFF_FORMAT_EMAIL_NONE:                         GIT_DIFF_FORMAT_EMAIL_NONE
    of c_GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER: GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER


converter toCint*(arg: c_git_diff_format_email_flags_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_diff_format_email_flags_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_diff_format_email_flags_t(arg)))

func `+`*(
    arg:    c_git_diff_format_email_flags_t,
    offset: int
  ): c_git_diff_format_email_flags_t =
  cast[c_git_diff_format_email_flags_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_diff_format_email_flags_t
  ): c_git_diff_format_email_flags_t =
  cast[c_git_diff_format_email_flags_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_diff_format_email_flags_t,
    offset: int
  ): c_git_diff_format_email_flags_t =
  cast[c_git_diff_format_email_flags_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_diff_format_email_flags_t
  ): c_git_diff_format_email_flags_t =
  cast[c_git_diff_format_email_flags_t](ord(arg) - offset)


converter toCint*(args: set[git_diff_format_email_flags_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_DIFF_FORMAT_EMAIL_NONE:                         result = cint(result or (0 shl 0))
      of GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER: result = cint(result or (1 shl 0))


proc git_diff_format_email*(
    arg_out: ptr git_buf,
    diff:    ptr git_diff,
    opts:    ptr git_diff_format_email_options
  ): cint {.git2Proc, importc.}



proc git_diff_commit_as_email*(
    arg_out:       ptr git_buf,
    repo:          ptr git_repository,
    commit:        ptr git_commit,
    patch_no:      csize_t,
    total_patches: csize_t,
    flags:         uint32,
    diff_opts:     ptr git_diff_options
  ): cint {.git2Proc, importc.}



proc git_diff_format_email_options_init*(
    opts:    ptr git_diff_format_email_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_diff_patchid_options_init*(
    opts:    ptr git_diff_patchid_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_diff_patchid*(
    arg_out: ptr git_oid,
    diff:    ptr git_diff,
    opts:    ptr git_diff_patchid_options
  ): cint {.git2Proc, importc.}



