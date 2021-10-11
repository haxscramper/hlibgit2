{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./oid

import
  ./buffer

import
  ./strarray

type
  git_delta_t* = enum
    GIT_DELTA_UNMODIFIED = 0
    GIT_DELTA_ADDED = 1 ## no changes 
    GIT_DELTA_DELETED = 2 ## entry does not exist in old version 
    GIT_DELTA_MODIFIED = 3 ## entry does not exist in new version 
    GIT_DELTA_RENAMED = 4 ## entry content changed between old and new 
    GIT_DELTA_COPIED = 5 ## entry was renamed between old and new 
    GIT_DELTA_IGNORED = 6 ## entry was copied from another old entry 
    GIT_DELTA_UNTRACKED = 7 ## entry is ignored item in workdir 
    GIT_DELTA_TYPECHANGE = 8 ## entry is untracked item in workdir 
    GIT_DELTA_UNREADABLE = 9 ## type of entry changed between old and new 
    GIT_DELTA_CONFLICTED = 10 ## entry is unreadable 
   
  git_diff* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_diff_binary* {.bycopy, header: "<git2/diff.h>", importc.} = object
    contains_data*: cuint
    old_file*: git_diff_binary_file
    new_file*: git_diff_binary_file ## The contents of the old file. 
   
  git_diff_binary_cb* = proc(delta: ptr git_diff_delta, binary: ptr git_diff_binary, payload: pointer): cint{.cdecl.}
   
  git_diff_binary_cbNim* = proc(delta: ptr git_diff_delta, binary: ptr git_diff_binary): cint
   
  git_diff_binary_file* {.bycopy, header: "<git2/diff.h>", importc.} = object
    ## The contents of one of the files in a binary diff. 
    type_f* {.importc: "type".}: git_diff_binary_t ## The type of binary data for this file. 
    data*: cstring ## The binary data, deflated. 
    datalen*: csize_t ## The length of the binary data. 
    inflatedlen*: csize_t ## The length of the binary data after inflation. 
   
  git_diff_binary_t* = enum
    GIT_DIFF_BINARY_NONE = 0 ## There is no binary delta. 
    GIT_DIFF_BINARY_LITERAL = 1 ## The binary data is the literal contents of the file. 
    GIT_DIFF_BINARY_DELTA = 2 ## The binary data is the delta from one side to the other. 
   
  git_diff_delta* {.bycopy, header: "<git2/diff.h>", importc.} = object
    status*: git_delta_t
    flags*: uint32
    similarity*: uint16 ## git_diff_flag_t values 
    nfiles*: uint16 ## for RENAMED and COPIED, value 0-100 
    old_file*: git_diff_file ## number of files in this delta 
    new_file*: git_diff_file
   
  git_diff_file* {.bycopy, header: "<git2/diff.h>", importc.} = object
    ## entry in the index is conflicted 
    id*: git_oid
    path*: cstring
    size*: git_object_size_t
    flags*: uint32
    mode*: uint16
    id_abbrev*: uint16
   
  git_diff_file_cb* = proc(delta: ptr git_diff_delta, progress: cfloat, payload: pointer): cint{.cdecl.}
   
  git_diff_file_cbNim* = proc(delta: ptr git_diff_delta, progress: cfloat): cint
   
  git_diff_find_options* {.bycopy, header: "<git2/diff.h>", importc.} = object
    version*: cuint
    flags*: uint32
    rename_threshold*: uint16
    rename_from_rewrite_threshold*: uint16
    copy_threshold*: uint16
    break_rewrite_threshold*: uint16
    rename_limit*: csize_t
    metric*: ptr git_diff_similarity_metric
   
  git_diff_find_t* = enum
    GIT_DIFF_FIND_BY_CONFIG = 0 ## Obey `diff.renames`. Overridden by any other GIT_DIFF_FIND_... flag. 
    GIT_DIFF_FIND_RENAMES = 1 ## Look for renames? (`--find-renames`) 
    GIT_DIFF_FIND_RENAMES_FROM_REWRITES = 2 ## Consider old side of MODIFIED for renames? (`--break-rewrites=N`) 
    GIT_DIFF_FIND_COPIES = 4 ## Look for copies? (a la `--find-copies`). 
    GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = 8
    GIT_DIFF_FIND_REWRITES = 16 ## Mark significant rewrites for split (`--break-rewrites=/M`) 
    GIT_DIFF_BREAK_REWRITES = 32 ## Actually split large rewrites into delete/add pairs 
    GIT_DIFF_FIND_AND_BREAK_REWRITES = 48 ## Mark rewrites for split and break into delete/add pairs 
    GIT_DIFF_FIND_FOR_UNTRACKED = 64
    GIT_DIFF_FIND_IGNORE_WHITESPACE = 4096 ## Measure similarity ignoring all whitespace 
    GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = 8192 ## Measure similarity including all data 
    GIT_DIFF_FIND_EXACT_MATCH_ONLY = 16384 ## Measure similarity only by comparing SHAs (fast and cheap) 
    GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY = 32768
    GIT_DIFF_FIND_REMOVE_UNMODIFIED = 65536
   
  git_diff_flag_t* = enum
    GIT_DIFF_FLAG_BINARY = 1
    GIT_DIFF_FLAG_NOT_BINARY = 2 ## file(s) treated as binary data 
    GIT_DIFF_FLAG_VALID_ID = 4 ## file(s) treated as text data 
    GIT_DIFF_FLAG_EXISTS = 8 ## `id` value is known correct 
   
  git_diff_format_email_flags_t* = enum
    GIT_DIFF_FORMAT_EMAIL_NONE = 0 ## Normal patch, the default 
    GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = 1 ## Don't insert "[PATCH]" in the subject header
   
  git_diff_format_email_options* {.bycopy, header: "<git2/diff.h>", importc.} = object
    version*: cuint
    flags*: uint32 ## see `git_diff_format_email_flags_t` above 
    patch_no*: csize_t ## This patch number 
    total_patches*: csize_t ## Total number of patches in this series 
    id*: ptr git_oid ## id to use for the commit 
    summary*: cstring ## Summary of the change 
    body*: cstring ## Commit message's body 
    author*: ptr git_signature ## Author of the change 
   
  git_diff_format_t* = enum
    GIT_DIFF_FORMAT_PATCH = 1
    GIT_DIFF_FORMAT_PATCH_HEADER = 2 ## full git diff 
    GIT_DIFF_FORMAT_RAW = 3 ## just the file headers of patch 
    GIT_DIFF_FORMAT_NAME_ONLY = 4 ## like git diff --raw 
    GIT_DIFF_FORMAT_NAME_STATUS = 5 ## like git diff --name-only 
    GIT_DIFF_FORMAT_PATCH_ID = 6 ## like git diff --name-status 
   
  git_diff_hunk* {.bycopy, header: "<git2/diff.h>", importc.} = object
    ## The contents of the new file. 
    old_start*: cint
    old_lines*: cint ## Starting line number in old_file 
    new_start*: cint ## Number of lines in old_file 
    new_lines*: cint ## Starting line number in new_file 
    header_len*: csize_t ## Number of lines in new_file 
    header*: ptr UncheckedArray[char] ## Number of bytes in header text 
   
  git_diff_hunk_cb* = proc(delta: ptr git_diff_delta, hunk: ptr git_diff_hunk, payload: pointer): cint{.cdecl.}
   
  git_diff_hunk_cbNim* = proc(delta: ptr git_diff_delta, hunk: ptr git_diff_hunk): cint
   
  git_diff_line* {.bycopy, header: "<git2/diff.h>", importc.} = object
    ## For "Binary files x and y differ" 
    origin*: char
    old_lineno*: cint ## A git_diff_line_t value 
    new_lineno*: cint ## Line number in old file or -1 for added line 
    num_lines*: cint ## Line number in new file or -1 for deleted line 
    content_len*: csize_t ## Number of newline characters in content 
    content_offset*: git_off_t ## Number of bytes of data 
    content*: cstring ## Offset in the original file to the content 
   
  git_diff_line_cb* = proc(delta: ptr git_diff_delta, hunk: ptr git_diff_hunk, line: ptr git_diff_line, payload: pointer): cint{.cdecl.}
   
  git_diff_line_cbNim* = proc(delta: ptr git_diff_delta, hunk: ptr git_diff_hunk, line: ptr git_diff_line): cint
   
  git_diff_line_t* = enum
    GIT_DIFF_LINE_CONTEXT = 39 ## These values will be sent to `git_diff_line_cb` along with the line 
   
  git_diff_notify_cb* = proc(diff_so_far: ptr git_diff, delta_to_add: ptr git_diff_delta, matched_pathspec: cstring, payload: pointer): cint{.cdecl.}
   
  git_diff_notify_cbNim* = proc(diff_so_far: ptr git_diff, delta_to_add: ptr git_diff_delta, matched_pathspec: cstring): cint
   
  git_diff_option_t* = enum
    GIT_DIFF_NORMAL = 0 ## Normal diff, the default 
    GIT_DIFF_REVERSE = 1 ## Reverse the sides of the diff 
    GIT_DIFF_INCLUDE_IGNORED = 2 ## Include ignored files in the diff 
    GIT_DIFF_RECURSE_IGNORED_DIRS = 4
    GIT_DIFF_INCLUDE_UNTRACKED = 8 ## Include untracked files in the diff 
    GIT_DIFF_RECURSE_UNTRACKED_DIRS = 16
    GIT_DIFF_INCLUDE_UNMODIFIED = 32 ## Include unmodified files in the diff 
    GIT_DIFF_INCLUDE_TYPECHANGE = 64
    GIT_DIFF_INCLUDE_TYPECHANGE_TREES = 128
    GIT_DIFF_IGNORE_FILEMODE = 256 ## Ignore file mode changes 
    GIT_DIFF_IGNORE_SUBMODULES = 512 ## Treat all submodules as unmodified 
    GIT_DIFF_IGNORE_CASE = 1024 ## Use case insensitive filename comparisons 
    GIT_DIFF_INCLUDE_CASECHANGE = 2048
    GIT_DIFF_DISABLE_PATHSPEC_MATCH = 4096
    GIT_DIFF_SKIP_BINARY_CHECK = 8192
    GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS = 16384
    GIT_DIFF_UPDATE_INDEX = 32768
    GIT_DIFF_INCLUDE_UNREADABLE = 65536 ## Include unreadable files in the diff 
    GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = 131072 ## Include unreadable files in the diff 
    GIT_DIFF_INDENT_HEURISTIC = 262144
    GIT_DIFF_FORCE_TEXT = 1048576 ## Treat all files as text, disabling binary attributes & detection 
    GIT_DIFF_FORCE_BINARY = 2097152 ## Treat all files as binary, disabling text diffs 
    GIT_DIFF_IGNORE_WHITESPACE = 4194304 ## Ignore all whitespace 
    GIT_DIFF_IGNORE_WHITESPACE_CHANGE = 8388608 ## Ignore changes in amount of whitespace 
    GIT_DIFF_IGNORE_WHITESPACE_EOL = 16777216 ## Ignore whitespace at end of line 
    GIT_DIFF_SHOW_UNTRACKED_CONTENT = 33554432
    GIT_DIFF_SHOW_UNMODIFIED = 67108864
    GIT_DIFF_PATIENCE = 268435456 ## Use the "patience diff" algorithm 
    GIT_DIFF_MINIMAL = 536870912 ## Take extra time to find minimal diff 
    GIT_DIFF_SHOW_BINARY = 1073741824
   
  git_diff_options* {.bycopy, header: "<git2/diff.h>", importc.} = object
    version*: cuint
    flags*: uint32 ## version for the struct 
    ignore_submodules*: git_submodule_ignore_t ## options controlling which files are in the diff 
                                               ## Overrides the submodule ignore setting for all submodules in the diff. 
    pathspec*: git_strarray
    notify_cb*: git_diff_notify_cb
    progress_cb*: git_diff_progress_cb
    payload*: pointer ## The payload to pass to the callback functions. 
    context_lines*: uint32 ## options controlling how to diff text is generated 
    interhunk_lines*: uint32
    id_abbrev*: uint16
    max_size*: git_off_t
    old_prefix*: cstring
    new_prefix*: cstring
   
  git_diff_patchid_options* {.bycopy, header: "<git2/diff.h>", importc.} = object
    version*: cuint
   
  git_diff_progress_cb* = proc(diff_so_far: ptr git_diff, old_path: cstring, new_path: cstring, payload: pointer): cint{.cdecl.}
   
  git_diff_progress_cbNim* = proc(diff_so_far: ptr git_diff, old_path: cstring, new_path: cstring): cint
   
  git_diff_similarity_metric* {.bycopy, header: "<git2/diff.h>", importc.} = object
    file_signature*: proc(arg_out: ptr pointer, file: ptr git_diff_file, fullpath: cstring, payload: pointer): cint{.cdecl.}
    buffer_signature*: proc(arg_out: ptr pointer, file: ptr git_diff_file, buf: cstring, buflen: csize_t, payload: pointer): cint{.cdecl.}
    free_signature*: proc(sig: pointer, payload: pointer): void{.cdecl.}
    similarity*: proc(score: ptr cint, siga: pointer, sigb: pointer, payload: pointer): cint{.cdecl.}
    payload*: pointer
   
  git_diff_stats* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_diff_stats_format_t* = enum
    GIT_DIFF_STATS_NONE = 0 ## No stats
    GIT_DIFF_STATS_FULL = 1 ## Full statistics, equivalent of `--stat` 
    GIT_DIFF_STATS_SHORT = 2 ## Short statistics, equivalent of `--shortstat` 
    GIT_DIFF_STATS_NUMBER = 4 ## Number statistics, equivalent of `--numstat` 
    GIT_DIFF_STATS_INCLUDE_SUMMARY = 8 ## Extended header information such as creations, renames and mode changes, equivalent of `--summary` 
   

proc git_diff_options_init*(
    opts:    ptr git_diff_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_find_options_init*(
    opts:    ptr git_diff_find_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_free*(diff: ptr git_diff): void {.dynlib: libgitDl, importc.}


proc git_diff_tree_to_tree*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    new_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_tree_to_index*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    index:    ptr git_index,
    opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_index_to_workdir*(
    diff:  ptr ptr git_diff,
    repo:  ptr git_repository,
    index: ptr git_index,
    opts:  ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_tree_to_workdir*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_tree_to_workdir_with_index*(
    diff:     ptr ptr git_diff,
    repo:     ptr git_repository,
    old_tree: ptr git_tree,
    opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_index_to_index*(
    diff:      ptr ptr git_diff,
    repo:      ptr git_repository,
    old_index: ptr git_index,
    new_index: ptr git_index,
    opts:      ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_merge*(
    onto:     ptr git_diff,
    arg_from: ptr git_diff
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_find_similar*(
    diff:    ptr git_diff,
    options: ptr git_diff_find_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_num_deltas*(
    diff: ptr git_diff
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_diff_num_deltas_of_type*(
    diff:   ptr git_diff,
    type_f: git_delta_t
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_diff_get_delta*(
    diff: ptr git_diff,
    idx:  csize_t
  ): ptr git_diff_delta {.dynlib: libgitDl, importc.}


proc git_diff_is_sorted_icase*(
    diff: ptr git_diff
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_foreach*(
    diff:      ptr git_diff,
    file_cb:   git_diff_file_cb,
    binary_cb: git_diff_binary_cb,
    hunk_cb:   git_diff_hunk_cb,
    line_cb:   git_diff_line_cb,
    payload:   pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_status_char*(
    status: git_delta_t
  ): char {.dynlib: libgitDl, importc.}


proc git_diff_print*(
    diff:     ptr git_diff,
    format:   git_diff_format_t,
    print_cb: git_diff_line_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_to_buf*(
    arg_out: ptr git_buf,
    diff:    ptr git_diff,
    format:  git_diff_format_t
  ): cint {.dynlib: libgitDl, importc.}


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
  ): cint {.dynlib: libgitDl, importc.}


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
  ): cint {.dynlib: libgitDl, importc.}


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
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_from_buffer*(
    arg_out:     ptr ptr git_diff,
    content:     cstring,
    content_len: csize_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_get_stats*(
    arg_out: ptr ptr git_diff_stats,
    diff:    ptr git_diff
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_stats_files_changed*(
    stats: ptr git_diff_stats
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_diff_stats_insertions*(
    stats: ptr git_diff_stats
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_diff_stats_deletions*(
    stats: ptr git_diff_stats
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_diff_stats_to_buf*(
    arg_out: ptr git_buf,
    stats:   ptr git_diff_stats,
    format:  git_diff_stats_format_t,
    width:   csize_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_stats_free*(
    stats: ptr git_diff_stats
  ): void {.dynlib: libgitDl, importc.}


proc git_diff_format_email*(
    arg_out: ptr git_buf,
    diff:    ptr git_diff,
    opts:    ptr git_diff_format_email_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_commit_as_email*(
    arg_out:       ptr git_buf,
    repo:          ptr git_repository,
    commit:        ptr git_commit,
    patch_no:      csize_t,
    total_patches: csize_t,
    flags:         uint32,
    diff_opts:     ptr git_diff_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_format_email_options_init*(
    opts:    ptr git_diff_format_email_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_patchid_options_init*(
    opts:    ptr git_diff_patchid_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_diff_patchid*(
    arg_out: ptr git_oid,
    diff:    ptr git_diff,
    opts:    ptr git_diff_patchid_options
  ): cint {.dynlib: libgitDl, importc.}


