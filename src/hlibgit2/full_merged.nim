
type
  git_status_t* = enum
    GIT_STATUS_CURRENT = 0, GIT_STATUS_INDEX_NEW = 1,
    GIT_STATUS_INDEX_MODIFIED = 2, GIT_STATUS_INDEX_DELETED = 4,
    GIT_STATUS_INDEX_RENAMED = 8, GIT_STATUS_INDEX_TYPECHANGE = 16,
    GIT_STATUS_WT_NEW = 128, GIT_STATUS_WT_MODIFIED = 256,
    GIT_STATUS_WT_DELETED = 512, GIT_STATUS_WT_TYPECHANGE = 1024,
    GIT_STATUS_WT_RENAMED = 2048, GIT_STATUS_WT_UNREADABLE = 4096,
    GIT_STATUS_IGNORED = 16384, GIT_STATUS_CONFLICTED = 32768
  git_status_cb* = proc (path: cstring; status_flags: cuint; payload: pointer): cint {.
      cdecl.}
  git_status_cbNim* = proc (path: cstring; status_flags: cuint): cint
  git_status_show_t* = enum
    GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0, GIT_STATUS_SHOW_INDEX_ONLY = 1,
    GIT_STATUS_SHOW_WORKDIR_ONLY = 2
  git_status_opt_t* = enum
    GIT_STATUS_OPT_INCLUDE_UNTRACKED = 1, GIT_STATUS_OPT_INCLUDE_IGNORED = 2,
    GIT_STATUS_OPT_INCLUDE_UNMODIFIED = 4,
    GIT_STATUS_OPT_EXCLUDE_SUBMODULES = 8,
    GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS = 16,
    GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH = 32,
    GIT_STATUS_OPT_RECURSE_IGNORED_DIRS = 64,
    GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX = 128,
    GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR = 256,
    GIT_STATUS_OPT_SORT_CASE_SENSITIVELY = 512,
    GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY = 1024,
    GIT_STATUS_OPT_RENAMES_FROM_REWRITES = 2048,
    GIT_STATUS_OPT_NO_REFRESH = 4096, GIT_STATUS_OPT_UPDATE_INDEX = 8192,
    GIT_STATUS_OPT_INCLUDE_UNREADABLE = 16384,
    GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED = 32768
  git_status_options* {.bycopy, importc: "git_status_options".} = object
    version*: cuint
    show*: git_status_show_t ## The version 
    flags*: cuint
    pathspec*: git_strarray
    baseline*: ptr git_tree

  git_status_entry* {.bycopy, importc: "git_status_entry".} = object
    status*: git_status_t
    head_to_index*: ptr git_diff_delta
    index_to_workdir*: ptr git_diff_delta

  git_revert_options* {.bycopy, importc: "git_revert_options".} = object
    ## @} 
    version*: cuint
    mainline*: cuint         ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
  
  git_buf* {.bycopy, importc: "git_buf".} = object
    ## Options for the checkout 
                                                   ## @} 
    ptr*: cstring
    asize*: size_t
    size*: size_t

  git_tag_foreach_cb* = proc (name: cstring; oid: ptr git_oid; payload: pointer): cint {.
      cdecl.}
  git_tag_foreach_cbNim* = proc (name: cstring; oid: ptr git_oid): cint
  git_diff_option_t* = enum ## @} 
                             ## @}
    GIT_DIFF_NORMAL = 0,    ## Normal diff, the default 
    GIT_DIFF_REVERSE = 1,   ## Reverse the sides of the diff 
    GIT_DIFF_INCLUDE_IGNORED = 2, ## Include ignored files in the diff 
    GIT_DIFF_RECURSE_IGNORED_DIRS = 4, GIT_DIFF_INCLUDE_UNTRACKED = 8, ## Include untracked files in the diff 
    GIT_DIFF_RECURSE_UNTRACKED_DIRS = 16, GIT_DIFF_INCLUDE_UNMODIFIED = 32, ## Include unmodified files in the diff 
    GIT_DIFF_INCLUDE_TYPECHANGE = 64, GIT_DIFF_INCLUDE_TYPECHANGE_TREES = 128, GIT_DIFF_IGNORE_FILEMODE = 256, ## Ignore file mode changes 
    GIT_DIFF_IGNORE_SUBMODULES = 512, ## Treat all submodules as unmodified 
    GIT_DIFF_IGNORE_CASE = 1024, ## Use case insensitive filename comparisons 
    GIT_DIFF_INCLUDE_CASECHANGE = 2048, GIT_DIFF_DISABLE_PATHSPEC_MATCH = 4096,
    GIT_DIFF_SKIP_BINARY_CHECK = 8192,
    GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS = 16384, GIT_DIFF_UPDATE_INDEX = 32768, GIT_DIFF_INCLUDE_UNREADABLE = 65536, ## Include unreadable files in the diff 
    GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = 131072, ## Include unreadable files in the diff 
    GIT_DIFF_INDENT_HEURISTIC = 262144, GIT_DIFF_FORCE_TEXT = 1048576, ## Treat all files as text, disabling binary attributes & detection 
    GIT_DIFF_FORCE_BINARY = 2097152, ## Treat all files as binary, disabling text diffs 
    GIT_DIFF_IGNORE_WHITESPACE = 4194304, ## Ignore all whitespace 
    GIT_DIFF_IGNORE_WHITESPACE_CHANGE = 8388608, ## Ignore changes in amount of whitespace 
    GIT_DIFF_IGNORE_WHITESPACE_EOL = 16777216, ## Ignore whitespace at end of line 
    GIT_DIFF_SHOW_UNTRACKED_CONTENT = 33554432,
    GIT_DIFF_SHOW_UNMODIFIED = 67108864, GIT_DIFF_PATIENCE = 268435456, ## Use the "patience diff" algorithm 
    GIT_DIFF_MINIMAL = 536870912, ## Take extra time to find minimal diff 
    GIT_DIFF_SHOW_BINARY = 1073741824
  git_diff* {.bycopy, incompleteStruct.} = object
  
  git_diff_flag_t* = enum
    GIT_DIFF_FLAG_BINARY = 1, GIT_DIFF_FLAG_NOT_BINARY = 2, ## file(s) treated as binary data 
    GIT_DIFF_FLAG_VALID_ID = 4, ## file(s) treated as text data 
    GIT_DIFF_FLAG_EXISTS = 8 ## `id` value is known correct 
  git_delta_t* = enum       ## file exists at this side of the delta
    GIT_DELTA_UNMODIFIED = 0, GIT_DELTA_ADDED = 1, ## no changes 
    GIT_DELTA_DELETED = 2,  ## entry does not exist in old version 
    GIT_DELTA_MODIFIED = 3, ## entry does not exist in new version 
    GIT_DELTA_RENAMED = 4,  ## entry content changed between old and new 
    GIT_DELTA_COPIED = 5,   ## entry was renamed between old and new 
    GIT_DELTA_IGNORED = 6,  ## entry was copied from another old entry 
    GIT_DELTA_UNTRACKED = 7, ## entry is ignored item in workdir 
    GIT_DELTA_TYPECHANGE = 8, ## entry is untracked item in workdir 
    GIT_DELTA_UNREADABLE = 9, ## type of entry changed between old and new 
    GIT_DELTA_CONFLICTED = 10 ## entry is unreadable 
  git_diff_file* {.bycopy, importc: "git_diff_file".} = object
    ## entry in the index is conflicted 
    id*: git_oid
    path*: cstring
    size*: git_object_size_t
    flags*: uint32
    mode*: uint16
    id_abbrev*: uint16

  git_diff_delta* {.bycopy, importc: "git_diff_delta".} = object
    status*: git_delta_t
    flags*: uint32
    similarity*: uint16      ## git_diff_flag_t values 
    nfiles*: uint16          ## for RENAMED and COPIED, value 0-100 
    old_file*: git_diff_file ## number of files in this delta 
    new_file*: git_diff_file

  git_diff_notify_cb* = proc (diff_so_far: ptr git_diff;
                              delta_to_add: ptr git_diff_delta;
                              matched_pathspec: cstring; payload: pointer): cint {.
      cdecl.}
  git_diff_notify_cbNim* = proc (diff_so_far: ptr git_diff;
                                 delta_to_add: ptr git_diff_delta;
                                 matched_pathspec: cstring): cint
  git_diff_progress_cb* = proc (diff_so_far: ptr git_diff; old_path: cstring;
                                new_path: cstring; payload: pointer): cint {.
      cdecl.}
  git_diff_progress_cbNim* = proc (diff_so_far: ptr git_diff; old_path: cstring;
                                   new_path: cstring): cint
  git_diff_options* {.bycopy, importc: "git_diff_options".} = object
    version*: cuint
    flags*: uint32           ## version for the struct 
    ignore_submodules*: git_submodule_ignore_t ## options controlling which files are in the diff 
                                               ## Overrides the submodule ignore setting for all submodules in the diff. 
    pathspec*: git_strarray
    notify_cb*: git_diff_notify_cb
    progress_cb*: git_diff_progress_cb
    payload*: pointer        ## The payload to pass to the callback functions. 
    context_lines*: uint32   ## options controlling how to diff text is generated 
    interhunk_lines*: uint32
    id_abbrev*: uint16
    max_size*: git_off_t
    old_prefix*: cstring
    new_prefix*: cstring

  git_diff_file_cb* = proc (delta: ptr git_diff_delta; progress: cfloat;
                            payload: pointer): cint {.cdecl.}
  git_diff_file_cbNim* = proc (delta: ptr git_diff_delta; progress: cfloat): cint
  git_diff_binary_t* = enum ## The current version of the diff options structure
    GIT_DIFF_BINARY_NONE = 0, ## There is no binary delta. 
    GIT_DIFF_BINARY_LITERAL = 1, ## The binary data is the literal contents of the file. 
    GIT_DIFF_BINARY_DELTA = 2 ## The binary data is the delta from one side to the other. 
  git_diff_binary_file* {.bycopy, importc: "git_diff_binary_file".} = object
    ## The contents of one of the files in a binary diff. 
    type*: git_diff_binary_t ## The type of binary data for this file. 
    data*: cstring           ## The binary data, deflated. 
    datalen*: size_t         ## The length of the binary data. 
    inflatedlen*: size_t     ## The length of the binary data after inflation. 
  
  git_diff_binary* {.bycopy, importc: "git_diff_binary".} = object
    contains_data*: cuint
    old_file*: git_diff_binary_file
    new_file*: git_diff_binary_file ## The contents of the old file. 
  
  git_diff_binary_cb* = proc (delta: ptr git_diff_delta;
                              binary: ptr git_diff_binary; payload: pointer): cint {.
      cdecl.}
  git_diff_binary_cbNim* = proc (delta: ptr git_diff_delta;
                                 binary: ptr git_diff_binary): cint
  git_diff_hunk* {.bycopy, importc: "git_diff_hunk".} = object
    ## The contents of the new file. 
    old_start*: cint
    old_lines*: cint         ## Starting line number in old_file 
    new_start*: cint         ## Number of lines in old_file 
    new_lines*: cint         ## Starting line number in new_file 
    header_len*: size_t      ## Number of lines in new_file 
    header*: ptr UncheckedArray[char] ## Number of bytes in header text 
  
  git_diff_hunk_cb* = proc (delta: ptr git_diff_delta; hunk: ptr git_diff_hunk;
                            payload: pointer): cint {.cdecl.}
  git_diff_hunk_cbNim* = proc (delta: ptr git_diff_delta;
                               hunk: ptr git_diff_hunk): cint
  git_diff_line_t* = enum   ## Header text, NUL-byte terminated
    GIT_DIFF_LINE_CONTEXT = 39 ## These values will be sent to `git_diff_line_cb` along with the line 
  git_diff_line* {.bycopy, importc: "git_diff_line".} = object
    ## For "Binary files x and y differ" 
    origin*: char
    old_lineno*: cint        ## A git_diff_line_t value 
    new_lineno*: cint        ## Line number in old file or -1 for added line 
    num_lines*: cint         ## Line number in new file or -1 for deleted line 
    content_len*: size_t     ## Number of newline characters in content 
    content_offset*: git_off_t ## Number of bytes of data 
    content*: cstring        ## Offset in the original file to the content 
  
  git_diff_line_cb* = proc (delta: ptr git_diff_delta; hunk: ptr git_diff_hunk;
                            line: ptr git_diff_line; payload: pointer): cint {.
      cdecl.}
  git_diff_line_cbNim* = proc (delta: ptr git_diff_delta;
                               hunk: ptr git_diff_hunk; line: ptr git_diff_line): cint
  git_diff_find_t* = enum   ## Pointer to diff text, not NUL-byte terminated 
                             ## user reference data
    GIT_DIFF_FIND_BY_CONFIG = 0, ## Obey `diff.renames`. Overridden by any other GIT_DIFF_FIND_... flag. 
    GIT_DIFF_FIND_RENAMES = 1, ## Look for renames? (`--find-renames`) 
    GIT_DIFF_FIND_RENAMES_FROM_REWRITES = 2, ## Consider old side of MODIFIED for renames? (`--break-rewrites=N`) 
    GIT_DIFF_FIND_COPIES = 4, ## Look for copies? (a la `--find-copies`). 
    GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = 8, GIT_DIFF_FIND_REWRITES = 16, ## Mark significant rewrites for split (`--break-rewrites=/M`) 
    GIT_DIFF_BREAK_REWRITES = 32, ## Actually split large rewrites into delete/add pairs 
    GIT_DIFF_FIND_AND_BREAK_REWRITES = 48, ## Mark rewrites for split and break into delete/add pairs 
    GIT_DIFF_FIND_FOR_UNTRACKED = 64, GIT_DIFF_FIND_IGNORE_WHITESPACE = 4096, ## Measure similarity ignoring all whitespace 
    GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = 8192, ## Measure similarity including all data 
    GIT_DIFF_FIND_EXACT_MATCH_ONLY = 16384, ## Measure similarity only by comparing SHAs (fast and cheap) 
    GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY = 32768,
    GIT_DIFF_FIND_REMOVE_UNMODIFIED = 65536
  git_diff_similarity_metric* {.bycopy, importc: "git_diff_similarity_metric".} = object
    file_signature*: proc (out: ptr pointer; file: ptr git_diff_file;
                           fullpath: cstring; payload: pointer): cint {.cdecl.}
    buffer_signature*: proc (out: ptr pointer; file: ptr git_diff_file;
                             buf: cstring; buflen: size_t; payload: pointer): cint {.
        cdecl.}
    free_signature*: proc (sig: pointer; payload: pointer): void {.cdecl.}
    similarity*: proc (score: ptr cint; siga: pointer; sigb: pointer;
                       payload: pointer): cint {.cdecl.}
    payload*: pointer

  git_diff_find_options* {.bycopy, importc: "git_diff_find_options".} = object
    version*: cuint
    flags*: uint32
    rename_threshold*: uint16
    rename_from_rewrite_threshold*: uint16
    copy_threshold*: uint16
    break_rewrite_threshold*: uint16
    rename_limit*: size_t
    metric*: ptr git_diff_similarity_metric

  git_diff_format_t* = enum ## @{
                             ## @}
                             ## @{
    GIT_DIFF_FORMAT_PATCH = 1, GIT_DIFF_FORMAT_PATCH_HEADER = 2, ## full git diff 
    GIT_DIFF_FORMAT_RAW = 3, ## just the file headers of patch 
    GIT_DIFF_FORMAT_NAME_ONLY = 4, ## like git diff --raw 
    GIT_DIFF_FORMAT_NAME_STATUS = 5, ## like git diff --name-only 
    GIT_DIFF_FORMAT_PATCH_ID = 6 ## like git diff --name-status 
  git_diff_stats* {.bycopy, incompleteStruct.} = object
  
  git_diff_stats_format_t* = enum
    GIT_DIFF_STATS_NONE = 0, ## No stats
    GIT_DIFF_STATS_FULL = 1, ## Full statistics, equivalent of `--stat` 
    GIT_DIFF_STATS_SHORT = 2, ## Short statistics, equivalent of `--shortstat` 
    GIT_DIFF_STATS_NUMBER = 4, ## Number statistics, equivalent of `--numstat` 
    GIT_DIFF_STATS_INCLUDE_SUMMARY = 8 ## Extended header information such as creations, renames and mode changes, equivalent of `--summary` 
  git_diff_format_email_flags_t* = enum
    GIT_DIFF_FORMAT_EMAIL_NONE = 0, ## Normal patch, the default 
    GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = 1 ## Don't insert "[PATCH]" in the subject header
  git_diff_format_email_options* {.bycopy,
                                   importc: "git_diff_format_email_options".} = object
    version*: cuint
    flags*: uint32           ## see `git_diff_format_email_flags_t` above 
    patch_no*: size_t        ## This patch number 
    total_patches*: size_t   ## Total number of patches in this series 
    id*: ptr git_oid         ## id to use for the commit 
    summary*: cstring        ## Summary of the change 
    body*: cstring           ## Commit message's body 
    author*: ptr git_signature ## Author of the change 
  
  git_diff_patchid_options* {.bycopy, importc: "git_diff_patchid_options".} = object
    version*: cuint

  git_describe_strategy_t* = enum ## @}
    GIT_DESCRIBE_DEFAULT = 0, GIT_DESCRIBE_TAGS = 1, GIT_DESCRIBE_ALL = 2
  git_describe_options* {.bycopy, importc: "git_describe_options".} = object
    version*: cuint
    max_candidates_tags*: cuint
    describe_strategy*: cuint ## default: 10 
    pattern*: cstring        ## default: GIT_DESCRIBE_DEFAULT 
    only_follow_first_parent*: cint
    show_commit_oid_as_fallback*: cint

  git_describe_format_options* {.bycopy, importc: "git_describe_format_options".} = object
    version*: cuint
    abbreviated_size*: cuint
    always_use_long_format*: cint
    dirty_suffix*: cstring

  git_describe_result* {.bycopy, incompleteStruct.} = object
  
  git_repository_open_flag_t* = enum ## @}
    GIT_REPOSITORY_OPEN_NO_SEARCH = 1, GIT_REPOSITORY_OPEN_CROSS_FS = 2,
    GIT_REPOSITORY_OPEN_BARE = 4, GIT_REPOSITORY_OPEN_NO_DOTGIT = 8,
    GIT_REPOSITORY_OPEN_FROM_ENV = 16
  git_repository_init_flag_t* = enum
    GIT_REPOSITORY_INIT_BARE = 1, GIT_REPOSITORY_INIT_NO_REINIT = 2,
    GIT_REPOSITORY_INIT_NO_DOTGIT_DIR = 4, GIT_REPOSITORY_INIT_MKDIR = 8,
    GIT_REPOSITORY_INIT_MKPATH = 16, GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = 32,
    GIT_REPOSITORY_INIT_RELATIVE_GITLINK = 64
  git_repository_init_mode_t* = enum
    GIT_REPOSITORY_INIT_SHARED_UMASK = 0,
    GIT_REPOSITORY_INIT_SHARED_GROUP = 2775,
    GIT_REPOSITORY_INIT_SHARED_ALL = 2777
  git_repository_init_options* {.bycopy, importc: "git_repository_init_options".} = object
    version*: cuint
    flags*: uint32
    mode*: uint32
    workdir_path*: cstring
    description*: cstring
    template_path*: cstring
    initial_head*: cstring
    origin_url*: cstring

  git_repository_item_t* = enum
    GIT_REPOSITORY_ITEM_GITDIR = 0, GIT_REPOSITORY_ITEM_WORKDIR = 1,
    GIT_REPOSITORY_ITEM_COMMONDIR = 2, GIT_REPOSITORY_ITEM_INDEX = 3,
    GIT_REPOSITORY_ITEM_OBJECTS = 4, GIT_REPOSITORY_ITEM_REFS = 5,
    GIT_REPOSITORY_ITEM_PACKED_REFS = 6, GIT_REPOSITORY_ITEM_REMOTES = 7,
    GIT_REPOSITORY_ITEM_CONFIG = 8, GIT_REPOSITORY_ITEM_INFO = 9,
    GIT_REPOSITORY_ITEM_HOOKS = 10, GIT_REPOSITORY_ITEM_LOGS = 11,
    GIT_REPOSITORY_ITEM_MODULES = 12, GIT_REPOSITORY_ITEM_WORKTREES = 13,
    GIT_REPOSITORY_ITEM_LAST = 14
  git_repository_fetchhead_foreach_cb* = proc (ref_name: cstring;
      remote_url: cstring; oid: ptr git_oid; is_merge: cuint; payload: pointer): cint {.
      cdecl.}
  git_repository_fetchhead_foreach_cbNim* = proc (ref_name: cstring;
      remote_url: cstring; oid: ptr git_oid; is_merge: cuint): cint
  git_repository_mergehead_foreach_cb* = proc (oid: ptr git_oid;
      payload: pointer): cint {.cdecl.}
  git_repository_mergehead_foreach_cbNim* = proc (oid: ptr git_oid): cint
  git_repository_state_t* = enum
    GIT_REPOSITORY_STATE_NONE = 0, GIT_REPOSITORY_STATE_MERGE = 1,
    GIT_REPOSITORY_STATE_REVERT = 2, GIT_REPOSITORY_STATE_REVERT_SEQUENCE = 3,
    GIT_REPOSITORY_STATE_CHERRYPICK = 4,
    GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE = 5,
    GIT_REPOSITORY_STATE_BISECT = 6, GIT_REPOSITORY_STATE_REBASE = 7,
    GIT_REPOSITORY_STATE_REBASE_INTERACTIVE = 8,
    GIT_REPOSITORY_STATE_REBASE_MERGE = 9,
    GIT_REPOSITORY_STATE_APPLY_MAILBOX = 10,
    GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE = 11
  git_checkout_strategy_t* = enum ## @}
    GIT_CHECKOUT_NONE = 0, GIT_CHECKOUT_SAFE = 1, ## default is a dry run, no actual updates 
    GIT_CHECKOUT_FORCE = 2, GIT_CHECKOUT_RECREATE_MISSING = 4, ## Allow checkout to recreate missing files 
    GIT_CHECKOUT_ALLOW_CONFLICTS = 16, ## Allow checkout to make safe updates even if conflicts are found 
    GIT_CHECKOUT_REMOVE_UNTRACKED = 32, ## Remove untracked files not in index (that are not ignored) 
    GIT_CHECKOUT_REMOVE_IGNORED = 64, ## Remove ignored files not in index 
    GIT_CHECKOUT_UPDATE_ONLY = 128, ## Only update existing files, don't create new ones 
    GIT_CHECKOUT_DONT_UPDATE_INDEX = 256, GIT_CHECKOUT_NO_REFRESH = 512, ## Don't refresh index/config/etc before doing checkout 
    GIT_CHECKOUT_SKIP_UNMERGED = 1024, ## Allow checkout to skip unmerged files 
    GIT_CHECKOUT_USE_OURS = 2048, ## For unmerged files, checkout stage 2 from index 
    GIT_CHECKOUT_USE_THEIRS = 4096, ## For unmerged files, checkout stage 3 from index 
    GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = 8192, ## Treat pathspec as simple list of exact match file paths 
    GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = 262144, ## Ignore directories in use, they will be left empty 
    GIT_CHECKOUT_DONT_OVERWRITE_IGNORED = 524288, ## Don't overwrite ignored files that exist in the checkout target 
    GIT_CHECKOUT_CONFLICT_STYLE_MERGE = 1048576, ## Write normal merge files for conflicts 
    GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 = 2097152, ## Include common ancestor data in diff3 format files for conflicts 
    GIT_CHECKOUT_DONT_REMOVE_EXISTING = 4194304, ## Don't overwrite existing files or folders 
    GIT_CHECKOUT_DONT_WRITE_INDEX = 8388608, ## Normally checkout writes the index upon completion; this prevents that. 
    GIT_CHECKOUT_UPDATE_SUBMODULES = 65536, ## Recursively checkout submodules with same options (NOT IMPLEMENTED) 
    GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 131072 ## Recursively checkout submodules if HEAD moved in super repo (NOT IMPLEMENTED) 
  git_checkout_notify_t* = enum
    GIT_CHECKOUT_NOTIFY_NONE = 0, GIT_CHECKOUT_NOTIFY_CONFLICT = 1,
    GIT_CHECKOUT_NOTIFY_DIRTY = 2, GIT_CHECKOUT_NOTIFY_UPDATED = 4,
    GIT_CHECKOUT_NOTIFY_UNTRACKED = 8, GIT_CHECKOUT_NOTIFY_IGNORED = 16
  git_checkout_perfdata* {.bycopy, importc: "git_checkout_perfdata".} = object
    ## Checkout performance-reporting structure 
    mkdir_calls*: size_t
    stat_calls*: size_t
    chmod_calls*: size_t

  git_checkout_notify_cb* = proc (why: git_checkout_notify_t; path: cstring;
                                  baseline: ptr git_diff_file;
                                  target: ptr git_diff_file;
                                  workdir: ptr git_diff_file; payload: pointer): cint {.
      cdecl.}
  git_checkout_notify_cbNim* = proc (why: git_checkout_notify_t; path: cstring;
                                     baseline: ptr git_diff_file;
                                     target: ptr git_diff_file;
                                     workdir: ptr git_diff_file): cint
  git_checkout_progress_cb* = proc (path: cstring; completed_steps: size_t;
                                    total_steps: size_t; payload: pointer): void {.
      cdecl.}
  git_checkout_progress_cbNim* = proc (path: cstring; completed_steps: size_t;
                                       total_steps: size_t): void
  git_checkout_perfdata_cb* = proc (perfdata: ptr git_checkout_perfdata;
                                    payload: pointer): void {.cdecl.}
  git_checkout_perfdata_cbNim* = proc (perfdata: ptr git_checkout_perfdata): void
  git_checkout_options* {.bycopy, importc: "git_checkout_options".} = object
    ## Checkout notification callback function 
                                                                             ## Checkout progress notification function 
                                                                             ## Checkout perfdata notification function 
    version*: cuint
    checkout_strategy*: cuint ## The version 
    disable_filters*: cint   ## default will be a safe checkout 
    dir_mode*: cuint         ## don't apply filters like CRLF conversion 
    file_mode*: cuint        ## default is 0755 
    file_open_flags*: cint   ## default is 0644 or 0755 as dictated by blob 
    notify_flags*: cuint     ## default is O_CREAT | O_TRUNC | O_WRONLY 
    notify_cb*: git_checkout_notify_cb ## see `git_checkout_notify_t` above 
    notify_payload*: pointer ## Payload passed to notify_cb 
    progress_cb*: git_checkout_progress_cb ## Optional callback to notify the consumer of checkout progress. 
    progress_payload*: pointer ## Payload passed to progress_cb 
    paths*: git_strarray
    baseline*: ptr git_tree
    baseline_index*: ptr git_index
    target_directory*: cstring
    ancestor_label*: cstring ## alternative checkout path to workdir 
    our_label*: cstring      ## the name of the common ancestor side of conflicts 
    their_label*: cstring    ## the name of the "our" side of conflicts 
    perfdata_cb*: git_checkout_perfdata_cb ## the name of the "their" side of conflicts 
                                           ## Optional callback to notify the consumer of performance data. 
    perfdata_payload*: pointer ## Payload passed to perfdata_cb 
  
  git_stash_flags* = enum   ## @}
    GIT_STASH_DEFAULT = 0, GIT_STASH_KEEP_INDEX = 1,
    GIT_STASH_INCLUDE_UNTRACKED = 2, GIT_STASH_INCLUDE_IGNORED = 4
  git_stash_apply_flags* = enum ## Stash application flags.
    GIT_STASH_APPLY_DEFAULT = 0, GIT_STASH_APPLY_REINSTATE_INDEX = 1
  git_stash_apply_progress_t* = enum ## Stash apply progression states
    GIT_STASH_APPLY_PROGRESS_NONE = 0, GIT_STASH_APPLY_PROGRESS_LOADING_STASH = 1, ## Loading the stashed data from the object database. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX = 2, ## The stored index is being analyzed. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED = 3, ## The modified files are being analyzed. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED = 4, ## The untracked and ignored files are being analyzed. 
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = 5, ## The untracked files are being written to disk. 
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED = 6, ## The modified files are being written to disk. 
    GIT_STASH_APPLY_PROGRESS_DONE = 7 ## The stash was applied successfully. 
  git_stash_apply_progress_cb* = proc (progress: git_stash_apply_progress_t;
                                       payload: pointer): cint {.cdecl.}
  git_stash_apply_progress_cbNim* = proc (progress: git_stash_apply_progress_t): cint
  git_stash_apply_options* {.bycopy, importc: "git_stash_apply_options".} = object
    version*: cuint
    flags*: uint32           ## See `git_stash_apply_flags`, above. 
    checkout_options*: git_checkout_options ## Options to use when writing files to the working directory. 
    progress_cb*: git_stash_apply_progress_cb ## Optional callback to notify the consumer of application progress. 
    progress_payload*: pointer

  git_stash_cb* = proc (index: size_t; message: cstring; stash_id: ptr git_oid;
                        payload: pointer): cint {.cdecl.}
  git_stash_cbNim* = proc (index: size_t; message: cstring;
                           stash_id: ptr git_oid): cint
  git_direction* = enum     ## @} 
                             ## @}
    GIT_DIRECTION_FETCH = 0, GIT_DIRECTION_PUSH = 1
  git_remote_head* {.bycopy, importc: "git_remote_head".} = object
    local*: cint
    oid*: git_oid            ## available locally 
    loid*: git_oid
    name*: cstring
    symref_target*: cstring

  git_treebuilder_filter_cb* = proc (entry: ptr git_tree_entry; payload: pointer): cint {.
      cdecl.}
  git_treebuilder_filter_cbNim* = proc (entry: ptr git_tree_entry): cint
  git_treewalk_cb* = proc (root: cstring; entry: ptr git_tree_entry;
                           payload: pointer): cint {.cdecl.}
  git_treewalk_cbNim* = proc (root: cstring; entry: ptr git_tree_entry): cint
  git_treewalk_mode* = enum ## @} 
                             ## Callback for the tree traversal method 
                             ## Tree traversal modes
    GIT_TREEWALK_PRE = 0, GIT_TREEWALK_POST = 1 ## Pre-order 
  git_tree_update_t* = enum ## Post-order
    GIT_TREE_UPDATE_UPSERT = 0, ## Update or insert an entry at the specified path 
    GIT_TREE_UPDATE_REMOVE = 1 ## Remove an entry from the specified path 
  git_tree_update* {.bycopy, importc: "git_tree_update".} = object
    action*: git_tree_update_t ## Update action. If it's an removal, only the path is looked at 
    id*: git_oid             ## The entry's id 
    filemode*: git_filemode_t ## The filemode/kind of object 
    path*: cstring           ## The full path from the root tree 
  
  git_branch_iterator* {.bycopy, incompleteStruct.} = object
  
  git_blob_filter_flag_t* = enum ## @}
    GIT_BLOB_FILTER_CHECK_FOR_BINARY = 1, ## When set, filters will not be applied to binary files. 
    GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES = 2,
    GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD = 4
  git_blob_filter_options* {.bycopy, importc: "git_blob_filter_options".} = object
    version*: cint
    flags*: uint32           ## Flags to control the filtering process, see `git_blob_filter_flag_t` above 
  
  git_commit_signing_cb* = proc (signature: ptr git_buf;
                                 signature_field: ptr git_buf;
                                 commit_content: cstring; payload: pointer): cint {.
      cdecl.}
  git_commit_signing_cbNim* = proc (signature: ptr git_buf;
                                    signature_field: ptr git_buf;
                                    commit_content: cstring): cint
  git_attr_value_t* = enum  ## @} 
                             ## @} 
                             ## @}
    GIT_ATTR_VALUE_UNSPECIFIED = 0, GIT_ATTR_VALUE_TRUE = 1, ## The attribute has been left unspecified 
    GIT_ATTR_VALUE_FALSE = 2, ## The attribute has been set 
    GIT_ATTR_VALUE_STRING = 3 ## The attribute has been unset 
  git_attr_foreach_cb* = proc (name: cstring; value: cstring; payload: pointer): cint {.
      cdecl.}
  git_attr_foreach_cbNim* = proc (name: cstring; value: cstring): cint
  git_blame_flag_t* = enum  ## This attribute has a value 
                             ## @}
    GIT_BLAME_NORMAL = 0,   ## Normal blame, the default 
    GIT_BLAME_TRACK_COPIES_SAME_FILE = 1,
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = 2,
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = 4,
    GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = 8, GIT_BLAME_FIRST_PARENT = 16,
    GIT_BLAME_USE_MAILMAP = 32, GIT_BLAME_IGNORE_WHITESPACE = 64 ## Ignore whitespace differences 
  git_blame_options* {.bycopy, importc: "git_blame_options".} = object
    version*: cuint
    flags*: uint32           ## A combination of `git_blame_flag_t` 
    min_match_characters*: uint16
    newest_commit*: git_oid  ## The id of the newest commit to consider. The default is HEAD. 
    oldest_commit*: git_oid
    min_line*: size_t
    max_line*: size_t

  git_blame_hunk* {.bycopy, importc: "git_blame_hunk".} = object
    lines_in_hunk*: size_t
    final_commit_id*: git_oid
    final_start_line_number*: size_t
    final_signature*: ptr git_signature
    orig_commit_id*: git_oid
    orig_path*: cstring
    orig_start_line_number*: size_t
    orig_signature*: ptr git_signature
    boundary*: char

  git_blame* {.bycopy, incompleteStruct.} = object
  
  git_sort_t* = enum        ## @}
    GIT_SORT_NONE = 0, GIT_SORT_TOPOLOGICAL = 1, GIT_SORT_TIME = 2,
    GIT_SORT_REVERSE = 4
  git_revwalk_hide_cb* = proc (commit_id: ptr git_oid; payload: pointer): cint {.
      cdecl.}
  git_revwalk_hide_cbNim* = proc (commit_id: ptr git_oid): cint
  git_remote_create_flags* = enum ## @}
    GIT_REMOTE_CREATE_SKIP_INSTEADOF = 1, ## Ignore the repository apply.insteadOf configuration 
    GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 2 ## Don't build a fetchspec from the name if none is set 
  git_remote_create_options* {.bycopy, importc: "git_remote_create_options".} = object
    version*: cuint
    repository*: ptr git_repository
    name*: cstring
    fetchspec*: cstring      ## The fetchspec the remote should use. 
    flags*: cuint            ## Additional flags for the remote. See git_remote_create_flags. 
  
  git_remote_completion_t* = enum
    GIT_REMOTE_COMPLETION_DOWNLOAD = 0, GIT_REMOTE_COMPLETION_INDEXING = 1,
    GIT_REMOTE_COMPLETION_ERROR = 2
  git_push_transfer_progress_cb* = proc (current: cuint; total: cuint;
      bytes: size_t; payload: pointer): cint {.cdecl.}
  git_push_transfer_progress_cbNim* = proc (current: cuint; total: cuint;
      bytes: size_t): cint
  git_push_update* {.bycopy, importc: "git_push_update".} = object
    ## Push network progress notification function 
    src_refname*: cstring
    dst_refname*: cstring
    src*: git_oid
    dst*: git_oid

  git_push_negotiation* = proc (updates: ptr ptr git_push_update; len: size_t;
                                payload: pointer): cint {.cdecl.}
  git_push_negotiationNim* = proc (updates: ptr ptr git_push_update; len: size_t): cint
  git_push_update_reference_cb* = proc (refname: cstring; status: cstring;
                                        data: pointer): cint {.cdecl.}
  git_push_update_reference_cbNim* = proc (refname: cstring; status: cstring): cint
  git_url_resolve_cb* = proc (url_resolved: ptr git_buf; url: cstring;
                              direction: cint; payload: pointer): cint {.cdecl.}
  git_url_resolve_cbNim* = proc (url_resolved: ptr git_buf; url: cstring;
                                 direction: cint): cint
  git_remote_callbacks* {.bycopy, importc: "git_remote_callbacks".} = object
    version*: cuint
    sideband_progress*: git_transport_message_cb ## The version 
    completion*: proc (type: git_remote_completion_t; data: pointer): cint {.
        cdecl.}
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    transfer_progress*: git_indexer_progress_cb
    update_tips*: proc (refname: cstring; a: ptr git_oid; b: ptr git_oid;
                        data: pointer): cint {.cdecl.}
    pack_progress*: git_packbuilder_progress
    push_transfer_progress*: git_push_transfer_progress_cb
    push_update_reference*: git_push_update_reference_cb
    push_negotiation*: git_push_negotiation
    transport*: git_transport_cb
    payload*: pointer
    resolve_url*: git_url_resolve_cb

  git_fetch_prune_t* = enum ## Acceptable prune settings when fetching
    GIT_FETCH_PRUNE_UNSPECIFIED = 0, GIT_FETCH_PRUNE = 1, GIT_FETCH_NO_PRUNE = 2
  git_remote_autotag_option_t* = enum
    GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0, GIT_REMOTE_DOWNLOAD_TAGS_AUTO = 1,
    GIT_REMOTE_DOWNLOAD_TAGS_NONE = 2, GIT_REMOTE_DOWNLOAD_TAGS_ALL = 3
  git_fetch_options* {.bycopy, importc: "git_fetch_options".} = object
    version*: cint
    callbacks*: git_remote_callbacks
    prune*: git_fetch_prune_t
    update_fetchhead*: cint
    download_tags*: git_remote_autotag_option_t
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray

  git_push_options* {.bycopy, importc: "git_push_options".} = object
    version*: cuint
    pb_parallelism*: cuint
    callbacks*: git_remote_callbacks
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray

  git_indexer* {.bycopy, incompleteStruct.} = object
  
  git_indexer_progress* {.bycopy, importc: "git_indexer_progress".} = object
    total_objects*: cuint    ## number of objects in the packfile being indexed 
    indexed_objects*: cuint  ## received objects that have been hashed 
    received_objects*: cuint ## received_objects: objects which have been downloaded 
    local_objects*: cuint
    total_deltas*: cuint     ## number of deltas in the packfile being indexed 
    indexed_deltas*: cuint   ## received deltas that have been indexed 
    received_bytes*: size_t  ## size of the packfile received up to now 
  
  git_indexer_progress_cb* = proc (stats: ptr git_indexer_progress;
                                   payload: pointer): cint {.cdecl.}
  git_indexer_progress_cbNim* = proc (stats: ptr git_indexer_progress): cint
  git_indexer_options* {.bycopy, importc: "git_indexer_options".} = object
    version*: cuint
    progress_cb*: git_indexer_progress_cb ## progress_cb function to call with progress information 
    progress_cb_payload*: pointer ## progress_cb_payload payload for the progress callback 
    verify*: uchar           ## Do connectivity checks for the received pack 
  
  git_merge_file_input* {.bycopy, importc: "git_merge_file_input".} = object
    ## @} 
    version*: cuint
    ptr*: cstring            ## Pointer to the contents of the file. 
    size*: size_t            ## Size of the contents pointed to in `ptr`. 
    path*: cstring           ## File name of the conflicted file, or `NULL` to not merge the path. 
    mode*: cuint             ## File mode of the conflicted file, or `0` to not merge the mode. 
  
  git_merge_flag_t* = enum
    GIT_MERGE_FIND_RENAMES = 1, GIT_MERGE_FAIL_ON_CONFLICT = 2,
    GIT_MERGE_SKIP_REUC = 4, GIT_MERGE_NO_RECURSIVE = 8
  git_merge_file_favor_t* = enum
    GIT_MERGE_FILE_FAVOR_NORMAL = 0, GIT_MERGE_FILE_FAVOR_OURS = 1,
    GIT_MERGE_FILE_FAVOR_THEIRS = 2, GIT_MERGE_FILE_FAVOR_UNION = 3
  git_merge_file_flag_t* = enum
    GIT_MERGE_FILE_DEFAULT = 0, ## Defaults 
    GIT_MERGE_FILE_STYLE_MERGE = 1, ## Create standard conflicted merge files 
    GIT_MERGE_FILE_STYLE_DIFF3 = 2, ## Create diff3-style files 
    GIT_MERGE_FILE_SIMPLIFY_ALNUM = 4, ## Condense non-alphanumeric regions for simplified diff file 
    GIT_MERGE_FILE_IGNORE_WHITESPACE = 8, ## Ignore all whitespace 
    GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = 16, ## Ignore changes in amount of whitespace 
    GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL = 32, ## Ignore whitespace at end of line 
    GIT_MERGE_FILE_DIFF_PATIENCE = 64, ## Use the "patience diff" algorithm 
    GIT_MERGE_FILE_DIFF_MINIMAL = 128 ## Take extra time to find minimal diff 
  git_merge_file_options* {.bycopy, importc: "git_merge_file_options".} = object
    version*: cuint
    ancestor_label*: cstring
    our_label*: cstring
    their_label*: cstring
    favor*: git_merge_file_favor_t ## The file to favor in region conflicts. 
    flags*: uint32           ## see `git_merge_file_flag_t` above 
    marker_size*: cushort

  git_merge_file_result* {.bycopy, importc: "git_merge_file_result".} = object
    automergeable*: cuint
    path*: cstring
    mode*: cuint             ## The mode that the resultant merge file should use.  
    ptr*: cstring            ## The contents of the merge. 
    len*: size_t             ## The length of the merge contents. 
  
  git_merge_options* {.bycopy, importc: "git_merge_options".} = object
    version*: cuint
    flags*: uint32           ## See `git_merge_flag_t` above 
    rename_threshold*: cuint
    target_limit*: cuint
    metric*: ptr git_diff_similarity_metric ## Pluggable similarity metric; pass NULL to use internal metric 
    recursion_limit*: cuint
    default_driver*: cstring
    file_favor*: git_merge_file_favor_t
    file_flags*: uint32      ## see `git_merge_file_flag_t` above 
  
  git_merge_analysis_t* = enum
    GIT_MERGE_ANALYSIS_NONE = 0, ## No merge is possible.  (Unused.) 
    GIT_MERGE_ANALYSIS_NORMAL = 1, GIT_MERGE_ANALYSIS_UP_TO_DATE = 2,
    GIT_MERGE_ANALYSIS_FASTFORWARD = 4, GIT_MERGE_ANALYSIS_UNBORN = 8
  git_merge_preference_t* = enum
    GIT_MERGE_PREFERENCE_NONE = 0, GIT_MERGE_PREFERENCE_NO_FASTFORWARD = 1,
    GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = 2
  git_rebase_options* {.bycopy, importc: "git_rebase_options".} = object
    ## @} 
    version*: cuint
    quiet*: cint
    inmemory*: cint
    rewrite_notes_ref*: cstring
    merge_options*: git_merge_options
    checkout_options*: git_checkout_options
    signing_cb*: git_commit_signing_cb
    payload*: pointer

  git_rebase_operation_t* = enum
    GIT_REBASE_OPERATION_PICK = 0, GIT_REBASE_OPERATION_REWORD = 1,
    GIT_REBASE_OPERATION_EDIT = 2, GIT_REBASE_OPERATION_SQUASH = 3,
    GIT_REBASE_OPERATION_FIXUP = 4, GIT_REBASE_OPERATION_EXEC = 5
  git_rebase_operation* {.bycopy, importc: "git_rebase_operation".} = object
    ## Indicates that a rebase operation is not (yet) in progress. 
    type*: git_rebase_operation_t ## The type of rebase operation. 
    id*: git_oid
    exec*: cstring

  git_feature_t* = enum ## @} 
                         ## Declare a public function exported for application use. 
                         ## Declare a callback function for application use. 
                         ## Declare a function as deprecated. 
                         ## Declare a function's takes printf style arguments.
    GIT_FEATURE_THREADS = 1, GIT_FEATURE_HTTPS = 2, GIT_FEATURE_SSH = 4,
    GIT_FEATURE_NSEC = 8
  git_libgit2_opt_t* = enum
    GIT_OPT_GET_MWINDOW_SIZE = 0, GIT_OPT_SET_MWINDOW_SIZE = 1,
    GIT_OPT_GET_MWINDOW_MAPPED_LIMIT = 2, GIT_OPT_SET_MWINDOW_MAPPED_LIMIT = 3,
    GIT_OPT_GET_SEARCH_PATH = 4, GIT_OPT_SET_SEARCH_PATH = 5,
    GIT_OPT_SET_CACHE_OBJECT_LIMIT = 6, GIT_OPT_SET_CACHE_MAX_SIZE = 7,
    GIT_OPT_ENABLE_CACHING = 8, GIT_OPT_GET_CACHED_MEMORY = 9,
    GIT_OPT_GET_TEMPLATE_PATH = 10, GIT_OPT_SET_TEMPLATE_PATH = 11,
    GIT_OPT_SET_SSL_CERT_LOCATIONS = 12, GIT_OPT_SET_USER_AGENT = 13,
    GIT_OPT_ENABLE_STRICT_OBJECT_CREATION = 14,
    GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION = 15,
    GIT_OPT_SET_SSL_CIPHERS = 16, GIT_OPT_GET_USER_AGENT = 17,
    GIT_OPT_ENABLE_OFS_DELTA = 18, GIT_OPT_ENABLE_FSYNC_GITDIR = 19,
    GIT_OPT_GET_WINDOWS_SHAREMODE = 20, GIT_OPT_SET_WINDOWS_SHAREMODE = 21,
    GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION = 22, GIT_OPT_SET_ALLOCATOR = 23,
    GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY = 24, GIT_OPT_GET_PACK_MAX_OBJECTS = 25,
    GIT_OPT_SET_PACK_MAX_OBJECTS = 26,
    GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS = 27,
    GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE = 28,
    GIT_OPT_GET_MWINDOW_FILE_LIMIT = 29, GIT_OPT_SET_MWINDOW_FILE_LIMIT = 30
  git_oid* {.bycopy, importc: "git_oid".} = object
    ## @} 
                                                   ## Size (in bytes) of a raw/binary oid 
                                                   ## Size (in bytes) of a hex formatted oid 
                                                   ## Unique identity of any object (commit, tree, blob, tag). 
    id*: ptr UncheckedArray[uchar] ## raw binary formatted id 
  
  git_oid_shorten* {.bycopy, incompleteStruct.} = object
  
  git_filter_mode_t* = enum ## @}
    GIT_FILTER_TO_WORKTREE = 0, GIT_FILTER_TO_ODB = 1
  git_filter_flag_t* = enum
    GIT_FILTER_DEFAULT = 0, GIT_FILTER_ALLOW_UNSAFE = 1, ## Don't error for `safecrlf` violations, allow them to continue. 
    GIT_FILTER_NO_SYSTEM_ATTRIBUTES = 2, ## Don't load `/etc/gitattributes` (or the system equivalent) 
    GIT_FILTER_ATTRIBUTES_FROM_HEAD = 4 ## Load attributes from `.gitattributes` in the root of HEAD 
  git_filter* {.bycopy, incompleteStruct.} = object
  
  git_filter_list* {.bycopy, incompleteStruct.} = object
  
  git_config_level_t* = enum ## @}
    GIT_CONFIG_LEVEL_PROGRAMDATA = 1, ## System-wide on Windows, for compatibility with portable git 
    GIT_CONFIG_LEVEL_SYSTEM = 2, ## System-wide configuration file; /etc/gitconfig on Linux systems 
    GIT_CONFIG_LEVEL_XDG = 3, ## XDG compatible configuration file; typically ~/.config/git/config 
    GIT_CONFIG_LEVEL_GLOBAL = 4, GIT_CONFIG_LEVEL_LOCAL = 5,
    GIT_CONFIG_LEVEL_APP = 6, GIT_CONFIG_HIGHEST_LEVEL = -1
  git_config_entry* {.bycopy, importc: "git_config_entry".} = object
    name*: cstring
    value*: cstring          ## Name of the entry (normalised) 
    include_depth*: cuint    ## String value of the entry 
    level*: git_config_level_t ## Depth of includes where this variable was found 
    free*: proc (entry: ptr git_config_entry): void {.cdecl.} ## Which config file this was found in 
    payload*: pointer        ## Free function for this entry 
  
  git_config_foreach_cb* = proc (entry: ptr git_config_entry; payload: pointer): cint {.
      cdecl.}
  git_config_foreach_cbNim* = proc (entry: ptr git_config_entry): cint
  git_config_iterator* {.bycopy, incompleteStruct.} = object
  
  git_configmap_t* = enum
    GIT_CONFIGMAP_FALSE = 0, GIT_CONFIGMAP_TRUE = 1, GIT_CONFIGMAP_INT32 = 2,
    GIT_CONFIGMAP_STRING = 3
  git_configmap* {.bycopy, importc: "git_configmap".} = object
    type*: git_configmap_t
    str_match*: cstring
    map_value*: cint

  git_patch* {.bycopy, incompleteStruct.} = object
  
  git_transport_message_cb* = proc (str: cstring; len: cint; payload: pointer): cint {.
      cdecl.}
  git_transport_message_cbNim* = proc (str: cstring; len: cint): cint
  git_transport_cb* = proc (out: ptr ptr git_transport; owner: ptr git_remote;
                            param: pointer): cint {.cdecl.}
  git_transport_cbNim* = proc (out: ptr ptr git_transport; owner: ptr git_remote): cint
  git_note_foreach_cb* = proc (blob_id: ptr git_oid;
                               annotated_object_id: ptr git_oid;
                               payload: pointer): cint {.cdecl.}
  git_note_foreach_cbNim* = proc (blob_id: ptr git_oid;
                                  annotated_object_id: ptr git_oid): cint
  git_note_iterator* = git_iterator
  git_reference_foreach_cb* = proc (reference: ptr git_reference;
                                    payload: pointer): cint {.cdecl.}
  git_reference_foreach_cbNim* = proc (reference: ptr git_reference): cint
  git_reference_foreach_name_cb* = proc (name: cstring; payload: pointer): cint {.
      cdecl.}
  git_reference_foreach_name_cbNim* = proc (name: cstring): cint
  git_reference_format_t* = enum ## @} 
                                  ## @} 
                                  ## @}
    GIT_REFERENCE_FORMAT_NORMAL = 0, GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL = 1,
    GIT_REFERENCE_FORMAT_REFSPEC_PATTERN = 2,
    GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 4
  git_odb_foreach_cb* = proc (id: ptr git_oid; payload: pointer): cint {.cdecl.}
  git_odb_foreach_cbNim* = proc (id: ptr git_oid): cint
  git_odb_expand_id* {.bycopy, importc: "git_odb_expand_id".} = object
    ## @} 
                                                                       ## @} 
    id*: git_oid             ## The object ID to expand 
    length*: cushort
    type*: git_object_t

  git_oidarray* {.bycopy, importc: "git_oidarray".} = object
    ## @} 
                                                             ## Array of object ids 
    ids*: ptr git_oid
    count*: size_t

  git_strarray* {.bycopy, importc: "git_strarray".} = object
    ## @} 
                                                             ## Array of strings 
    strings*: ptr cstring
    count*: size_t

  git_off_t* = int64
  git_time_t* = int64
  git_object_size_t* = uint64
  git_object_t* = enum      ## Basic type (loose or packed) of any Git object.
    GIT_OBJECT_ANY = -2, GIT_OBJECT_INVALID = -1, ## Object can be any of the following 
    GIT_OBJECT_COMMIT = 1,  ## Object is invalid. 
    GIT_OBJECT_TREE = 2,    ## A commit object. 
    GIT_OBJECT_BLOB = 3,    ## A tree (directory listing) object. 
    GIT_OBJECT_TAG = 4,     ## A file revision object. 
    GIT_OBJECT_OFS_DELTA = 6, ## An annotated tag object. 
    GIT_OBJECT_REF_DELTA = 7 ## A delta, base is given by an offset. 
  git_odb* {.bycopy, incompleteStruct.} = object
  
  git_odb_backend* {.bycopy, incompleteStruct.} = object
  
  git_odb_object* {.bycopy, incompleteStruct.} = object
  
  git_refdb* {.bycopy, incompleteStruct.} = object
  
  git_refdb_backend* {.bycopy, incompleteStruct.} = object
  
  git_repository* {.bycopy, incompleteStruct.} = object
  
  git_worktree* {.bycopy, incompleteStruct.} = object
  
  git_object* {.bycopy, incompleteStruct.} = object
  
  git_revwalk* {.bycopy, incompleteStruct.} = object
  
  git_tag* {.bycopy, incompleteStruct.} = object
  
  git_blob* {.bycopy, incompleteStruct.} = object
  
  git_commit* {.bycopy, incompleteStruct.} = object
  
  git_tree_entry* {.bycopy, incompleteStruct.} = object
  
  git_tree* {.bycopy, incompleteStruct.} = object
  
  git_treebuilder* {.bycopy, incompleteStruct.} = object
  
  git_index* {.bycopy, incompleteStruct.} = object
  
  git_index_iterator* {.bycopy, incompleteStruct.} = object
  
  git_index_conflict_iterator* {.bycopy, incompleteStruct.} = object
  
  git_config* {.bycopy, incompleteStruct.} = object
  
  git_config_backend* {.bycopy, incompleteStruct.} = object
  
  git_reflog_entry* {.bycopy, incompleteStruct.} = object
  
  git_reflog* {.bycopy, incompleteStruct.} = object
  
  git_note* {.bycopy, incompleteStruct.} = object
  
  git_packbuilder* {.bycopy, incompleteStruct.} = object
  
  git_time* {.bycopy, importc: "git_time".} = object
    ## Time in a signature 
    time*: git_time_t
    offset*: cint            ## time in seconds from epoch 
    sign*: char              ## timezone offset, in minutes 
  
  git_signature* {.bycopy, importc: "git_signature".} = object
    ## indicator for questionable '-0000' offsets in signature 
                                                               ## An action signature (e.g. for committers, taggers, etc) 
    name*: cstring
    email*: cstring          ## full name of the author 
    when*: git_time          ## email of the author 
  
  git_reference* {.bycopy, incompleteStruct.} = object
  
  git_reference_iterator* {.bycopy, incompleteStruct.} = object
  
  git_transaction* {.bycopy, incompleteStruct.} = object
  
  git_annotated_commit* {.bycopy, incompleteStruct.} = object
  
  git_status_list* {.bycopy, incompleteStruct.} = object
  
  git_rebase* {.bycopy, incompleteStruct.} = object
  
  git_reference_t* = enum   ## Basic type of any Git reference.
    GIT_REFERENCE_INVALID = 0, GIT_REFERENCE_DIRECT = 1, ## Invalid reference 
    GIT_REFERENCE_SYMBOLIC = 2, ## A reference that points at an object id 
    GIT_REFERENCE_ALL = 3    ## A reference that points at another reference 
  git_branch_t* = enum      ## Basic type of any Git branch.
    GIT_BRANCH_LOCAL = 1, GIT_BRANCH_REMOTE = 2, GIT_BRANCH_ALL = 3
  git_filemode_t* = enum    ## Valid modes for index and tree entries.
    GIT_FILEMODE_UNREADABLE = 0, GIT_FILEMODE_TREE = 40000,
    GIT_FILEMODE_BLOB = 100644, GIT_FILEMODE_BLOB_EXECUTABLE = 100755,
    GIT_FILEMODE_LINK = 120000, GIT_FILEMODE_COMMIT = 160000
  git_refspec* {.bycopy, incompleteStruct.} = object
  
  git_remote* {.bycopy, incompleteStruct.} = object
  
  git_transport* {.bycopy, incompleteStruct.} = object
  
  git_push* {.bycopy, incompleteStruct.} = object
  
  git_submodule* {.bycopy, incompleteStruct.} = object
  
  git_submodule_update_t* = enum
    GIT_SUBMODULE_UPDATE_CHECKOUT = 1, GIT_SUBMODULE_UPDATE_REBASE = 2,
    GIT_SUBMODULE_UPDATE_MERGE = 3, GIT_SUBMODULE_UPDATE_NONE = 4,
    GIT_SUBMODULE_UPDATE_DEFAULT = 0
  git_submodule_ignore_t* = enum
    GIT_SUBMODULE_IGNORE_UNSPECIFIED = -1, GIT_SUBMODULE_IGNORE_NONE = 1, ## use the submodule's configuration 
    GIT_SUBMODULE_IGNORE_UNTRACKED = 2, ## any change or untracked == dirty 
    GIT_SUBMODULE_IGNORE_DIRTY = 3, ## dirty if tracked files change 
    GIT_SUBMODULE_IGNORE_ALL = 4 ## only dirty if HEAD moved 
  git_submodule_recurse_t* = enum ## never dirty
    GIT_SUBMODULE_RECURSE_NO = 0, GIT_SUBMODULE_RECURSE_YES = 1,
    GIT_SUBMODULE_RECURSE_ONDEMAND = 2
  git_writestream* {.bycopy, importc: "git_writestream".} = object
    ## A type to write in a streaming fashion, for example, for filters. 
    write*: proc (stream: ptr git_writestream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    close*: proc (stream: ptr git_writestream): cint {.cdecl.}
    free*: proc (stream: ptr git_writestream): void {.cdecl.}

  git_mailmap* {.bycopy, incompleteStruct.} = object
  
  git_credential_t* = enum  ## @}
    GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1, GIT_CREDENTIAL_SSH_KEY = 2,
    GIT_CREDENTIAL_SSH_CUSTOM = 4, GIT_CREDENTIAL_DEFAULT = 8,
    GIT_CREDENTIAL_SSH_INTERACTIVE = 16, GIT_CREDENTIAL_USERNAME = 32,
    GIT_CREDENTIAL_SSH_MEMORY = 64
  git_credential* {.bycopy, incompleteStruct.} = object
  
  git_credential_userpass_plaintext* {.bycopy, incompleteStruct.} = object
  
  git_credential_username* {.bycopy, incompleteStruct.} = object
  
  git_credential_default* = git_credential
  git_credential_ssh_key* {.bycopy, incompleteStruct.} = object
  
  git_credential_ssh_interactive* {.bycopy, incompleteStruct.} = object
  
  git_credential_ssh_custom* {.bycopy, incompleteStruct.} = object
  
  git_credential_acquire_cb* = proc (out: ptr ptr git_credential; url: cstring;
                                     username_from_url: cstring;
                                     allowed_types: cuint; payload: pointer): cint {.
      cdecl.}
  git_credential_acquire_cbNim* = proc (out: ptr ptr git_credential;
                                        url: cstring;
                                        username_from_url: cstring;
                                        allowed_types: cuint): cint
  LIBSSH2_SESSION* = LIBSSH2_SESSION
  LIBSSH2_USERAUTH_KBDINT_PROMPT* = LIBSSH2_USERAUTH_KBDINT_PROMPT
  LIBSSH2_USERAUTH_KBDINT_RESPONSE* = LIBSSH2_USERAUTH_KBDINT_RESPONSE
  git_credential_ssh_interactive_cb* = proc (name: cstring; name_len: cint;
      instruction: cstring; instruction_len: cint; num_prompts: cint;
      prompts: ptr LIBSSH2_USERAUTH_KBDINT_PROMPT;
      responses: ptr LIBSSH2_USERAUTH_KBDINT_RESPONSE; abstract: ptr pointer): void {.
      cdecl.}
  git_credential_sign_cb* = proc (session: ptr LIBSSH2_SESSION;
                                  sig: ptr ptr uchar; sig_len: ptr size_t;
                                  data: ptr uchar; data_len: size_t;
                                  abstract: ptr pointer): cint {.cdecl.}
  git_clone_local_t* = enum ## @}
    GIT_CLONE_LOCAL_AUTO = 0, GIT_CLONE_LOCAL = 1, GIT_CLONE_NO_LOCAL = 2,
    GIT_CLONE_LOCAL_NO_LINKS = 3
  git_remote_create_cb* = proc (out: ptr ptr git_remote;
                                repo: ptr git_repository; name: cstring;
                                url: cstring; payload: pointer): cint {.cdecl.}
  git_remote_create_cbNim* = proc (out: ptr ptr git_remote;
                                   repo: ptr git_repository; name: cstring;
                                   url: cstring): cint
  git_repository_create_cb* = proc (out: ptr ptr git_repository; path: cstring;
                                    bare: cint; payload: pointer): cint {.cdecl.}
  git_repository_create_cbNim* = proc (out: ptr ptr git_repository;
                                       path: cstring; bare: cint): cint
  git_clone_options* {.bycopy, importc: "git_clone_options".} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    bare*: cint
    local*: git_clone_local_t
    checkout_branch*: cstring
    repository_cb*: git_repository_create_cb
    repository_cb_payload*: pointer
    remote_cb*: git_remote_create_cb
    remote_cb_payload*: pointer

  git_cherrypick_options* {.bycopy, importc: "git_cherrypick_options".} = object
    ## @} 
                                                                                 ## These declarations have moved. 
    version*: cuint
    mainline*: cuint         ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
  
  git_index_time* {.bycopy, importc: "git_index_time".} = object
    ## Options for the checkout 
                                                                 ## @} 
                                                                 ## Time structure used in a git index entry 
    seconds*: int32
    nanoseconds*: uint32     ## nsec should not be stored as time_t compatible 
  
  git_index_entry* {.bycopy, importc: "git_index_entry".} = object
    ctime*: git_index_time
    mtime*: git_index_time
    dev*: uint32
    ino*: uint32
    mode*: uint32
    uid*: uint32
    gid*: uint32
    file_size*: uint32
    id*: git_oid
    flags*: uint16
    flags_extended*: uint16
    path*: cstring

  git_index_entry_flag_t* = enum
    GIT_INDEX_ENTRY_EXTENDED = 0
  git_index_entry_extended_flag_t* = enum
    GIT_INDEX_ENTRY_INTENT_TO_ADD = 8192, GIT_INDEX_ENTRY_SKIP_WORKTREE = 16384,
    GIT_INDEX_ENTRY_EXTENDED_FLAGS = 24576, GIT_INDEX_ENTRY_UPTODATE = 4
  git_index_capability_t* = enum ## Capabilities of system that affect index actions.
    GIT_INDEX_CAPABILITY_IGNORE_CASE = 1, GIT_INDEX_CAPABILITY_NO_FILEMODE = 2,
    GIT_INDEX_CAPABILITY_NO_SYMLINKS = 4, GIT_INDEX_CAPABILITY_FROM_OWNER = -1
  git_index_matched_path_cb* = proc (path: cstring; matched_pathspec: cstring;
                                     payload: pointer): cint {.cdecl.}
  git_index_matched_path_cbNim* = proc (path: cstring; matched_pathspec: cstring): cint
  git_index_add_option_t* = enum ## Callback for APIs that add/remove/update files matching pathspec 
                                  ## Flags for APIs that add files matching pathspec
    GIT_INDEX_ADD_DEFAULT = 0, GIT_INDEX_ADD_FORCE = 1,
    GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 2, GIT_INDEX_ADD_CHECK_PATHSPEC = 4
  git_index_stage_t* = enum ## Git index stage states
    GIT_INDEX_STAGE_ANY = -1, GIT_INDEX_STAGE_NORMAL = 0, ## A normal staged file in the index. 
    GIT_INDEX_STAGE_ANCESTOR = 1, ## The ancestor side of a conflict. 
    GIT_INDEX_STAGE_OURS = 2, ## The "ours" side of a conflict. 
    GIT_INDEX_STAGE_THEIRS = 3 ## The "theirs" side of a conflict. 
  git_trace_level_t* = enum ## @}
                             ## @{
                             ## Index entry manipulation 
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
    GIT_TRACE_NONE = 0,     ## No tracing will be performed. 
    GIT_TRACE_FATAL = 1,    ## Severe errors that may impact the program's execution 
    GIT_TRACE_ERROR = 2,    ## Errors that do not impact the program's execution 
    GIT_TRACE_WARN = 3,     ## Warnings that suggest abnormal data 
    GIT_TRACE_INFO = 4,     ## Informational messages about program execution 
    GIT_TRACE_DEBUG = 5,    ## Detailed data that allows for debugging 
    GIT_TRACE_TRACE = 6      ## Exceptionally detailed debugging data 
  git_trace_cb* = proc (level: git_trace_level_t; msg: cstring): void {.cdecl.}
  git_error_code* = enum    ## @} 
                             ## Generic return codes
    GIT_OK = 0, GIT_ERROR = -1, ## No error 
    GIT_ENOTFOUND = -3,     ## Generic error 
    GIT_EEXISTS = -4,       ## Requested object could not be found 
    GIT_EAMBIGUOUS = -5,    ## Object exists preventing operation 
    GIT_EBUFS = -6,         ## More than one object matches 
    GIT_EUSER = -7,         ## Output buffer too short to hold data 
    GIT_EBAREREPO = -8, GIT_EUNBORNBRANCH = -9, ## Operation not allowed on bare repository 
    GIT_EUNMERGED = -10,    ## HEAD refers to branch with no commits 
    GIT_ENONFASTFORWARD = -11, ## Merge in progress prevented operation 
    GIT_EINVALIDSPEC = -12, ## Reference was not fast-forwardable 
    GIT_ECONFLICT = -13,    ## Name/ref spec was not in a valid format 
    GIT_ELOCKED = -14,      ## Checkout conflicts prevented operation 
    GIT_EMODIFIED = -15,    ## Lock file prevented operation 
    GIT_EAUTH = -16,        ## Reference value does not match expected 
    GIT_ECERTIFICATE = -17, ## Authentication error 
    GIT_EAPPLIED = -18,     ## Server certificate is invalid 
    GIT_EPEEL = -19,        ## Patch/merge has already been applied 
    GIT_EEOF = -20,         ## The requested peel operation is not possible 
    GIT_EINVALID = -21,     ## Unexpected EOF 
    GIT_EUNCOMMITTED = -22, ## Invalid operation or input 
    GIT_EDIRECTORY = -23,   ## Uncommitted changes in index prevented operation 
    GIT_EMERGECONFLICT = -24, ## The operation is not valid for a directory 
    GIT_PASSTHROUGH = -30,  ## A merge conflict exists and cannot continue 
    GIT_ITEROVER = -31,     ## A user-configured callback refused to act 
    GIT_RETRY = -32,        ## Signals end of iteration with iterator 
    GIT_EMISMATCH = -33,    ## Internal only 
    GIT_EINDEXDIRTY = -34,  ## Hashsum mismatch in object 
    GIT_EAPPLYFAIL = -35     ## Unsaved changes in the index would be overwritten 
  git_error* {.bycopy, importc: "git_error".} = object
    ## Patch application failed 
    message*: cstring
    klass*: cint

  git_error_t* = enum       ## Error classes
    GIT_ERROR_NONE = 0, GIT_ERROR_NOMEMORY = 1, GIT_ERROR_OS = 2,
    GIT_ERROR_INVALID = 3, GIT_ERROR_REFERENCE = 4, GIT_ERROR_ZLIB = 5,
    GIT_ERROR_REPOSITORY = 6, GIT_ERROR_CONFIG = 7, GIT_ERROR_REGEX = 8,
    GIT_ERROR_ODB = 9, GIT_ERROR_INDEX = 10, GIT_ERROR_OBJECT = 11,
    GIT_ERROR_NET = 12, GIT_ERROR_TAG = 13, GIT_ERROR_TREE = 14,
    GIT_ERROR_INDEXER = 15, GIT_ERROR_SSL = 16, GIT_ERROR_SUBMODULE = 17,
    GIT_ERROR_THREAD = 18, GIT_ERROR_STASH = 19, GIT_ERROR_CHECKOUT = 20,
    GIT_ERROR_FETCHHEAD = 21, GIT_ERROR_MERGE = 22, GIT_ERROR_SSH = 23,
    GIT_ERROR_FILTER = 24, GIT_ERROR_REVERT = 25, GIT_ERROR_CALLBACK = 26,
    GIT_ERROR_CHERRYPICK = 27, GIT_ERROR_DESCRIBE = 28, GIT_ERROR_REBASE = 29,
    GIT_ERROR_FILESYSTEM = 30, GIT_ERROR_PATCH = 31, GIT_ERROR_WORKTREE = 32,
    GIT_ERROR_SHA1 = 33, GIT_ERROR_HTTP = 34, GIT_ERROR_INTERNAL = 35
  git_odb_stream_t* = enum  ## @} 
                             ## Streaming mode
    GIT_STREAM_RDONLY = 2, GIT_STREAM_WRONLY = 4, GIT_STREAM_RW = 6
  git_odb_stream* {.bycopy, importc: "git_odb_stream".} = object
    backend*: ptr git_odb_backend
    mode*: cuint
    hash_ctx*: pointer
    declared_size*: git_object_size_t
    received_bytes*: git_object_size_t
    read*: proc (stream: ptr git_odb_stream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    write*: proc (stream: ptr git_odb_stream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    finalize_write*: proc (stream: ptr git_odb_stream; oid: ptr git_oid): cint {.
        cdecl.}
    free*: proc (stream: ptr git_odb_stream): void {.cdecl.}

  git_odb_writepack* {.bycopy, importc: "git_odb_writepack".} = object
    ## A stream to write a pack file to the ODB 
    backend*: ptr git_odb_backend
    append*: proc (writepack: ptr git_odb_writepack; data: pointer;
                   size: size_t; stats: ptr git_indexer_progress): cint {.cdecl.}
    commit*: proc (writepack: ptr git_odb_writepack;
                   stats: ptr git_indexer_progress): cint {.cdecl.}
    free*: proc (writepack: ptr git_odb_writepack): void {.cdecl.}

  git_message_trailer* {.bycopy, importc: "git_message_trailer".} = object
    key*: cstring
    value*: cstring

  git_message_trailer_array* {.bycopy, importc: "git_message_trailer_array".} = object
    trailers*: ptr git_message_trailer
    count*: size_t
    trailer_block* {.importc: "_trailer_block".}: cstring ## private 
  
  git_credential_userpass_payload* {.bycopy,
                                     importc: "git_credential_userpass_payload".} = object
    ## @} 
    username*: cstring
    password*: cstring

  git_packbuilder_stage_t* = enum ## @} 
                                   ## @}
    GIT_PACKBUILDER_ADDING_OBJECTS = 0, GIT_PACKBUILDER_DELTAFICATION = 1
  git_packbuilder_foreach_cb* = proc (buf: pointer; size: size_t;
                                      payload: pointer): cint {.cdecl.}
  git_packbuilder_foreach_cbNim* = proc (buf: pointer; size: size_t): cint
  git_packbuilder_progress* = proc (stage: cint; current: uint32; total: uint32;
                                    payload: pointer): cint {.cdecl.}
  git_packbuilder_progressNim* = proc (stage: cint; current: uint32;
                                       total: uint32): cint
  git_pathspec* {.bycopy, incompleteStruct.} = object
  
  git_pathspec_match_list* {.bycopy, incompleteStruct.} = object
  
  git_pathspec_flag_t* = enum
    GIT_PATHSPEC_DEFAULT = 0, GIT_PATHSPEC_IGNORE_CASE = 1,
    GIT_PATHSPEC_USE_CASE = 2, GIT_PATHSPEC_NO_GLOB = 4,
    GIT_PATHSPEC_NO_MATCH_ERROR = 8, GIT_PATHSPEC_FIND_FAILURES = 16,
    GIT_PATHSPEC_FAILURES_ONLY = 32
  git_worktree_add_options* {.bycopy, importc: "git_worktree_add_options".} = object
    version*: cuint
    lock*: cint
    ref*: ptr git_reference  ## lock newly created worktree 
  
  git_worktree_prune_t* = enum ## reference to use for the new worktree HEAD
    GIT_WORKTREE_PRUNE_VALID = 1, ## Prune working tree even if working tree is valid 
    GIT_WORKTREE_PRUNE_LOCKED = 2, ## Prune working tree even if it is locked 
    GIT_WORKTREE_PRUNE_WORKING_TREE = 4 ## Prune checked out working tree 
  git_worktree_prune_options* {.bycopy, importc: "git_worktree_prune_options".} = object
    version*: cuint
    flags*: uint32

  git_proxy_t* = enum       ## @}
    GIT_PROXY_NONE = 0, GIT_PROXY_AUTO = 1, GIT_PROXY_SPECIFIED = 2
  git_proxy_options* {.bycopy, importc: "git_proxy_options".} = object
    version*: cuint
    type*: git_proxy_t
    url*: cstring
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    payload*: pointer

  git_reset_t* = enum
    GIT_RESET_SOFT = 1, GIT_RESET_MIXED = 2, ## Move the head to the given commit 
    GIT_RESET_HARD = 3       ## SOFT plus reset index to the commit 
  git_apply_delta_cb* = proc (delta: ptr git_diff_delta; payload: pointer): cint {.
      cdecl.}
  git_apply_delta_cbNim* = proc (delta: ptr git_diff_delta): cint
  git_apply_hunk_cb* = proc (hunk: ptr git_diff_hunk; payload: pointer): cint {.
      cdecl.}
  git_apply_hunk_cbNim* = proc (hunk: ptr git_diff_hunk): cint
  git_apply_flags_t* = enum ## MIXED plus changes in working tree discarded 
                             ## @} 
                             ## Flags controlling the behavior of git_apply
    GIT_APPLY_CHECK = 1
  git_apply_options* {.bycopy, importc: "git_apply_options".} = object
    version*: cuint
    delta_cb*: git_apply_delta_cb ## The version 
                                  ## When applying a patch, callback that will be made per delta (file). 
    hunk_cb*: git_apply_hunk_cb ## When applying a patch, callback that will be made per hunk. 
    payload*: pointer        ## Payload passed to both delta_cb & hunk_cb. 
    flags*: cuint            ## Bitmask of git_apply_flags_t 
  
  git_apply_location_t* = enum ## Possible application locations for git_apply
    GIT_APPLY_LOCATION_WORKDIR = 0, GIT_APPLY_LOCATION_INDEX = 1,
    GIT_APPLY_LOCATION_BOTH = 2
  git_revparse_mode_t* = enum ## @}
    GIT_REVPARSE_SINGLE = 1, ## The spec targeted a single object. 
    GIT_REVPARSE_RANGE = 2, ## The spec targeted a range of commits. 
    GIT_REVPARSE_MERGE_BASE = 4 ## The spec used the '...' operator, which invokes special semantics. 
  git_revspec* {.bycopy, importc: "git_revspec".} = object
    from*: ptr git_object    ## The left element of the revspec; must be freed by the user 
    to*: ptr git_object      ## The right element of the revspec; must be freed by the user 
    flags*: cuint            ## The intent of the revspec (i.e. `git_revparse_mode_t` flags) 
  
  git_attr_t* = git_attr_value_t
  git_cvar_map* = git_configmap
  git_cred* = git_credential
  git_cred_userpass_plaintext* = git_credential_userpass_plaintext
  git_cred_username* = git_credential_username
  git_cred_default* = git_credential_default
  git_cred_ssh_key* = git_credential_ssh_key
  git_cred_ssh_interactive* = git_credential_ssh_interactive
  git_cred_ssh_custom* = git_credential_ssh_custom
  git_cred_acquire_cb* = git_credential_acquire_cb
  git_cred_sign_callback* = git_credential_sign_cb
  git_cred_sign_cb* = git_credential_sign_cb
  git_cred_ssh_interactive_callback* = git_credential_ssh_interactive_cb
  git_cred_ssh_interactive_cb* = git_credential_ssh_interactive_cb
  git_cred_userpass_payload* = git_credential_userpass_payload
  git_trace_callback* = git_trace_cb
  git_transfer_progress* = git_indexer_progress
  git_transfer_progress_cb* = git_indexer_progress_cb
  git_push_transfer_progress* = git_push_transfer_progress_cb
  git_headlist_cb* = proc (rhead: ptr git_remote_head; payload: pointer): cint {.
      cdecl.}
  git_headlist_cbNim* = proc (rhead: ptr git_remote_head): cint
  git_cert_t* = enum        ## The type of a remote completion event 
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
                             ## @}
    GIT_CERT_NONE = 0, GIT_CERT_X509 = 1, GIT_CERT_HOSTKEY_LIBSSH2 = 2,
    GIT_CERT_STRARRAY = 3
  git_cert* {.bycopy, importc: "git_cert".} = object
    cert_type*: git_cert_t

  git_transport_certificate_check_cb* = proc (cert: ptr git_cert; valid: cint;
      host: cstring; payload: pointer): cint {.cdecl.}
  git_transport_certificate_check_cbNim* = proc (cert: ptr git_cert;
      valid: cint; host: cstring): cint
  git_cert_ssh_t* = enum
    GIT_CERT_SSH_MD5 = 1,   ## MD5 is available 
    GIT_CERT_SSH_SHA1 = 2,  ## SHA-1 is available 
    GIT_CERT_SSH_SHA256 = 4  ## SHA-256 is available 
  git_cert_hostkey* {.bycopy, importc: "git_cert_hostkey".} = object
    parent*: git_cert
    type*: git_cert_ssh_t    ## The parent cert 
    hash_md5*: ptr UncheckedArray[uchar]
    hash_sha1*: ptr UncheckedArray[uchar]
    hash_sha256*: ptr UncheckedArray[uchar]

  git_cert_x509* {.bycopy, importc: "git_cert_x509".} = object
    parent*: git_cert
    data*: pointer           ## The parent cert 
    len*: size_t

  git_submodule_status_t* = enum ## @}
    GIT_SUBMODULE_STATUS_IN_HEAD = 1, GIT_SUBMODULE_STATUS_IN_INDEX = 2,
    GIT_SUBMODULE_STATUS_IN_CONFIG = 4, GIT_SUBMODULE_STATUS_IN_WD = 8,
    GIT_SUBMODULE_STATUS_INDEX_ADDED = 16,
    GIT_SUBMODULE_STATUS_INDEX_DELETED = 32,
    GIT_SUBMODULE_STATUS_INDEX_MODIFIED = 64,
    GIT_SUBMODULE_STATUS_WD_UNINITIALIZED = 128,
    GIT_SUBMODULE_STATUS_WD_ADDED = 256, GIT_SUBMODULE_STATUS_WD_DELETED = 512,
    GIT_SUBMODULE_STATUS_WD_MODIFIED = 1024,
    GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = 2048,
    GIT_SUBMODULE_STATUS_WD_WD_MODIFIED = 4096,
    GIT_SUBMODULE_STATUS_WD_UNTRACKED = 8192
  git_submodule_cb* = proc (sm: ptr git_submodule; name: cstring;
                            payload: pointer): cint {.cdecl.}
  git_submodule_cbNim* = proc (sm: ptr git_submodule; name: cstring): cint
  git_submodule_update_options* {.bycopy,
                                  importc: "git_submodule_update_options".} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    allow_fetch*: cint

  git_status_t* = enum      ## @}
    GIT_STATUS_CURRENT = 0, GIT_STATUS_INDEX_NEW = 1,
    GIT_STATUS_INDEX_MODIFIED = 2, GIT_STATUS_INDEX_DELETED = 4,
    GIT_STATUS_INDEX_RENAMED = 8, GIT_STATUS_INDEX_TYPECHANGE = 16,
    GIT_STATUS_WT_NEW = 128, GIT_STATUS_WT_MODIFIED = 256,
    GIT_STATUS_WT_DELETED = 512, GIT_STATUS_WT_TYPECHANGE = 1024,
    GIT_STATUS_WT_RENAMED = 2048, GIT_STATUS_WT_UNREADABLE = 4096,
    GIT_STATUS_IGNORED = 16384, GIT_STATUS_CONFLICTED = 32768
  git_status_cb* = proc (path: cstring; status_flags: cuint; payload: pointer): cint {.
      cdecl.}
  git_status_cbNim* = proc (path: cstring; status_flags: cuint): cint
  git_status_show_t* = enum
    GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0, GIT_STATUS_SHOW_INDEX_ONLY = 1,
    GIT_STATUS_SHOW_WORKDIR_ONLY = 2
  git_status_opt_t* = enum
    GIT_STATUS_OPT_INCLUDE_UNTRACKED = 1, GIT_STATUS_OPT_INCLUDE_IGNORED = 2,
    GIT_STATUS_OPT_INCLUDE_UNMODIFIED = 4,
    GIT_STATUS_OPT_EXCLUDE_SUBMODULES = 8,
    GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS = 16,
    GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH = 32,
    GIT_STATUS_OPT_RECURSE_IGNORED_DIRS = 64,
    GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX = 128,
    GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR = 256,
    GIT_STATUS_OPT_SORT_CASE_SENSITIVELY = 512,
    GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY = 1024,
    GIT_STATUS_OPT_RENAMES_FROM_REWRITES = 2048,
    GIT_STATUS_OPT_NO_REFRESH = 4096, GIT_STATUS_OPT_UPDATE_INDEX = 8192,
    GIT_STATUS_OPT_INCLUDE_UNREADABLE = 16384,
    GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED = 32768
  git_status_options* {.bycopy, importc: "git_status_options".} = object
    version*: cuint
    show*: git_status_show_t ## The version 
    flags*: cuint
    pathspec*: git_strarray
    baseline*: ptr git_tree

  git_status_entry* {.bycopy, importc: "git_status_entry".} = object
    status*: git_status_t
    head_to_index*: ptr git_diff_delta
    index_to_workdir*: ptr git_diff_delta

  git_revert_options* {.bycopy, importc: "git_revert_options".} = object
    ## @} 
    version*: cuint
    mainline*: cuint         ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
  
  git_buf* {.bycopy, importc: "git_buf".} = object
    ## Options for the checkout 
                                                   ## @} 
    ptr*: cstring
    asize*: size_t
    size*: size_t

  git_tag_foreach_cb* = proc (name: cstring; oid: ptr git_oid; payload: pointer): cint {.
      cdecl.}
  git_tag_foreach_cbNim* = proc (name: cstring; oid: ptr git_oid): cint
  git_diff_option_t* = enum ## @} 
                             ## @}
    GIT_DIFF_NORMAL = 0,    ## Normal diff, the default 
    GIT_DIFF_REVERSE = 1,   ## Reverse the sides of the diff 
    GIT_DIFF_INCLUDE_IGNORED = 2, ## Include ignored files in the diff 
    GIT_DIFF_RECURSE_IGNORED_DIRS = 4, GIT_DIFF_INCLUDE_UNTRACKED = 8, ## Include untracked files in the diff 
    GIT_DIFF_RECURSE_UNTRACKED_DIRS = 16, GIT_DIFF_INCLUDE_UNMODIFIED = 32, ## Include unmodified files in the diff 
    GIT_DIFF_INCLUDE_TYPECHANGE = 64, GIT_DIFF_INCLUDE_TYPECHANGE_TREES = 128, GIT_DIFF_IGNORE_FILEMODE = 256, ## Ignore file mode changes 
    GIT_DIFF_IGNORE_SUBMODULES = 512, ## Treat all submodules as unmodified 
    GIT_DIFF_IGNORE_CASE = 1024, ## Use case insensitive filename comparisons 
    GIT_DIFF_INCLUDE_CASECHANGE = 2048, GIT_DIFF_DISABLE_PATHSPEC_MATCH = 4096,
    GIT_DIFF_SKIP_BINARY_CHECK = 8192,
    GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS = 16384, GIT_DIFF_UPDATE_INDEX = 32768, GIT_DIFF_INCLUDE_UNREADABLE = 65536, ## Include unreadable files in the diff 
    GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = 131072, ## Include unreadable files in the diff 
    GIT_DIFF_INDENT_HEURISTIC = 262144, GIT_DIFF_FORCE_TEXT = 1048576, ## Treat all files as text, disabling binary attributes & detection 
    GIT_DIFF_FORCE_BINARY = 2097152, ## Treat all files as binary, disabling text diffs 
    GIT_DIFF_IGNORE_WHITESPACE = 4194304, ## Ignore all whitespace 
    GIT_DIFF_IGNORE_WHITESPACE_CHANGE = 8388608, ## Ignore changes in amount of whitespace 
    GIT_DIFF_IGNORE_WHITESPACE_EOL = 16777216, ## Ignore whitespace at end of line 
    GIT_DIFF_SHOW_UNTRACKED_CONTENT = 33554432,
    GIT_DIFF_SHOW_UNMODIFIED = 67108864, GIT_DIFF_PATIENCE = 268435456, ## Use the "patience diff" algorithm 
    GIT_DIFF_MINIMAL = 536870912, ## Take extra time to find minimal diff 
    GIT_DIFF_SHOW_BINARY = 1073741824
  git_diff_flag_t* = enum
    GIT_DIFF_FLAG_BINARY = 1, GIT_DIFF_FLAG_NOT_BINARY = 2, ## file(s) treated as binary data 
    GIT_DIFF_FLAG_VALID_ID = 4, ## file(s) treated as text data 
    GIT_DIFF_FLAG_EXISTS = 8 ## `id` value is known correct 
  git_delta_t* = enum       ## file exists at this side of the delta
    GIT_DELTA_UNMODIFIED = 0, GIT_DELTA_ADDED = 1, ## no changes 
    GIT_DELTA_DELETED = 2,  ## entry does not exist in old version 
    GIT_DELTA_MODIFIED = 3, ## entry does not exist in new version 
    GIT_DELTA_RENAMED = 4,  ## entry content changed between old and new 
    GIT_DELTA_COPIED = 5,   ## entry was renamed between old and new 
    GIT_DELTA_IGNORED = 6,  ## entry was copied from another old entry 
    GIT_DELTA_UNTRACKED = 7, ## entry is ignored item in workdir 
    GIT_DELTA_TYPECHANGE = 8, ## entry is untracked item in workdir 
    GIT_DELTA_UNREADABLE = 9, ## type of entry changed between old and new 
    GIT_DELTA_CONFLICTED = 10 ## entry is unreadable 
  git_diff_file* {.bycopy, importc: "git_diff_file".} = object
    ## entry in the index is conflicted 
    id*: git_oid
    path*: cstring
    size*: git_object_size_t
    flags*: uint32
    mode*: uint16
    id_abbrev*: uint16

  git_diff_delta* {.bycopy, importc: "git_diff_delta".} = object
    status*: git_delta_t
    flags*: uint32
    similarity*: uint16      ## git_diff_flag_t values 
    nfiles*: uint16          ## for RENAMED and COPIED, value 0-100 
    old_file*: git_diff_file ## number of files in this delta 
    new_file*: git_diff_file

  git_diff_notify_cb* = proc (diff_so_far: ptr git_diff;
                              delta_to_add: ptr git_diff_delta;
                              matched_pathspec: cstring; payload: pointer): cint {.
      cdecl.}
  git_diff_notify_cbNim* = proc (diff_so_far: ptr git_diff;
                                 delta_to_add: ptr git_diff_delta;
                                 matched_pathspec: cstring): cint
  git_diff_progress_cb* = proc (diff_so_far: ptr git_diff; old_path: cstring;
                                new_path: cstring; payload: pointer): cint {.
      cdecl.}
  git_diff_progress_cbNim* = proc (diff_so_far: ptr git_diff; old_path: cstring;
                                   new_path: cstring): cint
  git_diff_options* {.bycopy, importc: "git_diff_options".} = object
    version*: cuint
    flags*: uint32           ## version for the struct 
    ignore_submodules*: git_submodule_ignore_t ## options controlling which files are in the diff 
                                               ## Overrides the submodule ignore setting for all submodules in the diff. 
    pathspec*: git_strarray
    notify_cb*: git_diff_notify_cb
    progress_cb*: git_diff_progress_cb
    payload*: pointer        ## The payload to pass to the callback functions. 
    context_lines*: uint32   ## options controlling how to diff text is generated 
    interhunk_lines*: uint32
    id_abbrev*: uint16
    max_size*: git_off_t
    old_prefix*: cstring
    new_prefix*: cstring

  git_diff_file_cb* = proc (delta: ptr git_diff_delta; progress: cfloat;
                            payload: pointer): cint {.cdecl.}
  git_diff_file_cbNim* = proc (delta: ptr git_diff_delta; progress: cfloat): cint
  git_diff_binary_t* = enum ## The current version of the diff options structure
    GIT_DIFF_BINARY_NONE = 0, ## There is no binary delta. 
    GIT_DIFF_BINARY_LITERAL = 1, ## The binary data is the literal contents of the file. 
    GIT_DIFF_BINARY_DELTA = 2 ## The binary data is the delta from one side to the other. 
  git_diff_binary_file* {.bycopy, importc: "git_diff_binary_file".} = object
    ## The contents of one of the files in a binary diff. 
    type*: git_diff_binary_t ## The type of binary data for this file. 
    data*: cstring           ## The binary data, deflated. 
    datalen*: size_t         ## The length of the binary data. 
    inflatedlen*: size_t     ## The length of the binary data after inflation. 
  
  git_diff_binary* {.bycopy, importc: "git_diff_binary".} = object
    contains_data*: cuint
    old_file*: git_diff_binary_file
    new_file*: git_diff_binary_file ## The contents of the old file. 
  
  git_diff_binary_cb* = proc (delta: ptr git_diff_delta;
                              binary: ptr git_diff_binary; payload: pointer): cint {.
      cdecl.}
  git_diff_binary_cbNim* = proc (delta: ptr git_diff_delta;
                                 binary: ptr git_diff_binary): cint
  git_diff_hunk* {.bycopy, importc: "git_diff_hunk".} = object
    ## The contents of the new file. 
    old_start*: cint
    old_lines*: cint         ## Starting line number in old_file 
    new_start*: cint         ## Number of lines in old_file 
    new_lines*: cint         ## Starting line number in new_file 
    header_len*: size_t      ## Number of lines in new_file 
    header*: ptr UncheckedArray[char] ## Number of bytes in header text 
  
  git_diff_hunk_cb* = proc (delta: ptr git_diff_delta; hunk: ptr git_diff_hunk;
                            payload: pointer): cint {.cdecl.}
  git_diff_hunk_cbNim* = proc (delta: ptr git_diff_delta;
                               hunk: ptr git_diff_hunk): cint
  git_diff_line_t* = enum   ## Header text, NUL-byte terminated
    GIT_DIFF_LINE_CONTEXT = 39 ## These values will be sent to `git_diff_line_cb` along with the line 
  git_diff_line* {.bycopy, importc: "git_diff_line".} = object
    ## For "Binary files x and y differ" 
    origin*: char
    old_lineno*: cint        ## A git_diff_line_t value 
    new_lineno*: cint        ## Line number in old file or -1 for added line 
    num_lines*: cint         ## Line number in new file or -1 for deleted line 
    content_len*: size_t     ## Number of newline characters in content 
    content_offset*: git_off_t ## Number of bytes of data 
    content*: cstring        ## Offset in the original file to the content 
  
  git_diff_line_cb* = proc (delta: ptr git_diff_delta; hunk: ptr git_diff_hunk;
                            line: ptr git_diff_line; payload: pointer): cint {.
      cdecl.}
  git_diff_line_cbNim* = proc (delta: ptr git_diff_delta;
                               hunk: ptr git_diff_hunk; line: ptr git_diff_line): cint
  git_diff_find_t* = enum   ## Pointer to diff text, not NUL-byte terminated 
                             ## user reference data
    GIT_DIFF_FIND_BY_CONFIG = 0, ## Obey `diff.renames`. Overridden by any other GIT_DIFF_FIND_... flag. 
    GIT_DIFF_FIND_RENAMES = 1, ## Look for renames? (`--find-renames`) 
    GIT_DIFF_FIND_RENAMES_FROM_REWRITES = 2, ## Consider old side of MODIFIED for renames? (`--break-rewrites=N`) 
    GIT_DIFF_FIND_COPIES = 4, ## Look for copies? (a la `--find-copies`). 
    GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = 8, GIT_DIFF_FIND_REWRITES = 16, ## Mark significant rewrites for split (`--break-rewrites=/M`) 
    GIT_DIFF_BREAK_REWRITES = 32, ## Actually split large rewrites into delete/add pairs 
    GIT_DIFF_FIND_AND_BREAK_REWRITES = 48, ## Mark rewrites for split and break into delete/add pairs 
    GIT_DIFF_FIND_FOR_UNTRACKED = 64, GIT_DIFF_FIND_IGNORE_WHITESPACE = 4096, ## Measure similarity ignoring all whitespace 
    GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = 8192, ## Measure similarity including all data 
    GIT_DIFF_FIND_EXACT_MATCH_ONLY = 16384, ## Measure similarity only by comparing SHAs (fast and cheap) 
    GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY = 32768,
    GIT_DIFF_FIND_REMOVE_UNMODIFIED = 65536
  git_diff_similarity_metric* {.bycopy, importc: "git_diff_similarity_metric".} = object
    file_signature*: proc (out: ptr pointer; file: ptr git_diff_file;
                           fullpath: cstring; payload: pointer): cint {.cdecl.}
    buffer_signature*: proc (out: ptr pointer; file: ptr git_diff_file;
                             buf: cstring; buflen: size_t; payload: pointer): cint {.
        cdecl.}
    free_signature*: proc (sig: pointer; payload: pointer): void {.cdecl.}
    similarity*: proc (score: ptr cint; siga: pointer; sigb: pointer;
                       payload: pointer): cint {.cdecl.}
    payload*: pointer

  git_diff_find_options* {.bycopy, importc: "git_diff_find_options".} = object
    version*: cuint
    flags*: uint32
    rename_threshold*: uint16
    rename_from_rewrite_threshold*: uint16
    copy_threshold*: uint16
    break_rewrite_threshold*: uint16
    rename_limit*: size_t
    metric*: ptr git_diff_similarity_metric

  git_diff_format_t* = enum ## @{
                             ## @}
                             ## @{
    GIT_DIFF_FORMAT_PATCH = 1, GIT_DIFF_FORMAT_PATCH_HEADER = 2, ## full git diff 
    GIT_DIFF_FORMAT_RAW = 3, ## just the file headers of patch 
    GIT_DIFF_FORMAT_NAME_ONLY = 4, ## like git diff --raw 
    GIT_DIFF_FORMAT_NAME_STATUS = 5, ## like git diff --name-only 
    GIT_DIFF_FORMAT_PATCH_ID = 6 ## like git diff --name-status 
  git_diff_stats_format_t* = enum
    GIT_DIFF_STATS_NONE = 0, ## No stats
    GIT_DIFF_STATS_FULL = 1, ## Full statistics, equivalent of `--stat` 
    GIT_DIFF_STATS_SHORT = 2, ## Short statistics, equivalent of `--shortstat` 
    GIT_DIFF_STATS_NUMBER = 4, ## Number statistics, equivalent of `--numstat` 
    GIT_DIFF_STATS_INCLUDE_SUMMARY = 8 ## Extended header information such as creations, renames and mode changes, equivalent of `--summary` 
  git_diff_format_email_flags_t* = enum
    GIT_DIFF_FORMAT_EMAIL_NONE = 0, ## Normal patch, the default 
    GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = 1 ## Don't insert "[PATCH]" in the subject header
  git_diff_format_email_options* {.bycopy,
                                   importc: "git_diff_format_email_options".} = object
    version*: cuint
    flags*: uint32           ## see `git_diff_format_email_flags_t` above 
    patch_no*: size_t        ## This patch number 
    total_patches*: size_t   ## Total number of patches in this series 
    id*: ptr git_oid         ## id to use for the commit 
    summary*: cstring        ## Summary of the change 
    body*: cstring           ## Commit message's body 
    author*: ptr git_signature ## Author of the change 
  
  git_diff_patchid_options* {.bycopy, importc: "git_diff_patchid_options".} = object
    version*: cuint

  git_describe_strategy_t* = enum ## @}
    GIT_DESCRIBE_DEFAULT = 0, GIT_DESCRIBE_TAGS = 1, GIT_DESCRIBE_ALL = 2
  git_describe_options* {.bycopy, importc: "git_describe_options".} = object
    version*: cuint
    max_candidates_tags*: cuint
    describe_strategy*: cuint ## default: 10 
    pattern*: cstring        ## default: GIT_DESCRIBE_DEFAULT 
    only_follow_first_parent*: cint
    show_commit_oid_as_fallback*: cint

  git_describe_format_options* {.bycopy, importc: "git_describe_format_options".} = object
    version*: cuint
    abbreviated_size*: cuint
    always_use_long_format*: cint
    dirty_suffix*: cstring

  git_repository_open_flag_t* = enum ## @}
    GIT_REPOSITORY_OPEN_NO_SEARCH = 1, GIT_REPOSITORY_OPEN_CROSS_FS = 2,
    GIT_REPOSITORY_OPEN_BARE = 4, GIT_REPOSITORY_OPEN_NO_DOTGIT = 8,
    GIT_REPOSITORY_OPEN_FROM_ENV = 16
  git_repository_init_flag_t* = enum
    GIT_REPOSITORY_INIT_BARE = 1, GIT_REPOSITORY_INIT_NO_REINIT = 2,
    GIT_REPOSITORY_INIT_NO_DOTGIT_DIR = 4, GIT_REPOSITORY_INIT_MKDIR = 8,
    GIT_REPOSITORY_INIT_MKPATH = 16, GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = 32,
    GIT_REPOSITORY_INIT_RELATIVE_GITLINK = 64
  git_repository_init_mode_t* = enum
    GIT_REPOSITORY_INIT_SHARED_UMASK = 0,
    GIT_REPOSITORY_INIT_SHARED_GROUP = 2775,
    GIT_REPOSITORY_INIT_SHARED_ALL = 2777
  git_repository_init_options* {.bycopy, importc: "git_repository_init_options".} = object
    version*: cuint
    flags*: uint32
    mode*: uint32
    workdir_path*: cstring
    description*: cstring
    template_path*: cstring
    initial_head*: cstring
    origin_url*: cstring

  git_repository_item_t* = enum
    GIT_REPOSITORY_ITEM_GITDIR = 0, GIT_REPOSITORY_ITEM_WORKDIR = 1,
    GIT_REPOSITORY_ITEM_COMMONDIR = 2, GIT_REPOSITORY_ITEM_INDEX = 3,
    GIT_REPOSITORY_ITEM_OBJECTS = 4, GIT_REPOSITORY_ITEM_REFS = 5,
    GIT_REPOSITORY_ITEM_PACKED_REFS = 6, GIT_REPOSITORY_ITEM_REMOTES = 7,
    GIT_REPOSITORY_ITEM_CONFIG = 8, GIT_REPOSITORY_ITEM_INFO = 9,
    GIT_REPOSITORY_ITEM_HOOKS = 10, GIT_REPOSITORY_ITEM_LOGS = 11,
    GIT_REPOSITORY_ITEM_MODULES = 12, GIT_REPOSITORY_ITEM_WORKTREES = 13,
    GIT_REPOSITORY_ITEM_LAST = 14
  git_repository_fetchhead_foreach_cb* = proc (ref_name: cstring;
      remote_url: cstring; oid: ptr git_oid; is_merge: cuint; payload: pointer): cint {.
      cdecl.}
  git_repository_fetchhead_foreach_cbNim* = proc (ref_name: cstring;
      remote_url: cstring; oid: ptr git_oid; is_merge: cuint): cint
  git_repository_mergehead_foreach_cb* = proc (oid: ptr git_oid;
      payload: pointer): cint {.cdecl.}
  git_repository_mergehead_foreach_cbNim* = proc (oid: ptr git_oid): cint
  git_repository_state_t* = enum
    GIT_REPOSITORY_STATE_NONE = 0, GIT_REPOSITORY_STATE_MERGE = 1,
    GIT_REPOSITORY_STATE_REVERT = 2, GIT_REPOSITORY_STATE_REVERT_SEQUENCE = 3,
    GIT_REPOSITORY_STATE_CHERRYPICK = 4,
    GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE = 5,
    GIT_REPOSITORY_STATE_BISECT = 6, GIT_REPOSITORY_STATE_REBASE = 7,
    GIT_REPOSITORY_STATE_REBASE_INTERACTIVE = 8,
    GIT_REPOSITORY_STATE_REBASE_MERGE = 9,
    GIT_REPOSITORY_STATE_APPLY_MAILBOX = 10,
    GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE = 11
  git_checkout_strategy_t* = enum ## @}
    GIT_CHECKOUT_NONE = 0, GIT_CHECKOUT_SAFE = 1, ## default is a dry run, no actual updates 
    GIT_CHECKOUT_FORCE = 2, GIT_CHECKOUT_RECREATE_MISSING = 4, ## Allow checkout to recreate missing files 
    GIT_CHECKOUT_ALLOW_CONFLICTS = 16, ## Allow checkout to make safe updates even if conflicts are found 
    GIT_CHECKOUT_REMOVE_UNTRACKED = 32, ## Remove untracked files not in index (that are not ignored) 
    GIT_CHECKOUT_REMOVE_IGNORED = 64, ## Remove ignored files not in index 
    GIT_CHECKOUT_UPDATE_ONLY = 128, ## Only update existing files, don't create new ones 
    GIT_CHECKOUT_DONT_UPDATE_INDEX = 256, GIT_CHECKOUT_NO_REFRESH = 512, ## Don't refresh index/config/etc before doing checkout 
    GIT_CHECKOUT_SKIP_UNMERGED = 1024, ## Allow checkout to skip unmerged files 
    GIT_CHECKOUT_USE_OURS = 2048, ## For unmerged files, checkout stage 2 from index 
    GIT_CHECKOUT_USE_THEIRS = 4096, ## For unmerged files, checkout stage 3 from index 
    GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = 8192, ## Treat pathspec as simple list of exact match file paths 
    GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = 262144, ## Ignore directories in use, they will be left empty 
    GIT_CHECKOUT_DONT_OVERWRITE_IGNORED = 524288, ## Don't overwrite ignored files that exist in the checkout target 
    GIT_CHECKOUT_CONFLICT_STYLE_MERGE = 1048576, ## Write normal merge files for conflicts 
    GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 = 2097152, ## Include common ancestor data in diff3 format files for conflicts 
    GIT_CHECKOUT_DONT_REMOVE_EXISTING = 4194304, ## Don't overwrite existing files or folders 
    GIT_CHECKOUT_DONT_WRITE_INDEX = 8388608, ## Normally checkout writes the index upon completion; this prevents that. 
    GIT_CHECKOUT_UPDATE_SUBMODULES = 65536, ## Recursively checkout submodules with same options (NOT IMPLEMENTED) 
    GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 131072 ## Recursively checkout submodules if HEAD moved in super repo (NOT IMPLEMENTED) 
  git_checkout_notify_t* = enum
    GIT_CHECKOUT_NOTIFY_NONE = 0, GIT_CHECKOUT_NOTIFY_CONFLICT = 1,
    GIT_CHECKOUT_NOTIFY_DIRTY = 2, GIT_CHECKOUT_NOTIFY_UPDATED = 4,
    GIT_CHECKOUT_NOTIFY_UNTRACKED = 8, GIT_CHECKOUT_NOTIFY_IGNORED = 16
  git_checkout_perfdata* {.bycopy, importc: "git_checkout_perfdata".} = object
    ## Checkout performance-reporting structure 
    mkdir_calls*: size_t
    stat_calls*: size_t
    chmod_calls*: size_t

  git_checkout_notify_cb* = proc (why: git_checkout_notify_t; path: cstring;
                                  baseline: ptr git_diff_file;
                                  target: ptr git_diff_file;
                                  workdir: ptr git_diff_file; payload: pointer): cint {.
      cdecl.}
  git_checkout_notify_cbNim* = proc (why: git_checkout_notify_t; path: cstring;
                                     baseline: ptr git_diff_file;
                                     target: ptr git_diff_file;
                                     workdir: ptr git_diff_file): cint
  git_checkout_progress_cb* = proc (path: cstring; completed_steps: size_t;
                                    total_steps: size_t; payload: pointer): void {.
      cdecl.}
  git_checkout_progress_cbNim* = proc (path: cstring; completed_steps: size_t;
                                       total_steps: size_t): void
  git_checkout_perfdata_cb* = proc (perfdata: ptr git_checkout_perfdata;
                                    payload: pointer): void {.cdecl.}
  git_checkout_perfdata_cbNim* = proc (perfdata: ptr git_checkout_perfdata): void
  git_checkout_options* {.bycopy, importc: "git_checkout_options".} = object
    ## Checkout notification callback function 
                                                                             ## Checkout progress notification function 
                                                                             ## Checkout perfdata notification function 
    version*: cuint
    checkout_strategy*: cuint ## The version 
    disable_filters*: cint   ## default will be a safe checkout 
    dir_mode*: cuint         ## don't apply filters like CRLF conversion 
    file_mode*: cuint        ## default is 0755 
    file_open_flags*: cint   ## default is 0644 or 0755 as dictated by blob 
    notify_flags*: cuint     ## default is O_CREAT | O_TRUNC | O_WRONLY 
    notify_cb*: git_checkout_notify_cb ## see `git_checkout_notify_t` above 
    notify_payload*: pointer ## Payload passed to notify_cb 
    progress_cb*: git_checkout_progress_cb ## Optional callback to notify the consumer of checkout progress. 
    progress_payload*: pointer ## Payload passed to progress_cb 
    paths*: git_strarray
    baseline*: ptr git_tree
    baseline_index*: ptr git_index
    target_directory*: cstring
    ancestor_label*: cstring ## alternative checkout path to workdir 
    our_label*: cstring      ## the name of the common ancestor side of conflicts 
    their_label*: cstring    ## the name of the "our" side of conflicts 
    perfdata_cb*: git_checkout_perfdata_cb ## the name of the "their" side of conflicts 
                                           ## Optional callback to notify the consumer of performance data. 
    perfdata_payload*: pointer ## Payload passed to perfdata_cb 
  
  git_stash_flags* = enum   ## @}
    GIT_STASH_DEFAULT = 0, GIT_STASH_KEEP_INDEX = 1,
    GIT_STASH_INCLUDE_UNTRACKED = 2, GIT_STASH_INCLUDE_IGNORED = 4
  git_stash_apply_flags* = enum ## Stash application flags.
    GIT_STASH_APPLY_DEFAULT = 0, GIT_STASH_APPLY_REINSTATE_INDEX = 1
  git_stash_apply_progress_t* = enum ## Stash apply progression states
    GIT_STASH_APPLY_PROGRESS_NONE = 0, GIT_STASH_APPLY_PROGRESS_LOADING_STASH = 1, ## Loading the stashed data from the object database. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX = 2, ## The stored index is being analyzed. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED = 3, ## The modified files are being analyzed. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED = 4, ## The untracked and ignored files are being analyzed. 
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = 5, ## The untracked files are being written to disk. 
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED = 6, ## The modified files are being written to disk. 
    GIT_STASH_APPLY_PROGRESS_DONE = 7 ## The stash was applied successfully. 
  git_stash_apply_progress_cb* = proc (progress: git_stash_apply_progress_t;
                                       payload: pointer): cint {.cdecl.}
  git_stash_apply_progress_cbNim* = proc (progress: git_stash_apply_progress_t): cint
  git_stash_apply_options* {.bycopy, importc: "git_stash_apply_options".} = object
    version*: cuint
    flags*: uint32           ## See `git_stash_apply_flags`, above. 
    checkout_options*: git_checkout_options ## Options to use when writing files to the working directory. 
    progress_cb*: git_stash_apply_progress_cb ## Optional callback to notify the consumer of application progress. 
    progress_payload*: pointer

  git_stash_cb* = proc (index: size_t; message: cstring; stash_id: ptr git_oid;
                        payload: pointer): cint {.cdecl.}
  git_stash_cbNim* = proc (index: size_t; message: cstring;
                           stash_id: ptr git_oid): cint
  git_direction* = enum     ## @} 
                             ## @}
    GIT_DIRECTION_FETCH = 0, GIT_DIRECTION_PUSH = 1
  git_remote_head* {.bycopy, importc: "git_remote_head".} = object
    local*: cint
    oid*: git_oid            ## available locally 
    loid*: git_oid
    name*: cstring
    symref_target*: cstring

  git_treebuilder_filter_cb* = proc (entry: ptr git_tree_entry; payload: pointer): cint {.
      cdecl.}
  git_treebuilder_filter_cbNim* = proc (entry: ptr git_tree_entry): cint
  git_treewalk_cb* = proc (root: cstring; entry: ptr git_tree_entry;
                           payload: pointer): cint {.cdecl.}
  git_treewalk_cbNim* = proc (root: cstring; entry: ptr git_tree_entry): cint
  git_treewalk_mode* = enum ## @} 
                             ## Callback for the tree traversal method 
                             ## Tree traversal modes
    GIT_TREEWALK_PRE = 0, GIT_TREEWALK_POST = 1 ## Pre-order 
  git_tree_update_t* = enum ## Post-order
    GIT_TREE_UPDATE_UPSERT = 0, ## Update or insert an entry at the specified path 
    GIT_TREE_UPDATE_REMOVE = 1 ## Remove an entry from the specified path 
  git_tree_update* {.bycopy, importc: "git_tree_update".} = object
    action*: git_tree_update_t ## Update action. If it's an removal, only the path is looked at 
    id*: git_oid             ## The entry's id 
    filemode*: git_filemode_t ## The filemode/kind of object 
    path*: cstring           ## The full path from the root tree 
  
  git_blob_filter_flag_t* = enum ## @}
    GIT_BLOB_FILTER_CHECK_FOR_BINARY = 1, ## When set, filters will not be applied to binary files. 
    GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES = 2,
    GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD = 4
  git_blob_filter_options* {.bycopy, importc: "git_blob_filter_options".} = object
    version*: cint
    flags*: uint32           ## Flags to control the filtering process, see `git_blob_filter_flag_t` above 
  
  git_commit_signing_cb* = proc (signature: ptr git_buf;
                                 signature_field: ptr git_buf;
                                 commit_content: cstring; payload: pointer): cint {.
      cdecl.}
  git_commit_signing_cbNim* = proc (signature: ptr git_buf;
                                    signature_field: ptr git_buf;
                                    commit_content: cstring): cint
  git_attr_value_t* = enum  ## @} 
                             ## @} 
                             ## @}
    GIT_ATTR_VALUE_UNSPECIFIED = 0, GIT_ATTR_VALUE_TRUE = 1, ## The attribute has been left unspecified 
    GIT_ATTR_VALUE_FALSE = 2, ## The attribute has been set 
    GIT_ATTR_VALUE_STRING = 3 ## The attribute has been unset 
  git_attr_foreach_cb* = proc (name: cstring; value: cstring; payload: pointer): cint {.
      cdecl.}
  git_attr_foreach_cbNim* = proc (name: cstring; value: cstring): cint
  git_blame_flag_t* = enum  ## This attribute has a value 
                             ## @}
    GIT_BLAME_NORMAL = 0,   ## Normal blame, the default 
    GIT_BLAME_TRACK_COPIES_SAME_FILE = 1,
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = 2,
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = 4,
    GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = 8, GIT_BLAME_FIRST_PARENT = 16,
    GIT_BLAME_USE_MAILMAP = 32, GIT_BLAME_IGNORE_WHITESPACE = 64 ## Ignore whitespace differences 
  git_blame_options* {.bycopy, importc: "git_blame_options".} = object
    version*: cuint
    flags*: uint32           ## A combination of `git_blame_flag_t` 
    min_match_characters*: uint16
    newest_commit*: git_oid  ## The id of the newest commit to consider. The default is HEAD. 
    oldest_commit*: git_oid
    min_line*: size_t
    max_line*: size_t

  git_blame_hunk* {.bycopy, importc: "git_blame_hunk".} = object
    lines_in_hunk*: size_t
    final_commit_id*: git_oid
    final_start_line_number*: size_t
    final_signature*: ptr git_signature
    orig_commit_id*: git_oid
    orig_path*: cstring
    orig_start_line_number*: size_t
    orig_signature*: ptr git_signature
    boundary*: char

  git_sort_t* = enum        ## @}
    GIT_SORT_NONE = 0, GIT_SORT_TOPOLOGICAL = 1, GIT_SORT_TIME = 2,
    GIT_SORT_REVERSE = 4
  git_revwalk_hide_cb* = proc (commit_id: ptr git_oid; payload: pointer): cint {.
      cdecl.}
  git_revwalk_hide_cbNim* = proc (commit_id: ptr git_oid): cint
  git_remote_create_flags* = enum ## @}
    GIT_REMOTE_CREATE_SKIP_INSTEADOF = 1, ## Ignore the repository apply.insteadOf configuration 
    GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 2 ## Don't build a fetchspec from the name if none is set 
  git_remote_create_options* {.bycopy, importc: "git_remote_create_options".} = object
    version*: cuint
    repository*: ptr git_repository
    name*: cstring
    fetchspec*: cstring      ## The fetchspec the remote should use. 
    flags*: cuint            ## Additional flags for the remote. See git_remote_create_flags. 
  
  git_remote_completion_t* = enum
    GIT_REMOTE_COMPLETION_DOWNLOAD = 0, GIT_REMOTE_COMPLETION_INDEXING = 1,
    GIT_REMOTE_COMPLETION_ERROR = 2
  git_push_transfer_progress_cb* = proc (current: cuint; total: cuint;
      bytes: size_t; payload: pointer): cint {.cdecl.}
  git_push_transfer_progress_cbNim* = proc (current: cuint; total: cuint;
      bytes: size_t): cint
  git_push_update* {.bycopy, importc: "git_push_update".} = object
    ## Push network progress notification function 
    src_refname*: cstring
    dst_refname*: cstring
    src*: git_oid
    dst*: git_oid

  git_push_negotiation* = proc (updates: ptr ptr git_push_update; len: size_t;
                                payload: pointer): cint {.cdecl.}
  git_push_negotiationNim* = proc (updates: ptr ptr git_push_update; len: size_t): cint
  git_push_update_reference_cb* = proc (refname: cstring; status: cstring;
                                        data: pointer): cint {.cdecl.}
  git_push_update_reference_cbNim* = proc (refname: cstring; status: cstring): cint
  git_url_resolve_cb* = proc (url_resolved: ptr git_buf; url: cstring;
                              direction: cint; payload: pointer): cint {.cdecl.}
  git_url_resolve_cbNim* = proc (url_resolved: ptr git_buf; url: cstring;
                                 direction: cint): cint
  git_remote_callbacks* {.bycopy, importc: "git_remote_callbacks".} = object
    version*: cuint
    sideband_progress*: git_transport_message_cb ## The version 
    completion*: proc (type: git_remote_completion_t; data: pointer): cint {.
        cdecl.}
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    transfer_progress*: git_indexer_progress_cb
    update_tips*: proc (refname: cstring; a: ptr git_oid; b: ptr git_oid;
                        data: pointer): cint {.cdecl.}
    pack_progress*: git_packbuilder_progress
    push_transfer_progress*: git_push_transfer_progress_cb
    push_update_reference*: git_push_update_reference_cb
    push_negotiation*: git_push_negotiation
    transport*: git_transport_cb
    payload*: pointer
    resolve_url*: git_url_resolve_cb

  git_fetch_prune_t* = enum ## Acceptable prune settings when fetching
    GIT_FETCH_PRUNE_UNSPECIFIED = 0, GIT_FETCH_PRUNE = 1, GIT_FETCH_NO_PRUNE = 2
  git_remote_autotag_option_t* = enum
    GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0, GIT_REMOTE_DOWNLOAD_TAGS_AUTO = 1,
    GIT_REMOTE_DOWNLOAD_TAGS_NONE = 2, GIT_REMOTE_DOWNLOAD_TAGS_ALL = 3
  git_fetch_options* {.bycopy, importc: "git_fetch_options".} = object
    version*: cint
    callbacks*: git_remote_callbacks
    prune*: git_fetch_prune_t
    update_fetchhead*: cint
    download_tags*: git_remote_autotag_option_t
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray

  git_push_options* {.bycopy, importc: "git_push_options".} = object
    version*: cuint
    pb_parallelism*: cuint
    callbacks*: git_remote_callbacks
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray

  git_indexer_progress* {.bycopy, importc: "git_indexer_progress".} = object
    total_objects*: cuint    ## number of objects in the packfile being indexed 
    indexed_objects*: cuint  ## received objects that have been hashed 
    received_objects*: cuint ## received_objects: objects which have been downloaded 
    local_objects*: cuint
    total_deltas*: cuint     ## number of deltas in the packfile being indexed 
    indexed_deltas*: cuint   ## received deltas that have been indexed 
    received_bytes*: size_t  ## size of the packfile received up to now 
  
  git_indexer_progress_cb* = proc (stats: ptr git_indexer_progress;
                                   payload: pointer): cint {.cdecl.}
  git_indexer_progress_cbNim* = proc (stats: ptr git_indexer_progress): cint
  git_indexer_options* {.bycopy, importc: "git_indexer_options".} = object
    version*: cuint
    progress_cb*: git_indexer_progress_cb ## progress_cb function to call with progress information 
    progress_cb_payload*: pointer ## progress_cb_payload payload for the progress callback 
    verify*: uchar           ## Do connectivity checks for the received pack 
  
  git_merge_file_input* {.bycopy, importc: "git_merge_file_input".} = object
    ## @} 
    version*: cuint
    ptr*: cstring            ## Pointer to the contents of the file. 
    size*: size_t            ## Size of the contents pointed to in `ptr`. 
    path*: cstring           ## File name of the conflicted file, or `NULL` to not merge the path. 
    mode*: cuint             ## File mode of the conflicted file, or `0` to not merge the mode. 
  
  git_merge_flag_t* = enum
    GIT_MERGE_FIND_RENAMES = 1, GIT_MERGE_FAIL_ON_CONFLICT = 2,
    GIT_MERGE_SKIP_REUC = 4, GIT_MERGE_NO_RECURSIVE = 8
  git_merge_file_favor_t* = enum
    GIT_MERGE_FILE_FAVOR_NORMAL = 0, GIT_MERGE_FILE_FAVOR_OURS = 1,
    GIT_MERGE_FILE_FAVOR_THEIRS = 2, GIT_MERGE_FILE_FAVOR_UNION = 3
  git_merge_file_flag_t* = enum
    GIT_MERGE_FILE_DEFAULT = 0, ## Defaults 
    GIT_MERGE_FILE_STYLE_MERGE = 1, ## Create standard conflicted merge files 
    GIT_MERGE_FILE_STYLE_DIFF3 = 2, ## Create diff3-style files 
    GIT_MERGE_FILE_SIMPLIFY_ALNUM = 4, ## Condense non-alphanumeric regions for simplified diff file 
    GIT_MERGE_FILE_IGNORE_WHITESPACE = 8, ## Ignore all whitespace 
    GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = 16, ## Ignore changes in amount of whitespace 
    GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL = 32, ## Ignore whitespace at end of line 
    GIT_MERGE_FILE_DIFF_PATIENCE = 64, ## Use the "patience diff" algorithm 
    GIT_MERGE_FILE_DIFF_MINIMAL = 128 ## Take extra time to find minimal diff 
  git_merge_file_options* {.bycopy, importc: "git_merge_file_options".} = object
    version*: cuint
    ancestor_label*: cstring
    our_label*: cstring
    their_label*: cstring
    favor*: git_merge_file_favor_t ## The file to favor in region conflicts. 
    flags*: uint32           ## see `git_merge_file_flag_t` above 
    marker_size*: cushort

  git_merge_file_result* {.bycopy, importc: "git_merge_file_result".} = object
    automergeable*: cuint
    path*: cstring
    mode*: cuint             ## The mode that the resultant merge file should use.  
    ptr*: cstring            ## The contents of the merge. 
    len*: size_t             ## The length of the merge contents. 
  
  git_merge_options* {.bycopy, importc: "git_merge_options".} = object
    version*: cuint
    flags*: uint32           ## See `git_merge_flag_t` above 
    rename_threshold*: cuint
    target_limit*: cuint
    metric*: ptr git_diff_similarity_metric ## Pluggable similarity metric; pass NULL to use internal metric 
    recursion_limit*: cuint
    default_driver*: cstring
    file_favor*: git_merge_file_favor_t
    file_flags*: uint32      ## see `git_merge_file_flag_t` above 
  
  git_merge_analysis_t* = enum
    GIT_MERGE_ANALYSIS_NONE = 0, ## No merge is possible.  (Unused.) 
    GIT_MERGE_ANALYSIS_NORMAL = 1, GIT_MERGE_ANALYSIS_UP_TO_DATE = 2,
    GIT_MERGE_ANALYSIS_FASTFORWARD = 4, GIT_MERGE_ANALYSIS_UNBORN = 8
  git_merge_preference_t* = enum
    GIT_MERGE_PREFERENCE_NONE = 0, GIT_MERGE_PREFERENCE_NO_FASTFORWARD = 1,
    GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = 2
  git_rebase_options* {.bycopy, importc: "git_rebase_options".} = object
    ## @} 
    version*: cuint
    quiet*: cint
    inmemory*: cint
    rewrite_notes_ref*: cstring
    merge_options*: git_merge_options
    checkout_options*: git_checkout_options
    signing_cb*: git_commit_signing_cb
    payload*: pointer

  git_rebase_operation_t* = enum
    GIT_REBASE_OPERATION_PICK = 0, GIT_REBASE_OPERATION_REWORD = 1,
    GIT_REBASE_OPERATION_EDIT = 2, GIT_REBASE_OPERATION_SQUASH = 3,
    GIT_REBASE_OPERATION_FIXUP = 4, GIT_REBASE_OPERATION_EXEC = 5
  git_rebase_operation* {.bycopy, importc: "git_rebase_operation".} = object
    ## Indicates that a rebase operation is not (yet) in progress. 
    type*: git_rebase_operation_t ## The type of rebase operation. 
    id*: git_oid
    exec*: cstring

  git_feature_t* = enum ## @} 
                         ## Declare a public function exported for application use. 
                         ## Declare a callback function for application use. 
                         ## Declare a function as deprecated. 
                         ## Declare a function's takes printf style arguments.
    GIT_FEATURE_THREADS = 1, GIT_FEATURE_HTTPS = 2, GIT_FEATURE_SSH = 4,
    GIT_FEATURE_NSEC = 8
  git_libgit2_opt_t* = enum
    GIT_OPT_GET_MWINDOW_SIZE = 0, GIT_OPT_SET_MWINDOW_SIZE = 1,
    GIT_OPT_GET_MWINDOW_MAPPED_LIMIT = 2, GIT_OPT_SET_MWINDOW_MAPPED_LIMIT = 3,
    GIT_OPT_GET_SEARCH_PATH = 4, GIT_OPT_SET_SEARCH_PATH = 5,
    GIT_OPT_SET_CACHE_OBJECT_LIMIT = 6, GIT_OPT_SET_CACHE_MAX_SIZE = 7,
    GIT_OPT_ENABLE_CACHING = 8, GIT_OPT_GET_CACHED_MEMORY = 9,
    GIT_OPT_GET_TEMPLATE_PATH = 10, GIT_OPT_SET_TEMPLATE_PATH = 11,
    GIT_OPT_SET_SSL_CERT_LOCATIONS = 12, GIT_OPT_SET_USER_AGENT = 13,
    GIT_OPT_ENABLE_STRICT_OBJECT_CREATION = 14,
    GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION = 15,
    GIT_OPT_SET_SSL_CIPHERS = 16, GIT_OPT_GET_USER_AGENT = 17,
    GIT_OPT_ENABLE_OFS_DELTA = 18, GIT_OPT_ENABLE_FSYNC_GITDIR = 19,
    GIT_OPT_GET_WINDOWS_SHAREMODE = 20, GIT_OPT_SET_WINDOWS_SHAREMODE = 21,
    GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION = 22, GIT_OPT_SET_ALLOCATOR = 23,
    GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY = 24, GIT_OPT_GET_PACK_MAX_OBJECTS = 25,
    GIT_OPT_SET_PACK_MAX_OBJECTS = 26,
    GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS = 27,
    GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE = 28,
    GIT_OPT_GET_MWINDOW_FILE_LIMIT = 29, GIT_OPT_SET_MWINDOW_FILE_LIMIT = 30
  git_oid* {.bycopy, importc: "git_oid".} = object
    ## @} 
                                                   ## Size (in bytes) of a raw/binary oid 
                                                   ## Size (in bytes) of a hex formatted oid 
                                                   ## Unique identity of any object (commit, tree, blob, tag). 
    id*: ptr UncheckedArray[uchar] ## raw binary formatted id 
  
  git_filter_mode_t* = enum ## @}
    GIT_FILTER_TO_WORKTREE = 0, GIT_FILTER_TO_ODB = 1
  git_filter_flag_t* = enum
    GIT_FILTER_DEFAULT = 0, GIT_FILTER_ALLOW_UNSAFE = 1, ## Don't error for `safecrlf` violations, allow them to continue. 
    GIT_FILTER_NO_SYSTEM_ATTRIBUTES = 2, ## Don't load `/etc/gitattributes` (or the system equivalent) 
    GIT_FILTER_ATTRIBUTES_FROM_HEAD = 4 ## Load attributes from `.gitattributes` in the root of HEAD 
  git_config_level_t* = enum ## @}
    GIT_CONFIG_LEVEL_PROGRAMDATA = 1, ## System-wide on Windows, for compatibility with portable git 
    GIT_CONFIG_LEVEL_SYSTEM = 2, ## System-wide configuration file; /etc/gitconfig on Linux systems 
    GIT_CONFIG_LEVEL_XDG = 3, ## XDG compatible configuration file; typically ~/.config/git/config 
    GIT_CONFIG_LEVEL_GLOBAL = 4, GIT_CONFIG_LEVEL_LOCAL = 5,
    GIT_CONFIG_LEVEL_APP = 6, GIT_CONFIG_HIGHEST_LEVEL = -1
  git_config_entry* {.bycopy, importc: "git_config_entry".} = object
    name*: cstring
    value*: cstring          ## Name of the entry (normalised) 
    include_depth*: cuint    ## String value of the entry 
    level*: git_config_level_t ## Depth of includes where this variable was found 
    free*: proc (entry: ptr git_config_entry): void {.cdecl.} ## Which config file this was found in 
    payload*: pointer        ## Free function for this entry 
  
  git_config_foreach_cb* = proc (entry: ptr git_config_entry; payload: pointer): cint {.
      cdecl.}
  git_config_foreach_cbNim* = proc (entry: ptr git_config_entry): cint
  git_configmap_t* = enum
    GIT_CONFIGMAP_FALSE = 0, GIT_CONFIGMAP_TRUE = 1, GIT_CONFIGMAP_INT32 = 2,
    GIT_CONFIGMAP_STRING = 3
  git_configmap* {.bycopy, importc: "git_configmap".} = object
    type*: git_configmap_t
    str_match*: cstring
    map_value*: cint

  git_transport_message_cb* = proc (str: cstring; len: cint; payload: pointer): cint {.
      cdecl.}
  git_transport_message_cbNim* = proc (str: cstring; len: cint): cint
  git_transport_cb* = proc (out: ptr ptr git_transport; owner: ptr git_remote;
                            param: pointer): cint {.cdecl.}
  git_transport_cbNim* = proc (out: ptr ptr git_transport; owner: ptr git_remote): cint
  git_note_foreach_cb* = proc (blob_id: ptr git_oid;
                               annotated_object_id: ptr git_oid;
                               payload: pointer): cint {.cdecl.}
  git_note_foreach_cbNim* = proc (blob_id: ptr git_oid;
                                  annotated_object_id: ptr git_oid): cint
  git_note_iterator* = git_iterator
  git_reference_foreach_cb* = proc (reference: ptr git_reference;
                                    payload: pointer): cint {.cdecl.}
  git_reference_foreach_cbNim* = proc (reference: ptr git_reference): cint
  git_reference_foreach_name_cb* = proc (name: cstring; payload: pointer): cint {.
      cdecl.}
  git_reference_foreach_name_cbNim* = proc (name: cstring): cint
  git_reference_format_t* = enum ## @} 
                                  ## @} 
                                  ## @}
    GIT_REFERENCE_FORMAT_NORMAL = 0, GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL = 1,
    GIT_REFERENCE_FORMAT_REFSPEC_PATTERN = 2,
    GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 4
  git_odb_foreach_cb* = proc (id: ptr git_oid; payload: pointer): cint {.cdecl.}
  git_odb_foreach_cbNim* = proc (id: ptr git_oid): cint
  git_odb_expand_id* {.bycopy, importc: "git_odb_expand_id".} = object
    ## @} 
                                                                       ## @} 
    id*: git_oid             ## The object ID to expand 
    length*: cushort
    type*: git_object_t

  git_oidarray* {.bycopy, importc: "git_oidarray".} = object
    ## @} 
                                                             ## Array of object ids 
    ids*: ptr git_oid
    count*: size_t

  git_strarray* {.bycopy, importc: "git_strarray".} = object
    ## @} 
                                                             ## Array of strings 
    strings*: ptr cstring
    count*: size_t

  git_off_t* = int64
  git_time_t* = int64
  git_object_size_t* = uint64
  git_object_t* = enum      ## Basic type (loose or packed) of any Git object.
    GIT_OBJECT_ANY = -2, GIT_OBJECT_INVALID = -1, ## Object can be any of the following 
    GIT_OBJECT_COMMIT = 1,  ## Object is invalid. 
    GIT_OBJECT_TREE = 2,    ## A commit object. 
    GIT_OBJECT_BLOB = 3,    ## A tree (directory listing) object. 
    GIT_OBJECT_TAG = 4,     ## A file revision object. 
    GIT_OBJECT_OFS_DELTA = 6, ## An annotated tag object. 
    GIT_OBJECT_REF_DELTA = 7 ## A delta, base is given by an offset. 
  git_time* {.bycopy, importc: "git_time".} = object
    ## Time in a signature 
    time*: git_time_t
    offset*: cint            ## time in seconds from epoch 
    sign*: char              ## timezone offset, in minutes 
  
  git_signature* {.bycopy, importc: "git_signature".} = object
    ## indicator for questionable '-0000' offsets in signature 
                                                               ## An action signature (e.g. for committers, taggers, etc) 
    name*: cstring
    email*: cstring          ## full name of the author 
    when*: git_time          ## email of the author 
  
  git_reference_t* = enum   ## Basic type of any Git reference.
    GIT_REFERENCE_INVALID = 0, GIT_REFERENCE_DIRECT = 1, ## Invalid reference 
    GIT_REFERENCE_SYMBOLIC = 2, ## A reference that points at an object id 
    GIT_REFERENCE_ALL = 3    ## A reference that points at another reference 
  git_branch_t* = enum      ## Basic type of any Git branch.
    GIT_BRANCH_LOCAL = 1, GIT_BRANCH_REMOTE = 2, GIT_BRANCH_ALL = 3
  git_filemode_t* = enum    ## Valid modes for index and tree entries.
    GIT_FILEMODE_UNREADABLE = 0, GIT_FILEMODE_TREE = 40000,
    GIT_FILEMODE_BLOB = 100644, GIT_FILEMODE_BLOB_EXECUTABLE = 100755,
    GIT_FILEMODE_LINK = 120000, GIT_FILEMODE_COMMIT = 160000
  git_submodule_update_t* = enum
    GIT_SUBMODULE_UPDATE_CHECKOUT = 1, GIT_SUBMODULE_UPDATE_REBASE = 2,
    GIT_SUBMODULE_UPDATE_MERGE = 3, GIT_SUBMODULE_UPDATE_NONE = 4,
    GIT_SUBMODULE_UPDATE_DEFAULT = 0
  git_submodule_ignore_t* = enum
    GIT_SUBMODULE_IGNORE_UNSPECIFIED = -1, GIT_SUBMODULE_IGNORE_NONE = 1, ## use the submodule's configuration 
    GIT_SUBMODULE_IGNORE_UNTRACKED = 2, ## any change or untracked == dirty 
    GIT_SUBMODULE_IGNORE_DIRTY = 3, ## dirty if tracked files change 
    GIT_SUBMODULE_IGNORE_ALL = 4 ## only dirty if HEAD moved 
  git_submodule_recurse_t* = enum ## never dirty
    GIT_SUBMODULE_RECURSE_NO = 0, GIT_SUBMODULE_RECURSE_YES = 1,
    GIT_SUBMODULE_RECURSE_ONDEMAND = 2
  git_writestream* {.bycopy, importc: "git_writestream".} = object
    ## A type to write in a streaming fashion, for example, for filters. 
    write*: proc (stream: ptr git_writestream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    close*: proc (stream: ptr git_writestream): cint {.cdecl.}
    free*: proc (stream: ptr git_writestream): void {.cdecl.}

  git_credential_t* = enum  ## @}
    GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1, GIT_CREDENTIAL_SSH_KEY = 2,
    GIT_CREDENTIAL_SSH_CUSTOM = 4, GIT_CREDENTIAL_DEFAULT = 8,
    GIT_CREDENTIAL_SSH_INTERACTIVE = 16, GIT_CREDENTIAL_USERNAME = 32,
    GIT_CREDENTIAL_SSH_MEMORY = 64
  git_credential_default* = git_credential
  git_credential_acquire_cb* = proc (out: ptr ptr git_credential; url: cstring;
                                     username_from_url: cstring;
                                     allowed_types: cuint; payload: pointer): cint {.
      cdecl.}
  git_credential_acquire_cbNim* = proc (out: ptr ptr git_credential;
                                        url: cstring;
                                        username_from_url: cstring;
                                        allowed_types: cuint): cint
  LIBSSH2_SESSION* = LIBSSH2_SESSION
  LIBSSH2_USERAUTH_KBDINT_PROMPT* = LIBSSH2_USERAUTH_KBDINT_PROMPT
  LIBSSH2_USERAUTH_KBDINT_RESPONSE* = LIBSSH2_USERAUTH_KBDINT_RESPONSE
  git_credential_ssh_interactive_cb* = proc (name: cstring; name_len: cint;
      instruction: cstring; instruction_len: cint; num_prompts: cint;
      prompts: ptr LIBSSH2_USERAUTH_KBDINT_PROMPT;
      responses: ptr LIBSSH2_USERAUTH_KBDINT_RESPONSE; abstract: ptr pointer): void {.
      cdecl.}
  git_credential_sign_cb* = proc (session: ptr LIBSSH2_SESSION;
                                  sig: ptr ptr uchar; sig_len: ptr size_t;
                                  data: ptr uchar; data_len: size_t;
                                  abstract: ptr pointer): cint {.cdecl.}
  git_clone_local_t* = enum ## @}
    GIT_CLONE_LOCAL_AUTO = 0, GIT_CLONE_LOCAL = 1, GIT_CLONE_NO_LOCAL = 2,
    GIT_CLONE_LOCAL_NO_LINKS = 3
  git_remote_create_cb* = proc (out: ptr ptr git_remote;
                                repo: ptr git_repository; name: cstring;
                                url: cstring; payload: pointer): cint {.cdecl.}
  git_remote_create_cbNim* = proc (out: ptr ptr git_remote;
                                   repo: ptr git_repository; name: cstring;
                                   url: cstring): cint
  git_repository_create_cb* = proc (out: ptr ptr git_repository; path: cstring;
                                    bare: cint; payload: pointer): cint {.cdecl.}
  git_repository_create_cbNim* = proc (out: ptr ptr git_repository;
                                       path: cstring; bare: cint): cint
  git_clone_options* {.bycopy, importc: "git_clone_options".} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    bare*: cint
    local*: git_clone_local_t
    checkout_branch*: cstring
    repository_cb*: git_repository_create_cb
    repository_cb_payload*: pointer
    remote_cb*: git_remote_create_cb
    remote_cb_payload*: pointer

  git_cherrypick_options* {.bycopy, importc: "git_cherrypick_options".} = object
    ## @} 
                                                                                 ## These declarations have moved. 
    version*: cuint
    mainline*: cuint         ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
  
  git_index_time* {.bycopy, importc: "git_index_time".} = object
    ## Options for the checkout 
                                                                 ## @} 
                                                                 ## Time structure used in a git index entry 
    seconds*: int32
    nanoseconds*: uint32     ## nsec should not be stored as time_t compatible 
  
  git_index_entry* {.bycopy, importc: "git_index_entry".} = object
    ctime*: git_index_time
    mtime*: git_index_time
    dev*: uint32
    ino*: uint32
    mode*: uint32
    uid*: uint32
    gid*: uint32
    file_size*: uint32
    id*: git_oid
    flags*: uint16
    flags_extended*: uint16
    path*: cstring

  git_index_entry_flag_t* = enum
    GIT_INDEX_ENTRY_EXTENDED = 0
  git_index_entry_extended_flag_t* = enum
    GIT_INDEX_ENTRY_INTENT_TO_ADD = 8192, GIT_INDEX_ENTRY_SKIP_WORKTREE = 16384,
    GIT_INDEX_ENTRY_EXTENDED_FLAGS = 24576, GIT_INDEX_ENTRY_UPTODATE = 4
  git_index_capability_t* = enum ## Capabilities of system that affect index actions.
    GIT_INDEX_CAPABILITY_IGNORE_CASE = 1, GIT_INDEX_CAPABILITY_NO_FILEMODE = 2,
    GIT_INDEX_CAPABILITY_NO_SYMLINKS = 4, GIT_INDEX_CAPABILITY_FROM_OWNER = -1
  git_index_matched_path_cb* = proc (path: cstring; matched_pathspec: cstring;
                                     payload: pointer): cint {.cdecl.}
  git_index_matched_path_cbNim* = proc (path: cstring; matched_pathspec: cstring): cint
  git_index_add_option_t* = enum ## Callback for APIs that add/remove/update files matching pathspec 
                                  ## Flags for APIs that add files matching pathspec
    GIT_INDEX_ADD_DEFAULT = 0, GIT_INDEX_ADD_FORCE = 1,
    GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 2, GIT_INDEX_ADD_CHECK_PATHSPEC = 4
  git_index_stage_t* = enum ## Git index stage states
    GIT_INDEX_STAGE_ANY = -1, GIT_INDEX_STAGE_NORMAL = 0, ## A normal staged file in the index. 
    GIT_INDEX_STAGE_ANCESTOR = 1, ## The ancestor side of a conflict. 
    GIT_INDEX_STAGE_OURS = 2, ## The "ours" side of a conflict. 
    GIT_INDEX_STAGE_THEIRS = 3 ## The "theirs" side of a conflict. 
  git_trace_level_t* = enum ## @}
                             ## @{
                             ## Index entry manipulation 
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
    GIT_TRACE_NONE = 0,     ## No tracing will be performed. 
    GIT_TRACE_FATAL = 1,    ## Severe errors that may impact the program's execution 
    GIT_TRACE_ERROR = 2,    ## Errors that do not impact the program's execution 
    GIT_TRACE_WARN = 3,     ## Warnings that suggest abnormal data 
    GIT_TRACE_INFO = 4,     ## Informational messages about program execution 
    GIT_TRACE_DEBUG = 5,    ## Detailed data that allows for debugging 
    GIT_TRACE_TRACE = 6      ## Exceptionally detailed debugging data 
  git_trace_cb* = proc (level: git_trace_level_t; msg: cstring): void {.cdecl.}
  git_error_code* = enum    ## @} 
                             ## Generic return codes
    GIT_OK = 0, GIT_ERROR = -1, ## No error 
    GIT_ENOTFOUND = -3,     ## Generic error 
    GIT_EEXISTS = -4,       ## Requested object could not be found 
    GIT_EAMBIGUOUS = -5,    ## Object exists preventing operation 
    GIT_EBUFS = -6,         ## More than one object matches 
    GIT_EUSER = -7,         ## Output buffer too short to hold data 
    GIT_EBAREREPO = -8, GIT_EUNBORNBRANCH = -9, ## Operation not allowed on bare repository 
    GIT_EUNMERGED = -10,    ## HEAD refers to branch with no commits 
    GIT_ENONFASTFORWARD = -11, ## Merge in progress prevented operation 
    GIT_EINVALIDSPEC = -12, ## Reference was not fast-forwardable 
    GIT_ECONFLICT = -13,    ## Name/ref spec was not in a valid format 
    GIT_ELOCKED = -14,      ## Checkout conflicts prevented operation 
    GIT_EMODIFIED = -15,    ## Lock file prevented operation 
    GIT_EAUTH = -16,        ## Reference value does not match expected 
    GIT_ECERTIFICATE = -17, ## Authentication error 
    GIT_EAPPLIED = -18,     ## Server certificate is invalid 
    GIT_EPEEL = -19,        ## Patch/merge has already been applied 
    GIT_EEOF = -20,         ## The requested peel operation is not possible 
    GIT_EINVALID = -21,     ## Unexpected EOF 
    GIT_EUNCOMMITTED = -22, ## Invalid operation or input 
    GIT_EDIRECTORY = -23,   ## Uncommitted changes in index prevented operation 
    GIT_EMERGECONFLICT = -24, ## The operation is not valid for a directory 
    GIT_PASSTHROUGH = -30,  ## A merge conflict exists and cannot continue 
    GIT_ITEROVER = -31,     ## A user-configured callback refused to act 
    GIT_RETRY = -32,        ## Signals end of iteration with iterator 
    GIT_EMISMATCH = -33,    ## Internal only 
    GIT_EINDEXDIRTY = -34,  ## Hashsum mismatch in object 
    GIT_EAPPLYFAIL = -35     ## Unsaved changes in the index would be overwritten 
  git_error* {.bycopy, importc: "git_error".} = object
    ## Patch application failed 
    message*: cstring
    klass*: cint

  git_error_t* = enum       ## Error classes
    GIT_ERROR_NONE = 0, GIT_ERROR_NOMEMORY = 1, GIT_ERROR_OS = 2,
    GIT_ERROR_INVALID = 3, GIT_ERROR_REFERENCE = 4, GIT_ERROR_ZLIB = 5,
    GIT_ERROR_REPOSITORY = 6, GIT_ERROR_CONFIG = 7, GIT_ERROR_REGEX = 8,
    GIT_ERROR_ODB = 9, GIT_ERROR_INDEX = 10, GIT_ERROR_OBJECT = 11,
    GIT_ERROR_NET = 12, GIT_ERROR_TAG = 13, GIT_ERROR_TREE = 14,
    GIT_ERROR_INDEXER = 15, GIT_ERROR_SSL = 16, GIT_ERROR_SUBMODULE = 17,
    GIT_ERROR_THREAD = 18, GIT_ERROR_STASH = 19, GIT_ERROR_CHECKOUT = 20,
    GIT_ERROR_FETCHHEAD = 21, GIT_ERROR_MERGE = 22, GIT_ERROR_SSH = 23,
    GIT_ERROR_FILTER = 24, GIT_ERROR_REVERT = 25, GIT_ERROR_CALLBACK = 26,
    GIT_ERROR_CHERRYPICK = 27, GIT_ERROR_DESCRIBE = 28, GIT_ERROR_REBASE = 29,
    GIT_ERROR_FILESYSTEM = 30, GIT_ERROR_PATCH = 31, GIT_ERROR_WORKTREE = 32,
    GIT_ERROR_SHA1 = 33, GIT_ERROR_HTTP = 34, GIT_ERROR_INTERNAL = 35
  git_odb_stream_t* = enum  ## @} 
                             ## Streaming mode
    GIT_STREAM_RDONLY = 2, GIT_STREAM_WRONLY = 4, GIT_STREAM_RW = 6
  git_odb_stream* {.bycopy, importc: "git_odb_stream".} = object
    backend*: ptr git_odb_backend
    mode*: cuint
    hash_ctx*: pointer
    declared_size*: git_object_size_t
    received_bytes*: git_object_size_t
    read*: proc (stream: ptr git_odb_stream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    write*: proc (stream: ptr git_odb_stream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    finalize_write*: proc (stream: ptr git_odb_stream; oid: ptr git_oid): cint {.
        cdecl.}
    free*: proc (stream: ptr git_odb_stream): void {.cdecl.}

  git_odb_writepack* {.bycopy, importc: "git_odb_writepack".} = object
    ## A stream to write a pack file to the ODB 
    backend*: ptr git_odb_backend
    append*: proc (writepack: ptr git_odb_writepack; data: pointer;
                   size: size_t; stats: ptr git_indexer_progress): cint {.cdecl.}
    commit*: proc (writepack: ptr git_odb_writepack;
                   stats: ptr git_indexer_progress): cint {.cdecl.}
    free*: proc (writepack: ptr git_odb_writepack): void {.cdecl.}

  git_message_trailer* {.bycopy, importc: "git_message_trailer".} = object
    key*: cstring
    value*: cstring

  git_message_trailer_array* {.bycopy, importc: "git_message_trailer_array".} = object
    trailers*: ptr git_message_trailer
    count*: size_t
    trailer_block* {.importc: "_trailer_block".}: cstring ## private 
  
  git_credential_userpass_payload* {.bycopy,
                                     importc: "git_credential_userpass_payload".} = object
    ## @} 
    username*: cstring
    password*: cstring

  git_packbuilder_stage_t* = enum ## @} 
                                   ## @}
    GIT_PACKBUILDER_ADDING_OBJECTS = 0, GIT_PACKBUILDER_DELTAFICATION = 1
  git_packbuilder_foreach_cb* = proc (buf: pointer; size: size_t;
                                      payload: pointer): cint {.cdecl.}
  git_packbuilder_foreach_cbNim* = proc (buf: pointer; size: size_t): cint
  git_packbuilder_progress* = proc (stage: cint; current: uint32; total: uint32;
                                    payload: pointer): cint {.cdecl.}
  git_packbuilder_progressNim* = proc (stage: cint; current: uint32;
                                       total: uint32): cint
  git_pathspec_flag_t* = enum
    GIT_PATHSPEC_DEFAULT = 0, GIT_PATHSPEC_IGNORE_CASE = 1,
    GIT_PATHSPEC_USE_CASE = 2, GIT_PATHSPEC_NO_GLOB = 4,
    GIT_PATHSPEC_NO_MATCH_ERROR = 8, GIT_PATHSPEC_FIND_FAILURES = 16,
    GIT_PATHSPEC_FAILURES_ONLY = 32
  git_worktree_add_options* {.bycopy, importc: "git_worktree_add_options".} = object
    version*: cuint
    lock*: cint
    ref*: ptr git_reference  ## lock newly created worktree 
  
  git_worktree_prune_t* = enum ## reference to use for the new worktree HEAD
    GIT_WORKTREE_PRUNE_VALID = 1, ## Prune working tree even if working tree is valid 
    GIT_WORKTREE_PRUNE_LOCKED = 2, ## Prune working tree even if it is locked 
    GIT_WORKTREE_PRUNE_WORKING_TREE = 4 ## Prune checked out working tree 
  git_worktree_prune_options* {.bycopy, importc: "git_worktree_prune_options".} = object
    version*: cuint
    flags*: uint32

  git_proxy_t* = enum       ## @}
    GIT_PROXY_NONE = 0, GIT_PROXY_AUTO = 1, GIT_PROXY_SPECIFIED = 2
  git_proxy_options* {.bycopy, importc: "git_proxy_options".} = object
    version*: cuint
    type*: git_proxy_t
    url*: cstring
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    payload*: pointer

  git_reset_t* = enum
    GIT_RESET_SOFT = 1, GIT_RESET_MIXED = 2, ## Move the head to the given commit 
    GIT_RESET_HARD = 3       ## SOFT plus reset index to the commit 
  git_apply_delta_cb* = proc (delta: ptr git_diff_delta; payload: pointer): cint {.
      cdecl.}
  git_apply_delta_cbNim* = proc (delta: ptr git_diff_delta): cint
  git_apply_hunk_cb* = proc (hunk: ptr git_diff_hunk; payload: pointer): cint {.
      cdecl.}
  git_apply_hunk_cbNim* = proc (hunk: ptr git_diff_hunk): cint
  git_apply_flags_t* = enum ## MIXED plus changes in working tree discarded 
                             ## @} 
                             ## Flags controlling the behavior of git_apply
    GIT_APPLY_CHECK = 1
  git_apply_options* {.bycopy, importc: "git_apply_options".} = object
    version*: cuint
    delta_cb*: git_apply_delta_cb ## The version 
                                  ## When applying a patch, callback that will be made per delta (file). 
    hunk_cb*: git_apply_hunk_cb ## When applying a patch, callback that will be made per hunk. 
    payload*: pointer        ## Payload passed to both delta_cb & hunk_cb. 
    flags*: cuint            ## Bitmask of git_apply_flags_t 
  
  git_apply_location_t* = enum ## Possible application locations for git_apply
    GIT_APPLY_LOCATION_WORKDIR = 0, GIT_APPLY_LOCATION_INDEX = 1,
    GIT_APPLY_LOCATION_BOTH = 2
  git_revparse_mode_t* = enum ## @}
    GIT_REVPARSE_SINGLE = 1, ## The spec targeted a single object. 
    GIT_REVPARSE_RANGE = 2, ## The spec targeted a range of commits. 
    GIT_REVPARSE_MERGE_BASE = 4 ## The spec used the '...' operator, which invokes special semantics. 
  git_revspec* {.bycopy, importc: "git_revspec".} = object
    from*: ptr git_object    ## The left element of the revspec; must be freed by the user 
    to*: ptr git_object      ## The right element of the revspec; must be freed by the user 
    flags*: cuint            ## The intent of the revspec (i.e. `git_revparse_mode_t` flags) 
  
  git_attr_t* = git_attr_value_t
  git_cvar_map* = git_configmap
  git_cred* = git_credential
  git_cred_userpass_plaintext* = git_credential_userpass_plaintext
  git_cred_username* = git_credential_username
  git_cred_default* = git_credential_default
  git_cred_ssh_key* = git_credential_ssh_key
  git_cred_ssh_interactive* = git_credential_ssh_interactive
  git_cred_ssh_custom* = git_credential_ssh_custom
  git_cred_acquire_cb* = git_credential_acquire_cb
  git_cred_sign_callback* = git_credential_sign_cb
  git_cred_sign_cb* = git_credential_sign_cb
  git_cred_ssh_interactive_callback* = git_credential_ssh_interactive_cb
  git_cred_ssh_interactive_cb* = git_credential_ssh_interactive_cb
  git_cred_userpass_payload* = git_credential_userpass_payload
  git_trace_callback* = git_trace_cb
  git_transfer_progress* = git_indexer_progress
  git_transfer_progress_cb* = git_indexer_progress_cb
  git_push_transfer_progress* = git_push_transfer_progress_cb
  git_headlist_cb* = proc (rhead: ptr git_remote_head; payload: pointer): cint {.
      cdecl.}
  git_headlist_cbNim* = proc (rhead: ptr git_remote_head): cint
  git_cert_t* = enum        ## The type of a remote completion event 
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
                             ## @}
    GIT_CERT_NONE = 0, GIT_CERT_X509 = 1, GIT_CERT_HOSTKEY_LIBSSH2 = 2,
    GIT_CERT_STRARRAY = 3
  git_cert* {.bycopy, importc: "git_cert".} = object
    cert_type*: git_cert_t

  git_transport_certificate_check_cb* = proc (cert: ptr git_cert; valid: cint;
      host: cstring; payload: pointer): cint {.cdecl.}
  git_transport_certificate_check_cbNim* = proc (cert: ptr git_cert;
      valid: cint; host: cstring): cint
  git_cert_ssh_t* = enum
    GIT_CERT_SSH_MD5 = 1,   ## MD5 is available 
    GIT_CERT_SSH_SHA1 = 2,  ## SHA-1 is available 
    GIT_CERT_SSH_SHA256 = 4  ## SHA-256 is available 
  git_cert_hostkey* {.bycopy, importc: "git_cert_hostkey".} = object
    parent*: git_cert
    type*: git_cert_ssh_t    ## The parent cert 
    hash_md5*: ptr UncheckedArray[uchar]
    hash_sha1*: ptr UncheckedArray[uchar]
    hash_sha256*: ptr UncheckedArray[uchar]

  git_cert_x509* {.bycopy, importc: "git_cert_x509".} = object
    parent*: git_cert
    data*: pointer           ## The parent cert 
    len*: size_t

  git_submodule_status_t* = enum ## @}
    GIT_SUBMODULE_STATUS_IN_HEAD = 1, GIT_SUBMODULE_STATUS_IN_INDEX = 2,
    GIT_SUBMODULE_STATUS_IN_CONFIG = 4, GIT_SUBMODULE_STATUS_IN_WD = 8,
    GIT_SUBMODULE_STATUS_INDEX_ADDED = 16,
    GIT_SUBMODULE_STATUS_INDEX_DELETED = 32,
    GIT_SUBMODULE_STATUS_INDEX_MODIFIED = 64,
    GIT_SUBMODULE_STATUS_WD_UNINITIALIZED = 128,
    GIT_SUBMODULE_STATUS_WD_ADDED = 256, GIT_SUBMODULE_STATUS_WD_DELETED = 512,
    GIT_SUBMODULE_STATUS_WD_MODIFIED = 1024,
    GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = 2048,
    GIT_SUBMODULE_STATUS_WD_WD_MODIFIED = 4096,
    GIT_SUBMODULE_STATUS_WD_UNTRACKED = 8192
  git_submodule_cb* = proc (sm: ptr git_submodule; name: cstring;
                            payload: pointer): cint {.cdecl.}
  git_submodule_cbNim* = proc (sm: ptr git_submodule; name: cstring): cint
  git_submodule_update_options* {.bycopy,
                                  importc: "git_submodule_update_options".} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    allow_fetch*: cint

  git_status_t* = enum      ## @}
    GIT_STATUS_CURRENT = 0, GIT_STATUS_INDEX_NEW = 1,
    GIT_STATUS_INDEX_MODIFIED = 2, GIT_STATUS_INDEX_DELETED = 4,
    GIT_STATUS_INDEX_RENAMED = 8, GIT_STATUS_INDEX_TYPECHANGE = 16,
    GIT_STATUS_WT_NEW = 128, GIT_STATUS_WT_MODIFIED = 256,
    GIT_STATUS_WT_DELETED = 512, GIT_STATUS_WT_TYPECHANGE = 1024,
    GIT_STATUS_WT_RENAMED = 2048, GIT_STATUS_WT_UNREADABLE = 4096,
    GIT_STATUS_IGNORED = 16384, GIT_STATUS_CONFLICTED = 32768
  git_status_cb* = proc (path: cstring; status_flags: cuint; payload: pointer): cint {.
      cdecl.}
  git_status_cbNim* = proc (path: cstring; status_flags: cuint): cint
  git_status_show_t* = enum
    GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0, GIT_STATUS_SHOW_INDEX_ONLY = 1,
    GIT_STATUS_SHOW_WORKDIR_ONLY = 2
  git_status_opt_t* = enum
    GIT_STATUS_OPT_INCLUDE_UNTRACKED = 1, GIT_STATUS_OPT_INCLUDE_IGNORED = 2,
    GIT_STATUS_OPT_INCLUDE_UNMODIFIED = 4,
    GIT_STATUS_OPT_EXCLUDE_SUBMODULES = 8,
    GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS = 16,
    GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH = 32,
    GIT_STATUS_OPT_RECURSE_IGNORED_DIRS = 64,
    GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX = 128,
    GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR = 256,
    GIT_STATUS_OPT_SORT_CASE_SENSITIVELY = 512,
    GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY = 1024,
    GIT_STATUS_OPT_RENAMES_FROM_REWRITES = 2048,
    GIT_STATUS_OPT_NO_REFRESH = 4096, GIT_STATUS_OPT_UPDATE_INDEX = 8192,
    GIT_STATUS_OPT_INCLUDE_UNREADABLE = 16384,
    GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED = 32768
  git_status_options* {.bycopy, importc: "git_status_options".} = object
    version*: cuint
    show*: git_status_show_t ## The version 
    flags*: cuint
    pathspec*: git_strarray
    baseline*: ptr git_tree

  git_status_entry* {.bycopy, importc: "git_status_entry".} = object
    status*: git_status_t
    head_to_index*: ptr git_diff_delta
    index_to_workdir*: ptr git_diff_delta

  git_revert_options* {.bycopy, importc: "git_revert_options".} = object
    ## @} 
    version*: cuint
    mainline*: cuint         ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
  
  git_buf* {.bycopy, importc: "git_buf".} = object
    ## Options for the checkout 
                                                   ## @} 
    ptr*: cstring
    asize*: size_t
    size*: size_t

  git_tag_foreach_cb* = proc (name: cstring; oid: ptr git_oid; payload: pointer): cint {.
      cdecl.}
  git_tag_foreach_cbNim* = proc (name: cstring; oid: ptr git_oid): cint
  git_diff_option_t* = enum ## @} 
                             ## @}
    GIT_DIFF_NORMAL = 0,    ## Normal diff, the default 
    GIT_DIFF_REVERSE = 1,   ## Reverse the sides of the diff 
    GIT_DIFF_INCLUDE_IGNORED = 2, ## Include ignored files in the diff 
    GIT_DIFF_RECURSE_IGNORED_DIRS = 4, GIT_DIFF_INCLUDE_UNTRACKED = 8, ## Include untracked files in the diff 
    GIT_DIFF_RECURSE_UNTRACKED_DIRS = 16, GIT_DIFF_INCLUDE_UNMODIFIED = 32, ## Include unmodified files in the diff 
    GIT_DIFF_INCLUDE_TYPECHANGE = 64, GIT_DIFF_INCLUDE_TYPECHANGE_TREES = 128, GIT_DIFF_IGNORE_FILEMODE = 256, ## Ignore file mode changes 
    GIT_DIFF_IGNORE_SUBMODULES = 512, ## Treat all submodules as unmodified 
    GIT_DIFF_IGNORE_CASE = 1024, ## Use case insensitive filename comparisons 
    GIT_DIFF_INCLUDE_CASECHANGE = 2048, GIT_DIFF_DISABLE_PATHSPEC_MATCH = 4096,
    GIT_DIFF_SKIP_BINARY_CHECK = 8192,
    GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS = 16384, GIT_DIFF_UPDATE_INDEX = 32768, GIT_DIFF_INCLUDE_UNREADABLE = 65536, ## Include unreadable files in the diff 
    GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = 131072, ## Include unreadable files in the diff 
    GIT_DIFF_INDENT_HEURISTIC = 262144, GIT_DIFF_FORCE_TEXT = 1048576, ## Treat all files as text, disabling binary attributes & detection 
    GIT_DIFF_FORCE_BINARY = 2097152, ## Treat all files as binary, disabling text diffs 
    GIT_DIFF_IGNORE_WHITESPACE = 4194304, ## Ignore all whitespace 
    GIT_DIFF_IGNORE_WHITESPACE_CHANGE = 8388608, ## Ignore changes in amount of whitespace 
    GIT_DIFF_IGNORE_WHITESPACE_EOL = 16777216, ## Ignore whitespace at end of line 
    GIT_DIFF_SHOW_UNTRACKED_CONTENT = 33554432,
    GIT_DIFF_SHOW_UNMODIFIED = 67108864, GIT_DIFF_PATIENCE = 268435456, ## Use the "patience diff" algorithm 
    GIT_DIFF_MINIMAL = 536870912, ## Take extra time to find minimal diff 
    GIT_DIFF_SHOW_BINARY = 1073741824
  git_diff_flag_t* = enum
    GIT_DIFF_FLAG_BINARY = 1, GIT_DIFF_FLAG_NOT_BINARY = 2, ## file(s) treated as binary data 
    GIT_DIFF_FLAG_VALID_ID = 4, ## file(s) treated as text data 
    GIT_DIFF_FLAG_EXISTS = 8 ## `id` value is known correct 
  git_delta_t* = enum       ## file exists at this side of the delta
    GIT_DELTA_UNMODIFIED = 0, GIT_DELTA_ADDED = 1, ## no changes 
    GIT_DELTA_DELETED = 2,  ## entry does not exist in old version 
    GIT_DELTA_MODIFIED = 3, ## entry does not exist in new version 
    GIT_DELTA_RENAMED = 4,  ## entry content changed between old and new 
    GIT_DELTA_COPIED = 5,   ## entry was renamed between old and new 
    GIT_DELTA_IGNORED = 6,  ## entry was copied from another old entry 
    GIT_DELTA_UNTRACKED = 7, ## entry is ignored item in workdir 
    GIT_DELTA_TYPECHANGE = 8, ## entry is untracked item in workdir 
    GIT_DELTA_UNREADABLE = 9, ## type of entry changed between old and new 
    GIT_DELTA_CONFLICTED = 10 ## entry is unreadable 
  git_diff_file* {.bycopy, importc: "git_diff_file".} = object
    ## entry in the index is conflicted 
    id*: git_oid
    path*: cstring
    size*: git_object_size_t
    flags*: uint32
    mode*: uint16
    id_abbrev*: uint16

  git_diff_delta* {.bycopy, importc: "git_diff_delta".} = object
    status*: git_delta_t
    flags*: uint32
    similarity*: uint16      ## git_diff_flag_t values 
    nfiles*: uint16          ## for RENAMED and COPIED, value 0-100 
    old_file*: git_diff_file ## number of files in this delta 
    new_file*: git_diff_file

  git_diff_notify_cb* = proc (diff_so_far: ptr git_diff;
                              delta_to_add: ptr git_diff_delta;
                              matched_pathspec: cstring; payload: pointer): cint {.
      cdecl.}
  git_diff_notify_cbNim* = proc (diff_so_far: ptr git_diff;
                                 delta_to_add: ptr git_diff_delta;
                                 matched_pathspec: cstring): cint
  git_diff_progress_cb* = proc (diff_so_far: ptr git_diff; old_path: cstring;
                                new_path: cstring; payload: pointer): cint {.
      cdecl.}
  git_diff_progress_cbNim* = proc (diff_so_far: ptr git_diff; old_path: cstring;
                                   new_path: cstring): cint
  git_diff_options* {.bycopy, importc: "git_diff_options".} = object
    version*: cuint
    flags*: uint32           ## version for the struct 
    ignore_submodules*: git_submodule_ignore_t ## options controlling which files are in the diff 
                                               ## Overrides the submodule ignore setting for all submodules in the diff. 
    pathspec*: git_strarray
    notify_cb*: git_diff_notify_cb
    progress_cb*: git_diff_progress_cb
    payload*: pointer        ## The payload to pass to the callback functions. 
    context_lines*: uint32   ## options controlling how to diff text is generated 
    interhunk_lines*: uint32
    id_abbrev*: uint16
    max_size*: git_off_t
    old_prefix*: cstring
    new_prefix*: cstring

  git_diff_file_cb* = proc (delta: ptr git_diff_delta; progress: cfloat;
                            payload: pointer): cint {.cdecl.}
  git_diff_file_cbNim* = proc (delta: ptr git_diff_delta; progress: cfloat): cint
  git_diff_binary_t* = enum ## The current version of the diff options structure
    GIT_DIFF_BINARY_NONE = 0, ## There is no binary delta. 
    GIT_DIFF_BINARY_LITERAL = 1, ## The binary data is the literal contents of the file. 
    GIT_DIFF_BINARY_DELTA = 2 ## The binary data is the delta from one side to the other. 
  git_diff_binary_file* {.bycopy, importc: "git_diff_binary_file".} = object
    ## The contents of one of the files in a binary diff. 
    type*: git_diff_binary_t ## The type of binary data for this file. 
    data*: cstring           ## The binary data, deflated. 
    datalen*: size_t         ## The length of the binary data. 
    inflatedlen*: size_t     ## The length of the binary data after inflation. 
  
  git_diff_binary* {.bycopy, importc: "git_diff_binary".} = object
    contains_data*: cuint
    old_file*: git_diff_binary_file
    new_file*: git_diff_binary_file ## The contents of the old file. 
  
  git_diff_binary_cb* = proc (delta: ptr git_diff_delta;
                              binary: ptr git_diff_binary; payload: pointer): cint {.
      cdecl.}
  git_diff_binary_cbNim* = proc (delta: ptr git_diff_delta;
                                 binary: ptr git_diff_binary): cint
  git_diff_hunk* {.bycopy, importc: "git_diff_hunk".} = object
    ## The contents of the new file. 
    old_start*: cint
    old_lines*: cint         ## Starting line number in old_file 
    new_start*: cint         ## Number of lines in old_file 
    new_lines*: cint         ## Starting line number in new_file 
    header_len*: size_t      ## Number of lines in new_file 
    header*: ptr UncheckedArray[char] ## Number of bytes in header text 
  
  git_diff_hunk_cb* = proc (delta: ptr git_diff_delta; hunk: ptr git_diff_hunk;
                            payload: pointer): cint {.cdecl.}
  git_diff_hunk_cbNim* = proc (delta: ptr git_diff_delta;
                               hunk: ptr git_diff_hunk): cint
  git_diff_line_t* = enum   ## Header text, NUL-byte terminated
    GIT_DIFF_LINE_CONTEXT = 39 ## These values will be sent to `git_diff_line_cb` along with the line 
  git_diff_line* {.bycopy, importc: "git_diff_line".} = object
    ## For "Binary files x and y differ" 
    origin*: char
    old_lineno*: cint        ## A git_diff_line_t value 
    new_lineno*: cint        ## Line number in old file or -1 for added line 
    num_lines*: cint         ## Line number in new file or -1 for deleted line 
    content_len*: size_t     ## Number of newline characters in content 
    content_offset*: git_off_t ## Number of bytes of data 
    content*: cstring        ## Offset in the original file to the content 
  
  git_diff_line_cb* = proc (delta: ptr git_diff_delta; hunk: ptr git_diff_hunk;
                            line: ptr git_diff_line; payload: pointer): cint {.
      cdecl.}
  git_diff_line_cbNim* = proc (delta: ptr git_diff_delta;
                               hunk: ptr git_diff_hunk; line: ptr git_diff_line): cint
  git_diff_find_t* = enum   ## Pointer to diff text, not NUL-byte terminated 
                             ## user reference data
    GIT_DIFF_FIND_BY_CONFIG = 0, ## Obey `diff.renames`. Overridden by any other GIT_DIFF_FIND_... flag. 
    GIT_DIFF_FIND_RENAMES = 1, ## Look for renames? (`--find-renames`) 
    GIT_DIFF_FIND_RENAMES_FROM_REWRITES = 2, ## Consider old side of MODIFIED for renames? (`--break-rewrites=N`) 
    GIT_DIFF_FIND_COPIES = 4, ## Look for copies? (a la `--find-copies`). 
    GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = 8, GIT_DIFF_FIND_REWRITES = 16, ## Mark significant rewrites for split (`--break-rewrites=/M`) 
    GIT_DIFF_BREAK_REWRITES = 32, ## Actually split large rewrites into delete/add pairs 
    GIT_DIFF_FIND_AND_BREAK_REWRITES = 48, ## Mark rewrites for split and break into delete/add pairs 
    GIT_DIFF_FIND_FOR_UNTRACKED = 64, GIT_DIFF_FIND_IGNORE_WHITESPACE = 4096, ## Measure similarity ignoring all whitespace 
    GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = 8192, ## Measure similarity including all data 
    GIT_DIFF_FIND_EXACT_MATCH_ONLY = 16384, ## Measure similarity only by comparing SHAs (fast and cheap) 
    GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY = 32768,
    GIT_DIFF_FIND_REMOVE_UNMODIFIED = 65536
  git_diff_similarity_metric* {.bycopy, importc: "git_diff_similarity_metric".} = object
    file_signature*: proc (out: ptr pointer; file: ptr git_diff_file;
                           fullpath: cstring; payload: pointer): cint {.cdecl.}
    buffer_signature*: proc (out: ptr pointer; file: ptr git_diff_file;
                             buf: cstring; buflen: size_t; payload: pointer): cint {.
        cdecl.}
    free_signature*: proc (sig: pointer; payload: pointer): void {.cdecl.}
    similarity*: proc (score: ptr cint; siga: pointer; sigb: pointer;
                       payload: pointer): cint {.cdecl.}
    payload*: pointer

  git_diff_find_options* {.bycopy, importc: "git_diff_find_options".} = object
    version*: cuint
    flags*: uint32
    rename_threshold*: uint16
    rename_from_rewrite_threshold*: uint16
    copy_threshold*: uint16
    break_rewrite_threshold*: uint16
    rename_limit*: size_t
    metric*: ptr git_diff_similarity_metric

  git_diff_format_t* = enum ## @{
                             ## @}
                             ## @{
    GIT_DIFF_FORMAT_PATCH = 1, GIT_DIFF_FORMAT_PATCH_HEADER = 2, ## full git diff 
    GIT_DIFF_FORMAT_RAW = 3, ## just the file headers of patch 
    GIT_DIFF_FORMAT_NAME_ONLY = 4, ## like git diff --raw 
    GIT_DIFF_FORMAT_NAME_STATUS = 5, ## like git diff --name-only 
    GIT_DIFF_FORMAT_PATCH_ID = 6 ## like git diff --name-status 
  git_diff_stats_format_t* = enum
    GIT_DIFF_STATS_NONE = 0, ## No stats
    GIT_DIFF_STATS_FULL = 1, ## Full statistics, equivalent of `--stat` 
    GIT_DIFF_STATS_SHORT = 2, ## Short statistics, equivalent of `--shortstat` 
    GIT_DIFF_STATS_NUMBER = 4, ## Number statistics, equivalent of `--numstat` 
    GIT_DIFF_STATS_INCLUDE_SUMMARY = 8 ## Extended header information such as creations, renames and mode changes, equivalent of `--summary` 
  git_diff_format_email_flags_t* = enum
    GIT_DIFF_FORMAT_EMAIL_NONE = 0, ## Normal patch, the default 
    GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = 1 ## Don't insert "[PATCH]" in the subject header
  git_diff_format_email_options* {.bycopy,
                                   importc: "git_diff_format_email_options".} = object
    version*: cuint
    flags*: uint32           ## see `git_diff_format_email_flags_t` above 
    patch_no*: size_t        ## This patch number 
    total_patches*: size_t   ## Total number of patches in this series 
    id*: ptr git_oid         ## id to use for the commit 
    summary*: cstring        ## Summary of the change 
    body*: cstring           ## Commit message's body 
    author*: ptr git_signature ## Author of the change 
  
  git_diff_patchid_options* {.bycopy, importc: "git_diff_patchid_options".} = object
    version*: cuint

  git_describe_strategy_t* = enum ## @}
    GIT_DESCRIBE_DEFAULT = 0, GIT_DESCRIBE_TAGS = 1, GIT_DESCRIBE_ALL = 2
  git_describe_options* {.bycopy, importc: "git_describe_options".} = object
    version*: cuint
    max_candidates_tags*: cuint
    describe_strategy*: cuint ## default: 10 
    pattern*: cstring        ## default: GIT_DESCRIBE_DEFAULT 
    only_follow_first_parent*: cint
    show_commit_oid_as_fallback*: cint

  git_describe_format_options* {.bycopy, importc: "git_describe_format_options".} = object
    version*: cuint
    abbreviated_size*: cuint
    always_use_long_format*: cint
    dirty_suffix*: cstring

  git_repository_open_flag_t* = enum ## @}
    GIT_REPOSITORY_OPEN_NO_SEARCH = 1, GIT_REPOSITORY_OPEN_CROSS_FS = 2,
    GIT_REPOSITORY_OPEN_BARE = 4, GIT_REPOSITORY_OPEN_NO_DOTGIT = 8,
    GIT_REPOSITORY_OPEN_FROM_ENV = 16
  git_repository_init_flag_t* = enum
    GIT_REPOSITORY_INIT_BARE = 1, GIT_REPOSITORY_INIT_NO_REINIT = 2,
    GIT_REPOSITORY_INIT_NO_DOTGIT_DIR = 4, GIT_REPOSITORY_INIT_MKDIR = 8,
    GIT_REPOSITORY_INIT_MKPATH = 16, GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = 32,
    GIT_REPOSITORY_INIT_RELATIVE_GITLINK = 64
  git_repository_init_mode_t* = enum
    GIT_REPOSITORY_INIT_SHARED_UMASK = 0,
    GIT_REPOSITORY_INIT_SHARED_GROUP = 2775,
    GIT_REPOSITORY_INIT_SHARED_ALL = 2777
  git_repository_init_options* {.bycopy, importc: "git_repository_init_options".} = object
    version*: cuint
    flags*: uint32
    mode*: uint32
    workdir_path*: cstring
    description*: cstring
    template_path*: cstring
    initial_head*: cstring
    origin_url*: cstring

  git_repository_item_t* = enum
    GIT_REPOSITORY_ITEM_GITDIR = 0, GIT_REPOSITORY_ITEM_WORKDIR = 1,
    GIT_REPOSITORY_ITEM_COMMONDIR = 2, GIT_REPOSITORY_ITEM_INDEX = 3,
    GIT_REPOSITORY_ITEM_OBJECTS = 4, GIT_REPOSITORY_ITEM_REFS = 5,
    GIT_REPOSITORY_ITEM_PACKED_REFS = 6, GIT_REPOSITORY_ITEM_REMOTES = 7,
    GIT_REPOSITORY_ITEM_CONFIG = 8, GIT_REPOSITORY_ITEM_INFO = 9,
    GIT_REPOSITORY_ITEM_HOOKS = 10, GIT_REPOSITORY_ITEM_LOGS = 11,
    GIT_REPOSITORY_ITEM_MODULES = 12, GIT_REPOSITORY_ITEM_WORKTREES = 13,
    GIT_REPOSITORY_ITEM_LAST = 14
  git_repository_fetchhead_foreach_cb* = proc (ref_name: cstring;
      remote_url: cstring; oid: ptr git_oid; is_merge: cuint; payload: pointer): cint {.
      cdecl.}
  git_repository_fetchhead_foreach_cbNim* = proc (ref_name: cstring;
      remote_url: cstring; oid: ptr git_oid; is_merge: cuint): cint
  git_repository_mergehead_foreach_cb* = proc (oid: ptr git_oid;
      payload: pointer): cint {.cdecl.}
  git_repository_mergehead_foreach_cbNim* = proc (oid: ptr git_oid): cint
  git_repository_state_t* = enum
    GIT_REPOSITORY_STATE_NONE = 0, GIT_REPOSITORY_STATE_MERGE = 1,
    GIT_REPOSITORY_STATE_REVERT = 2, GIT_REPOSITORY_STATE_REVERT_SEQUENCE = 3,
    GIT_REPOSITORY_STATE_CHERRYPICK = 4,
    GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE = 5,
    GIT_REPOSITORY_STATE_BISECT = 6, GIT_REPOSITORY_STATE_REBASE = 7,
    GIT_REPOSITORY_STATE_REBASE_INTERACTIVE = 8,
    GIT_REPOSITORY_STATE_REBASE_MERGE = 9,
    GIT_REPOSITORY_STATE_APPLY_MAILBOX = 10,
    GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE = 11
  git_checkout_strategy_t* = enum ## @}
    GIT_CHECKOUT_NONE = 0, GIT_CHECKOUT_SAFE = 1, ## default is a dry run, no actual updates 
    GIT_CHECKOUT_FORCE = 2, GIT_CHECKOUT_RECREATE_MISSING = 4, ## Allow checkout to recreate missing files 
    GIT_CHECKOUT_ALLOW_CONFLICTS = 16, ## Allow checkout to make safe updates even if conflicts are found 
    GIT_CHECKOUT_REMOVE_UNTRACKED = 32, ## Remove untracked files not in index (that are not ignored) 
    GIT_CHECKOUT_REMOVE_IGNORED = 64, ## Remove ignored files not in index 
    GIT_CHECKOUT_UPDATE_ONLY = 128, ## Only update existing files, don't create new ones 
    GIT_CHECKOUT_DONT_UPDATE_INDEX = 256, GIT_CHECKOUT_NO_REFRESH = 512, ## Don't refresh index/config/etc before doing checkout 
    GIT_CHECKOUT_SKIP_UNMERGED = 1024, ## Allow checkout to skip unmerged files 
    GIT_CHECKOUT_USE_OURS = 2048, ## For unmerged files, checkout stage 2 from index 
    GIT_CHECKOUT_USE_THEIRS = 4096, ## For unmerged files, checkout stage 3 from index 
    GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = 8192, ## Treat pathspec as simple list of exact match file paths 
    GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = 262144, ## Ignore directories in use, they will be left empty 
    GIT_CHECKOUT_DONT_OVERWRITE_IGNORED = 524288, ## Don't overwrite ignored files that exist in the checkout target 
    GIT_CHECKOUT_CONFLICT_STYLE_MERGE = 1048576, ## Write normal merge files for conflicts 
    GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 = 2097152, ## Include common ancestor data in diff3 format files for conflicts 
    GIT_CHECKOUT_DONT_REMOVE_EXISTING = 4194304, ## Don't overwrite existing files or folders 
    GIT_CHECKOUT_DONT_WRITE_INDEX = 8388608, ## Normally checkout writes the index upon completion; this prevents that. 
    GIT_CHECKOUT_UPDATE_SUBMODULES = 65536, ## Recursively checkout submodules with same options (NOT IMPLEMENTED) 
    GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 131072 ## Recursively checkout submodules if HEAD moved in super repo (NOT IMPLEMENTED) 
  git_checkout_notify_t* = enum
    GIT_CHECKOUT_NOTIFY_NONE = 0, GIT_CHECKOUT_NOTIFY_CONFLICT = 1,
    GIT_CHECKOUT_NOTIFY_DIRTY = 2, GIT_CHECKOUT_NOTIFY_UPDATED = 4,
    GIT_CHECKOUT_NOTIFY_UNTRACKED = 8, GIT_CHECKOUT_NOTIFY_IGNORED = 16
  git_checkout_perfdata* {.bycopy, importc: "git_checkout_perfdata".} = object
    ## Checkout performance-reporting structure 
    mkdir_calls*: size_t
    stat_calls*: size_t
    chmod_calls*: size_t

  git_checkout_notify_cb* = proc (why: git_checkout_notify_t; path: cstring;
                                  baseline: ptr git_diff_file;
                                  target: ptr git_diff_file;
                                  workdir: ptr git_diff_file; payload: pointer): cint {.
      cdecl.}
  git_checkout_notify_cbNim* = proc (why: git_checkout_notify_t; path: cstring;
                                     baseline: ptr git_diff_file;
                                     target: ptr git_diff_file;
                                     workdir: ptr git_diff_file): cint
  git_checkout_progress_cb* = proc (path: cstring; completed_steps: size_t;
                                    total_steps: size_t; payload: pointer): void {.
      cdecl.}
  git_checkout_progress_cbNim* = proc (path: cstring; completed_steps: size_t;
                                       total_steps: size_t): void
  git_checkout_perfdata_cb* = proc (perfdata: ptr git_checkout_perfdata;
                                    payload: pointer): void {.cdecl.}
  git_checkout_perfdata_cbNim* = proc (perfdata: ptr git_checkout_perfdata): void
  git_checkout_options* {.bycopy, importc: "git_checkout_options".} = object
    ## Checkout notification callback function 
                                                                             ## Checkout progress notification function 
                                                                             ## Checkout perfdata notification function 
    version*: cuint
    checkout_strategy*: cuint ## The version 
    disable_filters*: cint   ## default will be a safe checkout 
    dir_mode*: cuint         ## don't apply filters like CRLF conversion 
    file_mode*: cuint        ## default is 0755 
    file_open_flags*: cint   ## default is 0644 or 0755 as dictated by blob 
    notify_flags*: cuint     ## default is O_CREAT | O_TRUNC | O_WRONLY 
    notify_cb*: git_checkout_notify_cb ## see `git_checkout_notify_t` above 
    notify_payload*: pointer ## Payload passed to notify_cb 
    progress_cb*: git_checkout_progress_cb ## Optional callback to notify the consumer of checkout progress. 
    progress_payload*: pointer ## Payload passed to progress_cb 
    paths*: git_strarray
    baseline*: ptr git_tree
    baseline_index*: ptr git_index
    target_directory*: cstring
    ancestor_label*: cstring ## alternative checkout path to workdir 
    our_label*: cstring      ## the name of the common ancestor side of conflicts 
    their_label*: cstring    ## the name of the "our" side of conflicts 
    perfdata_cb*: git_checkout_perfdata_cb ## the name of the "their" side of conflicts 
                                           ## Optional callback to notify the consumer of performance data. 
    perfdata_payload*: pointer ## Payload passed to perfdata_cb 
  
  git_stash_flags* = enum   ## @}
    GIT_STASH_DEFAULT = 0, GIT_STASH_KEEP_INDEX = 1,
    GIT_STASH_INCLUDE_UNTRACKED = 2, GIT_STASH_INCLUDE_IGNORED = 4
  git_stash_apply_flags* = enum ## Stash application flags.
    GIT_STASH_APPLY_DEFAULT = 0, GIT_STASH_APPLY_REINSTATE_INDEX = 1
  git_stash_apply_progress_t* = enum ## Stash apply progression states
    GIT_STASH_APPLY_PROGRESS_NONE = 0, GIT_STASH_APPLY_PROGRESS_LOADING_STASH = 1, ## Loading the stashed data from the object database. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX = 2, ## The stored index is being analyzed. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED = 3, ## The modified files are being analyzed. 
    GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED = 4, ## The untracked and ignored files are being analyzed. 
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = 5, ## The untracked files are being written to disk. 
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED = 6, ## The modified files are being written to disk. 
    GIT_STASH_APPLY_PROGRESS_DONE = 7 ## The stash was applied successfully. 
  git_stash_apply_progress_cb* = proc (progress: git_stash_apply_progress_t;
                                       payload: pointer): cint {.cdecl.}
  git_stash_apply_progress_cbNim* = proc (progress: git_stash_apply_progress_t): cint
  git_stash_apply_options* {.bycopy, importc: "git_stash_apply_options".} = object
    version*: cuint
    flags*: uint32           ## See `git_stash_apply_flags`, above. 
    checkout_options*: git_checkout_options ## Options to use when writing files to the working directory. 
    progress_cb*: git_stash_apply_progress_cb ## Optional callback to notify the consumer of application progress. 
    progress_payload*: pointer

  git_stash_cb* = proc (index: size_t; message: cstring; stash_id: ptr git_oid;
                        payload: pointer): cint {.cdecl.}
  git_stash_cbNim* = proc (index: size_t; message: cstring;
                           stash_id: ptr git_oid): cint
  git_direction* = enum     ## @} 
                             ## @}
    GIT_DIRECTION_FETCH = 0, GIT_DIRECTION_PUSH = 1
  git_remote_head* {.bycopy, importc: "git_remote_head".} = object
    local*: cint
    oid*: git_oid            ## available locally 
    loid*: git_oid
    name*: cstring
    symref_target*: cstring

  git_treebuilder_filter_cb* = proc (entry: ptr git_tree_entry; payload: pointer): cint {.
      cdecl.}
  git_treebuilder_filter_cbNim* = proc (entry: ptr git_tree_entry): cint
  git_treewalk_cb* = proc (root: cstring; entry: ptr git_tree_entry;
                           payload: pointer): cint {.cdecl.}
  git_treewalk_cbNim* = proc (root: cstring; entry: ptr git_tree_entry): cint
  git_treewalk_mode* = enum ## @} 
                             ## Callback for the tree traversal method 
                             ## Tree traversal modes
    GIT_TREEWALK_PRE = 0, GIT_TREEWALK_POST = 1 ## Pre-order 
  git_tree_update_t* = enum ## Post-order
    GIT_TREE_UPDATE_UPSERT = 0, ## Update or insert an entry at the specified path 
    GIT_TREE_UPDATE_REMOVE = 1 ## Remove an entry from the specified path 
  git_tree_update* {.bycopy, importc: "git_tree_update".} = object
    action*: git_tree_update_t ## Update action. If it's an removal, only the path is looked at 
    id*: git_oid             ## The entry's id 
    filemode*: git_filemode_t ## The filemode/kind of object 
    path*: cstring           ## The full path from the root tree 
  
  git_blob_filter_flag_t* = enum ## @}
    GIT_BLOB_FILTER_CHECK_FOR_BINARY = 1, ## When set, filters will not be applied to binary files. 
    GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES = 2,
    GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD = 4
  git_blob_filter_options* {.bycopy, importc: "git_blob_filter_options".} = object
    version*: cint
    flags*: uint32           ## Flags to control the filtering process, see `git_blob_filter_flag_t` above 
  
  git_commit_signing_cb* = proc (signature: ptr git_buf;
                                 signature_field: ptr git_buf;
                                 commit_content: cstring; payload: pointer): cint {.
      cdecl.}
  git_commit_signing_cbNim* = proc (signature: ptr git_buf;
                                    signature_field: ptr git_buf;
                                    commit_content: cstring): cint
  git_attr_value_t* = enum  ## @} 
                             ## @} 
                             ## @}
    GIT_ATTR_VALUE_UNSPECIFIED = 0, GIT_ATTR_VALUE_TRUE = 1, ## The attribute has been left unspecified 
    GIT_ATTR_VALUE_FALSE = 2, ## The attribute has been set 
    GIT_ATTR_VALUE_STRING = 3 ## The attribute has been unset 
  git_attr_foreach_cb* = proc (name: cstring; value: cstring; payload: pointer): cint {.
      cdecl.}
  git_attr_foreach_cbNim* = proc (name: cstring; value: cstring): cint
  git_blame_flag_t* = enum  ## This attribute has a value 
                             ## @}
    GIT_BLAME_NORMAL = 0,   ## Normal blame, the default 
    GIT_BLAME_TRACK_COPIES_SAME_FILE = 1,
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = 2,
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = 4,
    GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = 8, GIT_BLAME_FIRST_PARENT = 16,
    GIT_BLAME_USE_MAILMAP = 32, GIT_BLAME_IGNORE_WHITESPACE = 64 ## Ignore whitespace differences 
  git_blame_options* {.bycopy, importc: "git_blame_options".} = object
    version*: cuint
    flags*: uint32           ## A combination of `git_blame_flag_t` 
    min_match_characters*: uint16
    newest_commit*: git_oid  ## The id of the newest commit to consider. The default is HEAD. 
    oldest_commit*: git_oid
    min_line*: size_t
    max_line*: size_t

  git_blame_hunk* {.bycopy, importc: "git_blame_hunk".} = object
    lines_in_hunk*: size_t
    final_commit_id*: git_oid
    final_start_line_number*: size_t
    final_signature*: ptr git_signature
    orig_commit_id*: git_oid
    orig_path*: cstring
    orig_start_line_number*: size_t
    orig_signature*: ptr git_signature
    boundary*: char

  git_sort_t* = enum        ## @}
    GIT_SORT_NONE = 0, GIT_SORT_TOPOLOGICAL = 1, GIT_SORT_TIME = 2,
    GIT_SORT_REVERSE = 4
  git_revwalk_hide_cb* = proc (commit_id: ptr git_oid; payload: pointer): cint {.
      cdecl.}
  git_revwalk_hide_cbNim* = proc (commit_id: ptr git_oid): cint
  git_remote_create_flags* = enum ## @}
    GIT_REMOTE_CREATE_SKIP_INSTEADOF = 1, ## Ignore the repository apply.insteadOf configuration 
    GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 2 ## Don't build a fetchspec from the name if none is set 
  git_remote_create_options* {.bycopy, importc: "git_remote_create_options".} = object
    version*: cuint
    repository*: ptr git_repository
    name*: cstring
    fetchspec*: cstring      ## The fetchspec the remote should use. 
    flags*: cuint            ## Additional flags for the remote. See git_remote_create_flags. 
  
  git_remote_completion_t* = enum
    GIT_REMOTE_COMPLETION_DOWNLOAD = 0, GIT_REMOTE_COMPLETION_INDEXING = 1,
    GIT_REMOTE_COMPLETION_ERROR = 2
  git_push_transfer_progress_cb* = proc (current: cuint; total: cuint;
      bytes: size_t; payload: pointer): cint {.cdecl.}
  git_push_transfer_progress_cbNim* = proc (current: cuint; total: cuint;
      bytes: size_t): cint
  git_push_update* {.bycopy, importc: "git_push_update".} = object
    ## Push network progress notification function 
    src_refname*: cstring
    dst_refname*: cstring
    src*: git_oid
    dst*: git_oid

  git_push_negotiation* = proc (updates: ptr ptr git_push_update; len: size_t;
                                payload: pointer): cint {.cdecl.}
  git_push_negotiationNim* = proc (updates: ptr ptr git_push_update; len: size_t): cint
  git_push_update_reference_cb* = proc (refname: cstring; status: cstring;
                                        data: pointer): cint {.cdecl.}
  git_push_update_reference_cbNim* = proc (refname: cstring; status: cstring): cint
  git_url_resolve_cb* = proc (url_resolved: ptr git_buf; url: cstring;
                              direction: cint; payload: pointer): cint {.cdecl.}
  git_url_resolve_cbNim* = proc (url_resolved: ptr git_buf; url: cstring;
                                 direction: cint): cint
  git_remote_callbacks* {.bycopy, importc: "git_remote_callbacks".} = object
    version*: cuint
    sideband_progress*: git_transport_message_cb ## The version 
    completion*: proc (type: git_remote_completion_t; data: pointer): cint {.
        cdecl.}
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    transfer_progress*: git_indexer_progress_cb
    update_tips*: proc (refname: cstring; a: ptr git_oid; b: ptr git_oid;
                        data: pointer): cint {.cdecl.}
    pack_progress*: git_packbuilder_progress
    push_transfer_progress*: git_push_transfer_progress_cb
    push_update_reference*: git_push_update_reference_cb
    push_negotiation*: git_push_negotiation
    transport*: git_transport_cb
    payload*: pointer
    resolve_url*: git_url_resolve_cb

  git_fetch_prune_t* = enum ## Acceptable prune settings when fetching
    GIT_FETCH_PRUNE_UNSPECIFIED = 0, GIT_FETCH_PRUNE = 1, GIT_FETCH_NO_PRUNE = 2
  git_remote_autotag_option_t* = enum
    GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0, GIT_REMOTE_DOWNLOAD_TAGS_AUTO = 1,
    GIT_REMOTE_DOWNLOAD_TAGS_NONE = 2, GIT_REMOTE_DOWNLOAD_TAGS_ALL = 3
  git_fetch_options* {.bycopy, importc: "git_fetch_options".} = object
    version*: cint
    callbacks*: git_remote_callbacks
    prune*: git_fetch_prune_t
    update_fetchhead*: cint
    download_tags*: git_remote_autotag_option_t
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray

  git_push_options* {.bycopy, importc: "git_push_options".} = object
    version*: cuint
    pb_parallelism*: cuint
    callbacks*: git_remote_callbacks
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray

  git_indexer_progress* {.bycopy, importc: "git_indexer_progress".} = object
    total_objects*: cuint    ## number of objects in the packfile being indexed 
    indexed_objects*: cuint  ## received objects that have been hashed 
    received_objects*: cuint ## received_objects: objects which have been downloaded 
    local_objects*: cuint
    total_deltas*: cuint     ## number of deltas in the packfile being indexed 
    indexed_deltas*: cuint   ## received deltas that have been indexed 
    received_bytes*: size_t  ## size of the packfile received up to now 
  
  git_indexer_progress_cb* = proc (stats: ptr git_indexer_progress;
                                   payload: pointer): cint {.cdecl.}
  git_indexer_progress_cbNim* = proc (stats: ptr git_indexer_progress): cint
  git_indexer_options* {.bycopy, importc: "git_indexer_options".} = object
    version*: cuint
    progress_cb*: git_indexer_progress_cb ## progress_cb function to call with progress information 
    progress_cb_payload*: pointer ## progress_cb_payload payload for the progress callback 
    verify*: uchar           ## Do connectivity checks for the received pack 
  
  git_merge_file_input* {.bycopy, importc: "git_merge_file_input".} = object
    ## @} 
    version*: cuint
    ptr*: cstring            ## Pointer to the contents of the file. 
    size*: size_t            ## Size of the contents pointed to in `ptr`. 
    path*: cstring           ## File name of the conflicted file, or `NULL` to not merge the path. 
    mode*: cuint             ## File mode of the conflicted file, or `0` to not merge the mode. 
  
  git_merge_flag_t* = enum
    GIT_MERGE_FIND_RENAMES = 1, GIT_MERGE_FAIL_ON_CONFLICT = 2,
    GIT_MERGE_SKIP_REUC = 4, GIT_MERGE_NO_RECURSIVE = 8
  git_merge_file_favor_t* = enum
    GIT_MERGE_FILE_FAVOR_NORMAL = 0, GIT_MERGE_FILE_FAVOR_OURS = 1,
    GIT_MERGE_FILE_FAVOR_THEIRS = 2, GIT_MERGE_FILE_FAVOR_UNION = 3
  git_merge_file_flag_t* = enum
    GIT_MERGE_FILE_DEFAULT = 0, ## Defaults 
    GIT_MERGE_FILE_STYLE_MERGE = 1, ## Create standard conflicted merge files 
    GIT_MERGE_FILE_STYLE_DIFF3 = 2, ## Create diff3-style files 
    GIT_MERGE_FILE_SIMPLIFY_ALNUM = 4, ## Condense non-alphanumeric regions for simplified diff file 
    GIT_MERGE_FILE_IGNORE_WHITESPACE = 8, ## Ignore all whitespace 
    GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = 16, ## Ignore changes in amount of whitespace 
    GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL = 32, ## Ignore whitespace at end of line 
    GIT_MERGE_FILE_DIFF_PATIENCE = 64, ## Use the "patience diff" algorithm 
    GIT_MERGE_FILE_DIFF_MINIMAL = 128 ## Take extra time to find minimal diff 
  git_merge_file_options* {.bycopy, importc: "git_merge_file_options".} = object
    version*: cuint
    ancestor_label*: cstring
    our_label*: cstring
    their_label*: cstring
    favor*: git_merge_file_favor_t ## The file to favor in region conflicts. 
    flags*: uint32           ## see `git_merge_file_flag_t` above 
    marker_size*: cushort

  git_merge_file_result* {.bycopy, importc: "git_merge_file_result".} = object
    automergeable*: cuint
    path*: cstring
    mode*: cuint             ## The mode that the resultant merge file should use.  
    ptr*: cstring            ## The contents of the merge. 
    len*: size_t             ## The length of the merge contents. 
  
  git_merge_options* {.bycopy, importc: "git_merge_options".} = object
    version*: cuint
    flags*: uint32           ## See `git_merge_flag_t` above 
    rename_threshold*: cuint
    target_limit*: cuint
    metric*: ptr git_diff_similarity_metric ## Pluggable similarity metric; pass NULL to use internal metric 
    recursion_limit*: cuint
    default_driver*: cstring
    file_favor*: git_merge_file_favor_t
    file_flags*: uint32      ## see `git_merge_file_flag_t` above 
  
  git_merge_analysis_t* = enum
    GIT_MERGE_ANALYSIS_NONE = 0, ## No merge is possible.  (Unused.) 
    GIT_MERGE_ANALYSIS_NORMAL = 1, GIT_MERGE_ANALYSIS_UP_TO_DATE = 2,
    GIT_MERGE_ANALYSIS_FASTFORWARD = 4, GIT_MERGE_ANALYSIS_UNBORN = 8
  git_merge_preference_t* = enum
    GIT_MERGE_PREFERENCE_NONE = 0, GIT_MERGE_PREFERENCE_NO_FASTFORWARD = 1,
    GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = 2
  git_rebase_options* {.bycopy, importc: "git_rebase_options".} = object
    ## @} 
    version*: cuint
    quiet*: cint
    inmemory*: cint
    rewrite_notes_ref*: cstring
    merge_options*: git_merge_options
    checkout_options*: git_checkout_options
    signing_cb*: git_commit_signing_cb
    payload*: pointer

  git_rebase_operation_t* = enum
    GIT_REBASE_OPERATION_PICK = 0, GIT_REBASE_OPERATION_REWORD = 1,
    GIT_REBASE_OPERATION_EDIT = 2, GIT_REBASE_OPERATION_SQUASH = 3,
    GIT_REBASE_OPERATION_FIXUP = 4, GIT_REBASE_OPERATION_EXEC = 5
  git_rebase_operation* {.bycopy, importc: "git_rebase_operation".} = object
    ## Indicates that a rebase operation is not (yet) in progress. 
    type*: git_rebase_operation_t ## The type of rebase operation. 
    id*: git_oid
    exec*: cstring

  git_feature_t* = enum ## @} 
                         ## Declare a public function exported for application use. 
                         ## Declare a callback function for application use. 
                         ## Declare a function as deprecated. 
                         ## Declare a function's takes printf style arguments.
    GIT_FEATURE_THREADS = 1, GIT_FEATURE_HTTPS = 2, GIT_FEATURE_SSH = 4,
    GIT_FEATURE_NSEC = 8
  git_libgit2_opt_t* = enum
    GIT_OPT_GET_MWINDOW_SIZE = 0, GIT_OPT_SET_MWINDOW_SIZE = 1,
    GIT_OPT_GET_MWINDOW_MAPPED_LIMIT = 2, GIT_OPT_SET_MWINDOW_MAPPED_LIMIT = 3,
    GIT_OPT_GET_SEARCH_PATH = 4, GIT_OPT_SET_SEARCH_PATH = 5,
    GIT_OPT_SET_CACHE_OBJECT_LIMIT = 6, GIT_OPT_SET_CACHE_MAX_SIZE = 7,
    GIT_OPT_ENABLE_CACHING = 8, GIT_OPT_GET_CACHED_MEMORY = 9,
    GIT_OPT_GET_TEMPLATE_PATH = 10, GIT_OPT_SET_TEMPLATE_PATH = 11,
    GIT_OPT_SET_SSL_CERT_LOCATIONS = 12, GIT_OPT_SET_USER_AGENT = 13,
    GIT_OPT_ENABLE_STRICT_OBJECT_CREATION = 14,
    GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION = 15,
    GIT_OPT_SET_SSL_CIPHERS = 16, GIT_OPT_GET_USER_AGENT = 17,
    GIT_OPT_ENABLE_OFS_DELTA = 18, GIT_OPT_ENABLE_FSYNC_GITDIR = 19,
    GIT_OPT_GET_WINDOWS_SHAREMODE = 20, GIT_OPT_SET_WINDOWS_SHAREMODE = 21,
    GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION = 22, GIT_OPT_SET_ALLOCATOR = 23,
    GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY = 24, GIT_OPT_GET_PACK_MAX_OBJECTS = 25,
    GIT_OPT_SET_PACK_MAX_OBJECTS = 26,
    GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS = 27,
    GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE = 28,
    GIT_OPT_GET_MWINDOW_FILE_LIMIT = 29, GIT_OPT_SET_MWINDOW_FILE_LIMIT = 30
  git_oid* {.bycopy, importc: "git_oid".} = object
    ## @} 
                                                   ## Size (in bytes) of a raw/binary oid 
                                                   ## Size (in bytes) of a hex formatted oid 
                                                   ## Unique identity of any object (commit, tree, blob, tag). 
    id*: ptr UncheckedArray[uchar] ## raw binary formatted id 
  
  git_filter_mode_t* = enum ## @}
    GIT_FILTER_TO_WORKTREE = 0, GIT_FILTER_TO_ODB = 1
  git_filter_flag_t* = enum
    GIT_FILTER_DEFAULT = 0, GIT_FILTER_ALLOW_UNSAFE = 1, ## Don't error for `safecrlf` violations, allow them to continue. 
    GIT_FILTER_NO_SYSTEM_ATTRIBUTES = 2, ## Don't load `/etc/gitattributes` (or the system equivalent) 
    GIT_FILTER_ATTRIBUTES_FROM_HEAD = 4 ## Load attributes from `.gitattributes` in the root of HEAD 
  git_config_level_t* = enum ## @}
    GIT_CONFIG_LEVEL_PROGRAMDATA = 1, ## System-wide on Windows, for compatibility with portable git 
    GIT_CONFIG_LEVEL_SYSTEM = 2, ## System-wide configuration file; /etc/gitconfig on Linux systems 
    GIT_CONFIG_LEVEL_XDG = 3, ## XDG compatible configuration file; typically ~/.config/git/config 
    GIT_CONFIG_LEVEL_GLOBAL = 4, GIT_CONFIG_LEVEL_LOCAL = 5,
    GIT_CONFIG_LEVEL_APP = 6, GIT_CONFIG_HIGHEST_LEVEL = -1
  git_config_entry* {.bycopy, importc: "git_config_entry".} = object
    name*: cstring
    value*: cstring          ## Name of the entry (normalised) 
    include_depth*: cuint    ## String value of the entry 
    level*: git_config_level_t ## Depth of includes where this variable was found 
    free*: proc (entry: ptr git_config_entry): void {.cdecl.} ## Which config file this was found in 
    payload*: pointer        ## Free function for this entry 
  
  git_config_foreach_cb* = proc (entry: ptr git_config_entry; payload: pointer): cint {.
      cdecl.}
  git_config_foreach_cbNim* = proc (entry: ptr git_config_entry): cint
  git_configmap_t* = enum
    GIT_CONFIGMAP_FALSE = 0, GIT_CONFIGMAP_TRUE = 1, GIT_CONFIGMAP_INT32 = 2,
    GIT_CONFIGMAP_STRING = 3
  git_configmap* {.bycopy, importc: "git_configmap".} = object
    type*: git_configmap_t
    str_match*: cstring
    map_value*: cint

  git_transport_message_cb* = proc (str: cstring; len: cint; payload: pointer): cint {.
      cdecl.}
  git_transport_message_cbNim* = proc (str: cstring; len: cint): cint
  git_transport_cb* = proc (out: ptr ptr git_transport; owner: ptr git_remote;
                            param: pointer): cint {.cdecl.}
  git_transport_cbNim* = proc (out: ptr ptr git_transport; owner: ptr git_remote): cint
  git_note_foreach_cb* = proc (blob_id: ptr git_oid;
                               annotated_object_id: ptr git_oid;
                               payload: pointer): cint {.cdecl.}
  git_note_foreach_cbNim* = proc (blob_id: ptr git_oid;
                                  annotated_object_id: ptr git_oid): cint
  git_note_iterator* = git_iterator
  git_reference_foreach_cb* = proc (reference: ptr git_reference;
                                    payload: pointer): cint {.cdecl.}
  git_reference_foreach_cbNim* = proc (reference: ptr git_reference): cint
  git_reference_foreach_name_cb* = proc (name: cstring; payload: pointer): cint {.
      cdecl.}
  git_reference_foreach_name_cbNim* = proc (name: cstring): cint
  git_reference_format_t* = enum ## @} 
                                  ## @} 
                                  ## @}
    GIT_REFERENCE_FORMAT_NORMAL = 0, GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL = 1,
    GIT_REFERENCE_FORMAT_REFSPEC_PATTERN = 2,
    GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 4
  git_odb_foreach_cb* = proc (id: ptr git_oid; payload: pointer): cint {.cdecl.}
  git_odb_foreach_cbNim* = proc (id: ptr git_oid): cint
  git_odb_expand_id* {.bycopy, importc: "git_odb_expand_id".} = object
    ## @} 
                                                                       ## @} 
    id*: git_oid             ## The object ID to expand 
    length*: cushort
    type*: git_object_t

  git_oidarray* {.bycopy, importc: "git_oidarray".} = object
    ## @} 
                                                             ## Array of object ids 
    ids*: ptr git_oid
    count*: size_t

  git_strarray* {.bycopy, importc: "git_strarray".} = object
    ## @} 
                                                             ## Array of strings 
    strings*: ptr cstring
    count*: size_t

  git_off_t* = int64
  git_time_t* = int64
  git_object_size_t* = uint64
  git_object_t* = enum      ## Basic type (loose or packed) of any Git object.
    GIT_OBJECT_ANY = -2, GIT_OBJECT_INVALID = -1, ## Object can be any of the following 
    GIT_OBJECT_COMMIT = 1,  ## Object is invalid. 
    GIT_OBJECT_TREE = 2,    ## A commit object. 
    GIT_OBJECT_BLOB = 3,    ## A tree (directory listing) object. 
    GIT_OBJECT_TAG = 4,     ## A file revision object. 
    GIT_OBJECT_OFS_DELTA = 6, ## An annotated tag object. 
    GIT_OBJECT_REF_DELTA = 7 ## A delta, base is given by an offset. 
  git_time* {.bycopy, importc: "git_time".} = object
    ## Time in a signature 
    time*: git_time_t
    offset*: cint            ## time in seconds from epoch 
    sign*: char              ## timezone offset, in minutes 
  
  git_signature* {.bycopy, importc: "git_signature".} = object
    ## indicator for questionable '-0000' offsets in signature 
                                                               ## An action signature (e.g. for committers, taggers, etc) 
    name*: cstring
    email*: cstring          ## full name of the author 
    when*: git_time          ## email of the author 
  
  git_reference_t* = enum   ## Basic type of any Git reference.
    GIT_REFERENCE_INVALID = 0, GIT_REFERENCE_DIRECT = 1, ## Invalid reference 
    GIT_REFERENCE_SYMBOLIC = 2, ## A reference that points at an object id 
    GIT_REFERENCE_ALL = 3    ## A reference that points at another reference 
  git_branch_t* = enum      ## Basic type of any Git branch.
    GIT_BRANCH_LOCAL = 1, GIT_BRANCH_REMOTE = 2, GIT_BRANCH_ALL = 3
  git_filemode_t* = enum    ## Valid modes for index and tree entries.
    GIT_FILEMODE_UNREADABLE = 0, GIT_FILEMODE_TREE = 40000,
    GIT_FILEMODE_BLOB = 100644, GIT_FILEMODE_BLOB_EXECUTABLE = 100755,
    GIT_FILEMODE_LINK = 120000, GIT_FILEMODE_COMMIT = 160000
  git_submodule_update_t* = enum
    GIT_SUBMODULE_UPDATE_CHECKOUT = 1, GIT_SUBMODULE_UPDATE_REBASE = 2,
    GIT_SUBMODULE_UPDATE_MERGE = 3, GIT_SUBMODULE_UPDATE_NONE = 4,
    GIT_SUBMODULE_UPDATE_DEFAULT = 0
  git_submodule_ignore_t* = enum
    GIT_SUBMODULE_IGNORE_UNSPECIFIED = -1, GIT_SUBMODULE_IGNORE_NONE = 1, ## use the submodule's configuration 
    GIT_SUBMODULE_IGNORE_UNTRACKED = 2, ## any change or untracked == dirty 
    GIT_SUBMODULE_IGNORE_DIRTY = 3, ## dirty if tracked files change 
    GIT_SUBMODULE_IGNORE_ALL = 4 ## only dirty if HEAD moved 
  git_submodule_recurse_t* = enum ## never dirty
    GIT_SUBMODULE_RECURSE_NO = 0, GIT_SUBMODULE_RECURSE_YES = 1,
    GIT_SUBMODULE_RECURSE_ONDEMAND = 2
  git_writestream* {.bycopy, importc: "git_writestream".} = object
    ## A type to write in a streaming fashion, for example, for filters. 
    write*: proc (stream: ptr git_writestream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    close*: proc (stream: ptr git_writestream): cint {.cdecl.}
    free*: proc (stream: ptr git_writestream): void {.cdecl.}

  git_credential_t* = enum  ## @}
    GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1, GIT_CREDENTIAL_SSH_KEY = 2,
    GIT_CREDENTIAL_SSH_CUSTOM = 4, GIT_CREDENTIAL_DEFAULT = 8,
    GIT_CREDENTIAL_SSH_INTERACTIVE = 16, GIT_CREDENTIAL_USERNAME = 32,
    GIT_CREDENTIAL_SSH_MEMORY = 64
  git_credential_default* = git_credential
  git_credential_acquire_cb* = proc (out: ptr ptr git_credential; url: cstring;
                                     username_from_url: cstring;
                                     allowed_types: cuint; payload: pointer): cint {.
      cdecl.}
  git_credential_acquire_cbNim* = proc (out: ptr ptr git_credential;
                                        url: cstring;
                                        username_from_url: cstring;
                                        allowed_types: cuint): cint
  LIBSSH2_SESSION* = LIBSSH2_SESSION
  LIBSSH2_USERAUTH_KBDINT_PROMPT* = LIBSSH2_USERAUTH_KBDINT_PROMPT
  LIBSSH2_USERAUTH_KBDINT_RESPONSE* = LIBSSH2_USERAUTH_KBDINT_RESPONSE
  git_credential_ssh_interactive_cb* = proc (name: cstring; name_len: cint;
      instruction: cstring; instruction_len: cint; num_prompts: cint;
      prompts: ptr LIBSSH2_USERAUTH_KBDINT_PROMPT;
      responses: ptr LIBSSH2_USERAUTH_KBDINT_RESPONSE; abstract: ptr pointer): void {.
      cdecl.}
  git_credential_sign_cb* = proc (session: ptr LIBSSH2_SESSION;
                                  sig: ptr ptr uchar; sig_len: ptr size_t;
                                  data: ptr uchar; data_len: size_t;
                                  abstract: ptr pointer): cint {.cdecl.}
  git_clone_local_t* = enum ## @}
    GIT_CLONE_LOCAL_AUTO = 0, GIT_CLONE_LOCAL = 1, GIT_CLONE_NO_LOCAL = 2,
    GIT_CLONE_LOCAL_NO_LINKS = 3
  git_remote_create_cb* = proc (out: ptr ptr git_remote;
                                repo: ptr git_repository; name: cstring;
                                url: cstring; payload: pointer): cint {.cdecl.}
  git_remote_create_cbNim* = proc (out: ptr ptr git_remote;
                                   repo: ptr git_repository; name: cstring;
                                   url: cstring): cint
  git_repository_create_cb* = proc (out: ptr ptr git_repository; path: cstring;
                                    bare: cint; payload: pointer): cint {.cdecl.}
  git_repository_create_cbNim* = proc (out: ptr ptr git_repository;
                                       path: cstring; bare: cint): cint
  git_clone_options* {.bycopy, importc: "git_clone_options".} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    bare*: cint
    local*: git_clone_local_t
    checkout_branch*: cstring
    repository_cb*: git_repository_create_cb
    repository_cb_payload*: pointer
    remote_cb*: git_remote_create_cb
    remote_cb_payload*: pointer

  git_cherrypick_options* {.bycopy, importc: "git_cherrypick_options".} = object
    ## @} 
                                                                                 ## These declarations have moved. 
    version*: cuint
    mainline*: cuint         ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
  
  git_index_time* {.bycopy, importc: "git_index_time".} = object
    ## Options for the checkout 
                                                                 ## @} 
                                                                 ## Time structure used in a git index entry 
    seconds*: int32
    nanoseconds*: uint32     ## nsec should not be stored as time_t compatible 
  
  git_index_entry* {.bycopy, importc: "git_index_entry".} = object
    ctime*: git_index_time
    mtime*: git_index_time
    dev*: uint32
    ino*: uint32
    mode*: uint32
    uid*: uint32
    gid*: uint32
    file_size*: uint32
    id*: git_oid
    flags*: uint16
    flags_extended*: uint16
    path*: cstring

  git_index_entry_flag_t* = enum
    GIT_INDEX_ENTRY_EXTENDED = 0
  git_index_entry_extended_flag_t* = enum
    GIT_INDEX_ENTRY_INTENT_TO_ADD = 8192, GIT_INDEX_ENTRY_SKIP_WORKTREE = 16384,
    GIT_INDEX_ENTRY_EXTENDED_FLAGS = 24576, GIT_INDEX_ENTRY_UPTODATE = 4
  git_index_capability_t* = enum ## Capabilities of system that affect index actions.
    GIT_INDEX_CAPABILITY_IGNORE_CASE = 1, GIT_INDEX_CAPABILITY_NO_FILEMODE = 2,
    GIT_INDEX_CAPABILITY_NO_SYMLINKS = 4, GIT_INDEX_CAPABILITY_FROM_OWNER = -1
  git_index_matched_path_cb* = proc (path: cstring; matched_pathspec: cstring;
                                     payload: pointer): cint {.cdecl.}
  git_index_matched_path_cbNim* = proc (path: cstring; matched_pathspec: cstring): cint
  git_index_add_option_t* = enum ## Callback for APIs that add/remove/update files matching pathspec 
                                  ## Flags for APIs that add files matching pathspec
    GIT_INDEX_ADD_DEFAULT = 0, GIT_INDEX_ADD_FORCE = 1,
    GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 2, GIT_INDEX_ADD_CHECK_PATHSPEC = 4
  git_index_stage_t* = enum ## Git index stage states
    GIT_INDEX_STAGE_ANY = -1, GIT_INDEX_STAGE_NORMAL = 0, ## A normal staged file in the index. 
    GIT_INDEX_STAGE_ANCESTOR = 1, ## The ancestor side of a conflict. 
    GIT_INDEX_STAGE_OURS = 2, ## The "ours" side of a conflict. 
    GIT_INDEX_STAGE_THEIRS = 3 ## The "theirs" side of a conflict. 
  git_trace_level_t* = enum ## @}
                             ## @{
                             ## Index entry manipulation 
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
    GIT_TRACE_NONE = 0,     ## No tracing will be performed. 
    GIT_TRACE_FATAL = 1,    ## Severe errors that may impact the program's execution 
    GIT_TRACE_ERROR = 2,    ## Errors that do not impact the program's execution 
    GIT_TRACE_WARN = 3,     ## Warnings that suggest abnormal data 
    GIT_TRACE_INFO = 4,     ## Informational messages about program execution 
    GIT_TRACE_DEBUG = 5,    ## Detailed data that allows for debugging 
    GIT_TRACE_TRACE = 6      ## Exceptionally detailed debugging data 
  git_trace_cb* = proc (level: git_trace_level_t; msg: cstring): void {.cdecl.}
  git_error_code* = enum    ## @} 
                             ## Generic return codes
    GIT_OK = 0, GIT_ERROR = -1, ## No error 
    GIT_ENOTFOUND = -3,     ## Generic error 
    GIT_EEXISTS = -4,       ## Requested object could not be found 
    GIT_EAMBIGUOUS = -5,    ## Object exists preventing operation 
    GIT_EBUFS = -6,         ## More than one object matches 
    GIT_EUSER = -7,         ## Output buffer too short to hold data 
    GIT_EBAREREPO = -8, GIT_EUNBORNBRANCH = -9, ## Operation not allowed on bare repository 
    GIT_EUNMERGED = -10,    ## HEAD refers to branch with no commits 
    GIT_ENONFASTFORWARD = -11, ## Merge in progress prevented operation 
    GIT_EINVALIDSPEC = -12, ## Reference was not fast-forwardable 
    GIT_ECONFLICT = -13,    ## Name/ref spec was not in a valid format 
    GIT_ELOCKED = -14,      ## Checkout conflicts prevented operation 
    GIT_EMODIFIED = -15,    ## Lock file prevented operation 
    GIT_EAUTH = -16,        ## Reference value does not match expected 
    GIT_ECERTIFICATE = -17, ## Authentication error 
    GIT_EAPPLIED = -18,     ## Server certificate is invalid 
    GIT_EPEEL = -19,        ## Patch/merge has already been applied 
    GIT_EEOF = -20,         ## The requested peel operation is not possible 
    GIT_EINVALID = -21,     ## Unexpected EOF 
    GIT_EUNCOMMITTED = -22, ## Invalid operation or input 
    GIT_EDIRECTORY = -23,   ## Uncommitted changes in index prevented operation 
    GIT_EMERGECONFLICT = -24, ## The operation is not valid for a directory 
    GIT_PASSTHROUGH = -30,  ## A merge conflict exists and cannot continue 
    GIT_ITEROVER = -31,     ## A user-configured callback refused to act 
    GIT_RETRY = -32,        ## Signals end of iteration with iterator 
    GIT_EMISMATCH = -33,    ## Internal only 
    GIT_EINDEXDIRTY = -34,  ## Hashsum mismatch in object 
    GIT_EAPPLYFAIL = -35     ## Unsaved changes in the index would be overwritten 
  git_error* {.bycopy, importc: "git_error".} = object
    ## Patch application failed 
    message*: cstring
    klass*: cint

  git_error_t* = enum       ## Error classes
    GIT_ERROR_NONE = 0, GIT_ERROR_NOMEMORY = 1, GIT_ERROR_OS = 2,
    GIT_ERROR_INVALID = 3, GIT_ERROR_REFERENCE = 4, GIT_ERROR_ZLIB = 5,
    GIT_ERROR_REPOSITORY = 6, GIT_ERROR_CONFIG = 7, GIT_ERROR_REGEX = 8,
    GIT_ERROR_ODB = 9, GIT_ERROR_INDEX = 10, GIT_ERROR_OBJECT = 11,
    GIT_ERROR_NET = 12, GIT_ERROR_TAG = 13, GIT_ERROR_TREE = 14,
    GIT_ERROR_INDEXER = 15, GIT_ERROR_SSL = 16, GIT_ERROR_SUBMODULE = 17,
    GIT_ERROR_THREAD = 18, GIT_ERROR_STASH = 19, GIT_ERROR_CHECKOUT = 20,
    GIT_ERROR_FETCHHEAD = 21, GIT_ERROR_MERGE = 22, GIT_ERROR_SSH = 23,
    GIT_ERROR_FILTER = 24, GIT_ERROR_REVERT = 25, GIT_ERROR_CALLBACK = 26,
    GIT_ERROR_CHERRYPICK = 27, GIT_ERROR_DESCRIBE = 28, GIT_ERROR_REBASE = 29,
    GIT_ERROR_FILESYSTEM = 30, GIT_ERROR_PATCH = 31, GIT_ERROR_WORKTREE = 32,
    GIT_ERROR_SHA1 = 33, GIT_ERROR_HTTP = 34, GIT_ERROR_INTERNAL = 35
  git_odb_stream_t* = enum  ## @} 
                             ## Streaming mode
    GIT_STREAM_RDONLY = 2, GIT_STREAM_WRONLY = 4, GIT_STREAM_RW = 6
  git_odb_stream* {.bycopy, importc: "git_odb_stream".} = object
    backend*: ptr git_odb_backend
    mode*: cuint
    hash_ctx*: pointer
    declared_size*: git_object_size_t
    received_bytes*: git_object_size_t
    read*: proc (stream: ptr git_odb_stream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    write*: proc (stream: ptr git_odb_stream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    finalize_write*: proc (stream: ptr git_odb_stream; oid: ptr git_oid): cint {.
        cdecl.}
    free*: proc (stream: ptr git_odb_stream): void {.cdecl.}

  git_odb_writepack* {.bycopy, importc: "git_odb_writepack".} = object
    ## A stream to write a pack file to the ODB 
    backend*: ptr git_odb_backend
    append*: proc (writepack: ptr git_odb_writepack; data: pointer;
                   size: size_t; stats: ptr git_indexer_progress): cint {.cdecl.}
    commit*: proc (writepack: ptr git_odb_writepack;
                   stats: ptr git_indexer_progress): cint {.cdecl.}
    free*: proc (writepack: ptr git_odb_writepack): void {.cdecl.}

  git_message_trailer* {.bycopy, importc: "git_message_trailer".} = object
    key*: cstring
    value*: cstring

  git_message_trailer_array* {.bycopy, importc: "git_message_trailer_array".} = object
    trailers*: ptr git_message_trailer
    count*: size_t
    trailer_block* {.importc: "_trailer_block".}: cstring ## private 
  
  git_credential_userpass_payload* {.bycopy,
                                     importc: "git_credential_userpass_payload".} = object
    ## @} 
    username*: cstring
    password*: cstring

  git_packbuilder_stage_t* = enum ## @} 
                                   ## @}
    GIT_PACKBUILDER_ADDING_OBJECTS = 0, GIT_PACKBUILDER_DELTAFICATION = 1
  git_packbuilder_foreach_cb* = proc (buf: pointer; size: size_t;
                                      payload: pointer): cint {.cdecl.}
  git_packbuilder_foreach_cbNim* = proc (buf: pointer; size: size_t): cint
  git_packbuilder_progress* = proc (stage: cint; current: uint32; total: uint32;
                                    payload: pointer): cint {.cdecl.}
  git_packbuilder_progressNim* = proc (stage: cint; current: uint32;
                                       total: uint32): cint
  git_pathspec_flag_t* = enum
    GIT_PATHSPEC_DEFAULT = 0, GIT_PATHSPEC_IGNORE_CASE = 1,
    GIT_PATHSPEC_USE_CASE = 2, GIT_PATHSPEC_NO_GLOB = 4,
    GIT_PATHSPEC_NO_MATCH_ERROR = 8, GIT_PATHSPEC_FIND_FAILURES = 16,
    GIT_PATHSPEC_FAILURES_ONLY = 32
  git_worktree_add_options* {.bycopy, importc: "git_worktree_add_options".} = object
    version*: cuint
    lock*: cint
    ref*: ptr git_reference  ## lock newly created worktree 
  
  git_worktree_prune_t* = enum ## reference to use for the new worktree HEAD
    GIT_WORKTREE_PRUNE_VALID = 1, ## Prune working tree even if working tree is valid 
    GIT_WORKTREE_PRUNE_LOCKED = 2, ## Prune working tree even if it is locked 
    GIT_WORKTREE_PRUNE_WORKING_TREE = 4 ## Prune checked out working tree 
  git_worktree_prune_options* {.bycopy, importc: "git_worktree_prune_options".} = object
    version*: cuint
    flags*: uint32

  git_proxy_t* = enum       ## @}
    GIT_PROXY_NONE = 0, GIT_PROXY_AUTO = 1, GIT_PROXY_SPECIFIED = 2
  git_proxy_options* {.bycopy, importc: "git_proxy_options".} = object
    version*: cuint
    type*: git_proxy_t
    url*: cstring
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    payload*: pointer

  git_reset_t* = enum
    GIT_RESET_SOFT = 1, GIT_RESET_MIXED = 2, ## Move the head to the given commit 
    GIT_RESET_HARD = 3       ## SOFT plus reset index to the commit 
  git_apply_delta_cb* = proc (delta: ptr git_diff_delta; payload: pointer): cint {.
      cdecl.}
  git_apply_delta_cbNim* = proc (delta: ptr git_diff_delta): cint
  git_apply_hunk_cb* = proc (hunk: ptr git_diff_hunk; payload: pointer): cint {.
      cdecl.}
  git_apply_hunk_cbNim* = proc (hunk: ptr git_diff_hunk): cint
  git_apply_flags_t* = enum ## MIXED plus changes in working tree discarded 
                             ## @} 
                             ## Flags controlling the behavior of git_apply
    GIT_APPLY_CHECK = 1
  git_apply_options* {.bycopy, importc: "git_apply_options".} = object
    version*: cuint
    delta_cb*: git_apply_delta_cb ## The version 
                                  ## When applying a patch, callback that will be made per delta (file). 
    hunk_cb*: git_apply_hunk_cb ## When applying a patch, callback that will be made per hunk. 
    payload*: pointer        ## Payload passed to both delta_cb & hunk_cb. 
    flags*: cuint            ## Bitmask of git_apply_flags_t 
  
  git_apply_location_t* = enum ## Possible application locations for git_apply
    GIT_APPLY_LOCATION_WORKDIR = 0, GIT_APPLY_LOCATION_INDEX = 1,
    GIT_APPLY_LOCATION_BOTH = 2
  git_revparse_mode_t* = enum ## @}
    GIT_REVPARSE_SINGLE = 1, ## The spec targeted a single object. 
    GIT_REVPARSE_RANGE = 2, ## The spec targeted a range of commits. 
    GIT_REVPARSE_MERGE_BASE = 4 ## The spec used the '...' operator, which invokes special semantics. 
  git_revspec* {.bycopy, importc: "git_revspec".} = object
    from*: ptr git_object    ## The left element of the revspec; must be freed by the user 
    to*: ptr git_object      ## The right element of the revspec; must be freed by the user 
    flags*: cuint            ## The intent of the revspec (i.e. `git_revparse_mode_t` flags) 
  
  git_attr_t* = git_attr_value_t
  git_cvar_map* = git_configmap
  git_cred* = git_credential
  git_cred_userpass_plaintext* = git_credential_userpass_plaintext
  git_cred_username* = git_credential_username
  git_cred_default* = git_credential_default
  git_cred_ssh_key* = git_credential_ssh_key
  git_cred_ssh_interactive* = git_credential_ssh_interactive
  git_cred_ssh_custom* = git_credential_ssh_custom
  git_cred_acquire_cb* = git_credential_acquire_cb
  git_cred_sign_callback* = git_credential_sign_cb
  git_cred_sign_cb* = git_credential_sign_cb
  git_cred_ssh_interactive_callback* = git_credential_ssh_interactive_cb
  git_cred_ssh_interactive_cb* = git_credential_ssh_interactive_cb
  git_cred_userpass_payload* = git_credential_userpass_payload
  git_trace_callback* = git_trace_cb
  git_transfer_progress* = git_indexer_progress
  git_transfer_progress_cb* = git_indexer_progress_cb
  git_push_transfer_progress* = git_push_transfer_progress_cb
  git_headlist_cb* = proc (rhead: ptr git_remote_head; payload: pointer): cint {.
      cdecl.}
  git_headlist_cbNim* = proc (rhead: ptr git_remote_head): cint
  git_cert_t* = enum        ## The type of a remote completion event 
                             ## @}
                             ## @{
                             ## @}
                             ## @{
                             ## @}
                             ## @}
    GIT_CERT_NONE = 0, GIT_CERT_X509 = 1, GIT_CERT_HOSTKEY_LIBSSH2 = 2,
    GIT_CERT_STRARRAY = 3
  git_cert* {.bycopy, importc: "git_cert".} = object
    cert_type*: git_cert_t

  git_transport_certificate_check_cb* = proc (cert: ptr git_cert; valid: cint;
      host: cstring; payload: pointer): cint {.cdecl.}
  git_transport_certificate_check_cbNim* = proc (cert: ptr git_cert;
      valid: cint; host: cstring): cint
  git_cert_ssh_t* = enum
    GIT_CERT_SSH_MD5 = 1,   ## MD5 is available 
    GIT_CERT_SSH_SHA1 = 2,  ## SHA-1 is available 
    GIT_CERT_SSH_SHA256 = 4  ## SHA-256 is available 
  git_cert_hostkey* {.bycopy, importc: "git_cert_hostkey".} = object
    parent*: git_cert
    type*: git_cert_ssh_t    ## The parent cert 
    hash_md5*: ptr UncheckedArray[uchar]
    hash_sha1*: ptr UncheckedArray[uchar]
    hash_sha256*: ptr UncheckedArray[uchar]

  git_cert_x509* {.bycopy, importc: "git_cert_x509".} = object
    parent*: git_cert
    data*: pointer           ## The parent cert 
    len*: size_t

  git_submodule_status_t* = enum ## @}
    GIT_SUBMODULE_STATUS_IN_HEAD = 1, GIT_SUBMODULE_STATUS_IN_INDEX = 2,
    GIT_SUBMODULE_STATUS_IN_CONFIG = 4, GIT_SUBMODULE_STATUS_IN_WD = 8,
    GIT_SUBMODULE_STATUS_INDEX_ADDED = 16,
    GIT_SUBMODULE_STATUS_INDEX_DELETED = 32,
    GIT_SUBMODULE_STATUS_INDEX_MODIFIED = 64,
    GIT_SUBMODULE_STATUS_WD_UNINITIALIZED = 128,
    GIT_SUBMODULE_STATUS_WD_ADDED = 256, GIT_SUBMODULE_STATUS_WD_DELETED = 512,
    GIT_SUBMODULE_STATUS_WD_MODIFIED = 1024,
    GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = 2048,
    GIT_SUBMODULE_STATUS_WD_WD_MODIFIED = 4096,
    GIT_SUBMODULE_STATUS_WD_UNTRACKED = 8192
  git_submodule_cb* = proc (sm: ptr git_submodule; name: cstring;
                            payload: pointer): cint {.cdecl.}
  git_submodule_cbNim* = proc (sm: ptr git_submodule; name: cstring): cint
  git_submodule_update_options* {.bycopy,
                                  importc: "git_submodule_update_options".} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    allow_fetch*: cint

proc git_status_options_init*(opts: ptr git_status_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_status_foreach*(repo: ptr git_repository; callback: git_status_cb;
                         payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_status_foreach_ext*(repo: ptr git_repository;
                             opts: ptr git_status_options;
                             callback: git_status_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_status_file*(status_flags: ptr cuint; repo: ptr git_repository;
                      path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_status_list_new*(out: ptr ptr git_status_list;
                          repo: ptr git_repository; opts: ptr git_status_options): cint {.
    dynlib: libgitDl, importc.}
proc git_status_list_entrycount*(statuslist: ptr git_status_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_status_byindex*(statuslist: ptr git_status_list; idx: size_t): ptr git_status_entry {.
    dynlib: libgitDl, importc.}
proc git_status_list_free*(statuslist: ptr git_status_list): void {.
    dynlib: libgitDl, importc.}
proc git_status_should_ignore*(ignored: ptr cint; repo: ptr git_repository;
                               path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_revert_options_init*(opts: ptr git_revert_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_revert_commit*(out: ptr ptr git_index; repo: ptr git_repository;
                        revert_commit: ptr git_commit;
                        our_commit: ptr git_commit; mainline: cuint;
                        merge_options: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_revert*(repo: ptr git_repository; commit: ptr git_commit;
                 given_opts: ptr git_revert_options): cint {.dynlib: libgitDl,
    importc.}
proc git_buf_dispose*(buffer: ptr git_buf): void {.dynlib: libgitDl, importc.}
proc git_buf_grow*(buffer: ptr git_buf; target_size: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_set*(buffer: ptr git_buf; data: pointer; datalen: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_is_binary*(buf: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_buf_contains_nul*(buf: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_tag_lookup*(out: ptr ptr git_tag; repo: ptr git_repository;
                     id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_tag_lookup_prefix*(out: ptr ptr git_tag; repo: ptr git_repository;
                            id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_free*(tag: ptr git_tag): void {.dynlib: libgitDl, importc.}
proc git_tag_id*(tag: ptr git_tag): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_tag_owner*(tag: ptr git_tag): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_tag_target*(target_out: ptr ptr git_object; tag: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_target_id*(tag: ptr git_tag): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_tag_target_type*(tag: ptr git_tag): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_tag_name*(tag: ptr git_tag): cstring {.dynlib: libgitDl, importc.}
proc git_tag_tagger*(tag: ptr git_tag): ptr git_signature {.dynlib: libgitDl,
    importc.}
proc git_tag_message*(tag: ptr git_tag): cstring {.dynlib: libgitDl, importc.}
proc git_tag_create*(oid: ptr git_oid; repo: ptr git_repository;
                     tag_name: cstring; target: ptr git_object;
                     tagger: ptr git_signature; message: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_annotation_create*(oid: ptr git_oid; repo: ptr git_repository;
                                tag_name: cstring; target: ptr git_object;
                                tagger: ptr git_signature; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_create_from_buffer*(oid: ptr git_oid; repo: ptr git_repository;
                                 buffer: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_create_lightweight*(oid: ptr git_oid; repo: ptr git_repository;
                                 tag_name: cstring; target: ptr git_object;
                                 force: cint): cint {.dynlib: libgitDl, importc.}
proc git_tag_delete*(repo: ptr git_repository; tag_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_list*(tag_names: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_list_match*(tag_names: ptr git_strarray; pattern: cstring;
                         repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_tag_foreach*(repo: ptr git_repository; callback: git_tag_foreach_cb;
                      payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_tag_peel*(tag_target_out: ptr ptr git_object; tag: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_dup*(out: ptr ptr git_tag; source: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_options_init*(opts: ptr git_diff_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_options_init*(opts: ptr git_diff_find_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_free*(diff: ptr git_diff): void {.dynlib: libgitDl, importc.}
proc git_diff_tree_to_tree*(diff: ptr ptr git_diff; repo: ptr git_repository;
                            old_tree: ptr git_tree; new_tree: ptr git_tree;
                            opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_index*(diff: ptr ptr git_diff; repo: ptr git_repository;
                             old_tree: ptr git_tree; index: ptr git_index;
                             opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_index_to_workdir*(diff: ptr ptr git_diff;
                                repo: ptr git_repository; index: ptr git_index;
                                opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_workdir*(diff: ptr ptr git_diff; repo: ptr git_repository;
                               old_tree: ptr git_tree;
                               opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_workdir_with_index*(diff: ptr ptr git_diff;
    repo: ptr git_repository; old_tree: ptr git_tree; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_index_to_index*(diff: ptr ptr git_diff; repo: ptr git_repository;
                              old_index: ptr git_index;
                              new_index: ptr git_index;
                              opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_merge*(onto: ptr git_diff; from: ptr git_diff): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_similar*(diff: ptr git_diff;
                            options: ptr git_diff_find_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_num_deltas*(diff: ptr git_diff): size_t {.dynlib: libgitDl,
    importc.}
proc git_diff_num_deltas_of_type*(diff: ptr git_diff; type: git_delta_t): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_get_delta*(diff: ptr git_diff; idx: size_t): ptr git_diff_delta {.
    dynlib: libgitDl, importc.}
proc git_diff_is_sorted_icase*(diff: ptr git_diff): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_foreach*(diff: ptr git_diff; file_cb: git_diff_file_cb;
                       binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                       line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_status_char*(status: git_delta_t): char {.dynlib: libgitDl,
    importc.}
proc git_diff_print*(diff: ptr git_diff; format: git_diff_format_t;
                     print_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_to_buf*(out: ptr git_buf; diff: ptr git_diff;
                      format: git_diff_format_t): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_blobs*(old_blob: ptr git_blob; old_as_path: cstring;
                     new_blob: ptr git_blob; new_as_path: cstring;
                     options: ptr git_diff_options; file_cb: git_diff_file_cb;
                     binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                     line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_blob_to_buffer*(old_blob: ptr git_blob; old_as_path: cstring;
                              buffer: cstring; buffer_len: size_t;
                              buffer_as_path: cstring;
                              options: ptr git_diff_options;
                              file_cb: git_diff_file_cb;
                              binary_cb: git_diff_binary_cb;
                              hunk_cb: git_diff_hunk_cb;
                              line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_buffers*(old_buffer: pointer; old_len: size_t;
                       old_as_path: cstring; new_buffer: pointer;
                       new_len: size_t; new_as_path: cstring;
                       options: ptr git_diff_options; file_cb: git_diff_file_cb;
                       binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                       line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_from_buffer*(out: ptr ptr git_diff; content: cstring;
                           content_len: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_get_stats*(out: ptr ptr git_diff_stats; diff: ptr git_diff): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_files_changed*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_insertions*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_deletions*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_to_buf*(out: ptr git_buf; stats: ptr git_diff_stats;
                            format: git_diff_stats_format_t; width: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_free*(stats: ptr git_diff_stats): void {.dynlib: libgitDl,
    importc.}
proc git_diff_format_email*(out: ptr git_buf; diff: ptr git_diff;
                            opts: ptr git_diff_format_email_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_commit_as_email*(out: ptr git_buf; repo: ptr git_repository;
                               commit: ptr git_commit; patch_no: size_t;
                               total_patches: size_t; flags: uint32;
                               diff_opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_format_email_options_init*(
    opts: ptr git_diff_format_email_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_patchid_options_init*(opts: ptr git_diff_patchid_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_patchid*(out: ptr git_oid; diff: ptr git_diff;
                       opts: ptr git_diff_patchid_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_options_init*(opts: ptr git_describe_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_format_options_init*(opts: ptr git_describe_format_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_describe_commit*(result: ptr ptr git_describe_result;
                          committish: ptr git_object;
                          opts: ptr git_describe_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_workdir*(out: ptr ptr git_describe_result;
                           repo: ptr git_repository;
                           opts: ptr git_describe_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_format*(out: ptr git_buf; result: ptr git_describe_result;
                          opts: ptr git_describe_format_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_result_free*(result: ptr git_describe_result): void {.
    dynlib: libgitDl, importc.}
proc git_repository_open*(out: ptr ptr git_repository; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_from_worktree*(out: ptr ptr git_repository;
                                        wt: ptr git_worktree): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_wrap_odb*(out: ptr ptr git_repository; odb: ptr git_odb): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_discover*(out: ptr git_buf; start_path: cstring;
                              across_fs: cint; ceiling_dirs: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_ext*(out: ptr ptr git_repository; path: cstring;
                              flags: cuint; ceiling_dirs: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_bare*(out: ptr ptr git_repository; bare_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_free*(repo: ptr git_repository): void {.dynlib: libgitDl,
    importc.}
proc git_repository_init*(out: ptr ptr git_repository; path: cstring;
                          is_bare: cuint): cint {.dynlib: libgitDl, importc.}
proc git_repository_init_options_init*(opts: ptr git_repository_init_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_init_ext*(out: ptr ptr git_repository; repo_path: cstring;
                              opts: ptr git_repository_init_options): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head*(out: ptr ptr git_reference; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_for_worktree*(out: ptr ptr git_reference;
                                       repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_detached*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_detached_for_worktree*(repo: ptr git_repository;
    name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_repository_head_unborn*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_is_empty*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_item_path*(out: ptr git_buf; repo: ptr git_repository;
                               item: git_repository_item_t): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_path*(repo: ptr git_repository): cstring {.dynlib: libgitDl,
    importc.}
proc git_repository_workdir*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_commondir*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_set_workdir*(repo: ptr git_repository; workdir: cstring;
                                 update_gitlink: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_is_bare*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_is_worktree*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_config*(out: ptr ptr git_config; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_config_snapshot*(out: ptr ptr git_config;
                                     repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_odb*(out: ptr ptr git_odb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_refdb*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_index*(out: ptr ptr git_index; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_message*(out: ptr git_buf; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_message_remove*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_state_cleanup*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_fetchhead_foreach*(repo: ptr git_repository; callback: git_repository_fetchhead_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_mergehead_foreach*(repo: ptr git_repository; callback: git_repository_mergehead_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_hashfile*(out: ptr git_oid; repo: ptr git_repository;
                              path: cstring; type: git_object_t;
                              as_path: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_head*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_set_head_detached*(repo: ptr git_repository;
                                       commitish: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_set_head_detached_from_annotated*(repo: ptr git_repository;
    commitish: ptr git_annotated_commit): cint {.dynlib: libgitDl, importc.}
proc git_repository_detach_head*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_state*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_namespace*(repo: ptr git_repository; nmspace: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_get_namespace*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_is_shallow*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_ident*(name: ptr cstring; email: ptr cstring;
                           repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_ident*(repo: ptr git_repository; name: cstring;
                               email: cstring): cint {.dynlib: libgitDl, importc.}
proc git_checkout_options_init*(opts: ptr git_checkout_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_head*(repo: ptr git_repository; opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_index*(repo: ptr git_repository; index: ptr git_index;
                         opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_tree*(repo: ptr git_repository; treeish: ptr git_object;
                        opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_save*(out: ptr git_oid; repo: ptr git_repository;
                     stasher: ptr git_signature; message: cstring; flags: uint32): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_apply_options_init*(opts: ptr git_stash_apply_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_stash_apply*(repo: ptr git_repository; index: size_t;
                      options: ptr git_stash_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_foreach*(repo: ptr git_repository; callback: git_stash_cb;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_stash_drop*(repo: ptr git_repository; index: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_pop*(repo: ptr git_repository; index: size_t;
                    options: ptr git_stash_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_new*(out: ptr ptr git_mailmap): cint {.dynlib: libgitDl,
    importc.}
proc git_mailmap_free*(mm: ptr git_mailmap): void {.dynlib: libgitDl, importc.}
proc git_mailmap_add_entry*(mm: ptr git_mailmap; real_name: cstring;
                            real_email: cstring; replace_name: cstring;
                            replace_email: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_mailmap_from_buffer*(out: ptr ptr git_mailmap; buf: cstring;
                              len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_mailmap_from_repository*(out: ptr ptr git_mailmap;
                                  repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_resolve*(real_name: ptr cstring; real_email: ptr cstring;
                          mm: ptr git_mailmap; name: cstring; email: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_resolve_signature*(out: ptr ptr git_signature;
                                    mm: ptr git_mailmap; sig: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_lookup*(out: ptr ptr git_tree; repo: ptr git_repository;
                      id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_tree_lookup_prefix*(out: ptr ptr git_tree; repo: ptr git_repository;
                             id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_free*(tree: ptr git_tree): void {.dynlib: libgitDl, importc.}
proc git_tree_id*(tree: ptr git_tree): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_tree_owner*(tree: ptr git_tree): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_tree_entrycount*(tree: ptr git_tree): size_t {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_byname*(tree: ptr git_tree; filename: cstring): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_byindex*(tree: ptr git_tree; idx: size_t): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_byid*(tree: ptr git_tree; id: ptr git_oid): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_bypath*(out: ptr ptr git_tree_entry; root: ptr git_tree;
                            path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_tree_entry_dup*(dest: ptr ptr git_tree_entry;
                         source: ptr git_tree_entry): cint {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_free*(entry: ptr git_tree_entry): void {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_name*(entry: ptr git_tree_entry): cstring {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_id*(entry: ptr git_tree_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_type*(entry: ptr git_tree_entry): git_object_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_filemode*(entry: ptr git_tree_entry): git_filemode_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_filemode_raw*(entry: ptr git_tree_entry): git_filemode_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_cmp*(e1: ptr git_tree_entry; e2: ptr git_tree_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_to_object*(object_out: ptr ptr git_object;
                               repo: ptr git_repository;
                               entry: ptr git_tree_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_new*(out: ptr ptr git_treebuilder;
                          repo: ptr git_repository; source: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_clear*(bld: ptr git_treebuilder): cint {.dynlib: libgitDl,
    importc.}
proc git_treebuilder_entrycount*(bld: ptr git_treebuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_free*(bld: ptr git_treebuilder): void {.dynlib: libgitDl,
    importc.}
proc git_treebuilder_get*(bld: ptr git_treebuilder; filename: cstring): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_insert*(out: ptr ptr git_tree_entry;
                             bld: ptr git_treebuilder; filename: cstring;
                             id: ptr git_oid; filemode: git_filemode_t): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_remove*(bld: ptr git_treebuilder; filename: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_filter*(bld: ptr git_treebuilder;
                             filter: git_treebuilder_filter_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_write*(id: ptr git_oid; bld: ptr git_treebuilder): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_write_with_buffer*(oid: ptr git_oid;
                                        bld: ptr git_treebuilder;
                                        tree: ptr git_buf): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_walk*(tree: ptr git_tree; mode: git_treewalk_mode;
                    callback: git_treewalk_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_dup*(out: ptr ptr git_tree; source: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_create_updated*(out: ptr git_oid; repo: ptr git_repository;
                              baseline: ptr git_tree; nupdates: size_t;
                              updates: ptr git_tree_update): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_read*(out: ptr ptr git_reflog; repo: ptr git_repository;
                      name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reflog_write*(reflog: ptr git_reflog): cint {.dynlib: libgitDl, importc.}
proc git_reflog_append*(reflog: ptr git_reflog; id: ptr git_oid;
                        committer: ptr git_signature; msg: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_rename*(repo: ptr git_repository; old_name: cstring;
                        name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reflog_delete*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_entrycount*(reflog: ptr git_reflog): size_t {.dynlib: libgitDl,
    importc.}
proc git_reflog_entry_byindex*(reflog: ptr git_reflog; idx: size_t): ptr git_reflog_entry {.
    dynlib: libgitDl, importc.}
proc git_reflog_drop*(reflog: ptr git_reflog; idx: size_t;
                      rewrite_previous_entry: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_reflog_entry_id_old*(entry: ptr git_reflog_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_id_new*(entry: ptr git_reflog_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_committer*(entry: ptr git_reflog_entry): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_message*(entry: ptr git_reflog_entry): cstring {.
    dynlib: libgitDl, importc.}
proc git_reflog_free*(reflog: ptr git_reflog): void {.dynlib: libgitDl, importc.}
proc git_branch_create*(out: ptr ptr git_reference; repo: ptr git_repository;
                        branch_name: cstring; target: ptr git_commit;
                        force: cint): cint {.dynlib: libgitDl, importc.}
proc git_branch_create_from_annotated*(ref_out: ptr ptr git_reference;
                                       repository: ptr git_repository;
                                       branch_name: cstring;
                                       commit: ptr git_annotated_commit;
                                       force: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_delete*(branch: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_iterator_new*(out: ptr ptr git_branch_iterator;
                              repo: ptr git_repository; list_flags: git_branch_t): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_next*(out: ptr ptr git_reference; out_type: ptr git_branch_t;
                      iter: ptr git_branch_iterator): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_iterator_free*(iter: ptr git_branch_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_branch_move*(out: ptr ptr git_reference; branch: ptr git_reference;
                      new_branch_name: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_lookup*(out: ptr ptr git_reference; repo: ptr git_repository;
                        branch_name: cstring; branch_type: git_branch_t): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_name*(out: ptr cstring; ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_upstream*(out: ptr ptr git_reference; branch: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_set_upstream*(branch: ptr git_reference; branch_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_upstream_name*(out: ptr git_buf; repo: ptr git_repository;
                               refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_is_head*(branch: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_is_checked_out*(branch: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_remote_name*(out: ptr git_buf; repo: ptr git_repository;
                             refname: cstring): cint {.dynlib: libgitDl, importc.}
proc git_branch_upstream_remote*(buf: ptr git_buf; repo: ptr git_repository;
                                 refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_blob_lookup*(blob: ptr ptr git_blob; repo: ptr git_repository;
                      id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_blob_lookup_prefix*(blob: ptr ptr git_blob; repo: ptr git_repository;
                             id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_free*(blob: ptr git_blob): void {.dynlib: libgitDl, importc.}
proc git_blob_id*(blob: ptr git_blob): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_blob_owner*(blob: ptr git_blob): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_blob_rawcontent*(blob: ptr git_blob): pointer {.dynlib: libgitDl,
    importc.}
proc git_blob_rawsize*(blob: ptr git_blob): git_object_size_t {.
    dynlib: libgitDl, importc.}
proc git_blob_filter_options_init*(opts: ptr git_blob_filter_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_blob_filter*(out: ptr git_buf; blob: ptr git_blob; as_path: cstring;
                      opts: ptr git_blob_filter_options): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_workdir*(id: ptr git_oid; repo: ptr git_repository;
                                   relative_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_disk*(id: ptr git_oid; repo: ptr git_repository;
                                path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_from_stream*(out: ptr ptr git_writestream;
                                  repo: ptr git_repository; hintpath: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_stream_commit*(out: ptr git_oid;
    stream: ptr git_writestream): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_from_buffer*(id: ptr git_oid; repo: ptr git_repository;
                                  buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_is_binary*(blob: ptr git_blob): cint {.dynlib: libgitDl, importc.}
proc git_blob_dup*(out: ptr ptr git_blob; source: ptr git_blob): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_new*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_open*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_compress*(refdb: ptr git_refdb): cint {.dynlib: libgitDl, importc.}
proc git_refdb_free*(refdb: ptr git_refdb): void {.dynlib: libgitDl, importc.}
proc git_commit_lookup*(commit: ptr ptr git_commit; repo: ptr git_repository;
                        id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_commit_lookup_prefix*(commit: ptr ptr git_commit;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_commit_free*(commit: ptr git_commit): void {.dynlib: libgitDl, importc.}
proc git_commit_id*(commit: ptr git_commit): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_commit_owner*(commit: ptr git_commit): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_commit_message_encoding*(commit: ptr git_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_commit_message*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_message_raw*(commit: ptr git_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_commit_summary*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_body*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_time*(commit: ptr git_commit): git_time_t {.dynlib: libgitDl,
    importc.}
proc git_commit_time_offset*(commit: ptr git_commit): cint {.dynlib: libgitDl,
    importc.}
proc git_commit_committer*(commit: ptr git_commit): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_commit_author*(commit: ptr git_commit): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_commit_committer_with_mailmap*(out: ptr ptr git_signature;
                                        commit: ptr git_commit;
                                        mailmap: ptr git_mailmap): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_author_with_mailmap*(out: ptr ptr git_signature;
                                     commit: ptr git_commit;
                                     mailmap: ptr git_mailmap): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_raw_header*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_tree*(tree_out: ptr ptr git_tree; commit: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_tree_id*(commit: ptr git_commit): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_commit_parentcount*(commit: ptr git_commit): cuint {.dynlib: libgitDl,
    importc.}
proc git_commit_parent*(out: ptr ptr git_commit; commit: ptr git_commit;
                        n: cuint): cint {.dynlib: libgitDl, importc.}
proc git_commit_parent_id*(commit: ptr git_commit; n: cuint): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_commit_nth_gen_ancestor*(ancestor: ptr ptr git_commit;
                                  commit: ptr git_commit; n: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_header_field*(out: ptr git_buf; commit: ptr git_commit;
                              field: cstring): cint {.dynlib: libgitDl, importc.}
proc git_commit_extract_signature*(signature: ptr git_buf;
                                   signed_data: ptr git_buf;
                                   repo: ptr git_repository;
                                   commit_id: ptr git_oid; field: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create*(id: ptr git_oid; repo: ptr git_repository;
                        update_ref: cstring; author: ptr git_signature;
                        committer: ptr git_signature; message_encoding: cstring;
                        message: cstring; tree: ptr git_tree;
                        parent_count: size_t;
                        parents: ptr UncheckedArray[ptr git_commit]): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_v*(id: ptr git_oid; repo: ptr git_repository;
                          update_ref: cstring; author: ptr git_signature;
                          committer: ptr git_signature;
                          message_encoding: cstring; message: cstring;
                          tree: ptr git_tree; parent_count: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_amend*(id: ptr git_oid; commit_to_amend: ptr git_commit;
                       update_ref: cstring; author: ptr git_signature;
                       committer: ptr git_signature; message_encoding: cstring;
                       message: cstring; tree: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_buffer*(out: ptr git_buf; repo: ptr git_repository;
                               author: ptr git_signature;
                               committer: ptr git_signature;
                               message_encoding: cstring; message: cstring;
                               tree: ptr git_tree; parent_count: size_t;
                               parents: ptr UncheckedArray[ptr git_commit]): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_with_signature*(out: ptr git_oid;
                                       repo: ptr git_repository;
                                       commit_content: cstring;
                                       signature: cstring;
                                       signature_field: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_dup*(out: ptr ptr git_commit; source: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_value*(attr: cstring): git_attr_value_t {.dynlib: libgitDl,
    importc.}
proc git_attr_get*(value_out: ptr cstring; repo: ptr git_repository;
                   flags: uint32; path: cstring; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_get_many*(values_out: ptr cstring; repo: ptr git_repository;
                        flags: uint32; path: cstring; num_attr: size_t;
                        names: ptr cstring): cint {.dynlib: libgitDl, importc.}
proc git_attr_foreach*(repo: ptr git_repository; flags: uint32; path: cstring;
                       callback: git_attr_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_cache_flush*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_attr_add_macro*(repo: ptr git_repository; name: cstring;
                         values: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blame_options_init*(opts: ptr git_blame_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_get_hunk_count*(blame: ptr git_blame): uint32 {.dynlib: libgitDl,
    importc.}
proc git_blame_get_hunk_byindex*(blame: ptr git_blame; index: uint32): ptr git_blame_hunk {.
    dynlib: libgitDl, importc.}
proc git_blame_get_hunk_byline*(blame: ptr git_blame; lineno: size_t): ptr git_blame_hunk {.
    dynlib: libgitDl, importc.}
proc git_blame_file*(out: ptr ptr git_blame; repo: ptr git_repository;
                     path: cstring; options: ptr git_blame_options): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_buffer*(out: ptr ptr git_blame; reference: ptr git_blame;
                       buffer: cstring; buffer_len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_free*(blame: ptr git_blame): void {.dynlib: libgitDl, importc.}
proc git_ignore_add_rule*(repo: ptr git_repository; rules: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_ignore_clear_internal_rules*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_ignore_path_is_ignored*(ignored: ptr cint; repo: ptr git_repository;
                                 path: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_new*(out: ptr ptr git_revwalk; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_reset*(walker: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_push*(walk: ptr git_revwalk; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_glob*(walk: ptr git_revwalk; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_head*(walk: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_hide*(walk: ptr git_revwalk; commit_id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_glob*(walk: ptr git_revwalk; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_head*(walk: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_push_ref*(walk: ptr git_revwalk; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_ref*(walk: ptr git_revwalk; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_next*(out: ptr git_oid; walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_sorting*(walk: ptr git_revwalk; sort_mode: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_range*(walk: ptr git_revwalk; range: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_simplify_first_parent*(walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_free*(walk: ptr git_revwalk): void {.dynlib: libgitDl, importc.}
proc git_revwalk_repository*(walk: ptr git_revwalk): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_revwalk_add_hide_cb*(walk: ptr git_revwalk;
                              hide_cb: git_revwalk_hide_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create*(out: ptr ptr git_remote; repo: ptr git_repository;
                        name: cstring; url: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_create_options_init*(opts: ptr git_remote_create_options;
                                     version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_create_with_opts*(out: ptr ptr git_remote; url: cstring;
                                  opts: ptr git_remote_create_options): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_with_fetchspec*(out: ptr ptr git_remote;
                                       repo: ptr git_repository; name: cstring;
                                       url: cstring; fetch: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_anonymous*(out: ptr ptr git_remote;
                                  repo: ptr git_repository; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_detached*(out: ptr ptr git_remote; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_lookup*(out: ptr ptr git_remote; repo: ptr git_repository;
                        name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_dup*(dest: ptr ptr git_remote; source: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_owner*(remote: ptr git_remote): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_remote_name*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_url*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_pushurl*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_set_url*(repo: ptr git_repository; remote: cstring; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_set_pushurl*(repo: ptr git_repository; remote: cstring;
                             url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_add_fetch*(repo: ptr git_repository; remote: cstring;
                           refspec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_get_fetch_refspecs*(array: ptr git_strarray;
                                    remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_add_push*(repo: ptr git_repository; remote: cstring;
                          refspec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_get_push_refspecs*(array: ptr git_strarray;
                                   remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_refspec_count*(remote: ptr git_remote): size_t {.
    dynlib: libgitDl, importc.}
proc git_remote_get_refspec*(remote: ptr git_remote; n: size_t): ptr git_refspec {.
    dynlib: libgitDl, importc.}
proc git_remote_connect*(remote: ptr git_remote; direction: git_direction;
                         callbacks: ptr git_remote_callbacks;
                         proxy_opts: ptr git_proxy_options;
                         custom_headers: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_ls*(out: ptr ptr ptr git_remote_head; size: ptr size_t;
                    remote: ptr git_remote): cint {.dynlib: libgitDl, importc.}
proc git_remote_connected*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_stop*(remote: ptr git_remote): cint {.dynlib: libgitDl, importc.}
proc git_remote_disconnect*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_free*(remote: ptr git_remote): void {.dynlib: libgitDl, importc.}
proc git_remote_list*(out: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_init_callbacks*(opts: ptr git_remote_callbacks; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_fetch_options_init*(opts: ptr git_fetch_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_push_options_init*(opts: ptr git_push_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_download*(remote: ptr git_remote; refspecs: ptr git_strarray;
                          opts: ptr git_fetch_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_upload*(remote: ptr git_remote; refspecs: ptr git_strarray;
                        opts: ptr git_push_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_update_tips*(remote: ptr git_remote;
                             callbacks: ptr git_remote_callbacks;
                             update_fetchhead: cint;
                             download_tags: git_remote_autotag_option_t;
                             reflog_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_fetch*(remote: ptr git_remote; refspecs: ptr git_strarray;
                       opts: ptr git_fetch_options; reflog_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_prune*(remote: ptr git_remote;
                       callbacks: ptr git_remote_callbacks): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_push*(remote: ptr git_remote; refspecs: ptr git_strarray;
                      opts: ptr git_push_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_stats*(remote: ptr git_remote): ptr git_indexer_progress {.
    dynlib: libgitDl, importc.}
proc git_remote_autotag*(remote: ptr git_remote): git_remote_autotag_option_t {.
    dynlib: libgitDl, importc.}
proc git_remote_set_autotag*(repo: ptr git_repository; remote: cstring;
                             value: git_remote_autotag_option_t): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_prune_refs*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_rename*(problems: ptr git_strarray; repo: ptr git_repository;
                        name: cstring; new_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_is_valid_name*(remote_name: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_delete*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_default_branch*(out: ptr git_buf; remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_options_init*(opts: ptr git_indexer_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_new*(out: ptr ptr git_indexer; path: cstring; mode: cuint;
                      odb: ptr git_odb; opts: ptr git_indexer_options): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_append*(idx: ptr git_indexer; data: pointer; size: size_t;
                         stats: ptr git_indexer_progress): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_commit*(idx: ptr git_indexer; stats: ptr git_indexer_progress): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_hash*(idx: ptr git_indexer): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_indexer_free*(idx: ptr git_indexer): void {.dynlib: libgitDl, importc.}
proc git_signature_new*(out: ptr ptr git_signature; name: cstring;
                        email: cstring; time: git_time_t; offset: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_now*(out: ptr ptr git_signature; name: cstring;
                        email: cstring): cint {.dynlib: libgitDl, importc.}
proc git_signature_default*(out: ptr ptr git_signature; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_from_buffer*(out: ptr ptr git_signature; buf: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_dup*(dest: ptr ptr git_signature; sig: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_free*(sig: ptr git_signature): void {.dynlib: libgitDl,
    importc.}
proc git_merge_file_input_init*(opts: ptr git_merge_file_input; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_options_init*(opts: ptr git_merge_file_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_options_init*(opts: ptr git_merge_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_analysis*(analysis_out: ptr git_merge_analysis_t;
                         preference_out: ptr git_merge_preference_t;
                         repo: ptr git_repository;
                         their_heads: ptr ptr git_annotated_commit;
                         their_heads_len: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_analysis_for_ref*(analysis_out: ptr git_merge_analysis_t;
                                 preference_out: ptr git_merge_preference_t;
                                 repo: ptr git_repository;
                                 our_ref: ptr git_reference;
                                 their_heads: ptr ptr git_annotated_commit;
                                 their_heads_len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base*(out: ptr git_oid; repo: ptr git_repository;
                     one: ptr git_oid; two: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_bases*(out: ptr git_oidarray; repo: ptr git_repository;
                      one: ptr git_oid; two: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base_many*(out: ptr git_oid; repo: ptr git_repository;
                          length: size_t;
                          input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_bases_many*(out: ptr git_oidarray; repo: ptr git_repository;
                           length: size_t;
                           input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base_octopus*(out: ptr git_oid; repo: ptr git_repository;
                             length: size_t;
                             input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file*(out: ptr git_merge_file_result;
                     ancestor: ptr git_merge_file_input;
                     ours: ptr git_merge_file_input;
                     theirs: ptr git_merge_file_input;
                     opts: ptr git_merge_file_options): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_file_from_index*(out: ptr git_merge_file_result;
                                repo: ptr git_repository;
                                ancestor: ptr git_index_entry;
                                ours: ptr git_index_entry;
                                theirs: ptr git_index_entry;
                                opts: ptr git_merge_file_options): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_result_free*(result: ptr git_merge_file_result): void {.
    dynlib: libgitDl, importc.}
proc git_merge_trees*(out: ptr ptr git_index; repo: ptr git_repository;
                      ancestor_tree: ptr git_tree; our_tree: ptr git_tree;
                      their_tree: ptr git_tree; opts: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_commits*(out: ptr ptr git_index; repo: ptr git_repository;
                        our_commit: ptr git_commit;
                        their_commit: ptr git_commit;
                        opts: ptr git_merge_options): cint {.dynlib: libgitDl,
    importc.}
proc git_merge*(repo: ptr git_repository;
                their_heads: ptr ptr git_annotated_commit;
                their_heads_len: size_t; merge_opts: ptr git_merge_options;
                checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_options_init*(opts: ptr git_rebase_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_init*(out: ptr ptr git_rebase; repo: ptr git_repository;
                      branch: ptr git_annotated_commit;
                      upstream: ptr git_annotated_commit;
                      onto: ptr git_annotated_commit;
                      opts: ptr git_rebase_options): cint {.dynlib: libgitDl,
    importc.}
proc git_rebase_open*(out: ptr ptr git_rebase; repo: ptr git_repository;
                      opts: ptr git_rebase_options): cint {.dynlib: libgitDl,
    importc.}
proc git_rebase_orig_head_name*(rebase: ptr git_rebase): cstring {.
    dynlib: libgitDl, importc.}
proc git_rebase_orig_head_id*(rebase: ptr git_rebase): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_rebase_onto_name*(rebase: ptr git_rebase): cstring {.dynlib: libgitDl,
    importc.}
proc git_rebase_onto_id*(rebase: ptr git_rebase): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_entrycount*(rebase: ptr git_rebase): size_t {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_current*(rebase: ptr git_rebase): size_t {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_byindex*(rebase: ptr git_rebase; idx: size_t): ptr git_rebase_operation {.
    dynlib: libgitDl, importc.}
proc git_rebase_next*(operation: ptr ptr git_rebase_operation;
                      rebase: ptr git_rebase): cint {.dynlib: libgitDl, importc.}
proc git_rebase_inmemory_index*(index: ptr ptr git_index; rebase: ptr git_rebase): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_commit*(id: ptr git_oid; rebase: ptr git_rebase;
                        author: ptr git_signature; committer: ptr git_signature;
                        message_encoding: cstring; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_abort*(rebase: ptr git_rebase): cint {.dynlib: libgitDl, importc.}
proc git_rebase_finish*(rebase: ptr git_rebase; signature: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_free*(rebase: ptr git_rebase): void {.dynlib: libgitDl, importc.}
proc git_libgit2_version*(major: ptr cint; minor: ptr cint; rev: ptr cint): cint {.
    dynlib: libgitDl, importc.}
proc git_libgit2_features*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_libgit2_opts*(option: cint): cint {.dynlib: libgitDl, importc.}
proc git_oid_fromstr*(out: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_fromstrp*(out: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_fromstrn*(out: ptr git_oid; str: cstring; length: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_fromraw*(out: ptr git_oid; raw: ptr uchar): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_fmt*(out: cstring; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_nfmt*(out: cstring; n: size_t; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_pathfmt*(out: cstring; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_tostr_s*(oid: ptr git_oid): cstring {.dynlib: libgitDl, importc.}
proc git_oid_tostr*(out: cstring; n: size_t; id: ptr git_oid): cstring {.
    dynlib: libgitDl, importc.}
proc git_oid_cpy*(out: ptr git_oid; src: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_cmp*(a: ptr git_oid; b: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_equal*(a: ptr git_oid; b: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_ncmp*(a: ptr git_oid; b: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_streq*(id: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_strcmp*(id: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_is_zero*(id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_oid_shorten_new*(min_length: size_t): ptr git_oid_shorten {.
    dynlib: libgitDl, importc.}
proc git_oid_shorten_add*(os: ptr git_oid_shorten; text_id: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_shorten_free*(os: ptr git_oid_shorten): void {.dynlib: libgitDl,
    importc.}
proc git_filter_list_load*(filters: ptr ptr git_filter_list;
                           repo: ptr git_repository; blob: ptr git_blob;
                           path: cstring; mode: git_filter_mode_t; flags: uint32): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_contains*(filters: ptr git_filter_list; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_data*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    in: ptr git_buf): cint {.dynlib: libgitDl,
    importc.}
proc git_filter_list_apply_to_file*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    repo: ptr git_repository; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_blob*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    blob: ptr git_blob): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_data*(filters: ptr git_filter_list;
                                  data: ptr git_buf; target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_file*(filters: ptr git_filter_list;
                                  repo: ptr git_repository; path: cstring;
                                  target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_blob*(filters: ptr git_filter_list;
                                  blob: ptr git_blob;
                                  target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_free*(filters: ptr git_filter_list): void {.
    dynlib: libgitDl, importc.}
proc git_config_entry_free*(a0: ptr git_config_entry): void {.dynlib: libgitDl,
    importc.}
proc git_config_find_global*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_xdg*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_system*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_programdata*(out: ptr git_buf): cint {.dynlib: libgitDl,
    importc.}
proc git_config_open_default*(out: ptr ptr git_config): cint {.dynlib: libgitDl,
    importc.}
proc git_config_new*(out: ptr ptr git_config): cint {.dynlib: libgitDl, importc.}
proc git_config_add_file_ondisk*(cfg: ptr git_config; path: cstring;
                                 level: git_config_level_t;
                                 repo: ptr git_repository; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_config_open_ondisk*(out: ptr ptr git_config; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_open_level*(out: ptr ptr git_config; parent: ptr git_config;
                            level: git_config_level_t): cint {.dynlib: libgitDl,
    importc.}
proc git_config_open_global*(out: ptr ptr git_config; config: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_config_snapshot*(out: ptr ptr git_config; config: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_config_free*(cfg: ptr git_config): void {.dynlib: libgitDl, importc.}
proc git_config_get_entry*(out: ptr ptr git_config_entry; cfg: ptr git_config;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_config_get_int32*(out: ptr int32; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_int64*(out: ptr int64; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_bool*(out: ptr cint; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_path*(out: ptr git_buf; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_string*(out: ptr cstring; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_string_buf*(out: ptr git_buf; cfg: ptr git_config;
                                name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_config_get_multivar_foreach*(cfg: ptr git_config; name: cstring;
                                      regexp: cstring;
                                      callback: git_config_foreach_cb;
                                      payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_multivar_iterator_new*(out: ptr ptr git_config_iterator;
                                       cfg: ptr git_config; name: cstring;
                                       regexp: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_next*(entry: ptr ptr git_config_entry;
                      iter: ptr git_config_iterator): cint {.dynlib: libgitDl,
    importc.}
proc git_config_iterator_free*(iter: ptr git_config_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_config_set_int32*(cfg: ptr git_config; name: cstring; value: int32): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_int64*(cfg: ptr git_config; name: cstring; value: int64): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_bool*(cfg: ptr git_config; name: cstring; value: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_string*(cfg: ptr git_config; name: cstring; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_multivar*(cfg: ptr git_config; name: cstring;
                              regexp: cstring; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_delete_entry*(cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_delete_multivar*(cfg: ptr git_config; name: cstring;
                                 regexp: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_config_foreach*(cfg: ptr git_config; callback: git_config_foreach_cb;
                         payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_config_iterator_new*(out: ptr ptr git_config_iterator;
                              cfg: ptr git_config): cint {.dynlib: libgitDl,
    importc.}
proc git_config_iterator_glob_new*(out: ptr ptr git_config_iterator;
                                   cfg: ptr git_config; regexp: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_foreach_match*(cfg: ptr git_config; regexp: cstring;
                               callback: git_config_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_mapped*(out: ptr cint; cfg: ptr git_config; name: cstring;
                            maps: ptr git_configmap; map_n: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_config_lookup_map_value*(out: ptr cint; maps: ptr git_configmap;
                                  map_n: size_t; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_bool*(out: ptr cint; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_int32*(out: ptr int32; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_int64*(out: ptr int64; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_path*(out: ptr git_buf; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_backend_foreach_match*(backend: ptr git_config_backend;
                                       regexp: cstring;
                                       callback: git_config_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_lock*(tx: ptr ptr git_transaction; cfg: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_diff*(out: ptr ptr git_patch; diff: ptr git_diff;
                          idx: size_t): cint {.dynlib: libgitDl, importc.}
proc git_patch_from_blobs*(out: ptr ptr git_patch; old_blob: ptr git_blob;
                           old_as_path: cstring; new_blob: ptr git_blob;
                           new_as_path: cstring; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_blob_and_buffer*(out: ptr ptr git_patch;
                                     old_blob: ptr git_blob;
                                     old_as_path: cstring; buffer: pointer;
                                     buffer_len: size_t;
                                     buffer_as_path: cstring;
                                     opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_buffers*(out: ptr ptr git_patch; old_buffer: pointer;
                             old_len: size_t; old_as_path: cstring;
                             new_buffer: pointer; new_len: size_t;
                             new_as_path: cstring; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_free*(patch: ptr git_patch): void {.dynlib: libgitDl, importc.}
proc git_patch_get_delta*(patch: ptr git_patch): ptr git_diff_delta {.
    dynlib: libgitDl, importc.}
proc git_patch_num_hunks*(patch: ptr git_patch): size_t {.dynlib: libgitDl,
    importc.}
proc git_patch_line_stats*(total_context: ptr size_t;
                           total_additions: ptr size_t;
                           total_deletions: ptr size_t; patch: ptr git_patch): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_get_hunk*(out: ptr ptr git_diff_hunk; lines_in_hunk: ptr size_t;
                         patch: ptr git_patch; hunk_idx: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_num_lines_in_hunk*(patch: ptr git_patch; hunk_idx: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_get_line_in_hunk*(out: ptr ptr git_diff_line;
                                 patch: ptr git_patch; hunk_idx: size_t;
                                 line_of_hunk: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_patch_size*(patch: ptr git_patch; include_context: cint;
                     include_hunk_headers: cint; include_file_headers: cint): size_t {.
    dynlib: libgitDl, importc.}
proc git_patch_print*(patch: ptr git_patch; print_cb: git_diff_line_cb;
                      payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_patch_to_buf*(out: ptr git_buf; patch: ptr git_patch): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_ref*(out: ptr ptr git_annotated_commit;
                                    repo: ptr git_repository;
                                    ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_fetchhead*(out: ptr ptr git_annotated_commit;
    repo: ptr git_repository; branch_name: cstring; remote_url: cstring;
    id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_annotated_commit_lookup*(out: ptr ptr git_annotated_commit;
                                  repo: ptr git_repository; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_revspec*(out: ptr ptr git_annotated_commit;
                                        repo: ptr git_repository;
                                        revspec: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_id*(commit: ptr git_annotated_commit): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_ref*(commit: ptr git_annotated_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_free*(commit: ptr git_annotated_commit): void {.
    dynlib: libgitDl, importc.}
proc git_note_iterator_new*(out: ptr ptr git_note_iterator;
                            repo: ptr git_repository; notes_ref: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_note_commit_iterator_new*(out: ptr ptr git_note_iterator;
                                   notes_commit: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_note_iterator_free*(it: ptr git_note_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_note_next*(note_id: ptr git_oid; annotated_id: ptr git_oid;
                    it: ptr git_note_iterator): cint {.dynlib: libgitDl, importc.}
proc git_note_read*(out: ptr ptr git_note; repo: ptr git_repository;
                    notes_ref: cstring; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_commit_read*(out: ptr ptr git_note; repo: ptr git_repository;
                           notes_commit: ptr git_commit; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_author*(note: ptr git_note): ptr git_signature {.dynlib: libgitDl,
    importc.}
proc git_note_committer*(note: ptr git_note): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_note_message*(note: ptr git_note): cstring {.dynlib: libgitDl, importc.}
proc git_note_id*(note: ptr git_note): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_note_create*(out: ptr git_oid; repo: ptr git_repository;
                      notes_ref: cstring; author: ptr git_signature;
                      committer: ptr git_signature; oid: ptr git_oid;
                      note: cstring; force: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_note_commit_create*(notes_commit_out: ptr git_oid;
                             notes_blob_out: ptr git_oid;
                             repo: ptr git_repository; parent: ptr git_commit;
                             author: ptr git_signature;
                             committer: ptr git_signature; oid: ptr git_oid;
                             note: cstring; allow_note_overwrite: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_note_remove*(repo: ptr git_repository; notes_ref: cstring;
                      author: ptr git_signature; committer: ptr git_signature;
                      oid: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_note_commit_remove*(notes_commit_out: ptr git_oid;
                             repo: ptr git_repository;
                             notes_commit: ptr git_commit;
                             author: ptr git_signature;
                             committer: ptr git_signature; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_free*(note: ptr git_note): void {.dynlib: libgitDl, importc.}
proc git_note_default_ref*(out: ptr git_buf; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_note_foreach*(repo: ptr git_repository; notes_ref: cstring;
                       note_cb: git_note_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_graph_ahead_behind*(ahead: ptr size_t; behind: ptr size_t;
                             repo: ptr git_repository; local: ptr git_oid;
                             upstream: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_graph_descendant_of*(repo: ptr git_repository; commit: ptr git_oid;
                              ancestor: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_object_lookup*(object: ptr ptr git_object; repo: ptr git_repository;
                        id: ptr git_oid; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_lookup_prefix*(object_out: ptr ptr git_object;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_lookup_bypath*(out: ptr ptr git_object; treeish: ptr git_object;
                               path: cstring; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_id*(obj: ptr git_object): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_object_short_id*(out: ptr git_buf; obj: ptr git_object): cint {.
    dynlib: libgitDl, importc.}
proc git_object_type*(obj: ptr git_object): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_object_owner*(obj: ptr git_object): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_object_free*(object: ptr git_object): void {.dynlib: libgitDl, importc.}
proc git_object_type2string*(type: git_object_t): cstring {.dynlib: libgitDl,
    importc.}
proc git_object_string2type*(str: cstring): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_object_typeisloose*(type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_object_peel*(peeled: ptr ptr git_object; object: ptr git_object;
                      target_type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_object_dup*(dest: ptr ptr git_object; source: ptr git_object): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_lookup*(out: ptr ptr git_reference; repo: ptr git_repository;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_name_to_id*(out: ptr git_oid; repo: ptr git_repository;
                               name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_dwim*(out: ptr ptr git_reference; repo: ptr git_repository;
                         shorthand: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_symbolic_create_matching*(out: ptr ptr git_reference;
    repo: ptr git_repository; name: cstring; target: cstring; force: cint;
    current_value: cstring; log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_symbolic_create*(out: ptr ptr git_reference;
                                    repo: ptr git_repository; name: cstring;
                                    target: cstring; force: cint;
                                    log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_create*(out: ptr ptr git_reference; repo: ptr git_repository;
                           name: cstring; id: ptr git_oid; force: cint;
                           log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_create_matching*(out: ptr ptr git_reference;
                                    repo: ptr git_repository; name: cstring;
                                    id: ptr git_oid; force: cint;
                                    current_id: ptr git_oid;
                                    log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_target*(ref: ptr git_reference): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reference_target_peel*(ref: ptr git_reference): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reference_symbolic_target*(ref: ptr git_reference): cstring {.
    dynlib: libgitDl, importc.}
proc git_reference_type*(ref: ptr git_reference): git_reference_t {.
    dynlib: libgitDl, importc.}
proc git_reference_name*(ref: ptr git_reference): cstring {.dynlib: libgitDl,
    importc.}
proc git_reference_resolve*(out: ptr ptr git_reference; ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_owner*(ref: ptr git_reference): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_reference_symbolic_set_target*(out: ptr ptr git_reference;
                                        ref: ptr git_reference; target: cstring;
                                        log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_set_target*(out: ptr ptr git_reference;
                               ref: ptr git_reference; id: ptr git_oid;
                               log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_rename*(new_ref: ptr ptr git_reference;
                           ref: ptr git_reference; new_name: cstring;
                           force: cint; log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_delete*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_remove*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_list*(array: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach*(repo: ptr git_repository;
                            callback: git_reference_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach_name*(repo: ptr git_repository;
                                 callback: git_reference_foreach_name_cb;
                                 payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_dup*(dest: ptr ptr git_reference; source: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_free*(ref: ptr git_reference): void {.dynlib: libgitDl,
    importc.}
proc git_reference_cmp*(ref1: ptr git_reference; ref2: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_new*(out: ptr ptr git_reference_iterator;
                                 repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_glob_new*(out: ptr ptr git_reference_iterator;
                                      repo: ptr git_repository; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_next*(out: ptr ptr git_reference;
                         iter: ptr git_reference_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_next_name*(out: ptr cstring; iter: ptr git_reference_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_free*(iter: ptr git_reference_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach_glob*(repo: ptr git_repository; glob: cstring;
                                 callback: git_reference_foreach_name_cb;
                                 payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_has_log*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_ensure_log*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_is_branch*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_remote*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_tag*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_note*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_normalize_name*(buffer_out: cstring; buffer_size: size_t;
                                   name: cstring; flags: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_peel*(out: ptr ptr git_object; ref: ptr git_reference;
                         type: git_object_t): cint {.dynlib: libgitDl, importc.}
proc git_reference_is_valid_name*(refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_shorthand*(ref: ptr git_reference): cstring {.
    dynlib: libgitDl, importc.}
proc git_libgit2_init*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_libgit2_shutdown*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_odb_new*(out: ptr ptr git_odb): cint {.dynlib: libgitDl, importc.}
proc git_odb_open*(out: ptr ptr git_odb; objects_dir: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_add_disk_alternate*(odb: ptr git_odb; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_free*(db: ptr git_odb): void {.dynlib: libgitDl, importc.}
proc git_odb_read*(out: ptr ptr git_odb_object; db: ptr git_odb; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_read_prefix*(out: ptr ptr git_odb_object; db: ptr git_odb;
                          short_id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_read_header*(len_out: ptr size_t; type_out: ptr git_object_t;
                          db: ptr git_odb; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_exists*(db: ptr git_odb; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_exists_prefix*(out: ptr git_oid; db: ptr git_odb;
                            short_id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_expand_ids*(db: ptr git_odb; ids: ptr git_odb_expand_id;
                         count: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_refresh*(db: ptr git_odb): cint {.dynlib: libgitDl, importc.}
proc git_odb_foreach*(db: ptr git_odb; cb: git_odb_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_write*(out: ptr git_oid; odb: ptr git_odb; data: pointer;
                    len: size_t; type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_open_wstream*(out: ptr ptr git_odb_stream; db: ptr git_odb;
                           size: git_object_size_t; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_stream_write*(stream: ptr git_odb_stream; buffer: cstring;
                           len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_stream_finalize_write*(out: ptr git_oid; stream: ptr git_odb_stream): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_stream_read*(stream: ptr git_odb_stream; buffer: cstring;
                          len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_stream_free*(stream: ptr git_odb_stream): void {.dynlib: libgitDl,
    importc.}
proc git_odb_open_rstream*(out: ptr ptr git_odb_stream; len: ptr size_t;
                           type: ptr git_object_t; db: ptr git_odb;
                           oid: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_odb_write_pack*(out: ptr ptr git_odb_writepack; db: ptr git_odb;
                         progress_cb: git_indexer_progress_cb;
                         progress_payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_hash*(out: ptr git_oid; data: pointer; len: size_t;
                   type: git_object_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_hashfile*(out: ptr git_oid; path: cstring; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_object_dup*(dest: ptr ptr git_odb_object;
                         source: ptr git_odb_object): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_object_free*(object: ptr git_odb_object): void {.dynlib: libgitDl,
    importc.}
proc git_odb_object_id*(object: ptr git_odb_object): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_odb_object_data*(object: ptr git_odb_object): pointer {.
    dynlib: libgitDl, importc.}
proc git_odb_object_size*(object: ptr git_odb_object): size_t {.
    dynlib: libgitDl, importc.}
proc git_odb_object_type*(object: ptr git_odb_object): git_object_t {.
    dynlib: libgitDl, importc.}
proc git_odb_add_backend*(odb: ptr git_odb; backend: ptr git_odb_backend;
                          priority: cint): cint {.dynlib: libgitDl, importc.}
proc git_odb_add_alternate*(odb: ptr git_odb; backend: ptr git_odb_backend;
                            priority: cint): cint {.dynlib: libgitDl, importc.}
proc git_odb_num_backends*(odb: ptr git_odb): size_t {.dynlib: libgitDl, importc.}
proc git_odb_get_backend*(out: ptr ptr git_odb_backend; odb: ptr git_odb;
                          pos: size_t): cint {.dynlib: libgitDl, importc.}
proc git_oidarray_free*(array: ptr git_oidarray): void {.dynlib: libgitDl,
    importc.}
proc git_strarray_dispose*(array: ptr git_strarray): void {.dynlib: libgitDl,
    importc.}
proc git_strarray_copy*(tgt: ptr git_strarray; src: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_free*(cred: ptr git_credential): void {.dynlib: libgitDl,
    importc.}
proc git_credential_has_username*(cred: ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_get_username*(cred: ptr git_credential): cstring {.
    dynlib: libgitDl, importc.}
proc git_credential_userpass_plaintext_new*(out: ptr ptr git_credential;
    username: cstring; password: cstring): cint {.dynlib: libgitDl, importc.}
proc git_credential_default_new*(out: ptr ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_username_new*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_key_new*(out: ptr ptr git_credential; username: cstring;
                                 publickey: cstring; privatekey: cstring;
                                 passphrase: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_credential_ssh_key_memory_new*(out: ptr ptr git_credential;
                                        username: cstring; publickey: cstring;
                                        privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_interactive_new*(out: ptr ptr git_credential;
    username: cstring; prompt_callback: git_credential_ssh_interactive_cb;
    payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_credential_ssh_key_from_agent*(out: ptr ptr git_credential;
                                        username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_custom_new*(out: ptr ptr git_credential;
                                    username: cstring; publickey: cstring;
                                    publickey_len: size_t;
                                    sign_callback: git_credential_sign_cb;
                                    payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_clone_options_init*(opts: ptr git_clone_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_clone*(out: ptr ptr git_repository; url: cstring; local_path: cstring;
                options: ptr git_clone_options): cint {.dynlib: libgitDl,
    importc.}
proc git_cherrypick_options_init*(opts: ptr git_cherrypick_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_cherrypick_commit*(out: ptr ptr git_index; repo: ptr git_repository;
                            cherrypick_commit: ptr git_commit;
                            our_commit: ptr git_commit; mainline: cuint;
                            merge_options: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_cherrypick*(repo: ptr git_repository; commit: ptr git_commit;
                     cherrypick_options: ptr git_cherrypick_options): cint {.
    dynlib: libgitDl, importc.}
proc git_index_open*(out: ptr ptr git_index; index_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_new*(out: ptr ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_free*(index: ptr git_index): void {.dynlib: libgitDl, importc.}
proc git_index_owner*(index: ptr git_index): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_index_caps*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_set_caps*(index: ptr git_index; caps: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_version*(index: ptr git_index): cuint {.dynlib: libgitDl, importc.}
proc git_index_set_version*(index: ptr git_index; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_read*(index: ptr git_index; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_path*(index: ptr git_index): cstring {.dynlib: libgitDl, importc.}
proc git_index_checksum*(index: ptr git_index): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_index_read_tree*(index: ptr git_index; tree: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write_tree*(out: ptr git_oid; index: ptr git_index): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write_tree_to*(out: ptr git_oid; index: ptr git_index;
                              repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entrycount*(index: ptr git_index): size_t {.dynlib: libgitDl,
    importc.}
proc git_index_clear*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_get_byindex*(index: ptr git_index; n: size_t): ptr git_index_entry {.
    dynlib: libgitDl, importc.}
proc git_index_get_bypath*(index: ptr git_index; path: cstring; stage: cint): ptr git_index_entry {.
    dynlib: libgitDl, importc.}
proc git_index_remove*(index: ptr git_index; path: cstring; stage: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_remove_directory*(index: ptr git_index; dir: cstring; stage: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add*(index: ptr git_index; source_entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entry_stage*(entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entry_is_conflict*(entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_iterator_new*(iterator_out: ptr ptr git_index_iterator;
                             index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_iterator_next*(out: ptr ptr git_index_entry;
                              iterator: ptr git_index_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_index_iterator_free*(iterator: ptr git_index_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_index_add_bypath*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add_from_buffer*(index: ptr git_index;
                                entry: ptr git_index_entry; buffer: pointer;
                                len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_index_remove_bypath*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add_all*(index: ptr git_index; pathspec: ptr git_strarray;
                        flags: cuint; callback: git_index_matched_path_cb;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_index_remove_all*(index: ptr git_index; pathspec: ptr git_strarray;
                           callback: git_index_matched_path_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_index_update_all*(index: ptr git_index; pathspec: ptr git_strarray;
                           callback: git_index_matched_path_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_index_find*(at_pos: ptr size_t; index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_find_prefix*(at_pos: ptr size_t; index: ptr git_index;
                            prefix: cstring): cint {.dynlib: libgitDl, importc.}
proc git_index_conflict_add*(index: ptr git_index;
                             ancestor_entry: ptr git_index_entry;
                             our_entry: ptr git_index_entry;
                             their_entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_get*(ancestor_out: ptr ptr git_index_entry;
                             our_out: ptr ptr git_index_entry;
                             their_out: ptr ptr git_index_entry;
                             index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_remove*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_cleanup*(index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_has_conflicts*(index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_conflict_iterator_new*(iterator_out: ptr ptr git_index_conflict_iterator;
                                      index: ptr git_index): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_next*(ancestor_out: ptr ptr git_index_entry;
                              our_out: ptr ptr git_index_entry;
                              their_out: ptr ptr git_index_entry;
                              iterator: ptr git_index_conflict_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_iterator_free*(iterator: ptr git_index_conflict_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_trace_set*(level: git_trace_level_t; cb: git_trace_cb): cint {.
    dynlib: libgitDl, importc.}
proc git_error_last*(a0: void): ptr git_error {.dynlib: libgitDl, importc.}
proc git_error_clear*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_error_set_str*(error_class: cint; string: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_error_set_oom*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_odb_backend_pack*(out: ptr ptr git_odb_backend; objects_dir: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_backend_loose*(out: ptr ptr git_odb_backend; objects_dir: cstring;
                            compression_level: cint; do_fsync: cint;
                            dir_mode: cuint; file_mode: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_backend_one_pack*(out: ptr ptr git_odb_backend; index_file: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_message_prettify*(out: ptr git_buf; message: cstring;
                           strip_comments: cint; comment_char: char): cint {.
    dynlib: libgitDl, importc.}
proc git_message_trailers*(arr: ptr git_message_trailer_array; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_message_trailer_array_free*(arr: ptr git_message_trailer_array): void {.
    dynlib: libgitDl, importc.}
proc git_credential_userpass*(out: ptr ptr git_credential; url: cstring;
                              user_from_url: cstring; allowed_types: cuint;
                              payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_transaction_new*(out: ptr ptr git_transaction; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_lock_ref*(tx: ptr git_transaction; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_set_target*(tx: ptr git_transaction; refname: cstring;
                                 target: ptr git_oid; sig: ptr git_signature;
                                 msg: cstring): cint {.dynlib: libgitDl, importc.}
proc git_transaction_set_symbolic_target*(tx: ptr git_transaction;
    refname: cstring; target: cstring; sig: ptr git_signature; msg: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_set_reflog*(tx: ptr git_transaction; refname: cstring;
                                 reflog: ptr git_reflog): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_remove*(tx: ptr git_transaction; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_commit*(tx: ptr git_transaction): cint {.dynlib: libgitDl,
    importc.}
proc git_transaction_free*(tx: ptr git_transaction): void {.dynlib: libgitDl,
    importc.}
proc git_packbuilder_new*(out: ptr ptr git_packbuilder; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_set_threads*(pb: ptr git_packbuilder; n: cuint): cuint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert*(pb: ptr git_packbuilder; id: ptr git_oid;
                             name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_packbuilder_insert_tree*(pb: ptr git_packbuilder; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_commit*(pb: ptr git_packbuilder; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_walk*(pb: ptr git_packbuilder; walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_recur*(pb: ptr git_packbuilder; id: ptr git_oid;
                                   name: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_packbuilder_write_buf*(buf: ptr git_buf; pb: ptr git_packbuilder): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_write*(pb: ptr git_packbuilder; path: cstring; mode: cuint;
                            progress_cb: git_indexer_progress_cb;
                            progress_cb_payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_hash*(pb: ptr git_packbuilder): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_foreach*(pb: ptr git_packbuilder;
                              cb: git_packbuilder_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_object_count*(pb: ptr git_packbuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_written*(pb: ptr git_packbuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_set_callbacks*(pb: ptr git_packbuilder;
                                    progress_cb: git_packbuilder_progress;
                                    progress_cb_payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_free*(pb: ptr git_packbuilder): void {.dynlib: libgitDl,
    importc.}
proc git_pathspec_new*(out: ptr ptr git_pathspec; pathspec: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_pathspec_free*(ps: ptr git_pathspec): void {.dynlib: libgitDl, importc.}
proc git_pathspec_matches_path*(ps: ptr git_pathspec; flags: uint32;
                                path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_pathspec_match_workdir*(out: ptr ptr git_pathspec_match_list;
                                 repo: ptr git_repository; flags: uint32;
                                 ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_index*(out: ptr ptr git_pathspec_match_list;
                               index: ptr git_index; flags: uint32;
                               ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_tree*(out: ptr ptr git_pathspec_match_list;
                              tree: ptr git_tree; flags: uint32;
                              ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_diff*(out: ptr ptr git_pathspec_match_list;
                              diff: ptr git_diff; flags: uint32;
                              ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_list_free*(m: ptr git_pathspec_match_list): void {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_entrycount*(m: ptr git_pathspec_match_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_entry*(m: ptr git_pathspec_match_list; pos: size_t): cstring {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_diff_entry*(m: ptr git_pathspec_match_list;
    pos: size_t): ptr git_diff_delta {.dynlib: libgitDl, importc.}
proc git_pathspec_match_list_failed_entrycount*(m: ptr git_pathspec_match_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_failed_entry*(m: ptr git_pathspec_match_list;
    pos: size_t): cstring {.dynlib: libgitDl, importc.}
proc git_worktree_list*(out: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_lookup*(out: ptr ptr git_worktree; repo: ptr git_repository;
                          name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_worktree_open_from_repository*(out: ptr ptr git_worktree;
                                        repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_free*(wt: ptr git_worktree): void {.dynlib: libgitDl, importc.}
proc git_worktree_validate*(wt: ptr git_worktree): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_add_options_init*(opts: ptr git_worktree_add_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_add*(out: ptr ptr git_worktree; repo: ptr git_repository;
                       name: cstring; path: cstring;
                       opts: ptr git_worktree_add_options): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_lock*(wt: ptr git_worktree; reason: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_unlock*(wt: ptr git_worktree): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_is_locked*(reason: ptr git_buf; wt: ptr git_worktree): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_name*(wt: ptr git_worktree): cstring {.dynlib: libgitDl,
    importc.}
proc git_worktree_path*(wt: ptr git_worktree): cstring {.dynlib: libgitDl,
    importc.}
proc git_worktree_prune_options_init*(opts: ptr git_worktree_prune_options;
                                      version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_is_prunable*(wt: ptr git_worktree;
                               opts: ptr git_worktree_prune_options): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_prune*(wt: ptr git_worktree;
                         opts: ptr git_worktree_prune_options): cint {.
    dynlib: libgitDl, importc.}
proc git_proxy_options_init*(opts: ptr git_proxy_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_reset*(repo: ptr git_repository; target: ptr git_object;
                reset_type: git_reset_t; checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_reset_from_annotated*(repo: ptr git_repository;
                               commit: ptr git_annotated_commit;
                               reset_type: git_reset_t;
                               checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_reset_default*(repo: ptr git_repository; target: ptr git_object;
                        pathspecs: ptr git_strarray): cint {.dynlib: libgitDl,
    importc.}
proc git_apply_options_init*(opts: ptr git_apply_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_apply_to_tree*(out: ptr ptr git_index; repo: ptr git_repository;
                        preimage: ptr git_tree; diff: ptr git_diff;
                        options: ptr git_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_apply*(repo: ptr git_repository; diff: ptr git_diff;
                location: git_apply_location_t; options: ptr git_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_revparse_single*(out: ptr ptr git_object; repo: ptr git_repository;
                          spec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_revparse_ext*(object_out: ptr ptr git_object;
                       reference_out: ptr ptr git_reference;
                       repo: ptr git_repository; spec: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revparse*(revspec: ptr git_revspec; repo: ptr git_repository;
                   spec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_refspec_parse*(refspec: ptr ptr git_refspec; input: cstring;
                        is_fetch: cint): cint {.dynlib: libgitDl, importc.}
proc git_refspec_free*(refspec: ptr git_refspec): void {.dynlib: libgitDl,
    importc.}
proc git_refspec_src*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_dst*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_string*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_force*(refspec: ptr git_refspec): cint {.dynlib: libgitDl,
    importc.}
proc git_refspec_direction*(spec: ptr git_refspec): git_direction {.
    dynlib: libgitDl, importc.}
proc git_refspec_src_matches*(refspec: ptr git_refspec; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_refspec_dst_matches*(refspec: ptr git_refspec; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_refspec_transform*(out: ptr git_buf; spec: ptr git_refspec;
                            name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_refspec_rtransform*(out: ptr git_buf; spec: ptr git_refspec;
                             name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_fromworkdir*(id: ptr git_oid; repo: ptr git_repository;
                                  relative_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_fromdisk*(id: ptr git_oid; repo: ptr git_repository;
                               path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_fromstream*(out: ptr ptr git_writestream;
                                 repo: ptr git_repository; hintpath: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_fromstream_commit*(out: ptr git_oid;
                                        stream: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_frombuffer*(id: ptr git_oid; repo: ptr git_repository;
                                 buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_filtered_content*(out: ptr git_buf; blob: ptr git_blob;
                                as_path: cstring; check_for_binary_data: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_free*(buffer: ptr git_buf): void {.dynlib: libgitDl, importc.}
proc giterr_last*(a0: void): ptr git_error {.dynlib: libgitDl, importc.}
proc giterr_clear*(a0: void): void {.dynlib: libgitDl, importc.}
proc giterr_set_str*(error_class: cint; string: cstring): void {.
    dynlib: libgitDl, importc.}
proc giterr_set_oom*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_index_add_frombuffer*(index: ptr git_index; entry: ptr git_index_entry;
                               buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_size*(type: git_object_t): size_t {.dynlib: libgitDl,
    importc: "git_object__size".}
proc git_tag_create_frombuffer*(oid: ptr git_oid; repo: ptr git_repository;
                                buffer: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_free*(cred: ptr git_credential): void {.dynlib: libgitDl, importc.}
proc git_cred_has_username*(cred: ptr git_credential): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_get_username*(cred: ptr git_credential): cstring {.
    dynlib: libgitDl, importc.}
proc git_cred_userpass_plaintext_new*(out: ptr ptr git_credential;
                                      username: cstring; password: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_default_new*(out: ptr ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_username_new*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_key_new*(out: ptr ptr git_credential; username: cstring;
                           publickey: cstring; privatekey: cstring;
                           passphrase: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_ssh_key_memory_new*(out: ptr ptr git_credential;
                                  username: cstring; publickey: cstring;
                                  privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_interactive_new*(out: ptr ptr git_credential;
                                   username: cstring; prompt_callback: git_credential_ssh_interactive_cb;
                                   payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_ssh_key_from_agent*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_custom_new*(out: ptr ptr git_credential; username: cstring;
                              publickey: cstring; publickey_len: size_t;
                              sign_callback: git_credential_sign_cb;
                              payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_userpass*(out: ptr ptr git_credential; url: cstring;
                        user_from_url: cstring; allowed_types: cuint;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_oid_iszero*(id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_strarray_copy*(tgt: ptr git_strarray; src: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_strarray_free*(array: ptr git_strarray): void {.dynlib: libgitDl,
    importc.}
proc git_blame_init_options*(opts: ptr git_blame_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_init_options*(opts: ptr git_checkout_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_cherrypick_init_options*(opts: ptr git_cherrypick_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_clone_init_options*(opts: ptr git_clone_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_init_options*(opts: ptr git_describe_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_init_format_options*(opts: ptr git_describe_format_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_init_options*(opts: ptr git_diff_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_init_options*(opts: ptr git_diff_find_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_format_email_init_options*(
    opts: ptr git_diff_format_email_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_patchid_init_options*(opts: ptr git_diff_patchid_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_fetch_init_options*(opts: ptr git_fetch_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_init_options*(opts: ptr git_indexer_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_init_options*(opts: ptr git_merge_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_init_input*(input: ptr git_merge_file_input; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_init_options*(opts: ptr git_merge_file_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_proxy_init_options*(opts: ptr git_proxy_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_push_init_options*(opts: ptr git_push_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_init_options*(opts: ptr git_rebase_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_init_options*(opts: ptr git_remote_create_options;
                                     version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_init_init_options*(opts: ptr git_repository_init_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_revert_init_options*(opts: ptr git_revert_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_apply_init_options*(opts: ptr git_stash_apply_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_status_init_options*(opts: ptr git_status_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update_init_options*(opts: ptr git_submodule_update_options;
                                        version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_add_init_options*(opts: ptr git_worktree_add_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_prune_init_options*(opts: ptr git_worktree_prune_options;
                                      version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_update_options_init*(opts: ptr git_submodule_update_options;
                                        version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update*(submodule: ptr git_submodule; init: cint;
                           options: ptr git_submodule_update_options): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_lookup*(out: ptr ptr git_submodule; repo: ptr git_repository;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_free*(submodule: ptr git_submodule): void {.dynlib: libgitDl,
    importc.}
proc git_submodule_foreach*(repo: ptr git_repository;
                            callback: git_submodule_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_setup*(out: ptr ptr git_submodule;
                              repo: ptr git_repository; url: cstring;
                              path: cstring; use_gitlink: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_clone*(out: ptr ptr git_repository;
                          submodule: ptr git_submodule;
                          opts: ptr git_submodule_update_options): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_finalize*(submodule: ptr git_submodule): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_to_index*(submodule: ptr git_submodule; write_index: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_owner*(submodule: ptr git_submodule): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_submodule_name*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_path*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_url*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_resolve_url*(out: ptr git_buf; repo: ptr git_repository;
                                url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_branch*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_branch*(repo: ptr git_repository; name: cstring;
                               branch: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_set_url*(repo: ptr git_repository; name: cstring;
                            url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_index_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_head_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_wd_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_ignore*(submodule: ptr git_submodule): git_submodule_ignore_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_ignore*(repo: ptr git_repository; name: cstring;
                               ignore: git_submodule_ignore_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update_strategy*(submodule: ptr git_submodule): git_submodule_update_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_update*(repo: ptr git_repository; name: cstring;
                               update: git_submodule_update_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_fetch_recurse_submodules*(submodule: ptr git_submodule): git_submodule_recurse_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_fetch_recurse_submodules*(repo: ptr git_repository;
    name: cstring; fetch_recurse_submodules: git_submodule_recurse_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_init*(submodule: ptr git_submodule; overwrite: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_repo_init*(out: ptr ptr git_repository;
                              sm: ptr git_submodule; use_gitlink: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_sync*(submodule: ptr git_submodule): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_open*(repo: ptr ptr git_repository;
                         submodule: ptr git_submodule): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_reload*(submodule: ptr git_submodule; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_status*(status: ptr cuint; repo: ptr git_repository;
                           name: cstring; ignore: git_submodule_ignore_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_location*(location_status: ptr cuint;
                             submodule: ptr git_submodule): cint {.
    dynlib: libgitDl, importc.}
proc git_status_options_init*(opts: ptr git_status_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_status_foreach*(repo: ptr git_repository; callback: git_status_cb;
                         payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_status_foreach_ext*(repo: ptr git_repository;
                             opts: ptr git_status_options;
                             callback: git_status_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_status_file*(status_flags: ptr cuint; repo: ptr git_repository;
                      path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_status_list_new*(out: ptr ptr git_status_list;
                          repo: ptr git_repository; opts: ptr git_status_options): cint {.
    dynlib: libgitDl, importc.}
proc git_status_list_entrycount*(statuslist: ptr git_status_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_status_byindex*(statuslist: ptr git_status_list; idx: size_t): ptr git_status_entry {.
    dynlib: libgitDl, importc.}
proc git_status_list_free*(statuslist: ptr git_status_list): void {.
    dynlib: libgitDl, importc.}
proc git_status_should_ignore*(ignored: ptr cint; repo: ptr git_repository;
                               path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_revert_options_init*(opts: ptr git_revert_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_revert_commit*(out: ptr ptr git_index; repo: ptr git_repository;
                        revert_commit: ptr git_commit;
                        our_commit: ptr git_commit; mainline: cuint;
                        merge_options: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_revert*(repo: ptr git_repository; commit: ptr git_commit;
                 given_opts: ptr git_revert_options): cint {.dynlib: libgitDl,
    importc.}
proc git_buf_dispose*(buffer: ptr git_buf): void {.dynlib: libgitDl, importc.}
proc git_buf_grow*(buffer: ptr git_buf; target_size: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_set*(buffer: ptr git_buf; data: pointer; datalen: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_is_binary*(buf: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_buf_contains_nul*(buf: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_tag_lookup*(out: ptr ptr git_tag; repo: ptr git_repository;
                     id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_tag_lookup_prefix*(out: ptr ptr git_tag; repo: ptr git_repository;
                            id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_free*(tag: ptr git_tag): void {.dynlib: libgitDl, importc.}
proc git_tag_id*(tag: ptr git_tag): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_tag_owner*(tag: ptr git_tag): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_tag_target*(target_out: ptr ptr git_object; tag: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_target_id*(tag: ptr git_tag): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_tag_target_type*(tag: ptr git_tag): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_tag_name*(tag: ptr git_tag): cstring {.dynlib: libgitDl, importc.}
proc git_tag_tagger*(tag: ptr git_tag): ptr git_signature {.dynlib: libgitDl,
    importc.}
proc git_tag_message*(tag: ptr git_tag): cstring {.dynlib: libgitDl, importc.}
proc git_tag_create*(oid: ptr git_oid; repo: ptr git_repository;
                     tag_name: cstring; target: ptr git_object;
                     tagger: ptr git_signature; message: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_annotation_create*(oid: ptr git_oid; repo: ptr git_repository;
                                tag_name: cstring; target: ptr git_object;
                                tagger: ptr git_signature; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_create_from_buffer*(oid: ptr git_oid; repo: ptr git_repository;
                                 buffer: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_create_lightweight*(oid: ptr git_oid; repo: ptr git_repository;
                                 tag_name: cstring; target: ptr git_object;
                                 force: cint): cint {.dynlib: libgitDl, importc.}
proc git_tag_delete*(repo: ptr git_repository; tag_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_list*(tag_names: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_list_match*(tag_names: ptr git_strarray; pattern: cstring;
                         repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_tag_foreach*(repo: ptr git_repository; callback: git_tag_foreach_cb;
                      payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_tag_peel*(tag_target_out: ptr ptr git_object; tag: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_dup*(out: ptr ptr git_tag; source: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_options_init*(opts: ptr git_diff_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_options_init*(opts: ptr git_diff_find_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_free*(diff: ptr git_diff): void {.dynlib: libgitDl, importc.}
proc git_diff_tree_to_tree*(diff: ptr ptr git_diff; repo: ptr git_repository;
                            old_tree: ptr git_tree; new_tree: ptr git_tree;
                            opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_index*(diff: ptr ptr git_diff; repo: ptr git_repository;
                             old_tree: ptr git_tree; index: ptr git_index;
                             opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_index_to_workdir*(diff: ptr ptr git_diff;
                                repo: ptr git_repository; index: ptr git_index;
                                opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_workdir*(diff: ptr ptr git_diff; repo: ptr git_repository;
                               old_tree: ptr git_tree;
                               opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_workdir_with_index*(diff: ptr ptr git_diff;
    repo: ptr git_repository; old_tree: ptr git_tree; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_index_to_index*(diff: ptr ptr git_diff; repo: ptr git_repository;
                              old_index: ptr git_index;
                              new_index: ptr git_index;
                              opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_merge*(onto: ptr git_diff; from: ptr git_diff): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_similar*(diff: ptr git_diff;
                            options: ptr git_diff_find_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_num_deltas*(diff: ptr git_diff): size_t {.dynlib: libgitDl,
    importc.}
proc git_diff_num_deltas_of_type*(diff: ptr git_diff; type: git_delta_t): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_get_delta*(diff: ptr git_diff; idx: size_t): ptr git_diff_delta {.
    dynlib: libgitDl, importc.}
proc git_diff_is_sorted_icase*(diff: ptr git_diff): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_foreach*(diff: ptr git_diff; file_cb: git_diff_file_cb;
                       binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                       line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_status_char*(status: git_delta_t): char {.dynlib: libgitDl,
    importc.}
proc git_diff_print*(diff: ptr git_diff; format: git_diff_format_t;
                     print_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_to_buf*(out: ptr git_buf; diff: ptr git_diff;
                      format: git_diff_format_t): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_blobs*(old_blob: ptr git_blob; old_as_path: cstring;
                     new_blob: ptr git_blob; new_as_path: cstring;
                     options: ptr git_diff_options; file_cb: git_diff_file_cb;
                     binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                     line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_blob_to_buffer*(old_blob: ptr git_blob; old_as_path: cstring;
                              buffer: cstring; buffer_len: size_t;
                              buffer_as_path: cstring;
                              options: ptr git_diff_options;
                              file_cb: git_diff_file_cb;
                              binary_cb: git_diff_binary_cb;
                              hunk_cb: git_diff_hunk_cb;
                              line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_buffers*(old_buffer: pointer; old_len: size_t;
                       old_as_path: cstring; new_buffer: pointer;
                       new_len: size_t; new_as_path: cstring;
                       options: ptr git_diff_options; file_cb: git_diff_file_cb;
                       binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                       line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_from_buffer*(out: ptr ptr git_diff; content: cstring;
                           content_len: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_get_stats*(out: ptr ptr git_diff_stats; diff: ptr git_diff): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_files_changed*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_insertions*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_deletions*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_to_buf*(out: ptr git_buf; stats: ptr git_diff_stats;
                            format: git_diff_stats_format_t; width: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_free*(stats: ptr git_diff_stats): void {.dynlib: libgitDl,
    importc.}
proc git_diff_format_email*(out: ptr git_buf; diff: ptr git_diff;
                            opts: ptr git_diff_format_email_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_commit_as_email*(out: ptr git_buf; repo: ptr git_repository;
                               commit: ptr git_commit; patch_no: size_t;
                               total_patches: size_t; flags: uint32;
                               diff_opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_format_email_options_init*(
    opts: ptr git_diff_format_email_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_patchid_options_init*(opts: ptr git_diff_patchid_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_patchid*(out: ptr git_oid; diff: ptr git_diff;
                       opts: ptr git_diff_patchid_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_options_init*(opts: ptr git_describe_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_format_options_init*(opts: ptr git_describe_format_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_describe_commit*(result: ptr ptr git_describe_result;
                          committish: ptr git_object;
                          opts: ptr git_describe_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_workdir*(out: ptr ptr git_describe_result;
                           repo: ptr git_repository;
                           opts: ptr git_describe_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_format*(out: ptr git_buf; result: ptr git_describe_result;
                          opts: ptr git_describe_format_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_result_free*(result: ptr git_describe_result): void {.
    dynlib: libgitDl, importc.}
proc git_repository_open*(out: ptr ptr git_repository; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_from_worktree*(out: ptr ptr git_repository;
                                        wt: ptr git_worktree): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_wrap_odb*(out: ptr ptr git_repository; odb: ptr git_odb): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_discover*(out: ptr git_buf; start_path: cstring;
                              across_fs: cint; ceiling_dirs: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_ext*(out: ptr ptr git_repository; path: cstring;
                              flags: cuint; ceiling_dirs: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_bare*(out: ptr ptr git_repository; bare_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_free*(repo: ptr git_repository): void {.dynlib: libgitDl,
    importc.}
proc git_repository_init*(out: ptr ptr git_repository; path: cstring;
                          is_bare: cuint): cint {.dynlib: libgitDl, importc.}
proc git_repository_init_options_init*(opts: ptr git_repository_init_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_init_ext*(out: ptr ptr git_repository; repo_path: cstring;
                              opts: ptr git_repository_init_options): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head*(out: ptr ptr git_reference; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_for_worktree*(out: ptr ptr git_reference;
                                       repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_detached*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_detached_for_worktree*(repo: ptr git_repository;
    name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_repository_head_unborn*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_is_empty*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_item_path*(out: ptr git_buf; repo: ptr git_repository;
                               item: git_repository_item_t): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_path*(repo: ptr git_repository): cstring {.dynlib: libgitDl,
    importc.}
proc git_repository_workdir*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_commondir*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_set_workdir*(repo: ptr git_repository; workdir: cstring;
                                 update_gitlink: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_is_bare*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_is_worktree*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_config*(out: ptr ptr git_config; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_config_snapshot*(out: ptr ptr git_config;
                                     repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_odb*(out: ptr ptr git_odb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_refdb*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_index*(out: ptr ptr git_index; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_message*(out: ptr git_buf; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_message_remove*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_state_cleanup*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_fetchhead_foreach*(repo: ptr git_repository; callback: git_repository_fetchhead_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_mergehead_foreach*(repo: ptr git_repository; callback: git_repository_mergehead_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_hashfile*(out: ptr git_oid; repo: ptr git_repository;
                              path: cstring; type: git_object_t;
                              as_path: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_head*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_set_head_detached*(repo: ptr git_repository;
                                       commitish: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_set_head_detached_from_annotated*(repo: ptr git_repository;
    commitish: ptr git_annotated_commit): cint {.dynlib: libgitDl, importc.}
proc git_repository_detach_head*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_state*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_namespace*(repo: ptr git_repository; nmspace: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_get_namespace*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_is_shallow*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_ident*(name: ptr cstring; email: ptr cstring;
                           repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_ident*(repo: ptr git_repository; name: cstring;
                               email: cstring): cint {.dynlib: libgitDl, importc.}
proc git_checkout_options_init*(opts: ptr git_checkout_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_head*(repo: ptr git_repository; opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_index*(repo: ptr git_repository; index: ptr git_index;
                         opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_tree*(repo: ptr git_repository; treeish: ptr git_object;
                        opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_save*(out: ptr git_oid; repo: ptr git_repository;
                     stasher: ptr git_signature; message: cstring; flags: uint32): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_apply_options_init*(opts: ptr git_stash_apply_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_stash_apply*(repo: ptr git_repository; index: size_t;
                      options: ptr git_stash_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_foreach*(repo: ptr git_repository; callback: git_stash_cb;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_stash_drop*(repo: ptr git_repository; index: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_pop*(repo: ptr git_repository; index: size_t;
                    options: ptr git_stash_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_new*(out: ptr ptr git_mailmap): cint {.dynlib: libgitDl,
    importc.}
proc git_mailmap_free*(mm: ptr git_mailmap): void {.dynlib: libgitDl, importc.}
proc git_mailmap_add_entry*(mm: ptr git_mailmap; real_name: cstring;
                            real_email: cstring; replace_name: cstring;
                            replace_email: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_mailmap_from_buffer*(out: ptr ptr git_mailmap; buf: cstring;
                              len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_mailmap_from_repository*(out: ptr ptr git_mailmap;
                                  repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_resolve*(real_name: ptr cstring; real_email: ptr cstring;
                          mm: ptr git_mailmap; name: cstring; email: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_resolve_signature*(out: ptr ptr git_signature;
                                    mm: ptr git_mailmap; sig: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_lookup*(out: ptr ptr git_tree; repo: ptr git_repository;
                      id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_tree_lookup_prefix*(out: ptr ptr git_tree; repo: ptr git_repository;
                             id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_free*(tree: ptr git_tree): void {.dynlib: libgitDl, importc.}
proc git_tree_id*(tree: ptr git_tree): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_tree_owner*(tree: ptr git_tree): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_tree_entrycount*(tree: ptr git_tree): size_t {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_byname*(tree: ptr git_tree; filename: cstring): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_byindex*(tree: ptr git_tree; idx: size_t): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_byid*(tree: ptr git_tree; id: ptr git_oid): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_bypath*(out: ptr ptr git_tree_entry; root: ptr git_tree;
                            path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_tree_entry_dup*(dest: ptr ptr git_tree_entry;
                         source: ptr git_tree_entry): cint {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_free*(entry: ptr git_tree_entry): void {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_name*(entry: ptr git_tree_entry): cstring {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_id*(entry: ptr git_tree_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_type*(entry: ptr git_tree_entry): git_object_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_filemode*(entry: ptr git_tree_entry): git_filemode_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_filemode_raw*(entry: ptr git_tree_entry): git_filemode_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_cmp*(e1: ptr git_tree_entry; e2: ptr git_tree_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_to_object*(object_out: ptr ptr git_object;
                               repo: ptr git_repository;
                               entry: ptr git_tree_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_new*(out: ptr ptr git_treebuilder;
                          repo: ptr git_repository; source: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_clear*(bld: ptr git_treebuilder): cint {.dynlib: libgitDl,
    importc.}
proc git_treebuilder_entrycount*(bld: ptr git_treebuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_free*(bld: ptr git_treebuilder): void {.dynlib: libgitDl,
    importc.}
proc git_treebuilder_get*(bld: ptr git_treebuilder; filename: cstring): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_insert*(out: ptr ptr git_tree_entry;
                             bld: ptr git_treebuilder; filename: cstring;
                             id: ptr git_oid; filemode: git_filemode_t): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_remove*(bld: ptr git_treebuilder; filename: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_filter*(bld: ptr git_treebuilder;
                             filter: git_treebuilder_filter_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_write*(id: ptr git_oid; bld: ptr git_treebuilder): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_write_with_buffer*(oid: ptr git_oid;
                                        bld: ptr git_treebuilder;
                                        tree: ptr git_buf): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_walk*(tree: ptr git_tree; mode: git_treewalk_mode;
                    callback: git_treewalk_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_dup*(out: ptr ptr git_tree; source: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_create_updated*(out: ptr git_oid; repo: ptr git_repository;
                              baseline: ptr git_tree; nupdates: size_t;
                              updates: ptr git_tree_update): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_read*(out: ptr ptr git_reflog; repo: ptr git_repository;
                      name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reflog_write*(reflog: ptr git_reflog): cint {.dynlib: libgitDl, importc.}
proc git_reflog_append*(reflog: ptr git_reflog; id: ptr git_oid;
                        committer: ptr git_signature; msg: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_rename*(repo: ptr git_repository; old_name: cstring;
                        name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reflog_delete*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_entrycount*(reflog: ptr git_reflog): size_t {.dynlib: libgitDl,
    importc.}
proc git_reflog_entry_byindex*(reflog: ptr git_reflog; idx: size_t): ptr git_reflog_entry {.
    dynlib: libgitDl, importc.}
proc git_reflog_drop*(reflog: ptr git_reflog; idx: size_t;
                      rewrite_previous_entry: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_reflog_entry_id_old*(entry: ptr git_reflog_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_id_new*(entry: ptr git_reflog_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_committer*(entry: ptr git_reflog_entry): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_message*(entry: ptr git_reflog_entry): cstring {.
    dynlib: libgitDl, importc.}
proc git_reflog_free*(reflog: ptr git_reflog): void {.dynlib: libgitDl, importc.}
proc git_branch_create*(out: ptr ptr git_reference; repo: ptr git_repository;
                        branch_name: cstring; target: ptr git_commit;
                        force: cint): cint {.dynlib: libgitDl, importc.}
proc git_branch_create_from_annotated*(ref_out: ptr ptr git_reference;
                                       repository: ptr git_repository;
                                       branch_name: cstring;
                                       commit: ptr git_annotated_commit;
                                       force: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_delete*(branch: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_iterator_new*(out: ptr ptr git_branch_iterator;
                              repo: ptr git_repository; list_flags: git_branch_t): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_next*(out: ptr ptr git_reference; out_type: ptr git_branch_t;
                      iter: ptr git_branch_iterator): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_iterator_free*(iter: ptr git_branch_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_branch_move*(out: ptr ptr git_reference; branch: ptr git_reference;
                      new_branch_name: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_lookup*(out: ptr ptr git_reference; repo: ptr git_repository;
                        branch_name: cstring; branch_type: git_branch_t): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_name*(out: ptr cstring; ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_upstream*(out: ptr ptr git_reference; branch: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_set_upstream*(branch: ptr git_reference; branch_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_upstream_name*(out: ptr git_buf; repo: ptr git_repository;
                               refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_is_head*(branch: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_is_checked_out*(branch: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_remote_name*(out: ptr git_buf; repo: ptr git_repository;
                             refname: cstring): cint {.dynlib: libgitDl, importc.}
proc git_branch_upstream_remote*(buf: ptr git_buf; repo: ptr git_repository;
                                 refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_blob_lookup*(blob: ptr ptr git_blob; repo: ptr git_repository;
                      id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_blob_lookup_prefix*(blob: ptr ptr git_blob; repo: ptr git_repository;
                             id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_free*(blob: ptr git_blob): void {.dynlib: libgitDl, importc.}
proc git_blob_id*(blob: ptr git_blob): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_blob_owner*(blob: ptr git_blob): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_blob_rawcontent*(blob: ptr git_blob): pointer {.dynlib: libgitDl,
    importc.}
proc git_blob_rawsize*(blob: ptr git_blob): git_object_size_t {.
    dynlib: libgitDl, importc.}
proc git_blob_filter_options_init*(opts: ptr git_blob_filter_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_blob_filter*(out: ptr git_buf; blob: ptr git_blob; as_path: cstring;
                      opts: ptr git_blob_filter_options): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_workdir*(id: ptr git_oid; repo: ptr git_repository;
                                   relative_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_disk*(id: ptr git_oid; repo: ptr git_repository;
                                path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_from_stream*(out: ptr ptr git_writestream;
                                  repo: ptr git_repository; hintpath: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_stream_commit*(out: ptr git_oid;
    stream: ptr git_writestream): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_from_buffer*(id: ptr git_oid; repo: ptr git_repository;
                                  buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_is_binary*(blob: ptr git_blob): cint {.dynlib: libgitDl, importc.}
proc git_blob_dup*(out: ptr ptr git_blob; source: ptr git_blob): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_new*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_open*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_compress*(refdb: ptr git_refdb): cint {.dynlib: libgitDl, importc.}
proc git_refdb_free*(refdb: ptr git_refdb): void {.dynlib: libgitDl, importc.}
proc git_commit_lookup*(commit: ptr ptr git_commit; repo: ptr git_repository;
                        id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_commit_lookup_prefix*(commit: ptr ptr git_commit;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_commit_free*(commit: ptr git_commit): void {.dynlib: libgitDl, importc.}
proc git_commit_id*(commit: ptr git_commit): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_commit_owner*(commit: ptr git_commit): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_commit_message_encoding*(commit: ptr git_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_commit_message*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_message_raw*(commit: ptr git_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_commit_summary*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_body*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_time*(commit: ptr git_commit): git_time_t {.dynlib: libgitDl,
    importc.}
proc git_commit_time_offset*(commit: ptr git_commit): cint {.dynlib: libgitDl,
    importc.}
proc git_commit_committer*(commit: ptr git_commit): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_commit_author*(commit: ptr git_commit): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_commit_committer_with_mailmap*(out: ptr ptr git_signature;
                                        commit: ptr git_commit;
                                        mailmap: ptr git_mailmap): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_author_with_mailmap*(out: ptr ptr git_signature;
                                     commit: ptr git_commit;
                                     mailmap: ptr git_mailmap): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_raw_header*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_tree*(tree_out: ptr ptr git_tree; commit: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_tree_id*(commit: ptr git_commit): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_commit_parentcount*(commit: ptr git_commit): cuint {.dynlib: libgitDl,
    importc.}
proc git_commit_parent*(out: ptr ptr git_commit; commit: ptr git_commit;
                        n: cuint): cint {.dynlib: libgitDl, importc.}
proc git_commit_parent_id*(commit: ptr git_commit; n: cuint): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_commit_nth_gen_ancestor*(ancestor: ptr ptr git_commit;
                                  commit: ptr git_commit; n: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_header_field*(out: ptr git_buf; commit: ptr git_commit;
                              field: cstring): cint {.dynlib: libgitDl, importc.}
proc git_commit_extract_signature*(signature: ptr git_buf;
                                   signed_data: ptr git_buf;
                                   repo: ptr git_repository;
                                   commit_id: ptr git_oid; field: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create*(id: ptr git_oid; repo: ptr git_repository;
                        update_ref: cstring; author: ptr git_signature;
                        committer: ptr git_signature; message_encoding: cstring;
                        message: cstring; tree: ptr git_tree;
                        parent_count: size_t;
                        parents: ptr UncheckedArray[ptr git_commit]): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_v*(id: ptr git_oid; repo: ptr git_repository;
                          update_ref: cstring; author: ptr git_signature;
                          committer: ptr git_signature;
                          message_encoding: cstring; message: cstring;
                          tree: ptr git_tree; parent_count: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_amend*(id: ptr git_oid; commit_to_amend: ptr git_commit;
                       update_ref: cstring; author: ptr git_signature;
                       committer: ptr git_signature; message_encoding: cstring;
                       message: cstring; tree: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_buffer*(out: ptr git_buf; repo: ptr git_repository;
                               author: ptr git_signature;
                               committer: ptr git_signature;
                               message_encoding: cstring; message: cstring;
                               tree: ptr git_tree; parent_count: size_t;
                               parents: ptr UncheckedArray[ptr git_commit]): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_with_signature*(out: ptr git_oid;
                                       repo: ptr git_repository;
                                       commit_content: cstring;
                                       signature: cstring;
                                       signature_field: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_dup*(out: ptr ptr git_commit; source: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_value*(attr: cstring): git_attr_value_t {.dynlib: libgitDl,
    importc.}
proc git_attr_get*(value_out: ptr cstring; repo: ptr git_repository;
                   flags: uint32; path: cstring; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_get_many*(values_out: ptr cstring; repo: ptr git_repository;
                        flags: uint32; path: cstring; num_attr: size_t;
                        names: ptr cstring): cint {.dynlib: libgitDl, importc.}
proc git_attr_foreach*(repo: ptr git_repository; flags: uint32; path: cstring;
                       callback: git_attr_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_cache_flush*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_attr_add_macro*(repo: ptr git_repository; name: cstring;
                         values: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blame_options_init*(opts: ptr git_blame_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_get_hunk_count*(blame: ptr git_blame): uint32 {.dynlib: libgitDl,
    importc.}
proc git_blame_get_hunk_byindex*(blame: ptr git_blame; index: uint32): ptr git_blame_hunk {.
    dynlib: libgitDl, importc.}
proc git_blame_get_hunk_byline*(blame: ptr git_blame; lineno: size_t): ptr git_blame_hunk {.
    dynlib: libgitDl, importc.}
proc git_blame_file*(out: ptr ptr git_blame; repo: ptr git_repository;
                     path: cstring; options: ptr git_blame_options): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_buffer*(out: ptr ptr git_blame; reference: ptr git_blame;
                       buffer: cstring; buffer_len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_free*(blame: ptr git_blame): void {.dynlib: libgitDl, importc.}
proc git_ignore_add_rule*(repo: ptr git_repository; rules: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_ignore_clear_internal_rules*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_ignore_path_is_ignored*(ignored: ptr cint; repo: ptr git_repository;
                                 path: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_new*(out: ptr ptr git_revwalk; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_reset*(walker: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_push*(walk: ptr git_revwalk; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_glob*(walk: ptr git_revwalk; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_head*(walk: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_hide*(walk: ptr git_revwalk; commit_id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_glob*(walk: ptr git_revwalk; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_head*(walk: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_push_ref*(walk: ptr git_revwalk; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_ref*(walk: ptr git_revwalk; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_next*(out: ptr git_oid; walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_sorting*(walk: ptr git_revwalk; sort_mode: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_range*(walk: ptr git_revwalk; range: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_simplify_first_parent*(walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_free*(walk: ptr git_revwalk): void {.dynlib: libgitDl, importc.}
proc git_revwalk_repository*(walk: ptr git_revwalk): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_revwalk_add_hide_cb*(walk: ptr git_revwalk;
                              hide_cb: git_revwalk_hide_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create*(out: ptr ptr git_remote; repo: ptr git_repository;
                        name: cstring; url: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_create_options_init*(opts: ptr git_remote_create_options;
                                     version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_create_with_opts*(out: ptr ptr git_remote; url: cstring;
                                  opts: ptr git_remote_create_options): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_with_fetchspec*(out: ptr ptr git_remote;
                                       repo: ptr git_repository; name: cstring;
                                       url: cstring; fetch: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_anonymous*(out: ptr ptr git_remote;
                                  repo: ptr git_repository; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_detached*(out: ptr ptr git_remote; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_lookup*(out: ptr ptr git_remote; repo: ptr git_repository;
                        name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_dup*(dest: ptr ptr git_remote; source: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_owner*(remote: ptr git_remote): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_remote_name*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_url*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_pushurl*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_set_url*(repo: ptr git_repository; remote: cstring; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_set_pushurl*(repo: ptr git_repository; remote: cstring;
                             url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_add_fetch*(repo: ptr git_repository; remote: cstring;
                           refspec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_get_fetch_refspecs*(array: ptr git_strarray;
                                    remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_add_push*(repo: ptr git_repository; remote: cstring;
                          refspec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_get_push_refspecs*(array: ptr git_strarray;
                                   remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_refspec_count*(remote: ptr git_remote): size_t {.
    dynlib: libgitDl, importc.}
proc git_remote_get_refspec*(remote: ptr git_remote; n: size_t): ptr git_refspec {.
    dynlib: libgitDl, importc.}
proc git_remote_connect*(remote: ptr git_remote; direction: git_direction;
                         callbacks: ptr git_remote_callbacks;
                         proxy_opts: ptr git_proxy_options;
                         custom_headers: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_ls*(out: ptr ptr ptr git_remote_head; size: ptr size_t;
                    remote: ptr git_remote): cint {.dynlib: libgitDl, importc.}
proc git_remote_connected*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_stop*(remote: ptr git_remote): cint {.dynlib: libgitDl, importc.}
proc git_remote_disconnect*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_free*(remote: ptr git_remote): void {.dynlib: libgitDl, importc.}
proc git_remote_list*(out: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_init_callbacks*(opts: ptr git_remote_callbacks; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_fetch_options_init*(opts: ptr git_fetch_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_push_options_init*(opts: ptr git_push_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_download*(remote: ptr git_remote; refspecs: ptr git_strarray;
                          opts: ptr git_fetch_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_upload*(remote: ptr git_remote; refspecs: ptr git_strarray;
                        opts: ptr git_push_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_update_tips*(remote: ptr git_remote;
                             callbacks: ptr git_remote_callbacks;
                             update_fetchhead: cint;
                             download_tags: git_remote_autotag_option_t;
                             reflog_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_fetch*(remote: ptr git_remote; refspecs: ptr git_strarray;
                       opts: ptr git_fetch_options; reflog_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_prune*(remote: ptr git_remote;
                       callbacks: ptr git_remote_callbacks): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_push*(remote: ptr git_remote; refspecs: ptr git_strarray;
                      opts: ptr git_push_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_stats*(remote: ptr git_remote): ptr git_indexer_progress {.
    dynlib: libgitDl, importc.}
proc git_remote_autotag*(remote: ptr git_remote): git_remote_autotag_option_t {.
    dynlib: libgitDl, importc.}
proc git_remote_set_autotag*(repo: ptr git_repository; remote: cstring;
                             value: git_remote_autotag_option_t): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_prune_refs*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_rename*(problems: ptr git_strarray; repo: ptr git_repository;
                        name: cstring; new_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_is_valid_name*(remote_name: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_delete*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_default_branch*(out: ptr git_buf; remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_options_init*(opts: ptr git_indexer_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_new*(out: ptr ptr git_indexer; path: cstring; mode: cuint;
                      odb: ptr git_odb; opts: ptr git_indexer_options): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_append*(idx: ptr git_indexer; data: pointer; size: size_t;
                         stats: ptr git_indexer_progress): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_commit*(idx: ptr git_indexer; stats: ptr git_indexer_progress): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_hash*(idx: ptr git_indexer): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_indexer_free*(idx: ptr git_indexer): void {.dynlib: libgitDl, importc.}
proc git_signature_new*(out: ptr ptr git_signature; name: cstring;
                        email: cstring; time: git_time_t; offset: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_now*(out: ptr ptr git_signature; name: cstring;
                        email: cstring): cint {.dynlib: libgitDl, importc.}
proc git_signature_default*(out: ptr ptr git_signature; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_from_buffer*(out: ptr ptr git_signature; buf: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_dup*(dest: ptr ptr git_signature; sig: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_free*(sig: ptr git_signature): void {.dynlib: libgitDl,
    importc.}
proc git_merge_file_input_init*(opts: ptr git_merge_file_input; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_options_init*(opts: ptr git_merge_file_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_options_init*(opts: ptr git_merge_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_analysis*(analysis_out: ptr git_merge_analysis_t;
                         preference_out: ptr git_merge_preference_t;
                         repo: ptr git_repository;
                         their_heads: ptr ptr git_annotated_commit;
                         their_heads_len: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_analysis_for_ref*(analysis_out: ptr git_merge_analysis_t;
                                 preference_out: ptr git_merge_preference_t;
                                 repo: ptr git_repository;
                                 our_ref: ptr git_reference;
                                 their_heads: ptr ptr git_annotated_commit;
                                 their_heads_len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base*(out: ptr git_oid; repo: ptr git_repository;
                     one: ptr git_oid; two: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_bases*(out: ptr git_oidarray; repo: ptr git_repository;
                      one: ptr git_oid; two: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base_many*(out: ptr git_oid; repo: ptr git_repository;
                          length: size_t;
                          input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_bases_many*(out: ptr git_oidarray; repo: ptr git_repository;
                           length: size_t;
                           input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base_octopus*(out: ptr git_oid; repo: ptr git_repository;
                             length: size_t;
                             input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file*(out: ptr git_merge_file_result;
                     ancestor: ptr git_merge_file_input;
                     ours: ptr git_merge_file_input;
                     theirs: ptr git_merge_file_input;
                     opts: ptr git_merge_file_options): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_file_from_index*(out: ptr git_merge_file_result;
                                repo: ptr git_repository;
                                ancestor: ptr git_index_entry;
                                ours: ptr git_index_entry;
                                theirs: ptr git_index_entry;
                                opts: ptr git_merge_file_options): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_result_free*(result: ptr git_merge_file_result): void {.
    dynlib: libgitDl, importc.}
proc git_merge_trees*(out: ptr ptr git_index; repo: ptr git_repository;
                      ancestor_tree: ptr git_tree; our_tree: ptr git_tree;
                      their_tree: ptr git_tree; opts: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_commits*(out: ptr ptr git_index; repo: ptr git_repository;
                        our_commit: ptr git_commit;
                        their_commit: ptr git_commit;
                        opts: ptr git_merge_options): cint {.dynlib: libgitDl,
    importc.}
proc git_merge*(repo: ptr git_repository;
                their_heads: ptr ptr git_annotated_commit;
                their_heads_len: size_t; merge_opts: ptr git_merge_options;
                checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_options_init*(opts: ptr git_rebase_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_init*(out: ptr ptr git_rebase; repo: ptr git_repository;
                      branch: ptr git_annotated_commit;
                      upstream: ptr git_annotated_commit;
                      onto: ptr git_annotated_commit;
                      opts: ptr git_rebase_options): cint {.dynlib: libgitDl,
    importc.}
proc git_rebase_open*(out: ptr ptr git_rebase; repo: ptr git_repository;
                      opts: ptr git_rebase_options): cint {.dynlib: libgitDl,
    importc.}
proc git_rebase_orig_head_name*(rebase: ptr git_rebase): cstring {.
    dynlib: libgitDl, importc.}
proc git_rebase_orig_head_id*(rebase: ptr git_rebase): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_rebase_onto_name*(rebase: ptr git_rebase): cstring {.dynlib: libgitDl,
    importc.}
proc git_rebase_onto_id*(rebase: ptr git_rebase): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_entrycount*(rebase: ptr git_rebase): size_t {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_current*(rebase: ptr git_rebase): size_t {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_byindex*(rebase: ptr git_rebase; idx: size_t): ptr git_rebase_operation {.
    dynlib: libgitDl, importc.}
proc git_rebase_next*(operation: ptr ptr git_rebase_operation;
                      rebase: ptr git_rebase): cint {.dynlib: libgitDl, importc.}
proc git_rebase_inmemory_index*(index: ptr ptr git_index; rebase: ptr git_rebase): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_commit*(id: ptr git_oid; rebase: ptr git_rebase;
                        author: ptr git_signature; committer: ptr git_signature;
                        message_encoding: cstring; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_abort*(rebase: ptr git_rebase): cint {.dynlib: libgitDl, importc.}
proc git_rebase_finish*(rebase: ptr git_rebase; signature: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_free*(rebase: ptr git_rebase): void {.dynlib: libgitDl, importc.}
proc git_libgit2_version*(major: ptr cint; minor: ptr cint; rev: ptr cint): cint {.
    dynlib: libgitDl, importc.}
proc git_libgit2_features*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_libgit2_opts*(option: cint): cint {.dynlib: libgitDl, importc.}
proc git_oid_fromstr*(out: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_fromstrp*(out: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_fromstrn*(out: ptr git_oid; str: cstring; length: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_fromraw*(out: ptr git_oid; raw: ptr uchar): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_fmt*(out: cstring; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_nfmt*(out: cstring; n: size_t; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_pathfmt*(out: cstring; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_tostr_s*(oid: ptr git_oid): cstring {.dynlib: libgitDl, importc.}
proc git_oid_tostr*(out: cstring; n: size_t; id: ptr git_oid): cstring {.
    dynlib: libgitDl, importc.}
proc git_oid_cpy*(out: ptr git_oid; src: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_cmp*(a: ptr git_oid; b: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_equal*(a: ptr git_oid; b: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_ncmp*(a: ptr git_oid; b: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_streq*(id: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_strcmp*(id: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_is_zero*(id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_oid_shorten_new*(min_length: size_t): ptr git_oid_shorten {.
    dynlib: libgitDl, importc.}
proc git_oid_shorten_add*(os: ptr git_oid_shorten; text_id: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_shorten_free*(os: ptr git_oid_shorten): void {.dynlib: libgitDl,
    importc.}
proc git_filter_list_load*(filters: ptr ptr git_filter_list;
                           repo: ptr git_repository; blob: ptr git_blob;
                           path: cstring; mode: git_filter_mode_t; flags: uint32): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_contains*(filters: ptr git_filter_list; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_data*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    in: ptr git_buf): cint {.dynlib: libgitDl,
    importc.}
proc git_filter_list_apply_to_file*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    repo: ptr git_repository; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_blob*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    blob: ptr git_blob): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_data*(filters: ptr git_filter_list;
                                  data: ptr git_buf; target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_file*(filters: ptr git_filter_list;
                                  repo: ptr git_repository; path: cstring;
                                  target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_blob*(filters: ptr git_filter_list;
                                  blob: ptr git_blob;
                                  target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_free*(filters: ptr git_filter_list): void {.
    dynlib: libgitDl, importc.}
proc git_config_entry_free*(a0: ptr git_config_entry): void {.dynlib: libgitDl,
    importc.}
proc git_config_find_global*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_xdg*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_system*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_programdata*(out: ptr git_buf): cint {.dynlib: libgitDl,
    importc.}
proc git_config_open_default*(out: ptr ptr git_config): cint {.dynlib: libgitDl,
    importc.}
proc git_config_new*(out: ptr ptr git_config): cint {.dynlib: libgitDl, importc.}
proc git_config_add_file_ondisk*(cfg: ptr git_config; path: cstring;
                                 level: git_config_level_t;
                                 repo: ptr git_repository; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_config_open_ondisk*(out: ptr ptr git_config; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_open_level*(out: ptr ptr git_config; parent: ptr git_config;
                            level: git_config_level_t): cint {.dynlib: libgitDl,
    importc.}
proc git_config_open_global*(out: ptr ptr git_config; config: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_config_snapshot*(out: ptr ptr git_config; config: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_config_free*(cfg: ptr git_config): void {.dynlib: libgitDl, importc.}
proc git_config_get_entry*(out: ptr ptr git_config_entry; cfg: ptr git_config;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_config_get_int32*(out: ptr int32; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_int64*(out: ptr int64; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_bool*(out: ptr cint; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_path*(out: ptr git_buf; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_string*(out: ptr cstring; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_string_buf*(out: ptr git_buf; cfg: ptr git_config;
                                name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_config_get_multivar_foreach*(cfg: ptr git_config; name: cstring;
                                      regexp: cstring;
                                      callback: git_config_foreach_cb;
                                      payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_multivar_iterator_new*(out: ptr ptr git_config_iterator;
                                       cfg: ptr git_config; name: cstring;
                                       regexp: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_next*(entry: ptr ptr git_config_entry;
                      iter: ptr git_config_iterator): cint {.dynlib: libgitDl,
    importc.}
proc git_config_iterator_free*(iter: ptr git_config_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_config_set_int32*(cfg: ptr git_config; name: cstring; value: int32): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_int64*(cfg: ptr git_config; name: cstring; value: int64): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_bool*(cfg: ptr git_config; name: cstring; value: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_string*(cfg: ptr git_config; name: cstring; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_multivar*(cfg: ptr git_config; name: cstring;
                              regexp: cstring; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_delete_entry*(cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_delete_multivar*(cfg: ptr git_config; name: cstring;
                                 regexp: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_config_foreach*(cfg: ptr git_config; callback: git_config_foreach_cb;
                         payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_config_iterator_new*(out: ptr ptr git_config_iterator;
                              cfg: ptr git_config): cint {.dynlib: libgitDl,
    importc.}
proc git_config_iterator_glob_new*(out: ptr ptr git_config_iterator;
                                   cfg: ptr git_config; regexp: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_foreach_match*(cfg: ptr git_config; regexp: cstring;
                               callback: git_config_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_mapped*(out: ptr cint; cfg: ptr git_config; name: cstring;
                            maps: ptr git_configmap; map_n: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_config_lookup_map_value*(out: ptr cint; maps: ptr git_configmap;
                                  map_n: size_t; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_bool*(out: ptr cint; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_int32*(out: ptr int32; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_int64*(out: ptr int64; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_path*(out: ptr git_buf; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_backend_foreach_match*(backend: ptr git_config_backend;
                                       regexp: cstring;
                                       callback: git_config_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_lock*(tx: ptr ptr git_transaction; cfg: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_diff*(out: ptr ptr git_patch; diff: ptr git_diff;
                          idx: size_t): cint {.dynlib: libgitDl, importc.}
proc git_patch_from_blobs*(out: ptr ptr git_patch; old_blob: ptr git_blob;
                           old_as_path: cstring; new_blob: ptr git_blob;
                           new_as_path: cstring; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_blob_and_buffer*(out: ptr ptr git_patch;
                                     old_blob: ptr git_blob;
                                     old_as_path: cstring; buffer: pointer;
                                     buffer_len: size_t;
                                     buffer_as_path: cstring;
                                     opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_buffers*(out: ptr ptr git_patch; old_buffer: pointer;
                             old_len: size_t; old_as_path: cstring;
                             new_buffer: pointer; new_len: size_t;
                             new_as_path: cstring; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_free*(patch: ptr git_patch): void {.dynlib: libgitDl, importc.}
proc git_patch_get_delta*(patch: ptr git_patch): ptr git_diff_delta {.
    dynlib: libgitDl, importc.}
proc git_patch_num_hunks*(patch: ptr git_patch): size_t {.dynlib: libgitDl,
    importc.}
proc git_patch_line_stats*(total_context: ptr size_t;
                           total_additions: ptr size_t;
                           total_deletions: ptr size_t; patch: ptr git_patch): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_get_hunk*(out: ptr ptr git_diff_hunk; lines_in_hunk: ptr size_t;
                         patch: ptr git_patch; hunk_idx: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_num_lines_in_hunk*(patch: ptr git_patch; hunk_idx: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_get_line_in_hunk*(out: ptr ptr git_diff_line;
                                 patch: ptr git_patch; hunk_idx: size_t;
                                 line_of_hunk: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_patch_size*(patch: ptr git_patch; include_context: cint;
                     include_hunk_headers: cint; include_file_headers: cint): size_t {.
    dynlib: libgitDl, importc.}
proc git_patch_print*(patch: ptr git_patch; print_cb: git_diff_line_cb;
                      payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_patch_to_buf*(out: ptr git_buf; patch: ptr git_patch): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_ref*(out: ptr ptr git_annotated_commit;
                                    repo: ptr git_repository;
                                    ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_fetchhead*(out: ptr ptr git_annotated_commit;
    repo: ptr git_repository; branch_name: cstring; remote_url: cstring;
    id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_annotated_commit_lookup*(out: ptr ptr git_annotated_commit;
                                  repo: ptr git_repository; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_revspec*(out: ptr ptr git_annotated_commit;
                                        repo: ptr git_repository;
                                        revspec: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_id*(commit: ptr git_annotated_commit): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_ref*(commit: ptr git_annotated_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_free*(commit: ptr git_annotated_commit): void {.
    dynlib: libgitDl, importc.}
proc git_note_iterator_new*(out: ptr ptr git_note_iterator;
                            repo: ptr git_repository; notes_ref: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_note_commit_iterator_new*(out: ptr ptr git_note_iterator;
                                   notes_commit: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_note_iterator_free*(it: ptr git_note_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_note_next*(note_id: ptr git_oid; annotated_id: ptr git_oid;
                    it: ptr git_note_iterator): cint {.dynlib: libgitDl, importc.}
proc git_note_read*(out: ptr ptr git_note; repo: ptr git_repository;
                    notes_ref: cstring; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_commit_read*(out: ptr ptr git_note; repo: ptr git_repository;
                           notes_commit: ptr git_commit; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_author*(note: ptr git_note): ptr git_signature {.dynlib: libgitDl,
    importc.}
proc git_note_committer*(note: ptr git_note): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_note_message*(note: ptr git_note): cstring {.dynlib: libgitDl, importc.}
proc git_note_id*(note: ptr git_note): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_note_create*(out: ptr git_oid; repo: ptr git_repository;
                      notes_ref: cstring; author: ptr git_signature;
                      committer: ptr git_signature; oid: ptr git_oid;
                      note: cstring; force: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_note_commit_create*(notes_commit_out: ptr git_oid;
                             notes_blob_out: ptr git_oid;
                             repo: ptr git_repository; parent: ptr git_commit;
                             author: ptr git_signature;
                             committer: ptr git_signature; oid: ptr git_oid;
                             note: cstring; allow_note_overwrite: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_note_remove*(repo: ptr git_repository; notes_ref: cstring;
                      author: ptr git_signature; committer: ptr git_signature;
                      oid: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_note_commit_remove*(notes_commit_out: ptr git_oid;
                             repo: ptr git_repository;
                             notes_commit: ptr git_commit;
                             author: ptr git_signature;
                             committer: ptr git_signature; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_free*(note: ptr git_note): void {.dynlib: libgitDl, importc.}
proc git_note_default_ref*(out: ptr git_buf; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_note_foreach*(repo: ptr git_repository; notes_ref: cstring;
                       note_cb: git_note_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_graph_ahead_behind*(ahead: ptr size_t; behind: ptr size_t;
                             repo: ptr git_repository; local: ptr git_oid;
                             upstream: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_graph_descendant_of*(repo: ptr git_repository; commit: ptr git_oid;
                              ancestor: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_object_lookup*(object: ptr ptr git_object; repo: ptr git_repository;
                        id: ptr git_oid; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_lookup_prefix*(object_out: ptr ptr git_object;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_lookup_bypath*(out: ptr ptr git_object; treeish: ptr git_object;
                               path: cstring; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_id*(obj: ptr git_object): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_object_short_id*(out: ptr git_buf; obj: ptr git_object): cint {.
    dynlib: libgitDl, importc.}
proc git_object_type*(obj: ptr git_object): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_object_owner*(obj: ptr git_object): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_object_free*(object: ptr git_object): void {.dynlib: libgitDl, importc.}
proc git_object_type2string*(type: git_object_t): cstring {.dynlib: libgitDl,
    importc.}
proc git_object_string2type*(str: cstring): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_object_typeisloose*(type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_object_peel*(peeled: ptr ptr git_object; object: ptr git_object;
                      target_type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_object_dup*(dest: ptr ptr git_object; source: ptr git_object): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_lookup*(out: ptr ptr git_reference; repo: ptr git_repository;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_name_to_id*(out: ptr git_oid; repo: ptr git_repository;
                               name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_dwim*(out: ptr ptr git_reference; repo: ptr git_repository;
                         shorthand: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_symbolic_create_matching*(out: ptr ptr git_reference;
    repo: ptr git_repository; name: cstring; target: cstring; force: cint;
    current_value: cstring; log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_symbolic_create*(out: ptr ptr git_reference;
                                    repo: ptr git_repository; name: cstring;
                                    target: cstring; force: cint;
                                    log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_create*(out: ptr ptr git_reference; repo: ptr git_repository;
                           name: cstring; id: ptr git_oid; force: cint;
                           log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_create_matching*(out: ptr ptr git_reference;
                                    repo: ptr git_repository; name: cstring;
                                    id: ptr git_oid; force: cint;
                                    current_id: ptr git_oid;
                                    log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_target*(ref: ptr git_reference): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reference_target_peel*(ref: ptr git_reference): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reference_symbolic_target*(ref: ptr git_reference): cstring {.
    dynlib: libgitDl, importc.}
proc git_reference_type*(ref: ptr git_reference): git_reference_t {.
    dynlib: libgitDl, importc.}
proc git_reference_name*(ref: ptr git_reference): cstring {.dynlib: libgitDl,
    importc.}
proc git_reference_resolve*(out: ptr ptr git_reference; ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_owner*(ref: ptr git_reference): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_reference_symbolic_set_target*(out: ptr ptr git_reference;
                                        ref: ptr git_reference; target: cstring;
                                        log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_set_target*(out: ptr ptr git_reference;
                               ref: ptr git_reference; id: ptr git_oid;
                               log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_rename*(new_ref: ptr ptr git_reference;
                           ref: ptr git_reference; new_name: cstring;
                           force: cint; log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_delete*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_remove*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_list*(array: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach*(repo: ptr git_repository;
                            callback: git_reference_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach_name*(repo: ptr git_repository;
                                 callback: git_reference_foreach_name_cb;
                                 payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_dup*(dest: ptr ptr git_reference; source: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_free*(ref: ptr git_reference): void {.dynlib: libgitDl,
    importc.}
proc git_reference_cmp*(ref1: ptr git_reference; ref2: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_new*(out: ptr ptr git_reference_iterator;
                                 repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_glob_new*(out: ptr ptr git_reference_iterator;
                                      repo: ptr git_repository; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_next*(out: ptr ptr git_reference;
                         iter: ptr git_reference_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_next_name*(out: ptr cstring; iter: ptr git_reference_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_free*(iter: ptr git_reference_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach_glob*(repo: ptr git_repository; glob: cstring;
                                 callback: git_reference_foreach_name_cb;
                                 payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_has_log*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_ensure_log*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_is_branch*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_remote*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_tag*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_note*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_normalize_name*(buffer_out: cstring; buffer_size: size_t;
                                   name: cstring; flags: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_peel*(out: ptr ptr git_object; ref: ptr git_reference;
                         type: git_object_t): cint {.dynlib: libgitDl, importc.}
proc git_reference_is_valid_name*(refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_shorthand*(ref: ptr git_reference): cstring {.
    dynlib: libgitDl, importc.}
proc git_libgit2_init*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_libgit2_shutdown*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_odb_new*(out: ptr ptr git_odb): cint {.dynlib: libgitDl, importc.}
proc git_odb_open*(out: ptr ptr git_odb; objects_dir: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_add_disk_alternate*(odb: ptr git_odb; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_free*(db: ptr git_odb): void {.dynlib: libgitDl, importc.}
proc git_odb_read*(out: ptr ptr git_odb_object; db: ptr git_odb; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_read_prefix*(out: ptr ptr git_odb_object; db: ptr git_odb;
                          short_id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_read_header*(len_out: ptr size_t; type_out: ptr git_object_t;
                          db: ptr git_odb; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_exists*(db: ptr git_odb; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_exists_prefix*(out: ptr git_oid; db: ptr git_odb;
                            short_id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_expand_ids*(db: ptr git_odb; ids: ptr git_odb_expand_id;
                         count: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_refresh*(db: ptr git_odb): cint {.dynlib: libgitDl, importc.}
proc git_odb_foreach*(db: ptr git_odb; cb: git_odb_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_write*(out: ptr git_oid; odb: ptr git_odb; data: pointer;
                    len: size_t; type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_open_wstream*(out: ptr ptr git_odb_stream; db: ptr git_odb;
                           size: git_object_size_t; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_stream_write*(stream: ptr git_odb_stream; buffer: cstring;
                           len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_stream_finalize_write*(out: ptr git_oid; stream: ptr git_odb_stream): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_stream_read*(stream: ptr git_odb_stream; buffer: cstring;
                          len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_stream_free*(stream: ptr git_odb_stream): void {.dynlib: libgitDl,
    importc.}
proc git_odb_open_rstream*(out: ptr ptr git_odb_stream; len: ptr size_t;
                           type: ptr git_object_t; db: ptr git_odb;
                           oid: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_odb_write_pack*(out: ptr ptr git_odb_writepack; db: ptr git_odb;
                         progress_cb: git_indexer_progress_cb;
                         progress_payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_hash*(out: ptr git_oid; data: pointer; len: size_t;
                   type: git_object_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_hashfile*(out: ptr git_oid; path: cstring; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_object_dup*(dest: ptr ptr git_odb_object;
                         source: ptr git_odb_object): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_object_free*(object: ptr git_odb_object): void {.dynlib: libgitDl,
    importc.}
proc git_odb_object_id*(object: ptr git_odb_object): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_odb_object_data*(object: ptr git_odb_object): pointer {.
    dynlib: libgitDl, importc.}
proc git_odb_object_size*(object: ptr git_odb_object): size_t {.
    dynlib: libgitDl, importc.}
proc git_odb_object_type*(object: ptr git_odb_object): git_object_t {.
    dynlib: libgitDl, importc.}
proc git_odb_add_backend*(odb: ptr git_odb; backend: ptr git_odb_backend;
                          priority: cint): cint {.dynlib: libgitDl, importc.}
proc git_odb_add_alternate*(odb: ptr git_odb; backend: ptr git_odb_backend;
                            priority: cint): cint {.dynlib: libgitDl, importc.}
proc git_odb_num_backends*(odb: ptr git_odb): size_t {.dynlib: libgitDl, importc.}
proc git_odb_get_backend*(out: ptr ptr git_odb_backend; odb: ptr git_odb;
                          pos: size_t): cint {.dynlib: libgitDl, importc.}
proc git_oidarray_free*(array: ptr git_oidarray): void {.dynlib: libgitDl,
    importc.}
proc git_strarray_dispose*(array: ptr git_strarray): void {.dynlib: libgitDl,
    importc.}
proc git_strarray_copy*(tgt: ptr git_strarray; src: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_free*(cred: ptr git_credential): void {.dynlib: libgitDl,
    importc.}
proc git_credential_has_username*(cred: ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_get_username*(cred: ptr git_credential): cstring {.
    dynlib: libgitDl, importc.}
proc git_credential_userpass_plaintext_new*(out: ptr ptr git_credential;
    username: cstring; password: cstring): cint {.dynlib: libgitDl, importc.}
proc git_credential_default_new*(out: ptr ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_username_new*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_key_new*(out: ptr ptr git_credential; username: cstring;
                                 publickey: cstring; privatekey: cstring;
                                 passphrase: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_credential_ssh_key_memory_new*(out: ptr ptr git_credential;
                                        username: cstring; publickey: cstring;
                                        privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_interactive_new*(out: ptr ptr git_credential;
    username: cstring; prompt_callback: git_credential_ssh_interactive_cb;
    payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_credential_ssh_key_from_agent*(out: ptr ptr git_credential;
                                        username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_custom_new*(out: ptr ptr git_credential;
                                    username: cstring; publickey: cstring;
                                    publickey_len: size_t;
                                    sign_callback: git_credential_sign_cb;
                                    payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_clone_options_init*(opts: ptr git_clone_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_clone*(out: ptr ptr git_repository; url: cstring; local_path: cstring;
                options: ptr git_clone_options): cint {.dynlib: libgitDl,
    importc.}
proc git_cherrypick_options_init*(opts: ptr git_cherrypick_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_cherrypick_commit*(out: ptr ptr git_index; repo: ptr git_repository;
                            cherrypick_commit: ptr git_commit;
                            our_commit: ptr git_commit; mainline: cuint;
                            merge_options: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_cherrypick*(repo: ptr git_repository; commit: ptr git_commit;
                     cherrypick_options: ptr git_cherrypick_options): cint {.
    dynlib: libgitDl, importc.}
proc git_index_open*(out: ptr ptr git_index; index_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_new*(out: ptr ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_free*(index: ptr git_index): void {.dynlib: libgitDl, importc.}
proc git_index_owner*(index: ptr git_index): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_index_caps*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_set_caps*(index: ptr git_index; caps: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_version*(index: ptr git_index): cuint {.dynlib: libgitDl, importc.}
proc git_index_set_version*(index: ptr git_index; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_read*(index: ptr git_index; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_path*(index: ptr git_index): cstring {.dynlib: libgitDl, importc.}
proc git_index_checksum*(index: ptr git_index): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_index_read_tree*(index: ptr git_index; tree: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write_tree*(out: ptr git_oid; index: ptr git_index): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write_tree_to*(out: ptr git_oid; index: ptr git_index;
                              repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entrycount*(index: ptr git_index): size_t {.dynlib: libgitDl,
    importc.}
proc git_index_clear*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_get_byindex*(index: ptr git_index; n: size_t): ptr git_index_entry {.
    dynlib: libgitDl, importc.}
proc git_index_get_bypath*(index: ptr git_index; path: cstring; stage: cint): ptr git_index_entry {.
    dynlib: libgitDl, importc.}
proc git_index_remove*(index: ptr git_index; path: cstring; stage: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_remove_directory*(index: ptr git_index; dir: cstring; stage: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add*(index: ptr git_index; source_entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entry_stage*(entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entry_is_conflict*(entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_iterator_new*(iterator_out: ptr ptr git_index_iterator;
                             index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_iterator_next*(out: ptr ptr git_index_entry;
                              iterator: ptr git_index_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_index_iterator_free*(iterator: ptr git_index_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_index_add_bypath*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add_from_buffer*(index: ptr git_index;
                                entry: ptr git_index_entry; buffer: pointer;
                                len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_index_remove_bypath*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add_all*(index: ptr git_index; pathspec: ptr git_strarray;
                        flags: cuint; callback: git_index_matched_path_cb;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_index_remove_all*(index: ptr git_index; pathspec: ptr git_strarray;
                           callback: git_index_matched_path_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_index_update_all*(index: ptr git_index; pathspec: ptr git_strarray;
                           callback: git_index_matched_path_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_index_find*(at_pos: ptr size_t; index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_find_prefix*(at_pos: ptr size_t; index: ptr git_index;
                            prefix: cstring): cint {.dynlib: libgitDl, importc.}
proc git_index_conflict_add*(index: ptr git_index;
                             ancestor_entry: ptr git_index_entry;
                             our_entry: ptr git_index_entry;
                             their_entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_get*(ancestor_out: ptr ptr git_index_entry;
                             our_out: ptr ptr git_index_entry;
                             their_out: ptr ptr git_index_entry;
                             index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_remove*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_cleanup*(index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_has_conflicts*(index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_conflict_iterator_new*(iterator_out: ptr ptr git_index_conflict_iterator;
                                      index: ptr git_index): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_next*(ancestor_out: ptr ptr git_index_entry;
                              our_out: ptr ptr git_index_entry;
                              their_out: ptr ptr git_index_entry;
                              iterator: ptr git_index_conflict_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_iterator_free*(iterator: ptr git_index_conflict_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_trace_set*(level: git_trace_level_t; cb: git_trace_cb): cint {.
    dynlib: libgitDl, importc.}
proc git_error_last*(a0: void): ptr git_error {.dynlib: libgitDl, importc.}
proc git_error_clear*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_error_set_str*(error_class: cint; string: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_error_set_oom*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_odb_backend_pack*(out: ptr ptr git_odb_backend; objects_dir: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_backend_loose*(out: ptr ptr git_odb_backend; objects_dir: cstring;
                            compression_level: cint; do_fsync: cint;
                            dir_mode: cuint; file_mode: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_backend_one_pack*(out: ptr ptr git_odb_backend; index_file: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_message_prettify*(out: ptr git_buf; message: cstring;
                           strip_comments: cint; comment_char: char): cint {.
    dynlib: libgitDl, importc.}
proc git_message_trailers*(arr: ptr git_message_trailer_array; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_message_trailer_array_free*(arr: ptr git_message_trailer_array): void {.
    dynlib: libgitDl, importc.}
proc git_credential_userpass*(out: ptr ptr git_credential; url: cstring;
                              user_from_url: cstring; allowed_types: cuint;
                              payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_transaction_new*(out: ptr ptr git_transaction; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_lock_ref*(tx: ptr git_transaction; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_set_target*(tx: ptr git_transaction; refname: cstring;
                                 target: ptr git_oid; sig: ptr git_signature;
                                 msg: cstring): cint {.dynlib: libgitDl, importc.}
proc git_transaction_set_symbolic_target*(tx: ptr git_transaction;
    refname: cstring; target: cstring; sig: ptr git_signature; msg: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_set_reflog*(tx: ptr git_transaction; refname: cstring;
                                 reflog: ptr git_reflog): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_remove*(tx: ptr git_transaction; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_commit*(tx: ptr git_transaction): cint {.dynlib: libgitDl,
    importc.}
proc git_transaction_free*(tx: ptr git_transaction): void {.dynlib: libgitDl,
    importc.}
proc git_packbuilder_new*(out: ptr ptr git_packbuilder; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_set_threads*(pb: ptr git_packbuilder; n: cuint): cuint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert*(pb: ptr git_packbuilder; id: ptr git_oid;
                             name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_packbuilder_insert_tree*(pb: ptr git_packbuilder; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_commit*(pb: ptr git_packbuilder; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_walk*(pb: ptr git_packbuilder; walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_recur*(pb: ptr git_packbuilder; id: ptr git_oid;
                                   name: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_packbuilder_write_buf*(buf: ptr git_buf; pb: ptr git_packbuilder): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_write*(pb: ptr git_packbuilder; path: cstring; mode: cuint;
                            progress_cb: git_indexer_progress_cb;
                            progress_cb_payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_hash*(pb: ptr git_packbuilder): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_foreach*(pb: ptr git_packbuilder;
                              cb: git_packbuilder_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_object_count*(pb: ptr git_packbuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_written*(pb: ptr git_packbuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_set_callbacks*(pb: ptr git_packbuilder;
                                    progress_cb: git_packbuilder_progress;
                                    progress_cb_payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_free*(pb: ptr git_packbuilder): void {.dynlib: libgitDl,
    importc.}
proc git_pathspec_new*(out: ptr ptr git_pathspec; pathspec: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_pathspec_free*(ps: ptr git_pathspec): void {.dynlib: libgitDl, importc.}
proc git_pathspec_matches_path*(ps: ptr git_pathspec; flags: uint32;
                                path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_pathspec_match_workdir*(out: ptr ptr git_pathspec_match_list;
                                 repo: ptr git_repository; flags: uint32;
                                 ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_index*(out: ptr ptr git_pathspec_match_list;
                               index: ptr git_index; flags: uint32;
                               ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_tree*(out: ptr ptr git_pathspec_match_list;
                              tree: ptr git_tree; flags: uint32;
                              ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_diff*(out: ptr ptr git_pathspec_match_list;
                              diff: ptr git_diff; flags: uint32;
                              ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_list_free*(m: ptr git_pathspec_match_list): void {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_entrycount*(m: ptr git_pathspec_match_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_entry*(m: ptr git_pathspec_match_list; pos: size_t): cstring {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_diff_entry*(m: ptr git_pathspec_match_list;
    pos: size_t): ptr git_diff_delta {.dynlib: libgitDl, importc.}
proc git_pathspec_match_list_failed_entrycount*(m: ptr git_pathspec_match_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_failed_entry*(m: ptr git_pathspec_match_list;
    pos: size_t): cstring {.dynlib: libgitDl, importc.}
proc git_worktree_list*(out: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_lookup*(out: ptr ptr git_worktree; repo: ptr git_repository;
                          name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_worktree_open_from_repository*(out: ptr ptr git_worktree;
                                        repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_free*(wt: ptr git_worktree): void {.dynlib: libgitDl, importc.}
proc git_worktree_validate*(wt: ptr git_worktree): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_add_options_init*(opts: ptr git_worktree_add_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_add*(out: ptr ptr git_worktree; repo: ptr git_repository;
                       name: cstring; path: cstring;
                       opts: ptr git_worktree_add_options): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_lock*(wt: ptr git_worktree; reason: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_unlock*(wt: ptr git_worktree): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_is_locked*(reason: ptr git_buf; wt: ptr git_worktree): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_name*(wt: ptr git_worktree): cstring {.dynlib: libgitDl,
    importc.}
proc git_worktree_path*(wt: ptr git_worktree): cstring {.dynlib: libgitDl,
    importc.}
proc git_worktree_prune_options_init*(opts: ptr git_worktree_prune_options;
                                      version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_is_prunable*(wt: ptr git_worktree;
                               opts: ptr git_worktree_prune_options): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_prune*(wt: ptr git_worktree;
                         opts: ptr git_worktree_prune_options): cint {.
    dynlib: libgitDl, importc.}
proc git_proxy_options_init*(opts: ptr git_proxy_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_reset*(repo: ptr git_repository; target: ptr git_object;
                reset_type: git_reset_t; checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_reset_from_annotated*(repo: ptr git_repository;
                               commit: ptr git_annotated_commit;
                               reset_type: git_reset_t;
                               checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_reset_default*(repo: ptr git_repository; target: ptr git_object;
                        pathspecs: ptr git_strarray): cint {.dynlib: libgitDl,
    importc.}
proc git_apply_options_init*(opts: ptr git_apply_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_apply_to_tree*(out: ptr ptr git_index; repo: ptr git_repository;
                        preimage: ptr git_tree; diff: ptr git_diff;
                        options: ptr git_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_apply*(repo: ptr git_repository; diff: ptr git_diff;
                location: git_apply_location_t; options: ptr git_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_revparse_single*(out: ptr ptr git_object; repo: ptr git_repository;
                          spec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_revparse_ext*(object_out: ptr ptr git_object;
                       reference_out: ptr ptr git_reference;
                       repo: ptr git_repository; spec: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revparse*(revspec: ptr git_revspec; repo: ptr git_repository;
                   spec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_refspec_parse*(refspec: ptr ptr git_refspec; input: cstring;
                        is_fetch: cint): cint {.dynlib: libgitDl, importc.}
proc git_refspec_free*(refspec: ptr git_refspec): void {.dynlib: libgitDl,
    importc.}
proc git_refspec_src*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_dst*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_string*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_force*(refspec: ptr git_refspec): cint {.dynlib: libgitDl,
    importc.}
proc git_refspec_direction*(spec: ptr git_refspec): git_direction {.
    dynlib: libgitDl, importc.}
proc git_refspec_src_matches*(refspec: ptr git_refspec; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_refspec_dst_matches*(refspec: ptr git_refspec; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_refspec_transform*(out: ptr git_buf; spec: ptr git_refspec;
                            name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_refspec_rtransform*(out: ptr git_buf; spec: ptr git_refspec;
                             name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_fromworkdir*(id: ptr git_oid; repo: ptr git_repository;
                                  relative_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_fromdisk*(id: ptr git_oid; repo: ptr git_repository;
                               path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_fromstream*(out: ptr ptr git_writestream;
                                 repo: ptr git_repository; hintpath: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_fromstream_commit*(out: ptr git_oid;
                                        stream: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_frombuffer*(id: ptr git_oid; repo: ptr git_repository;
                                 buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_filtered_content*(out: ptr git_buf; blob: ptr git_blob;
                                as_path: cstring; check_for_binary_data: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_free*(buffer: ptr git_buf): void {.dynlib: libgitDl, importc.}
proc giterr_last*(a0: void): ptr git_error {.dynlib: libgitDl, importc.}
proc giterr_clear*(a0: void): void {.dynlib: libgitDl, importc.}
proc giterr_set_str*(error_class: cint; string: cstring): void {.
    dynlib: libgitDl, importc.}
proc giterr_set_oom*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_index_add_frombuffer*(index: ptr git_index; entry: ptr git_index_entry;
                               buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_size*(type: git_object_t): size_t {.dynlib: libgitDl,
    importc: "git_object__size".}
proc git_tag_create_frombuffer*(oid: ptr git_oid; repo: ptr git_repository;
                                buffer: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_free*(cred: ptr git_credential): void {.dynlib: libgitDl, importc.}
proc git_cred_has_username*(cred: ptr git_credential): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_get_username*(cred: ptr git_credential): cstring {.
    dynlib: libgitDl, importc.}
proc git_cred_userpass_plaintext_new*(out: ptr ptr git_credential;
                                      username: cstring; password: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_default_new*(out: ptr ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_username_new*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_key_new*(out: ptr ptr git_credential; username: cstring;
                           publickey: cstring; privatekey: cstring;
                           passphrase: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_ssh_key_memory_new*(out: ptr ptr git_credential;
                                  username: cstring; publickey: cstring;
                                  privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_interactive_new*(out: ptr ptr git_credential;
                                   username: cstring; prompt_callback: git_credential_ssh_interactive_cb;
                                   payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_ssh_key_from_agent*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_custom_new*(out: ptr ptr git_credential; username: cstring;
                              publickey: cstring; publickey_len: size_t;
                              sign_callback: git_credential_sign_cb;
                              payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_userpass*(out: ptr ptr git_credential; url: cstring;
                        user_from_url: cstring; allowed_types: cuint;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_oid_iszero*(id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_strarray_copy*(tgt: ptr git_strarray; src: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_strarray_free*(array: ptr git_strarray): void {.dynlib: libgitDl,
    importc.}
proc git_blame_init_options*(opts: ptr git_blame_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_init_options*(opts: ptr git_checkout_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_cherrypick_init_options*(opts: ptr git_cherrypick_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_clone_init_options*(opts: ptr git_clone_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_init_options*(opts: ptr git_describe_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_init_format_options*(opts: ptr git_describe_format_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_init_options*(opts: ptr git_diff_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_init_options*(opts: ptr git_diff_find_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_format_email_init_options*(
    opts: ptr git_diff_format_email_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_patchid_init_options*(opts: ptr git_diff_patchid_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_fetch_init_options*(opts: ptr git_fetch_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_init_options*(opts: ptr git_indexer_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_init_options*(opts: ptr git_merge_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_init_input*(input: ptr git_merge_file_input; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_init_options*(opts: ptr git_merge_file_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_proxy_init_options*(opts: ptr git_proxy_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_push_init_options*(opts: ptr git_push_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_init_options*(opts: ptr git_rebase_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_init_options*(opts: ptr git_remote_create_options;
                                     version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_init_init_options*(opts: ptr git_repository_init_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_revert_init_options*(opts: ptr git_revert_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_apply_init_options*(opts: ptr git_stash_apply_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_status_init_options*(opts: ptr git_status_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update_init_options*(opts: ptr git_submodule_update_options;
                                        version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_add_init_options*(opts: ptr git_worktree_add_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_prune_init_options*(opts: ptr git_worktree_prune_options;
                                      version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_update_options_init*(opts: ptr git_submodule_update_options;
                                        version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update*(submodule: ptr git_submodule; init: cint;
                           options: ptr git_submodule_update_options): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_lookup*(out: ptr ptr git_submodule; repo: ptr git_repository;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_free*(submodule: ptr git_submodule): void {.dynlib: libgitDl,
    importc.}
proc git_submodule_foreach*(repo: ptr git_repository;
                            callback: git_submodule_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_setup*(out: ptr ptr git_submodule;
                              repo: ptr git_repository; url: cstring;
                              path: cstring; use_gitlink: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_clone*(out: ptr ptr git_repository;
                          submodule: ptr git_submodule;
                          opts: ptr git_submodule_update_options): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_finalize*(submodule: ptr git_submodule): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_to_index*(submodule: ptr git_submodule; write_index: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_owner*(submodule: ptr git_submodule): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_submodule_name*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_path*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_url*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_resolve_url*(out: ptr git_buf; repo: ptr git_repository;
                                url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_branch*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_branch*(repo: ptr git_repository; name: cstring;
                               branch: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_set_url*(repo: ptr git_repository; name: cstring;
                            url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_index_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_head_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_wd_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_ignore*(submodule: ptr git_submodule): git_submodule_ignore_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_ignore*(repo: ptr git_repository; name: cstring;
                               ignore: git_submodule_ignore_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update_strategy*(submodule: ptr git_submodule): git_submodule_update_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_update*(repo: ptr git_repository; name: cstring;
                               update: git_submodule_update_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_fetch_recurse_submodules*(submodule: ptr git_submodule): git_submodule_recurse_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_fetch_recurse_submodules*(repo: ptr git_repository;
    name: cstring; fetch_recurse_submodules: git_submodule_recurse_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_init*(submodule: ptr git_submodule; overwrite: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_repo_init*(out: ptr ptr git_repository;
                              sm: ptr git_submodule; use_gitlink: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_sync*(submodule: ptr git_submodule): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_open*(repo: ptr ptr git_repository;
                         submodule: ptr git_submodule): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_reload*(submodule: ptr git_submodule; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_status*(status: ptr cuint; repo: ptr git_repository;
                           name: cstring; ignore: git_submodule_ignore_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_location*(location_status: ptr cuint;
                             submodule: ptr git_submodule): cint {.
    dynlib: libgitDl, importc.}
proc git_status_options_init*(opts: ptr git_status_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_status_foreach*(repo: ptr git_repository; callback: git_status_cb;
                         payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_status_foreach_ext*(repo: ptr git_repository;
                             opts: ptr git_status_options;
                             callback: git_status_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_status_file*(status_flags: ptr cuint; repo: ptr git_repository;
                      path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_status_list_new*(out: ptr ptr git_status_list;
                          repo: ptr git_repository; opts: ptr git_status_options): cint {.
    dynlib: libgitDl, importc.}
proc git_status_list_entrycount*(statuslist: ptr git_status_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_status_byindex*(statuslist: ptr git_status_list; idx: size_t): ptr git_status_entry {.
    dynlib: libgitDl, importc.}
proc git_status_list_free*(statuslist: ptr git_status_list): void {.
    dynlib: libgitDl, importc.}
proc git_status_should_ignore*(ignored: ptr cint; repo: ptr git_repository;
                               path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_revert_options_init*(opts: ptr git_revert_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_revert_commit*(out: ptr ptr git_index; repo: ptr git_repository;
                        revert_commit: ptr git_commit;
                        our_commit: ptr git_commit; mainline: cuint;
                        merge_options: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_revert*(repo: ptr git_repository; commit: ptr git_commit;
                 given_opts: ptr git_revert_options): cint {.dynlib: libgitDl,
    importc.}
proc git_buf_dispose*(buffer: ptr git_buf): void {.dynlib: libgitDl, importc.}
proc git_buf_grow*(buffer: ptr git_buf; target_size: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_set*(buffer: ptr git_buf; data: pointer; datalen: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_is_binary*(buf: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_buf_contains_nul*(buf: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_tag_lookup*(out: ptr ptr git_tag; repo: ptr git_repository;
                     id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_tag_lookup_prefix*(out: ptr ptr git_tag; repo: ptr git_repository;
                            id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_free*(tag: ptr git_tag): void {.dynlib: libgitDl, importc.}
proc git_tag_id*(tag: ptr git_tag): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_tag_owner*(tag: ptr git_tag): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_tag_target*(target_out: ptr ptr git_object; tag: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_target_id*(tag: ptr git_tag): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_tag_target_type*(tag: ptr git_tag): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_tag_name*(tag: ptr git_tag): cstring {.dynlib: libgitDl, importc.}
proc git_tag_tagger*(tag: ptr git_tag): ptr git_signature {.dynlib: libgitDl,
    importc.}
proc git_tag_message*(tag: ptr git_tag): cstring {.dynlib: libgitDl, importc.}
proc git_tag_create*(oid: ptr git_oid; repo: ptr git_repository;
                     tag_name: cstring; target: ptr git_object;
                     tagger: ptr git_signature; message: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_annotation_create*(oid: ptr git_oid; repo: ptr git_repository;
                                tag_name: cstring; target: ptr git_object;
                                tagger: ptr git_signature; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_create_from_buffer*(oid: ptr git_oid; repo: ptr git_repository;
                                 buffer: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_create_lightweight*(oid: ptr git_oid; repo: ptr git_repository;
                                 tag_name: cstring; target: ptr git_object;
                                 force: cint): cint {.dynlib: libgitDl, importc.}
proc git_tag_delete*(repo: ptr git_repository; tag_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_list*(tag_names: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_list_match*(tag_names: ptr git_strarray; pattern: cstring;
                         repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_tag_foreach*(repo: ptr git_repository; callback: git_tag_foreach_cb;
                      payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_tag_peel*(tag_target_out: ptr ptr git_object; tag: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_tag_dup*(out: ptr ptr git_tag; source: ptr git_tag): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_options_init*(opts: ptr git_diff_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_options_init*(opts: ptr git_diff_find_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_free*(diff: ptr git_diff): void {.dynlib: libgitDl, importc.}
proc git_diff_tree_to_tree*(diff: ptr ptr git_diff; repo: ptr git_repository;
                            old_tree: ptr git_tree; new_tree: ptr git_tree;
                            opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_index*(diff: ptr ptr git_diff; repo: ptr git_repository;
                             old_tree: ptr git_tree; index: ptr git_index;
                             opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_index_to_workdir*(diff: ptr ptr git_diff;
                                repo: ptr git_repository; index: ptr git_index;
                                opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_workdir*(diff: ptr ptr git_diff; repo: ptr git_repository;
                               old_tree: ptr git_tree;
                               opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_tree_to_workdir_with_index*(diff: ptr ptr git_diff;
    repo: ptr git_repository; old_tree: ptr git_tree; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_index_to_index*(diff: ptr ptr git_diff; repo: ptr git_repository;
                              old_index: ptr git_index;
                              new_index: ptr git_index;
                              opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_merge*(onto: ptr git_diff; from: ptr git_diff): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_similar*(diff: ptr git_diff;
                            options: ptr git_diff_find_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_num_deltas*(diff: ptr git_diff): size_t {.dynlib: libgitDl,
    importc.}
proc git_diff_num_deltas_of_type*(diff: ptr git_diff; type: git_delta_t): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_get_delta*(diff: ptr git_diff; idx: size_t): ptr git_diff_delta {.
    dynlib: libgitDl, importc.}
proc git_diff_is_sorted_icase*(diff: ptr git_diff): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_foreach*(diff: ptr git_diff; file_cb: git_diff_file_cb;
                       binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                       line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_status_char*(status: git_delta_t): char {.dynlib: libgitDl,
    importc.}
proc git_diff_print*(diff: ptr git_diff; format: git_diff_format_t;
                     print_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_to_buf*(out: ptr git_buf; diff: ptr git_diff;
                      format: git_diff_format_t): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_blobs*(old_blob: ptr git_blob; old_as_path: cstring;
                     new_blob: ptr git_blob; new_as_path: cstring;
                     options: ptr git_diff_options; file_cb: git_diff_file_cb;
                     binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                     line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_blob_to_buffer*(old_blob: ptr git_blob; old_as_path: cstring;
                              buffer: cstring; buffer_len: size_t;
                              buffer_as_path: cstring;
                              options: ptr git_diff_options;
                              file_cb: git_diff_file_cb;
                              binary_cb: git_diff_binary_cb;
                              hunk_cb: git_diff_hunk_cb;
                              line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_buffers*(old_buffer: pointer; old_len: size_t;
                       old_as_path: cstring; new_buffer: pointer;
                       new_len: size_t; new_as_path: cstring;
                       options: ptr git_diff_options; file_cb: git_diff_file_cb;
                       binary_cb: git_diff_binary_cb; hunk_cb: git_diff_hunk_cb;
                       line_cb: git_diff_line_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_from_buffer*(out: ptr ptr git_diff; content: cstring;
                           content_len: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_get_stats*(out: ptr ptr git_diff_stats; diff: ptr git_diff): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_files_changed*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_insertions*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_deletions*(stats: ptr git_diff_stats): size_t {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_to_buf*(out: ptr git_buf; stats: ptr git_diff_stats;
                            format: git_diff_stats_format_t; width: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_stats_free*(stats: ptr git_diff_stats): void {.dynlib: libgitDl,
    importc.}
proc git_diff_format_email*(out: ptr git_buf; diff: ptr git_diff;
                            opts: ptr git_diff_format_email_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_commit_as_email*(out: ptr git_buf; repo: ptr git_repository;
                               commit: ptr git_commit; patch_no: size_t;
                               total_patches: size_t; flags: uint32;
                               diff_opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_format_email_options_init*(
    opts: ptr git_diff_format_email_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_patchid_options_init*(opts: ptr git_diff_patchid_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_patchid*(out: ptr git_oid; diff: ptr git_diff;
                       opts: ptr git_diff_patchid_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_options_init*(opts: ptr git_describe_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_format_options_init*(opts: ptr git_describe_format_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_describe_commit*(result: ptr ptr git_describe_result;
                          committish: ptr git_object;
                          opts: ptr git_describe_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_workdir*(out: ptr ptr git_describe_result;
                           repo: ptr git_repository;
                           opts: ptr git_describe_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_format*(out: ptr git_buf; result: ptr git_describe_result;
                          opts: ptr git_describe_format_options): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_result_free*(result: ptr git_describe_result): void {.
    dynlib: libgitDl, importc.}
proc git_repository_open*(out: ptr ptr git_repository; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_from_worktree*(out: ptr ptr git_repository;
                                        wt: ptr git_worktree): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_wrap_odb*(out: ptr ptr git_repository; odb: ptr git_odb): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_discover*(out: ptr git_buf; start_path: cstring;
                              across_fs: cint; ceiling_dirs: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_ext*(out: ptr ptr git_repository; path: cstring;
                              flags: cuint; ceiling_dirs: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_open_bare*(out: ptr ptr git_repository; bare_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_free*(repo: ptr git_repository): void {.dynlib: libgitDl,
    importc.}
proc git_repository_init*(out: ptr ptr git_repository; path: cstring;
                          is_bare: cuint): cint {.dynlib: libgitDl, importc.}
proc git_repository_init_options_init*(opts: ptr git_repository_init_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_init_ext*(out: ptr ptr git_repository; repo_path: cstring;
                              opts: ptr git_repository_init_options): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head*(out: ptr ptr git_reference; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_for_worktree*(out: ptr ptr git_reference;
                                       repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_detached*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_head_detached_for_worktree*(repo: ptr git_repository;
    name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_repository_head_unborn*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_is_empty*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_item_path*(out: ptr git_buf; repo: ptr git_repository;
                               item: git_repository_item_t): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_path*(repo: ptr git_repository): cstring {.dynlib: libgitDl,
    importc.}
proc git_repository_workdir*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_commondir*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_set_workdir*(repo: ptr git_repository; workdir: cstring;
                                 update_gitlink: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_is_bare*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_is_worktree*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_config*(out: ptr ptr git_config; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_config_snapshot*(out: ptr ptr git_config;
                                     repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_odb*(out: ptr ptr git_odb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_refdb*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_index*(out: ptr ptr git_index; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_message*(out: ptr git_buf; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_message_remove*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_state_cleanup*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_fetchhead_foreach*(repo: ptr git_repository; callback: git_repository_fetchhead_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_mergehead_foreach*(repo: ptr git_repository; callback: git_repository_mergehead_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_hashfile*(out: ptr git_oid; repo: ptr git_repository;
                              path: cstring; type: git_object_t;
                              as_path: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_head*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_set_head_detached*(repo: ptr git_repository;
                                       commitish: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_set_head_detached_from_annotated*(repo: ptr git_repository;
    commitish: ptr git_annotated_commit): cint {.dynlib: libgitDl, importc.}
proc git_repository_detach_head*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_state*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_namespace*(repo: ptr git_repository; nmspace: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_get_namespace*(repo: ptr git_repository): cstring {.
    dynlib: libgitDl, importc.}
proc git_repository_is_shallow*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_repository_ident*(name: ptr cstring; email: ptr cstring;
                           repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_set_ident*(repo: ptr git_repository; name: cstring;
                               email: cstring): cint {.dynlib: libgitDl, importc.}
proc git_checkout_options_init*(opts: ptr git_checkout_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_head*(repo: ptr git_repository; opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_index*(repo: ptr git_repository; index: ptr git_index;
                         opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_tree*(repo: ptr git_repository; treeish: ptr git_object;
                        opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_save*(out: ptr git_oid; repo: ptr git_repository;
                     stasher: ptr git_signature; message: cstring; flags: uint32): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_apply_options_init*(opts: ptr git_stash_apply_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_stash_apply*(repo: ptr git_repository; index: size_t;
                      options: ptr git_stash_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_foreach*(repo: ptr git_repository; callback: git_stash_cb;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_stash_drop*(repo: ptr git_repository; index: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_pop*(repo: ptr git_repository; index: size_t;
                    options: ptr git_stash_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_new*(out: ptr ptr git_mailmap): cint {.dynlib: libgitDl,
    importc.}
proc git_mailmap_free*(mm: ptr git_mailmap): void {.dynlib: libgitDl, importc.}
proc git_mailmap_add_entry*(mm: ptr git_mailmap; real_name: cstring;
                            real_email: cstring; replace_name: cstring;
                            replace_email: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_mailmap_from_buffer*(out: ptr ptr git_mailmap; buf: cstring;
                              len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_mailmap_from_repository*(out: ptr ptr git_mailmap;
                                  repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_resolve*(real_name: ptr cstring; real_email: ptr cstring;
                          mm: ptr git_mailmap; name: cstring; email: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_mailmap_resolve_signature*(out: ptr ptr git_signature;
                                    mm: ptr git_mailmap; sig: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_lookup*(out: ptr ptr git_tree; repo: ptr git_repository;
                      id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_tree_lookup_prefix*(out: ptr ptr git_tree; repo: ptr git_repository;
                             id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_free*(tree: ptr git_tree): void {.dynlib: libgitDl, importc.}
proc git_tree_id*(tree: ptr git_tree): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_tree_owner*(tree: ptr git_tree): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_tree_entrycount*(tree: ptr git_tree): size_t {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_byname*(tree: ptr git_tree; filename: cstring): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_byindex*(tree: ptr git_tree; idx: size_t): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_byid*(tree: ptr git_tree; id: ptr git_oid): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_bypath*(out: ptr ptr git_tree_entry; root: ptr git_tree;
                            path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_tree_entry_dup*(dest: ptr ptr git_tree_entry;
                         source: ptr git_tree_entry): cint {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_free*(entry: ptr git_tree_entry): void {.dynlib: libgitDl,
    importc.}
proc git_tree_entry_name*(entry: ptr git_tree_entry): cstring {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_id*(entry: ptr git_tree_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_type*(entry: ptr git_tree_entry): git_object_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_filemode*(entry: ptr git_tree_entry): git_filemode_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_filemode_raw*(entry: ptr git_tree_entry): git_filemode_t {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_cmp*(e1: ptr git_tree_entry; e2: ptr git_tree_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_entry_to_object*(object_out: ptr ptr git_object;
                               repo: ptr git_repository;
                               entry: ptr git_tree_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_new*(out: ptr ptr git_treebuilder;
                          repo: ptr git_repository; source: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_clear*(bld: ptr git_treebuilder): cint {.dynlib: libgitDl,
    importc.}
proc git_treebuilder_entrycount*(bld: ptr git_treebuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_free*(bld: ptr git_treebuilder): void {.dynlib: libgitDl,
    importc.}
proc git_treebuilder_get*(bld: ptr git_treebuilder; filename: cstring): ptr git_tree_entry {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_insert*(out: ptr ptr git_tree_entry;
                             bld: ptr git_treebuilder; filename: cstring;
                             id: ptr git_oid; filemode: git_filemode_t): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_remove*(bld: ptr git_treebuilder; filename: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_filter*(bld: ptr git_treebuilder;
                             filter: git_treebuilder_filter_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_write*(id: ptr git_oid; bld: ptr git_treebuilder): cint {.
    dynlib: libgitDl, importc.}
proc git_treebuilder_write_with_buffer*(oid: ptr git_oid;
                                        bld: ptr git_treebuilder;
                                        tree: ptr git_buf): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_walk*(tree: ptr git_tree; mode: git_treewalk_mode;
                    callback: git_treewalk_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_dup*(out: ptr ptr git_tree; source: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_tree_create_updated*(out: ptr git_oid; repo: ptr git_repository;
                              baseline: ptr git_tree; nupdates: size_t;
                              updates: ptr git_tree_update): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_read*(out: ptr ptr git_reflog; repo: ptr git_repository;
                      name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reflog_write*(reflog: ptr git_reflog): cint {.dynlib: libgitDl, importc.}
proc git_reflog_append*(reflog: ptr git_reflog; id: ptr git_oid;
                        committer: ptr git_signature; msg: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_rename*(repo: ptr git_repository; old_name: cstring;
                        name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reflog_delete*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reflog_entrycount*(reflog: ptr git_reflog): size_t {.dynlib: libgitDl,
    importc.}
proc git_reflog_entry_byindex*(reflog: ptr git_reflog; idx: size_t): ptr git_reflog_entry {.
    dynlib: libgitDl, importc.}
proc git_reflog_drop*(reflog: ptr git_reflog; idx: size_t;
                      rewrite_previous_entry: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_reflog_entry_id_old*(entry: ptr git_reflog_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_id_new*(entry: ptr git_reflog_entry): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_committer*(entry: ptr git_reflog_entry): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_reflog_entry_message*(entry: ptr git_reflog_entry): cstring {.
    dynlib: libgitDl, importc.}
proc git_reflog_free*(reflog: ptr git_reflog): void {.dynlib: libgitDl, importc.}
proc git_branch_create*(out: ptr ptr git_reference; repo: ptr git_repository;
                        branch_name: cstring; target: ptr git_commit;
                        force: cint): cint {.dynlib: libgitDl, importc.}
proc git_branch_create_from_annotated*(ref_out: ptr ptr git_reference;
                                       repository: ptr git_repository;
                                       branch_name: cstring;
                                       commit: ptr git_annotated_commit;
                                       force: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_delete*(branch: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_iterator_new*(out: ptr ptr git_branch_iterator;
                              repo: ptr git_repository; list_flags: git_branch_t): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_next*(out: ptr ptr git_reference; out_type: ptr git_branch_t;
                      iter: ptr git_branch_iterator): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_iterator_free*(iter: ptr git_branch_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_branch_move*(out: ptr ptr git_reference; branch: ptr git_reference;
                      new_branch_name: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_lookup*(out: ptr ptr git_reference; repo: ptr git_repository;
                        branch_name: cstring; branch_type: git_branch_t): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_name*(out: ptr cstring; ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_upstream*(out: ptr ptr git_reference; branch: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_set_upstream*(branch: ptr git_reference; branch_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_upstream_name*(out: ptr git_buf; repo: ptr git_repository;
                               refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_is_head*(branch: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_branch_is_checked_out*(branch: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_branch_remote_name*(out: ptr git_buf; repo: ptr git_repository;
                             refname: cstring): cint {.dynlib: libgitDl, importc.}
proc git_branch_upstream_remote*(buf: ptr git_buf; repo: ptr git_repository;
                                 refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_blob_lookup*(blob: ptr ptr git_blob; repo: ptr git_repository;
                      id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_blob_lookup_prefix*(blob: ptr ptr git_blob; repo: ptr git_repository;
                             id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_free*(blob: ptr git_blob): void {.dynlib: libgitDl, importc.}
proc git_blob_id*(blob: ptr git_blob): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_blob_owner*(blob: ptr git_blob): ptr git_repository {.dynlib: libgitDl,
    importc.}
proc git_blob_rawcontent*(blob: ptr git_blob): pointer {.dynlib: libgitDl,
    importc.}
proc git_blob_rawsize*(blob: ptr git_blob): git_object_size_t {.
    dynlib: libgitDl, importc.}
proc git_blob_filter_options_init*(opts: ptr git_blob_filter_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_blob_filter*(out: ptr git_buf; blob: ptr git_blob; as_path: cstring;
                      opts: ptr git_blob_filter_options): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_workdir*(id: ptr git_oid; repo: ptr git_repository;
                                   relative_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_disk*(id: ptr git_oid; repo: ptr git_repository;
                                path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_from_stream*(out: ptr ptr git_writestream;
                                  repo: ptr git_repository; hintpath: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_from_stream_commit*(out: ptr git_oid;
    stream: ptr git_writestream): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_from_buffer*(id: ptr git_oid; repo: ptr git_repository;
                                  buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_is_binary*(blob: ptr git_blob): cint {.dynlib: libgitDl, importc.}
proc git_blob_dup*(out: ptr ptr git_blob; source: ptr git_blob): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_new*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_open*(out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_compress*(refdb: ptr git_refdb): cint {.dynlib: libgitDl, importc.}
proc git_refdb_free*(refdb: ptr git_refdb): void {.dynlib: libgitDl, importc.}
proc git_commit_lookup*(commit: ptr ptr git_commit; repo: ptr git_repository;
                        id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_commit_lookup_prefix*(commit: ptr ptr git_commit;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_commit_free*(commit: ptr git_commit): void {.dynlib: libgitDl, importc.}
proc git_commit_id*(commit: ptr git_commit): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_commit_owner*(commit: ptr git_commit): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_commit_message_encoding*(commit: ptr git_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_commit_message*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_message_raw*(commit: ptr git_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_commit_summary*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_body*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_time*(commit: ptr git_commit): git_time_t {.dynlib: libgitDl,
    importc.}
proc git_commit_time_offset*(commit: ptr git_commit): cint {.dynlib: libgitDl,
    importc.}
proc git_commit_committer*(commit: ptr git_commit): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_commit_author*(commit: ptr git_commit): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_commit_committer_with_mailmap*(out: ptr ptr git_signature;
                                        commit: ptr git_commit;
                                        mailmap: ptr git_mailmap): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_author_with_mailmap*(out: ptr ptr git_signature;
                                     commit: ptr git_commit;
                                     mailmap: ptr git_mailmap): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_raw_header*(commit: ptr git_commit): cstring {.dynlib: libgitDl,
    importc.}
proc git_commit_tree*(tree_out: ptr ptr git_tree; commit: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_tree_id*(commit: ptr git_commit): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_commit_parentcount*(commit: ptr git_commit): cuint {.dynlib: libgitDl,
    importc.}
proc git_commit_parent*(out: ptr ptr git_commit; commit: ptr git_commit;
                        n: cuint): cint {.dynlib: libgitDl, importc.}
proc git_commit_parent_id*(commit: ptr git_commit; n: cuint): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_commit_nth_gen_ancestor*(ancestor: ptr ptr git_commit;
                                  commit: ptr git_commit; n: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_header_field*(out: ptr git_buf; commit: ptr git_commit;
                              field: cstring): cint {.dynlib: libgitDl, importc.}
proc git_commit_extract_signature*(signature: ptr git_buf;
                                   signed_data: ptr git_buf;
                                   repo: ptr git_repository;
                                   commit_id: ptr git_oid; field: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create*(id: ptr git_oid; repo: ptr git_repository;
                        update_ref: cstring; author: ptr git_signature;
                        committer: ptr git_signature; message_encoding: cstring;
                        message: cstring; tree: ptr git_tree;
                        parent_count: size_t;
                        parents: ptr UncheckedArray[ptr git_commit]): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_v*(id: ptr git_oid; repo: ptr git_repository;
                          update_ref: cstring; author: ptr git_signature;
                          committer: ptr git_signature;
                          message_encoding: cstring; message: cstring;
                          tree: ptr git_tree; parent_count: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_amend*(id: ptr git_oid; commit_to_amend: ptr git_commit;
                       update_ref: cstring; author: ptr git_signature;
                       committer: ptr git_signature; message_encoding: cstring;
                       message: cstring; tree: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_buffer*(out: ptr git_buf; repo: ptr git_repository;
                               author: ptr git_signature;
                               committer: ptr git_signature;
                               message_encoding: cstring; message: cstring;
                               tree: ptr git_tree; parent_count: size_t;
                               parents: ptr UncheckedArray[ptr git_commit]): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_create_with_signature*(out: ptr git_oid;
                                       repo: ptr git_repository;
                                       commit_content: cstring;
                                       signature: cstring;
                                       signature_field: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_commit_dup*(out: ptr ptr git_commit; source: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_value*(attr: cstring): git_attr_value_t {.dynlib: libgitDl,
    importc.}
proc git_attr_get*(value_out: ptr cstring; repo: ptr git_repository;
                   flags: uint32; path: cstring; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_get_many*(values_out: ptr cstring; repo: ptr git_repository;
                        flags: uint32; path: cstring; num_attr: size_t;
                        names: ptr cstring): cint {.dynlib: libgitDl, importc.}
proc git_attr_foreach*(repo: ptr git_repository; flags: uint32; path: cstring;
                       callback: git_attr_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_attr_cache_flush*(repo: ptr git_repository): cint {.dynlib: libgitDl,
    importc.}
proc git_attr_add_macro*(repo: ptr git_repository; name: cstring;
                         values: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blame_options_init*(opts: ptr git_blame_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_get_hunk_count*(blame: ptr git_blame): uint32 {.dynlib: libgitDl,
    importc.}
proc git_blame_get_hunk_byindex*(blame: ptr git_blame; index: uint32): ptr git_blame_hunk {.
    dynlib: libgitDl, importc.}
proc git_blame_get_hunk_byline*(blame: ptr git_blame; lineno: size_t): ptr git_blame_hunk {.
    dynlib: libgitDl, importc.}
proc git_blame_file*(out: ptr ptr git_blame; repo: ptr git_repository;
                     path: cstring; options: ptr git_blame_options): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_buffer*(out: ptr ptr git_blame; reference: ptr git_blame;
                       buffer: cstring; buffer_len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blame_free*(blame: ptr git_blame): void {.dynlib: libgitDl, importc.}
proc git_ignore_add_rule*(repo: ptr git_repository; rules: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_ignore_clear_internal_rules*(repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_ignore_path_is_ignored*(ignored: ptr cint; repo: ptr git_repository;
                                 path: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_new*(out: ptr ptr git_revwalk; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_reset*(walker: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_push*(walk: ptr git_revwalk; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_glob*(walk: ptr git_revwalk; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_head*(walk: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_hide*(walk: ptr git_revwalk; commit_id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_glob*(walk: ptr git_revwalk; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_head*(walk: ptr git_revwalk): cint {.dynlib: libgitDl,
    importc.}
proc git_revwalk_push_ref*(walk: ptr git_revwalk; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_hide_ref*(walk: ptr git_revwalk; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_next*(out: ptr git_oid; walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_sorting*(walk: ptr git_revwalk; sort_mode: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_push_range*(walk: ptr git_revwalk; range: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_simplify_first_parent*(walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_revwalk_free*(walk: ptr git_revwalk): void {.dynlib: libgitDl, importc.}
proc git_revwalk_repository*(walk: ptr git_revwalk): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_revwalk_add_hide_cb*(walk: ptr git_revwalk;
                              hide_cb: git_revwalk_hide_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create*(out: ptr ptr git_remote; repo: ptr git_repository;
                        name: cstring; url: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_create_options_init*(opts: ptr git_remote_create_options;
                                     version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_create_with_opts*(out: ptr ptr git_remote; url: cstring;
                                  opts: ptr git_remote_create_options): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_with_fetchspec*(out: ptr ptr git_remote;
                                       repo: ptr git_repository; name: cstring;
                                       url: cstring; fetch: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_anonymous*(out: ptr ptr git_remote;
                                  repo: ptr git_repository; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_detached*(out: ptr ptr git_remote; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_lookup*(out: ptr ptr git_remote; repo: ptr git_repository;
                        name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_dup*(dest: ptr ptr git_remote; source: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_owner*(remote: ptr git_remote): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_remote_name*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_url*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_pushurl*(remote: ptr git_remote): cstring {.dynlib: libgitDl,
    importc.}
proc git_remote_set_url*(repo: ptr git_repository; remote: cstring; url: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_set_pushurl*(repo: ptr git_repository; remote: cstring;
                             url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_add_fetch*(repo: ptr git_repository; remote: cstring;
                           refspec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_get_fetch_refspecs*(array: ptr git_strarray;
                                    remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_add_push*(repo: ptr git_repository; remote: cstring;
                          refspec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_remote_get_push_refspecs*(array: ptr git_strarray;
                                   remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_refspec_count*(remote: ptr git_remote): size_t {.
    dynlib: libgitDl, importc.}
proc git_remote_get_refspec*(remote: ptr git_remote; n: size_t): ptr git_refspec {.
    dynlib: libgitDl, importc.}
proc git_remote_connect*(remote: ptr git_remote; direction: git_direction;
                         callbacks: ptr git_remote_callbacks;
                         proxy_opts: ptr git_proxy_options;
                         custom_headers: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_ls*(out: ptr ptr ptr git_remote_head; size: ptr size_t;
                    remote: ptr git_remote): cint {.dynlib: libgitDl, importc.}
proc git_remote_connected*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_stop*(remote: ptr git_remote): cint {.dynlib: libgitDl, importc.}
proc git_remote_disconnect*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_free*(remote: ptr git_remote): void {.dynlib: libgitDl, importc.}
proc git_remote_list*(out: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_init_callbacks*(opts: ptr git_remote_callbacks; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_fetch_options_init*(opts: ptr git_fetch_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_push_options_init*(opts: ptr git_push_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_download*(remote: ptr git_remote; refspecs: ptr git_strarray;
                          opts: ptr git_fetch_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_upload*(remote: ptr git_remote; refspecs: ptr git_strarray;
                        opts: ptr git_push_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_update_tips*(remote: ptr git_remote;
                             callbacks: ptr git_remote_callbacks;
                             update_fetchhead: cint;
                             download_tags: git_remote_autotag_option_t;
                             reflog_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_fetch*(remote: ptr git_remote; refspecs: ptr git_strarray;
                       opts: ptr git_fetch_options; reflog_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_prune*(remote: ptr git_remote;
                       callbacks: ptr git_remote_callbacks): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_push*(remote: ptr git_remote; refspecs: ptr git_strarray;
                      opts: ptr git_push_options): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_stats*(remote: ptr git_remote): ptr git_indexer_progress {.
    dynlib: libgitDl, importc.}
proc git_remote_autotag*(remote: ptr git_remote): git_remote_autotag_option_t {.
    dynlib: libgitDl, importc.}
proc git_remote_set_autotag*(repo: ptr git_repository; remote: cstring;
                             value: git_remote_autotag_option_t): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_prune_refs*(remote: ptr git_remote): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_rename*(problems: ptr git_strarray; repo: ptr git_repository;
                        name: cstring; new_name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_is_valid_name*(remote_name: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_remote_delete*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_default_branch*(out: ptr git_buf; remote: ptr git_remote): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_options_init*(opts: ptr git_indexer_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_new*(out: ptr ptr git_indexer; path: cstring; mode: cuint;
                      odb: ptr git_odb; opts: ptr git_indexer_options): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_append*(idx: ptr git_indexer; data: pointer; size: size_t;
                         stats: ptr git_indexer_progress): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_commit*(idx: ptr git_indexer; stats: ptr git_indexer_progress): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_hash*(idx: ptr git_indexer): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_indexer_free*(idx: ptr git_indexer): void {.dynlib: libgitDl, importc.}
proc git_signature_new*(out: ptr ptr git_signature; name: cstring;
                        email: cstring; time: git_time_t; offset: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_now*(out: ptr ptr git_signature; name: cstring;
                        email: cstring): cint {.dynlib: libgitDl, importc.}
proc git_signature_default*(out: ptr ptr git_signature; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_from_buffer*(out: ptr ptr git_signature; buf: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_dup*(dest: ptr ptr git_signature; sig: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_signature_free*(sig: ptr git_signature): void {.dynlib: libgitDl,
    importc.}
proc git_merge_file_input_init*(opts: ptr git_merge_file_input; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_options_init*(opts: ptr git_merge_file_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_options_init*(opts: ptr git_merge_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_analysis*(analysis_out: ptr git_merge_analysis_t;
                         preference_out: ptr git_merge_preference_t;
                         repo: ptr git_repository;
                         their_heads: ptr ptr git_annotated_commit;
                         their_heads_len: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_analysis_for_ref*(analysis_out: ptr git_merge_analysis_t;
                                 preference_out: ptr git_merge_preference_t;
                                 repo: ptr git_repository;
                                 our_ref: ptr git_reference;
                                 their_heads: ptr ptr git_annotated_commit;
                                 their_heads_len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base*(out: ptr git_oid; repo: ptr git_repository;
                     one: ptr git_oid; two: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_bases*(out: ptr git_oidarray; repo: ptr git_repository;
                      one: ptr git_oid; two: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base_many*(out: ptr git_oid; repo: ptr git_repository;
                          length: size_t;
                          input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_bases_many*(out: ptr git_oidarray; repo: ptr git_repository;
                           length: size_t;
                           input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_base_octopus*(out: ptr git_oid; repo: ptr git_repository;
                             length: size_t;
                             input_array: ptr UncheckedArray[git_oid]): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file*(out: ptr git_merge_file_result;
                     ancestor: ptr git_merge_file_input;
                     ours: ptr git_merge_file_input;
                     theirs: ptr git_merge_file_input;
                     opts: ptr git_merge_file_options): cint {.dynlib: libgitDl,
    importc.}
proc git_merge_file_from_index*(out: ptr git_merge_file_result;
                                repo: ptr git_repository;
                                ancestor: ptr git_index_entry;
                                ours: ptr git_index_entry;
                                theirs: ptr git_index_entry;
                                opts: ptr git_merge_file_options): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_result_free*(result: ptr git_merge_file_result): void {.
    dynlib: libgitDl, importc.}
proc git_merge_trees*(out: ptr ptr git_index; repo: ptr git_repository;
                      ancestor_tree: ptr git_tree; our_tree: ptr git_tree;
                      their_tree: ptr git_tree; opts: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_commits*(out: ptr ptr git_index; repo: ptr git_repository;
                        our_commit: ptr git_commit;
                        their_commit: ptr git_commit;
                        opts: ptr git_merge_options): cint {.dynlib: libgitDl,
    importc.}
proc git_merge*(repo: ptr git_repository;
                their_heads: ptr ptr git_annotated_commit;
                their_heads_len: size_t; merge_opts: ptr git_merge_options;
                checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_options_init*(opts: ptr git_rebase_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_init*(out: ptr ptr git_rebase; repo: ptr git_repository;
                      branch: ptr git_annotated_commit;
                      upstream: ptr git_annotated_commit;
                      onto: ptr git_annotated_commit;
                      opts: ptr git_rebase_options): cint {.dynlib: libgitDl,
    importc.}
proc git_rebase_open*(out: ptr ptr git_rebase; repo: ptr git_repository;
                      opts: ptr git_rebase_options): cint {.dynlib: libgitDl,
    importc.}
proc git_rebase_orig_head_name*(rebase: ptr git_rebase): cstring {.
    dynlib: libgitDl, importc.}
proc git_rebase_orig_head_id*(rebase: ptr git_rebase): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_rebase_onto_name*(rebase: ptr git_rebase): cstring {.dynlib: libgitDl,
    importc.}
proc git_rebase_onto_id*(rebase: ptr git_rebase): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_entrycount*(rebase: ptr git_rebase): size_t {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_current*(rebase: ptr git_rebase): size_t {.
    dynlib: libgitDl, importc.}
proc git_rebase_operation_byindex*(rebase: ptr git_rebase; idx: size_t): ptr git_rebase_operation {.
    dynlib: libgitDl, importc.}
proc git_rebase_next*(operation: ptr ptr git_rebase_operation;
                      rebase: ptr git_rebase): cint {.dynlib: libgitDl, importc.}
proc git_rebase_inmemory_index*(index: ptr ptr git_index; rebase: ptr git_rebase): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_commit*(id: ptr git_oid; rebase: ptr git_rebase;
                        author: ptr git_signature; committer: ptr git_signature;
                        message_encoding: cstring; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_abort*(rebase: ptr git_rebase): cint {.dynlib: libgitDl, importc.}
proc git_rebase_finish*(rebase: ptr git_rebase; signature: ptr git_signature): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_free*(rebase: ptr git_rebase): void {.dynlib: libgitDl, importc.}
proc git_libgit2_version*(major: ptr cint; minor: ptr cint; rev: ptr cint): cint {.
    dynlib: libgitDl, importc.}
proc git_libgit2_features*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_libgit2_opts*(option: cint): cint {.dynlib: libgitDl, importc.}
proc git_oid_fromstr*(out: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_fromstrp*(out: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_fromstrn*(out: ptr git_oid; str: cstring; length: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_fromraw*(out: ptr git_oid; raw: ptr uchar): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_fmt*(out: cstring; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_nfmt*(out: cstring; n: size_t; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_pathfmt*(out: cstring; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_tostr_s*(oid: ptr git_oid): cstring {.dynlib: libgitDl, importc.}
proc git_oid_tostr*(out: cstring; n: size_t; id: ptr git_oid): cstring {.
    dynlib: libgitDl, importc.}
proc git_oid_cpy*(out: ptr git_oid; src: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_cmp*(a: ptr git_oid; b: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_equal*(a: ptr git_oid; b: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_ncmp*(a: ptr git_oid; b: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_streq*(id: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_strcmp*(id: ptr git_oid; str: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_oid_is_zero*(id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_oid_shorten_new*(min_length: size_t): ptr git_oid_shorten {.
    dynlib: libgitDl, importc.}
proc git_oid_shorten_add*(os: ptr git_oid_shorten; text_id: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_oid_shorten_free*(os: ptr git_oid_shorten): void {.dynlib: libgitDl,
    importc.}
proc git_filter_list_load*(filters: ptr ptr git_filter_list;
                           repo: ptr git_repository; blob: ptr git_blob;
                           path: cstring; mode: git_filter_mode_t; flags: uint32): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_contains*(filters: ptr git_filter_list; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_data*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    in: ptr git_buf): cint {.dynlib: libgitDl,
    importc.}
proc git_filter_list_apply_to_file*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    repo: ptr git_repository; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_blob*(out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    blob: ptr git_blob): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_data*(filters: ptr git_filter_list;
                                  data: ptr git_buf; target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_file*(filters: ptr git_filter_list;
                                  repo: ptr git_repository; path: cstring;
                                  target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_blob*(filters: ptr git_filter_list;
                                  blob: ptr git_blob;
                                  target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_free*(filters: ptr git_filter_list): void {.
    dynlib: libgitDl, importc.}
proc git_config_entry_free*(a0: ptr git_config_entry): void {.dynlib: libgitDl,
    importc.}
proc git_config_find_global*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_xdg*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_system*(out: ptr git_buf): cint {.dynlib: libgitDl, importc.}
proc git_config_find_programdata*(out: ptr git_buf): cint {.dynlib: libgitDl,
    importc.}
proc git_config_open_default*(out: ptr ptr git_config): cint {.dynlib: libgitDl,
    importc.}
proc git_config_new*(out: ptr ptr git_config): cint {.dynlib: libgitDl, importc.}
proc git_config_add_file_ondisk*(cfg: ptr git_config; path: cstring;
                                 level: git_config_level_t;
                                 repo: ptr git_repository; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_config_open_ondisk*(out: ptr ptr git_config; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_open_level*(out: ptr ptr git_config; parent: ptr git_config;
                            level: git_config_level_t): cint {.dynlib: libgitDl,
    importc.}
proc git_config_open_global*(out: ptr ptr git_config; config: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_config_snapshot*(out: ptr ptr git_config; config: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_config_free*(cfg: ptr git_config): void {.dynlib: libgitDl, importc.}
proc git_config_get_entry*(out: ptr ptr git_config_entry; cfg: ptr git_config;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_config_get_int32*(out: ptr int32; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_int64*(out: ptr int64; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_bool*(out: ptr cint; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_path*(out: ptr git_buf; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_string*(out: ptr cstring; cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_string_buf*(out: ptr git_buf; cfg: ptr git_config;
                                name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_config_get_multivar_foreach*(cfg: ptr git_config; name: cstring;
                                      regexp: cstring;
                                      callback: git_config_foreach_cb;
                                      payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_multivar_iterator_new*(out: ptr ptr git_config_iterator;
                                       cfg: ptr git_config; name: cstring;
                                       regexp: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_next*(entry: ptr ptr git_config_entry;
                      iter: ptr git_config_iterator): cint {.dynlib: libgitDl,
    importc.}
proc git_config_iterator_free*(iter: ptr git_config_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_config_set_int32*(cfg: ptr git_config; name: cstring; value: int32): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_int64*(cfg: ptr git_config; name: cstring; value: int64): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_bool*(cfg: ptr git_config; name: cstring; value: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_string*(cfg: ptr git_config; name: cstring; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_set_multivar*(cfg: ptr git_config; name: cstring;
                              regexp: cstring; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_delete_entry*(cfg: ptr git_config; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_delete_multivar*(cfg: ptr git_config; name: cstring;
                                 regexp: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_config_foreach*(cfg: ptr git_config; callback: git_config_foreach_cb;
                         payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_config_iterator_new*(out: ptr ptr git_config_iterator;
                              cfg: ptr git_config): cint {.dynlib: libgitDl,
    importc.}
proc git_config_iterator_glob_new*(out: ptr ptr git_config_iterator;
                                   cfg: ptr git_config; regexp: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_foreach_match*(cfg: ptr git_config; regexp: cstring;
                               callback: git_config_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_get_mapped*(out: ptr cint; cfg: ptr git_config; name: cstring;
                            maps: ptr git_configmap; map_n: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_config_lookup_map_value*(out: ptr cint; maps: ptr git_configmap;
                                  map_n: size_t; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_bool*(out: ptr cint; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_int32*(out: ptr int32; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_int64*(out: ptr int64; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_parse_path*(out: ptr git_buf; value: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_config_backend_foreach_match*(backend: ptr git_config_backend;
                                       regexp: cstring;
                                       callback: git_config_foreach_cb;
                                       payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_config_lock*(tx: ptr ptr git_transaction; cfg: ptr git_config): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_diff*(out: ptr ptr git_patch; diff: ptr git_diff;
                          idx: size_t): cint {.dynlib: libgitDl, importc.}
proc git_patch_from_blobs*(out: ptr ptr git_patch; old_blob: ptr git_blob;
                           old_as_path: cstring; new_blob: ptr git_blob;
                           new_as_path: cstring; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_blob_and_buffer*(out: ptr ptr git_patch;
                                     old_blob: ptr git_blob;
                                     old_as_path: cstring; buffer: pointer;
                                     buffer_len: size_t;
                                     buffer_as_path: cstring;
                                     opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_buffers*(out: ptr ptr git_patch; old_buffer: pointer;
                             old_len: size_t; old_as_path: cstring;
                             new_buffer: pointer; new_len: size_t;
                             new_as_path: cstring; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_free*(patch: ptr git_patch): void {.dynlib: libgitDl, importc.}
proc git_patch_get_delta*(patch: ptr git_patch): ptr git_diff_delta {.
    dynlib: libgitDl, importc.}
proc git_patch_num_hunks*(patch: ptr git_patch): size_t {.dynlib: libgitDl,
    importc.}
proc git_patch_line_stats*(total_context: ptr size_t;
                           total_additions: ptr size_t;
                           total_deletions: ptr size_t; patch: ptr git_patch): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_get_hunk*(out: ptr ptr git_diff_hunk; lines_in_hunk: ptr size_t;
                         patch: ptr git_patch; hunk_idx: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_num_lines_in_hunk*(patch: ptr git_patch; hunk_idx: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_get_line_in_hunk*(out: ptr ptr git_diff_line;
                                 patch: ptr git_patch; hunk_idx: size_t;
                                 line_of_hunk: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_patch_size*(patch: ptr git_patch; include_context: cint;
                     include_hunk_headers: cint; include_file_headers: cint): size_t {.
    dynlib: libgitDl, importc.}
proc git_patch_print*(patch: ptr git_patch; print_cb: git_diff_line_cb;
                      payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_patch_to_buf*(out: ptr git_buf; patch: ptr git_patch): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_ref*(out: ptr ptr git_annotated_commit;
                                    repo: ptr git_repository;
                                    ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_fetchhead*(out: ptr ptr git_annotated_commit;
    repo: ptr git_repository; branch_name: cstring; remote_url: cstring;
    id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_annotated_commit_lookup*(out: ptr ptr git_annotated_commit;
                                  repo: ptr git_repository; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_from_revspec*(out: ptr ptr git_annotated_commit;
                                        repo: ptr git_repository;
                                        revspec: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_id*(commit: ptr git_annotated_commit): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_ref*(commit: ptr git_annotated_commit): cstring {.
    dynlib: libgitDl, importc.}
proc git_annotated_commit_free*(commit: ptr git_annotated_commit): void {.
    dynlib: libgitDl, importc.}
proc git_note_iterator_new*(out: ptr ptr git_note_iterator;
                            repo: ptr git_repository; notes_ref: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_note_commit_iterator_new*(out: ptr ptr git_note_iterator;
                                   notes_commit: ptr git_commit): cint {.
    dynlib: libgitDl, importc.}
proc git_note_iterator_free*(it: ptr git_note_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_note_next*(note_id: ptr git_oid; annotated_id: ptr git_oid;
                    it: ptr git_note_iterator): cint {.dynlib: libgitDl, importc.}
proc git_note_read*(out: ptr ptr git_note; repo: ptr git_repository;
                    notes_ref: cstring; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_commit_read*(out: ptr ptr git_note; repo: ptr git_repository;
                           notes_commit: ptr git_commit; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_author*(note: ptr git_note): ptr git_signature {.dynlib: libgitDl,
    importc.}
proc git_note_committer*(note: ptr git_note): ptr git_signature {.
    dynlib: libgitDl, importc.}
proc git_note_message*(note: ptr git_note): cstring {.dynlib: libgitDl, importc.}
proc git_note_id*(note: ptr git_note): ptr git_oid {.dynlib: libgitDl, importc.}
proc git_note_create*(out: ptr git_oid; repo: ptr git_repository;
                      notes_ref: cstring; author: ptr git_signature;
                      committer: ptr git_signature; oid: ptr git_oid;
                      note: cstring; force: cint): cint {.dynlib: libgitDl,
    importc.}
proc git_note_commit_create*(notes_commit_out: ptr git_oid;
                             notes_blob_out: ptr git_oid;
                             repo: ptr git_repository; parent: ptr git_commit;
                             author: ptr git_signature;
                             committer: ptr git_signature; oid: ptr git_oid;
                             note: cstring; allow_note_overwrite: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_note_remove*(repo: ptr git_repository; notes_ref: cstring;
                      author: ptr git_signature; committer: ptr git_signature;
                      oid: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_note_commit_remove*(notes_commit_out: ptr git_oid;
                             repo: ptr git_repository;
                             notes_commit: ptr git_commit;
                             author: ptr git_signature;
                             committer: ptr git_signature; oid: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_note_free*(note: ptr git_note): void {.dynlib: libgitDl, importc.}
proc git_note_default_ref*(out: ptr git_buf; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_note_foreach*(repo: ptr git_repository; notes_ref: cstring;
                       note_cb: git_note_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_graph_ahead_behind*(ahead: ptr size_t; behind: ptr size_t;
                             repo: ptr git_repository; local: ptr git_oid;
                             upstream: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_graph_descendant_of*(repo: ptr git_repository; commit: ptr git_oid;
                              ancestor: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_object_lookup*(object: ptr ptr git_object; repo: ptr git_repository;
                        id: ptr git_oid; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_lookup_prefix*(object_out: ptr ptr git_object;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_lookup_bypath*(out: ptr ptr git_object; treeish: ptr git_object;
                               path: cstring; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_id*(obj: ptr git_object): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_object_short_id*(out: ptr git_buf; obj: ptr git_object): cint {.
    dynlib: libgitDl, importc.}
proc git_object_type*(obj: ptr git_object): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_object_owner*(obj: ptr git_object): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_object_free*(object: ptr git_object): void {.dynlib: libgitDl, importc.}
proc git_object_type2string*(type: git_object_t): cstring {.dynlib: libgitDl,
    importc.}
proc git_object_string2type*(str: cstring): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_object_typeisloose*(type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_object_peel*(peeled: ptr ptr git_object; object: ptr git_object;
                      target_type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_object_dup*(dest: ptr ptr git_object; source: ptr git_object): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_lookup*(out: ptr ptr git_reference; repo: ptr git_repository;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_name_to_id*(out: ptr git_oid; repo: ptr git_repository;
                               name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_dwim*(out: ptr ptr git_reference; repo: ptr git_repository;
                         shorthand: cstring): cint {.dynlib: libgitDl, importc.}
proc git_reference_symbolic_create_matching*(out: ptr ptr git_reference;
    repo: ptr git_repository; name: cstring; target: cstring; force: cint;
    current_value: cstring; log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_symbolic_create*(out: ptr ptr git_reference;
                                    repo: ptr git_repository; name: cstring;
                                    target: cstring; force: cint;
                                    log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_create*(out: ptr ptr git_reference; repo: ptr git_repository;
                           name: cstring; id: ptr git_oid; force: cint;
                           log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_create_matching*(out: ptr ptr git_reference;
                                    repo: ptr git_repository; name: cstring;
                                    id: ptr git_oid; force: cint;
                                    current_id: ptr git_oid;
                                    log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_target*(ref: ptr git_reference): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reference_target_peel*(ref: ptr git_reference): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_reference_symbolic_target*(ref: ptr git_reference): cstring {.
    dynlib: libgitDl, importc.}
proc git_reference_type*(ref: ptr git_reference): git_reference_t {.
    dynlib: libgitDl, importc.}
proc git_reference_name*(ref: ptr git_reference): cstring {.dynlib: libgitDl,
    importc.}
proc git_reference_resolve*(out: ptr ptr git_reference; ref: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_owner*(ref: ptr git_reference): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_reference_symbolic_set_target*(out: ptr ptr git_reference;
                                        ref: ptr git_reference; target: cstring;
                                        log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_set_target*(out: ptr ptr git_reference;
                               ref: ptr git_reference; id: ptr git_oid;
                               log_message: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_rename*(new_ref: ptr ptr git_reference;
                           ref: ptr git_reference; new_name: cstring;
                           force: cint; log_message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_delete*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_remove*(repo: ptr git_repository; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_list*(array: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach*(repo: ptr git_repository;
                            callback: git_reference_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach_name*(repo: ptr git_repository;
                                 callback: git_reference_foreach_name_cb;
                                 payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_dup*(dest: ptr ptr git_reference; source: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_free*(ref: ptr git_reference): void {.dynlib: libgitDl,
    importc.}
proc git_reference_cmp*(ref1: ptr git_reference; ref2: ptr git_reference): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_new*(out: ptr ptr git_reference_iterator;
                                 repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_glob_new*(out: ptr ptr git_reference_iterator;
                                      repo: ptr git_repository; glob: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_next*(out: ptr ptr git_reference;
                         iter: ptr git_reference_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_next_name*(out: ptr cstring; iter: ptr git_reference_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_iterator_free*(iter: ptr git_reference_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_reference_foreach_glob*(repo: ptr git_repository; glob: cstring;
                                 callback: git_reference_foreach_name_cb;
                                 payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_has_log*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_ensure_log*(repo: ptr git_repository; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_is_branch*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_remote*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_tag*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_is_note*(ref: ptr git_reference): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_normalize_name*(buffer_out: cstring; buffer_size: size_t;
                                   name: cstring; flags: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_reference_peel*(out: ptr ptr git_object; ref: ptr git_reference;
                         type: git_object_t): cint {.dynlib: libgitDl, importc.}
proc git_reference_is_valid_name*(refname: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_reference_shorthand*(ref: ptr git_reference): cstring {.
    dynlib: libgitDl, importc.}
proc git_libgit2_init*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_libgit2_shutdown*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_odb_new*(out: ptr ptr git_odb): cint {.dynlib: libgitDl, importc.}
proc git_odb_open*(out: ptr ptr git_odb; objects_dir: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_add_disk_alternate*(odb: ptr git_odb; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_free*(db: ptr git_odb): void {.dynlib: libgitDl, importc.}
proc git_odb_read*(out: ptr ptr git_odb_object; db: ptr git_odb; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_read_prefix*(out: ptr ptr git_odb_object; db: ptr git_odb;
                          short_id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_read_header*(len_out: ptr size_t; type_out: ptr git_object_t;
                          db: ptr git_odb; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_exists*(db: ptr git_odb; id: ptr git_oid): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_exists_prefix*(out: ptr git_oid; db: ptr git_odb;
                            short_id: ptr git_oid; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_expand_ids*(db: ptr git_odb; ids: ptr git_odb_expand_id;
                         count: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_refresh*(db: ptr git_odb): cint {.dynlib: libgitDl, importc.}
proc git_odb_foreach*(db: ptr git_odb; cb: git_odb_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_write*(out: ptr git_oid; odb: ptr git_odb; data: pointer;
                    len: size_t; type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_open_wstream*(out: ptr ptr git_odb_stream; db: ptr git_odb;
                           size: git_object_size_t; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_stream_write*(stream: ptr git_odb_stream; buffer: cstring;
                           len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_stream_finalize_write*(out: ptr git_oid; stream: ptr git_odb_stream): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_stream_read*(stream: ptr git_odb_stream; buffer: cstring;
                          len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_stream_free*(stream: ptr git_odb_stream): void {.dynlib: libgitDl,
    importc.}
proc git_odb_open_rstream*(out: ptr ptr git_odb_stream; len: ptr size_t;
                           type: ptr git_object_t; db: ptr git_odb;
                           oid: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_odb_write_pack*(out: ptr ptr git_odb_writepack; db: ptr git_odb;
                         progress_cb: git_indexer_progress_cb;
                         progress_payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_hash*(out: ptr git_oid; data: pointer; len: size_t;
                   type: git_object_t): cint {.dynlib: libgitDl, importc.}
proc git_odb_hashfile*(out: ptr git_oid; path: cstring; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_object_dup*(dest: ptr ptr git_odb_object;
                         source: ptr git_odb_object): cint {.dynlib: libgitDl,
    importc.}
proc git_odb_object_free*(object: ptr git_odb_object): void {.dynlib: libgitDl,
    importc.}
proc git_odb_object_id*(object: ptr git_odb_object): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_odb_object_data*(object: ptr git_odb_object): pointer {.
    dynlib: libgitDl, importc.}
proc git_odb_object_size*(object: ptr git_odb_object): size_t {.
    dynlib: libgitDl, importc.}
proc git_odb_object_type*(object: ptr git_odb_object): git_object_t {.
    dynlib: libgitDl, importc.}
proc git_odb_add_backend*(odb: ptr git_odb; backend: ptr git_odb_backend;
                          priority: cint): cint {.dynlib: libgitDl, importc.}
proc git_odb_add_alternate*(odb: ptr git_odb; backend: ptr git_odb_backend;
                            priority: cint): cint {.dynlib: libgitDl, importc.}
proc git_odb_num_backends*(odb: ptr git_odb): size_t {.dynlib: libgitDl, importc.}
proc git_odb_get_backend*(out: ptr ptr git_odb_backend; odb: ptr git_odb;
                          pos: size_t): cint {.dynlib: libgitDl, importc.}
proc git_oidarray_free*(array: ptr git_oidarray): void {.dynlib: libgitDl,
    importc.}
proc git_strarray_dispose*(array: ptr git_strarray): void {.dynlib: libgitDl,
    importc.}
proc git_strarray_copy*(tgt: ptr git_strarray; src: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_free*(cred: ptr git_credential): void {.dynlib: libgitDl,
    importc.}
proc git_credential_has_username*(cred: ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_get_username*(cred: ptr git_credential): cstring {.
    dynlib: libgitDl, importc.}
proc git_credential_userpass_plaintext_new*(out: ptr ptr git_credential;
    username: cstring; password: cstring): cint {.dynlib: libgitDl, importc.}
proc git_credential_default_new*(out: ptr ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_username_new*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_key_new*(out: ptr ptr git_credential; username: cstring;
                                 publickey: cstring; privatekey: cstring;
                                 passphrase: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_credential_ssh_key_memory_new*(out: ptr ptr git_credential;
                                        username: cstring; publickey: cstring;
                                        privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_interactive_new*(out: ptr ptr git_credential;
    username: cstring; prompt_callback: git_credential_ssh_interactive_cb;
    payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_credential_ssh_key_from_agent*(out: ptr ptr git_credential;
                                        username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_credential_ssh_custom_new*(out: ptr ptr git_credential;
                                    username: cstring; publickey: cstring;
                                    publickey_len: size_t;
                                    sign_callback: git_credential_sign_cb;
                                    payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_clone_options_init*(opts: ptr git_clone_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_clone*(out: ptr ptr git_repository; url: cstring; local_path: cstring;
                options: ptr git_clone_options): cint {.dynlib: libgitDl,
    importc.}
proc git_cherrypick_options_init*(opts: ptr git_cherrypick_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_cherrypick_commit*(out: ptr ptr git_index; repo: ptr git_repository;
                            cherrypick_commit: ptr git_commit;
                            our_commit: ptr git_commit; mainline: cuint;
                            merge_options: ptr git_merge_options): cint {.
    dynlib: libgitDl, importc.}
proc git_cherrypick*(repo: ptr git_repository; commit: ptr git_commit;
                     cherrypick_options: ptr git_cherrypick_options): cint {.
    dynlib: libgitDl, importc.}
proc git_index_open*(out: ptr ptr git_index; index_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_new*(out: ptr ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_free*(index: ptr git_index): void {.dynlib: libgitDl, importc.}
proc git_index_owner*(index: ptr git_index): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_index_caps*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_set_caps*(index: ptr git_index; caps: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_version*(index: ptr git_index): cuint {.dynlib: libgitDl, importc.}
proc git_index_set_version*(index: ptr git_index; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_read*(index: ptr git_index; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_path*(index: ptr git_index): cstring {.dynlib: libgitDl, importc.}
proc git_index_checksum*(index: ptr git_index): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_index_read_tree*(index: ptr git_index; tree: ptr git_tree): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write_tree*(out: ptr git_oid; index: ptr git_index): cint {.
    dynlib: libgitDl, importc.}
proc git_index_write_tree_to*(out: ptr git_oid; index: ptr git_index;
                              repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entrycount*(index: ptr git_index): size_t {.dynlib: libgitDl,
    importc.}
proc git_index_clear*(index: ptr git_index): cint {.dynlib: libgitDl, importc.}
proc git_index_get_byindex*(index: ptr git_index; n: size_t): ptr git_index_entry {.
    dynlib: libgitDl, importc.}
proc git_index_get_bypath*(index: ptr git_index; path: cstring; stage: cint): ptr git_index_entry {.
    dynlib: libgitDl, importc.}
proc git_index_remove*(index: ptr git_index; path: cstring; stage: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_remove_directory*(index: ptr git_index; dir: cstring; stage: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add*(index: ptr git_index; source_entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entry_stage*(entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_entry_is_conflict*(entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_iterator_new*(iterator_out: ptr ptr git_index_iterator;
                             index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_iterator_next*(out: ptr ptr git_index_entry;
                              iterator: ptr git_index_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_index_iterator_free*(iterator: ptr git_index_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_index_add_bypath*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add_from_buffer*(index: ptr git_index;
                                entry: ptr git_index_entry; buffer: pointer;
                                len: size_t): cint {.dynlib: libgitDl, importc.}
proc git_index_remove_bypath*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_add_all*(index: ptr git_index; pathspec: ptr git_strarray;
                        flags: cuint; callback: git_index_matched_path_cb;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_index_remove_all*(index: ptr git_index; pathspec: ptr git_strarray;
                           callback: git_index_matched_path_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_index_update_all*(index: ptr git_index; pathspec: ptr git_strarray;
                           callback: git_index_matched_path_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_index_find*(at_pos: ptr size_t; index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_find_prefix*(at_pos: ptr size_t; index: ptr git_index;
                            prefix: cstring): cint {.dynlib: libgitDl, importc.}
proc git_index_conflict_add*(index: ptr git_index;
                             ancestor_entry: ptr git_index_entry;
                             our_entry: ptr git_index_entry;
                             their_entry: ptr git_index_entry): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_get*(ancestor_out: ptr ptr git_index_entry;
                             our_out: ptr ptr git_index_entry;
                             their_out: ptr ptr git_index_entry;
                             index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_remove*(index: ptr git_index; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_cleanup*(index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_has_conflicts*(index: ptr git_index): cint {.dynlib: libgitDl,
    importc.}
proc git_index_conflict_iterator_new*(iterator_out: ptr ptr git_index_conflict_iterator;
                                      index: ptr git_index): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_next*(ancestor_out: ptr ptr git_index_entry;
                              our_out: ptr ptr git_index_entry;
                              their_out: ptr ptr git_index_entry;
                              iterator: ptr git_index_conflict_iterator): cint {.
    dynlib: libgitDl, importc.}
proc git_index_conflict_iterator_free*(iterator: ptr git_index_conflict_iterator): void {.
    dynlib: libgitDl, importc.}
proc git_trace_set*(level: git_trace_level_t; cb: git_trace_cb): cint {.
    dynlib: libgitDl, importc.}
proc git_error_last*(a0: void): ptr git_error {.dynlib: libgitDl, importc.}
proc git_error_clear*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_error_set_str*(error_class: cint; string: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_error_set_oom*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_odb_backend_pack*(out: ptr ptr git_odb_backend; objects_dir: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_backend_loose*(out: ptr ptr git_odb_backend; objects_dir: cstring;
                            compression_level: cint; do_fsync: cint;
                            dir_mode: cuint; file_mode: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_odb_backend_one_pack*(out: ptr ptr git_odb_backend; index_file: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_message_prettify*(out: ptr git_buf; message: cstring;
                           strip_comments: cint; comment_char: char): cint {.
    dynlib: libgitDl, importc.}
proc git_message_trailers*(arr: ptr git_message_trailer_array; message: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_message_trailer_array_free*(arr: ptr git_message_trailer_array): void {.
    dynlib: libgitDl, importc.}
proc git_credential_userpass*(out: ptr ptr git_credential; url: cstring;
                              user_from_url: cstring; allowed_types: cuint;
                              payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_transaction_new*(out: ptr ptr git_transaction; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_lock_ref*(tx: ptr git_transaction; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_set_target*(tx: ptr git_transaction; refname: cstring;
                                 target: ptr git_oid; sig: ptr git_signature;
                                 msg: cstring): cint {.dynlib: libgitDl, importc.}
proc git_transaction_set_symbolic_target*(tx: ptr git_transaction;
    refname: cstring; target: cstring; sig: ptr git_signature; msg: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_set_reflog*(tx: ptr git_transaction; refname: cstring;
                                 reflog: ptr git_reflog): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_remove*(tx: ptr git_transaction; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_transaction_commit*(tx: ptr git_transaction): cint {.dynlib: libgitDl,
    importc.}
proc git_transaction_free*(tx: ptr git_transaction): void {.dynlib: libgitDl,
    importc.}
proc git_packbuilder_new*(out: ptr ptr git_packbuilder; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_set_threads*(pb: ptr git_packbuilder; n: cuint): cuint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert*(pb: ptr git_packbuilder; id: ptr git_oid;
                             name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_packbuilder_insert_tree*(pb: ptr git_packbuilder; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_commit*(pb: ptr git_packbuilder; id: ptr git_oid): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_walk*(pb: ptr git_packbuilder; walk: ptr git_revwalk): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_insert_recur*(pb: ptr git_packbuilder; id: ptr git_oid;
                                   name: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_packbuilder_write_buf*(buf: ptr git_buf; pb: ptr git_packbuilder): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_write*(pb: ptr git_packbuilder; path: cstring; mode: cuint;
                            progress_cb: git_indexer_progress_cb;
                            progress_cb_payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_hash*(pb: ptr git_packbuilder): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_foreach*(pb: ptr git_packbuilder;
                              cb: git_packbuilder_foreach_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_object_count*(pb: ptr git_packbuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_written*(pb: ptr git_packbuilder): size_t {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_set_callbacks*(pb: ptr git_packbuilder;
                                    progress_cb: git_packbuilder_progress;
                                    progress_cb_payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_packbuilder_free*(pb: ptr git_packbuilder): void {.dynlib: libgitDl,
    importc.}
proc git_pathspec_new*(out: ptr ptr git_pathspec; pathspec: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_pathspec_free*(ps: ptr git_pathspec): void {.dynlib: libgitDl, importc.}
proc git_pathspec_matches_path*(ps: ptr git_pathspec; flags: uint32;
                                path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_pathspec_match_workdir*(out: ptr ptr git_pathspec_match_list;
                                 repo: ptr git_repository; flags: uint32;
                                 ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_index*(out: ptr ptr git_pathspec_match_list;
                               index: ptr git_index; flags: uint32;
                               ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_tree*(out: ptr ptr git_pathspec_match_list;
                              tree: ptr git_tree; flags: uint32;
                              ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_diff*(out: ptr ptr git_pathspec_match_list;
                              diff: ptr git_diff; flags: uint32;
                              ps: ptr git_pathspec): cint {.dynlib: libgitDl,
    importc.}
proc git_pathspec_match_list_free*(m: ptr git_pathspec_match_list): void {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_entrycount*(m: ptr git_pathspec_match_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_entry*(m: ptr git_pathspec_match_list; pos: size_t): cstring {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_diff_entry*(m: ptr git_pathspec_match_list;
    pos: size_t): ptr git_diff_delta {.dynlib: libgitDl, importc.}
proc git_pathspec_match_list_failed_entrycount*(m: ptr git_pathspec_match_list): size_t {.
    dynlib: libgitDl, importc.}
proc git_pathspec_match_list_failed_entry*(m: ptr git_pathspec_match_list;
    pos: size_t): cstring {.dynlib: libgitDl, importc.}
proc git_worktree_list*(out: ptr git_strarray; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_lookup*(out: ptr ptr git_worktree; repo: ptr git_repository;
                          name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_worktree_open_from_repository*(out: ptr ptr git_worktree;
                                        repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_free*(wt: ptr git_worktree): void {.dynlib: libgitDl, importc.}
proc git_worktree_validate*(wt: ptr git_worktree): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_add_options_init*(opts: ptr git_worktree_add_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_add*(out: ptr ptr git_worktree; repo: ptr git_repository;
                       name: cstring; path: cstring;
                       opts: ptr git_worktree_add_options): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_lock*(wt: ptr git_worktree; reason: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_unlock*(wt: ptr git_worktree): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_is_locked*(reason: ptr git_buf; wt: ptr git_worktree): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_name*(wt: ptr git_worktree): cstring {.dynlib: libgitDl,
    importc.}
proc git_worktree_path*(wt: ptr git_worktree): cstring {.dynlib: libgitDl,
    importc.}
proc git_worktree_prune_options_init*(opts: ptr git_worktree_prune_options;
                                      version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_is_prunable*(wt: ptr git_worktree;
                               opts: ptr git_worktree_prune_options): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_prune*(wt: ptr git_worktree;
                         opts: ptr git_worktree_prune_options): cint {.
    dynlib: libgitDl, importc.}
proc git_proxy_options_init*(opts: ptr git_proxy_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_reset*(repo: ptr git_repository; target: ptr git_object;
                reset_type: git_reset_t; checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_reset_from_annotated*(repo: ptr git_repository;
                               commit: ptr git_annotated_commit;
                               reset_type: git_reset_t;
                               checkout_opts: ptr git_checkout_options): cint {.
    dynlib: libgitDl, importc.}
proc git_reset_default*(repo: ptr git_repository; target: ptr git_object;
                        pathspecs: ptr git_strarray): cint {.dynlib: libgitDl,
    importc.}
proc git_apply_options_init*(opts: ptr git_apply_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_apply_to_tree*(out: ptr ptr git_index; repo: ptr git_repository;
                        preimage: ptr git_tree; diff: ptr git_diff;
                        options: ptr git_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_apply*(repo: ptr git_repository; diff: ptr git_diff;
                location: git_apply_location_t; options: ptr git_apply_options): cint {.
    dynlib: libgitDl, importc.}
proc git_revparse_single*(out: ptr ptr git_object; repo: ptr git_repository;
                          spec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_revparse_ext*(object_out: ptr ptr git_object;
                       reference_out: ptr ptr git_reference;
                       repo: ptr git_repository; spec: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_revparse*(revspec: ptr git_revspec; repo: ptr git_repository;
                   spec: cstring): cint {.dynlib: libgitDl, importc.}
proc git_refspec_parse*(refspec: ptr ptr git_refspec; input: cstring;
                        is_fetch: cint): cint {.dynlib: libgitDl, importc.}
proc git_refspec_free*(refspec: ptr git_refspec): void {.dynlib: libgitDl,
    importc.}
proc git_refspec_src*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_dst*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_string*(refspec: ptr git_refspec): cstring {.dynlib: libgitDl,
    importc.}
proc git_refspec_force*(refspec: ptr git_refspec): cint {.dynlib: libgitDl,
    importc.}
proc git_refspec_direction*(spec: ptr git_refspec): git_direction {.
    dynlib: libgitDl, importc.}
proc git_refspec_src_matches*(refspec: ptr git_refspec; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_refspec_dst_matches*(refspec: ptr git_refspec; refname: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_refspec_transform*(out: ptr git_buf; spec: ptr git_refspec;
                            name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_refspec_rtransform*(out: ptr git_buf; spec: ptr git_refspec;
                             name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_fromworkdir*(id: ptr git_oid; repo: ptr git_repository;
                                  relative_path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_fromdisk*(id: ptr git_oid; repo: ptr git_repository;
                               path: cstring): cint {.dynlib: libgitDl, importc.}
proc git_blob_create_fromstream*(out: ptr ptr git_writestream;
                                 repo: ptr git_repository; hintpath: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_fromstream_commit*(out: ptr git_oid;
                                        stream: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_create_frombuffer*(id: ptr git_oid; repo: ptr git_repository;
                                 buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_blob_filtered_content*(out: ptr git_buf; blob: ptr git_blob;
                                as_path: cstring; check_for_binary_data: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_buf_free*(buffer: ptr git_buf): void {.dynlib: libgitDl, importc.}
proc giterr_last*(a0: void): ptr git_error {.dynlib: libgitDl, importc.}
proc giterr_clear*(a0: void): void {.dynlib: libgitDl, importc.}
proc giterr_set_str*(error_class: cint; string: cstring): void {.
    dynlib: libgitDl, importc.}
proc giterr_set_oom*(a0: void): void {.dynlib: libgitDl, importc.}
proc git_index_add_frombuffer*(index: ptr git_index; entry: ptr git_index_entry;
                               buffer: pointer; len: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_size*(type: git_object_t): size_t {.dynlib: libgitDl,
    importc: "git_object__size".}
proc git_tag_create_frombuffer*(oid: ptr git_oid; repo: ptr git_repository;
                                buffer: cstring; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_free*(cred: ptr git_credential): void {.dynlib: libgitDl, importc.}
proc git_cred_has_username*(cred: ptr git_credential): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_get_username*(cred: ptr git_credential): cstring {.
    dynlib: libgitDl, importc.}
proc git_cred_userpass_plaintext_new*(out: ptr ptr git_credential;
                                      username: cstring; password: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_default_new*(out: ptr ptr git_credential): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_username_new*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_key_new*(out: ptr ptr git_credential; username: cstring;
                           publickey: cstring; privatekey: cstring;
                           passphrase: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_ssh_key_memory_new*(out: ptr ptr git_credential;
                                  username: cstring; publickey: cstring;
                                  privatekey: cstring; passphrase: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_interactive_new*(out: ptr ptr git_credential;
                                   username: cstring; prompt_callback: git_credential_ssh_interactive_cb;
                                   payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_ssh_key_from_agent*(out: ptr ptr git_credential; username: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_cred_ssh_custom_new*(out: ptr ptr git_credential; username: cstring;
                              publickey: cstring; publickey_len: size_t;
                              sign_callback: git_credential_sign_cb;
                              payload: pointer): cint {.dynlib: libgitDl,
    importc.}
proc git_cred_userpass*(out: ptr ptr git_credential; url: cstring;
                        user_from_url: cstring; allowed_types: cuint;
                        payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_oid_iszero*(id: ptr git_oid): cint {.dynlib: libgitDl, importc.}
proc git_strarray_copy*(tgt: ptr git_strarray; src: ptr git_strarray): cint {.
    dynlib: libgitDl, importc.}
proc git_strarray_free*(array: ptr git_strarray): void {.dynlib: libgitDl,
    importc.}
proc git_blame_init_options*(opts: ptr git_blame_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_checkout_init_options*(opts: ptr git_checkout_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_cherrypick_init_options*(opts: ptr git_cherrypick_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_clone_init_options*(opts: ptr git_clone_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_init_options*(opts: ptr git_describe_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_describe_init_format_options*(opts: ptr git_describe_format_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_diff_init_options*(opts: ptr git_diff_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_find_init_options*(opts: ptr git_diff_find_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_format_email_init_options*(
    opts: ptr git_diff_format_email_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_diff_patchid_init_options*(opts: ptr git_diff_patchid_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_fetch_init_options*(opts: ptr git_fetch_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_indexer_init_options*(opts: ptr git_indexer_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_init_options*(opts: ptr git_merge_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_init_input*(input: ptr git_merge_file_input; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_merge_file_init_options*(opts: ptr git_merge_file_options;
                                  version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_proxy_init_options*(opts: ptr git_proxy_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_push_init_options*(opts: ptr git_push_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_rebase_init_options*(opts: ptr git_rebase_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_remote_create_init_options*(opts: ptr git_remote_create_options;
                                     version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_repository_init_init_options*(opts: ptr git_repository_init_options;
                                       version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_revert_init_options*(opts: ptr git_revert_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_stash_apply_init_options*(opts: ptr git_stash_apply_options;
                                   version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_status_init_options*(opts: ptr git_status_options; version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update_init_options*(opts: ptr git_submodule_update_options;
                                        version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_worktree_add_init_options*(opts: ptr git_worktree_add_options;
                                    version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_worktree_prune_init_options*(opts: ptr git_worktree_prune_options;
                                      version: cuint): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_update_options_init*(opts: ptr git_submodule_update_options;
                                        version: cuint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update*(submodule: ptr git_submodule; init: cint;
                           options: ptr git_submodule_update_options): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_lookup*(out: ptr ptr git_submodule; repo: ptr git_repository;
                           name: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_free*(submodule: ptr git_submodule): void {.dynlib: libgitDl,
    importc.}
proc git_submodule_foreach*(repo: ptr git_repository;
                            callback: git_submodule_cb; payload: pointer): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_setup*(out: ptr ptr git_submodule;
                              repo: ptr git_repository; url: cstring;
                              path: cstring; use_gitlink: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_clone*(out: ptr ptr git_repository;
                          submodule: ptr git_submodule;
                          opts: ptr git_submodule_update_options): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_finalize*(submodule: ptr git_submodule): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_add_to_index*(submodule: ptr git_submodule; write_index: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_owner*(submodule: ptr git_submodule): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_submodule_name*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_path*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_url*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_resolve_url*(out: ptr git_buf; repo: ptr git_repository;
                                url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_branch*(submodule: ptr git_submodule): cstring {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_branch*(repo: ptr git_repository; name: cstring;
                               branch: cstring): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_set_url*(repo: ptr git_repository; name: cstring;
                            url: cstring): cint {.dynlib: libgitDl, importc.}
proc git_submodule_index_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_head_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_wd_id*(submodule: ptr git_submodule): ptr git_oid {.
    dynlib: libgitDl, importc.}
proc git_submodule_ignore*(submodule: ptr git_submodule): git_submodule_ignore_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_ignore*(repo: ptr git_repository; name: cstring;
                               ignore: git_submodule_ignore_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_update_strategy*(submodule: ptr git_submodule): git_submodule_update_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_update*(repo: ptr git_repository; name: cstring;
                               update: git_submodule_update_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_fetch_recurse_submodules*(submodule: ptr git_submodule): git_submodule_recurse_t {.
    dynlib: libgitDl, importc.}
proc git_submodule_set_fetch_recurse_submodules*(repo: ptr git_repository;
    name: cstring; fetch_recurse_submodules: git_submodule_recurse_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_init*(submodule: ptr git_submodule; overwrite: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_repo_init*(out: ptr ptr git_repository;
                              sm: ptr git_submodule; use_gitlink: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_sync*(submodule: ptr git_submodule): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_open*(repo: ptr ptr git_repository;
                         submodule: ptr git_submodule): cint {.dynlib: libgitDl,
    importc.}
proc git_submodule_reload*(submodule: ptr git_submodule; force: cint): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_status*(status: ptr cuint; repo: ptr git_repository;
                           name: cstring; ignore: git_submodule_ignore_t): cint {.
    dynlib: libgitDl, importc.}
proc git_submodule_location*(location_status: ptr cuint;
                             submodule: ptr git_submodule): cint {.
    dynlib: libgitDl, importc.}