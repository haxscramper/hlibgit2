
import
  . / config

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
  git_status_options* {.bycopy.} = object
    version*: cuint
    show*: git_status_show_t ## The version 
    flags*: cuint
    pathspec*: git_strarray
    baseline*: ptr git_tree

  git_status_entry* {.bycopy.} = object
    status*: git_status_t
    head_to_index*: ptr git_diff_delta
    index_to_workdir*: ptr git_diff_delta

  git_strarray* {.bycopy.} = object
    ## Array of strings 
    strings*: ptr cstring
    count*: size_t

  git_diff_option_t* = enum
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
  git_diff_file* {.bycopy.} = object
    ## entry in the index is conflicted 
    id*: git_oid
    path*: cstring
    size*: git_object_size_t
    flags*: uint32
    mode*: uint16
    id_abbrev*: uint16

  git_diff_delta* {.bycopy.} = object
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
  git_diff_options* {.bycopy.} = object
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
  git_diff_binary_file* {.bycopy.} = object
    ## The contents of one of the files in a binary diff. 
    type_f* {.importc: "type".}: git_diff_binary_t ## The type of binary data for this file. 
    data*: cstring           ## The binary data, deflated. 
    datalen*: size_t         ## The length of the binary data. 
    inflatedlen*: size_t     ## The length of the binary data after inflation. 
  
  git_diff_binary* {.bycopy.} = object
    contains_data*: cuint
    old_file*: git_diff_binary_file
    new_file*: git_diff_binary_file ## The contents of the old file. 
  
  git_diff_binary_cb* = proc (delta: ptr git_diff_delta;
                              binary: ptr git_diff_binary; payload: pointer): cint {.
      cdecl.}
  git_diff_binary_cbNim* = proc (delta: ptr git_diff_delta;
                                 binary: ptr git_diff_binary): cint
  git_diff_hunk* {.bycopy.} = object
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
  git_diff_line* {.bycopy.} = object
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
  git_diff_similarity_metric* {.bycopy.} = object
    file_signature*: proc (arg_out: ptr pointer; file: ptr git_diff_file;
                           fullpath: cstring; payload: pointer): cint {.cdecl.}
    buffer_signature*: proc (arg_out: ptr pointer; file: ptr git_diff_file;
                             buf: cstring; buflen: size_t; payload: pointer): cint {.
        cdecl.}
    free_signature*: proc (sig: pointer; payload: pointer): void {.cdecl.}
    similarity*: proc (score: ptr cint; siga: pointer; sigb: pointer;
                       payload: pointer): cint {.cdecl.}
    payload*: pointer

  git_diff_find_options* {.bycopy.} = object
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
  git_diff_format_email_options* {.bycopy.} = object
    version*: cuint
    flags*: uint32           ## see `git_diff_format_email_flags_t` above 
    patch_no*: size_t        ## This patch number 
    total_patches*: size_t   ## Total number of patches in this series 
    id*: ptr git_oid         ## id to use for the commit 
    summary*: cstring        ## Summary of the change 
    body*: cstring           ## Commit message's body 
    author*: ptr git_signature ## Author of the change 
  
  git_diff_patchid_options* {.bycopy.} = object
    version*: cuint

  git_remote_create_flags* = enum
    GIT_REMOTE_CREATE_SKIP_INSTEADOF = 1, ## Ignore the repository apply.insteadOf configuration 
    GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 2 ## Don't build a fetchspec from the name if none is set 
  git_remote_create_options* {.bycopy.} = object
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
  git_push_update* {.bycopy.} = object
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
  git_remote_callbacks* {.bycopy.} = object
    version*: cuint
    sideband_progress*: git_transport_message_cb ## The version 
    completion*: proc (arg_type: git_remote_completion_t; data: pointer): cint {.
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
  git_fetch_options* {.bycopy.} = object
    version*: cint
    callbacks*: git_remote_callbacks
    prune*: git_fetch_prune_t
    update_fetchhead*: cint
    download_tags*: git_remote_autotag_option_t
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray

  git_push_options* {.bycopy.} = object
    version*: cuint
    pb_parallelism*: cuint
    callbacks*: git_remote_callbacks
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray

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
  git_time* {.bycopy.} = object
    ## Time in a signature 
    time*: git_time_t
    offset*: cint            ## time in seconds from epoch 
    sign*: char              ## timezone offset, in minutes 
  
  git_signature* {.bycopy.} = object
    ## indicator for questionable '-0000' offsets in signature 
                                     ## An action signature (e.g. for committers, taggers, etc) 
    name*: cstring
    email*: cstring          ## full name of the author 
    when_f* {.importc: "when".}: git_time ## email of the author 
  
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
  git_writestream* {.bycopy.} = object
    ## A type to write in a streaming fashion, for example, for filters. 
    write*: proc (stream: ptr git_writestream; buffer: cstring; len: size_t): cint {.
        cdecl.}
    close*: proc (stream: ptr git_writestream): cint {.cdecl.}
    free*: proc (stream: ptr git_writestream): void {.cdecl.}

  git_checkout_strategy_t* = enum
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
  git_checkout_perfdata* {.bycopy.} = object
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
  git_checkout_options* {.bycopy.} = object
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
  
  git_credential_t* = enum
    GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1, GIT_CREDENTIAL_SSH_KEY = 2,
    GIT_CREDENTIAL_SSH_CUSTOM = 4, GIT_CREDENTIAL_DEFAULT = 8,
    GIT_CREDENTIAL_SSH_INTERACTIVE = 16, GIT_CREDENTIAL_USERNAME = 32,
    GIT_CREDENTIAL_SSH_MEMORY = 64
  git_credential_default* = git_credential
  git_credential_acquire_cb* = proc (arg_out: ptr ptr git_credential;
                                     url: cstring; username_from_url: cstring;
                                     allowed_types: cuint; payload: pointer): cint {.
      cdecl.}
  git_credential_acquire_cbNim* = proc (arg_out: ptr ptr git_credential;
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
  git_clone_local_t* = enum
    GIT_CLONE_LOCAL_AUTO = 0, GIT_CLONE_LOCAL = 1, GIT_CLONE_NO_LOCAL = 2,
    GIT_CLONE_LOCAL_NO_LINKS = 3
  git_remote_create_cb* = proc (arg_out: ptr ptr git_remote;
                                repo: ptr git_repository; name: cstring;
                                url: cstring; payload: pointer): cint {.cdecl.}
  git_remote_create_cbNim* = proc (arg_out: ptr ptr git_remote;
                                   repo: ptr git_repository; name: cstring;
                                   url: cstring): cint
  git_repository_create_cb* = proc (arg_out: ptr ptr git_repository;
                                    path: cstring; bare: cint; payload: pointer): cint {.
      cdecl.}
  git_repository_create_cbNim* = proc (arg_out: ptr ptr git_repository;
                                       path: cstring; bare: cint): cint
  git_clone_options* {.bycopy.} = object
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

  git_attr_value_t* = enum
    GIT_ATTR_VALUE_UNSPECIFIED = 0, GIT_ATTR_VALUE_TRUE = 1, ## The attribute has been left unspecified 
    GIT_ATTR_VALUE_FALSE = 2, ## The attribute has been set 
    GIT_ATTR_VALUE_STRING = 3 ## The attribute has been unset 
  git_attr_foreach_cb* = proc (name: cstring; value: cstring; payload: pointer): cint {.
      cdecl.}
  git_attr_foreach_cbNim* = proc (name: cstring; value: cstring): cint
  git_proxy_t* = enum
    GIT_PROXY_NONE = 0, GIT_PROXY_AUTO = 1, GIT_PROXY_SPECIFIED = 2
  git_proxy_options* {.bycopy.} = object
    version*: cuint
    type_f* {.importc: "type".}: git_proxy_t
    url*: cstring
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    payload*: pointer

  git_cert_t* = enum
    GIT_CERT_NONE = 0, GIT_CERT_X509 = 1, GIT_CERT_HOSTKEY_LIBSSH2 = 2,
    GIT_CERT_STRARRAY = 3
  git_cert* {.bycopy.} = object
    cert_type*: git_cert_t

  git_transport_certificate_check_cb* = proc (cert: ptr git_cert; valid: cint;
      host: cstring; payload: pointer): cint {.cdecl.}
  git_transport_certificate_check_cbNim* = proc (cert: ptr git_cert;
      valid: cint; host: cstring): cint
  git_cert_ssh_t* = enum
    GIT_CERT_SSH_MD5 = 1,   ## MD5 is available 
    GIT_CERT_SSH_SHA1 = 2,  ## SHA-1 is available 
    GIT_CERT_SSH_SHA256 = 4  ## SHA-256 is available 
  git_cert_hostkey* {.bycopy.} = object
    parent*: git_cert
    type_f* {.importc: "type".}: git_cert_ssh_t ## The parent cert 
    hash_md5*: ptr UncheckedArray[uchar]
    hash_sha1*: ptr UncheckedArray[uchar]
    hash_sha256*: ptr UncheckedArray[uchar]

  git_cert_x509* {.bycopy.} = object
    parent*: git_cert
    data*: pointer           ## The parent cert 
    len*: size_t

  git_merge_file_input* {.bycopy.} = object
    version*: cuint
    ptr_f* {.importc: "ptr".}: cstring ## Pointer to the contents of the file. 
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
  git_merge_file_options* {.bycopy.} = object
    version*: cuint
    ancestor_label*: cstring
    our_label*: cstring
    their_label*: cstring
    favor*: git_merge_file_favor_t ## The file to favor in region conflicts. 
    flags*: uint32           ## see `git_merge_file_flag_t` above 
    marker_size*: cushort

  git_merge_file_result* {.bycopy.} = object
    automergeable*: cuint
    path*: cstring
    mode*: cuint             ## The mode that the resultant merge file should use.  
    ptr_f* {.importc: "ptr".}: cstring ## The contents of the merge. 
    len*: size_t             ## The length of the merge contents. 
  
  git_merge_options* {.bycopy.} = object
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
  git_odb_stream_t* = enum  ## Streaming mode
    GIT_STREAM_RDONLY = 2, GIT_STREAM_WRONLY = 4, GIT_STREAM_RW = 6
  git_odb_stream* {.bycopy.} = object
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

  git_odb_writepack* {.bycopy.} = object
    ## A stream to write a pack file to the ODB 
    backend*: ptr git_odb_backend
    append*: proc (writepack: ptr git_odb_writepack; data: pointer;
                   size: size_t; stats: ptr git_indexer_progress): cint {.cdecl.}
    commit*: proc (writepack: ptr git_odb_writepack;
                   stats: ptr git_indexer_progress): cint {.cdecl.}
    free*: proc (writepack: ptr git_odb_writepack): void {.cdecl.}

  git_indexer_progress* {.bycopy.} = object
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
  git_indexer_options* {.bycopy.} = object
    version*: cuint
    progress_cb*: git_indexer_progress_cb ## progress_cb function to call with progress information 
    progress_cb_payload*: pointer ## progress_cb_payload payload for the progress callback 
    verify*: uchar           ## Do connectivity checks for the received pack 
  
  git_apply_delta_cb* = proc (delta: ptr git_diff_delta; payload: pointer): cint {.
      cdecl.}
  git_apply_delta_cbNim* = proc (delta: ptr git_diff_delta): cint
  git_apply_hunk_cb* = proc (hunk: ptr git_diff_hunk; payload: pointer): cint {.
      cdecl.}
  git_apply_hunk_cbNim* = proc (hunk: ptr git_diff_hunk): cint
  git_apply_flags_t* = enum ## Flags controlling the behavior of git_apply
    GIT_APPLY_CHECK = 1
  git_apply_options* {.bycopy.} = object
    version*: cuint
    delta_cb*: git_apply_delta_cb ## The version 
                                  ## When applying a patch, callback that will be made per delta (file). 
    hunk_cb*: git_apply_hunk_cb ## When applying a patch, callback that will be made per hunk. 
    payload*: pointer        ## Payload passed to both delta_cb & hunk_cb. 
    flags*: cuint            ## Bitmask of git_apply_flags_t 
  
  git_apply_location_t* = enum ## Possible application locations for git_apply
    GIT_APPLY_LOCATION_WORKDIR = 0, GIT_APPLY_LOCATION_INDEX = 1,
    GIT_APPLY_LOCATION_BOTH = 2
  git_commit_signing_cb* = proc (signature: ptr git_buf;
                                 signature_field: ptr git_buf;
                                 commit_content: cstring; payload: pointer): cint {.
      cdecl.}
  git_commit_signing_cbNim* = proc (signature: ptr git_buf;
                                    signature_field: ptr git_buf;
                                    commit_content: cstring): cint
  git_packbuilder_stage_t* = enum
    GIT_PACKBUILDER_ADDING_OBJECTS = 0, GIT_PACKBUILDER_DELTAFICATION = 1
  git_packbuilder_foreach_cb* = proc (buf: pointer; size: size_t;
                                      payload: pointer): cint {.cdecl.}
  git_packbuilder_foreach_cbNim* = proc (buf: pointer; size: size_t): cint
  git_packbuilder_progress* = proc (stage: cint; current: uint32; total: uint32;
                                    payload: pointer): cint {.cdecl.}
  git_packbuilder_progressNim* = proc (stage: cint; current: uint32;
                                       total: uint32): cint
  git_transport_message_cb* = proc (str: cstring; len: cint; payload: pointer): cint {.
      cdecl.}
  git_transport_message_cbNim* = proc (str: cstring; len: cint): cint
  git_transport_cb* = proc (arg_out: ptr ptr git_transport;
                            owner: ptr git_remote; param: pointer): cint {.cdecl.}
  git_transport_cbNim* = proc (arg_out: ptr ptr git_transport;
                               owner: ptr git_remote): cint
  git_stash_flags* = enum
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
  git_stash_apply_options* {.bycopy.} = object
    version*: cuint
    flags*: uint32           ## See `git_stash_apply_flags`, above. 
    checkout_options*: git_checkout_options ## Options to use when writing files to the working directory. 
    progress_cb*: git_stash_apply_progress_cb ## Optional callback to notify the consumer of application progress. 
    progress_payload*: pointer

  git_stash_cb* = proc (index: size_t; message: cstring; stash_id: ptr git_oid;
                        payload: pointer): cint {.cdecl.}
  git_stash_cbNim* = proc (index: size_t; message: cstring;
                           stash_id: ptr git_oid): cint
  git_config_level_t* = enum
    GIT_CONFIG_LEVEL_PROGRAMDATA = 1, ## System-wide on Windows, for compatibility with portable git 
    GIT_CONFIG_LEVEL_SYSTEM = 2, ## System-wide configuration file; /etc/gitconfig on Linux systems 
    GIT_CONFIG_LEVEL_XDG = 3, ## XDG compatible configuration file; typically ~/.config/git/config 
    GIT_CONFIG_LEVEL_GLOBAL = 4, GIT_CONFIG_LEVEL_LOCAL = 5,
    GIT_CONFIG_LEVEL_APP = 6, GIT_CONFIG_HIGHEST_LEVEL = -1
  git_config_entry* {.bycopy.} = object
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
  git_configmap* {.bycopy.} = object
    type_f* {.importc: "type".}: git_configmap_t
    str_match*: cstring
    map_value*: cint

  git_index_time* {.bycopy.} = object
    ## Time structure used in a git index entry 
    seconds*: int32
    nanoseconds*: uint32     ## nsec should not be stored as time_t compatible 
  
  git_index_entry* {.bycopy.} = object
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
  git_trace_level_t* = enum
    GIT_TRACE_NONE = 0,     ## No tracing will be performed. 
    GIT_TRACE_FATAL = 1,    ## Severe errors that may impact the program's execution 
    GIT_TRACE_ERROR = 2,    ## Errors that do not impact the program's execution 
    GIT_TRACE_WARN = 3,     ## Warnings that suggest abnormal data 
    GIT_TRACE_INFO = 4,     ## Informational messages about program execution 
    GIT_TRACE_DEBUG = 5,    ## Detailed data that allows for debugging 
    GIT_TRACE_TRACE = 6      ## Exceptionally detailed debugging data 
  git_trace_cb* = proc (level: git_trace_level_t; msg: cstring): void {.cdecl.}
  git_direction* = enum
    GIT_DIRECTION_FETCH = 0, GIT_DIRECTION_PUSH = 1
  git_remote_head* {.bycopy.} = object
    local*: cint
    oid*: git_oid            ## available locally 
    loid*: git_oid
    name*: cstring
    symref_target*: cstring

  git_buf* {.bycopy.} = object
    ptr_f* {.importc: "ptr".}: cstring
    asize*: size_t
    size*: size_t

  git_message_trailer* {.bycopy.} = object
    key*: cstring
    value*: cstring

  git_message_trailer_array* {.bycopy.} = object
    trailers*: ptr git_message_trailer
    count*: size_t
    trailer_block* {.importc: "_trailer_block".}: cstring ## private 
  
  git_treebuilder_filter_cb* = proc (entry: ptr git_tree_entry; payload: pointer): cint {.
      cdecl.}
  git_treebuilder_filter_cbNim* = proc (entry: ptr git_tree_entry): cint
  git_treewalk_cb* = proc (root: cstring; entry: ptr git_tree_entry;
                           payload: pointer): cint {.cdecl.}
  git_treewalk_cbNim* = proc (root: cstring; entry: ptr git_tree_entry): cint
  git_treewalk_mode* = enum ## Callback for the tree traversal method 
                             ## Tree traversal modes
    GIT_TREEWALK_PRE = 0, GIT_TREEWALK_POST = 1 ## Pre-order 
  git_tree_update_t* = enum ## Post-order
    GIT_TREE_UPDATE_UPSERT = 0, ## Update or insert an entry at the specified path 
    GIT_TREE_UPDATE_REMOVE = 1 ## Remove an entry from the specified path 
  git_tree_update* {.bycopy.} = object
    action*: git_tree_update_t ## Update action. If it's an removal, only the path is looked at 
    id*: git_oid             ## The entry's id 
    filemode*: git_filemode_t ## The filemode/kind of object 
    path*: cstring           ## The full path from the root tree 
  
  git_oid* {.bycopy.} = object
    ## Size (in bytes) of a raw/binary oid 
                               ## Size (in bytes) of a hex formatted oid 
                               ## Unique identity of any object (commit, tree, blob, tag). 
    id*: ptr UncheckedArray[uchar] ## raw binary formatted id 
  
  git_rebase_options* {.bycopy.} = object
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
  git_rebase_operation* {.bycopy.} = object
    ## Indicates that a rebase operation is not (yet) in progress. 
    type_f* {.importc: "type".}: git_rebase_operation_t ## The type of rebase operation. 
    id*: git_oid
    exec*: cstring

  git_credential_userpass_payload* {.bycopy.} = object
    username*: cstring
    password*: cstring

  git_reset_t* = enum
    GIT_RESET_SOFT = 1, GIT_RESET_MIXED = 2, ## Move the head to the given commit 
    GIT_RESET_HARD = 3       ## SOFT plus reset index to the commit 
  git_repository_open_flag_t* = enum
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
  git_repository_init_options* {.bycopy.} = object
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
  git_filter_mode_t* = enum
    GIT_FILTER_TO_WORKTREE = 0, GIT_FILTER_TO_ODB = 1
  git_filter_flag_t* = enum
    GIT_FILTER_DEFAULT = 0, GIT_FILTER_ALLOW_UNSAFE = 1, ## Don't error for `safecrlf` violations, allow them to continue. 
    GIT_FILTER_NO_SYSTEM_ATTRIBUTES = 2, ## Don't load `/etc/gitattributes` (or the system equivalent) 
    GIT_FILTER_ATTRIBUTES_FROM_HEAD = 4 ## Load attributes from `.gitattributes` in the root of HEAD 
  git_reference_foreach_cb* = proc (reference: ptr git_reference;
                                    payload: pointer): cint {.cdecl.}
  git_reference_foreach_cbNim* = proc (reference: ptr git_reference): cint
  git_reference_foreach_name_cb* = proc (name: cstring; payload: pointer): cint {.
      cdecl.}
  git_reference_foreach_name_cbNim* = proc (name: cstring): cint
  git_reference_format_t* = enum
    GIT_REFERENCE_FORMAT_NORMAL = 0, GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL = 1,
    GIT_REFERENCE_FORMAT_REFSPEC_PATTERN = 2,
    GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 4
  git_note_foreach_cb* = proc (blob_id: ptr git_oid;
                               annotated_object_id: ptr git_oid;
                               payload: pointer): cint {.cdecl.}
  git_note_foreach_cbNim* = proc (blob_id: ptr git_oid;
                                  annotated_object_id: ptr git_oid): cint
  git_note_iterator* = git_iterator
  git_cherrypick_options* {.bycopy.} = object
    version*: cuint
    mainline*: cuint         ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
  
  git_worktree_add_options* {.bycopy.} = object
    version*: cuint
    lock*: cint
    ref_f* {.importc: "ref".}: ptr git_reference ## lock newly created worktree 
  
  git_worktree_prune_t* = enum ## reference to use for the new worktree HEAD
    GIT_WORKTREE_PRUNE_VALID = 1, ## Prune working tree even if working tree is valid 
    GIT_WORKTREE_PRUNE_LOCKED = 2, ## Prune working tree even if it is locked 
    GIT_WORKTREE_PRUNE_WORKING_TREE = 4 ## Prune checked out working tree 
  git_worktree_prune_options* {.bycopy.} = object
    version*: cuint
    flags*: uint32

  git_error_code* = enum    ## Generic return codes
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
  git_error* {.bycopy.} = object
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
  git_sort_t* = enum
    GIT_SORT_NONE = 0, GIT_SORT_TOPOLOGICAL = 1, GIT_SORT_TIME = 2,
    GIT_SORT_REVERSE = 4
  git_revwalk_hide_cb* = proc (commit_id: ptr git_oid; payload: pointer): cint {.
      cdecl.}
  git_revwalk_hide_cbNim* = proc (commit_id: ptr git_oid): cint
  git_describe_strategy_t* = enum
    GIT_DESCRIBE_DEFAULT = 0, GIT_DESCRIBE_TAGS = 1, GIT_DESCRIBE_ALL = 2
  git_describe_options* {.bycopy.} = object
    version*: cuint
    max_candidates_tags*: cuint
    describe_strategy*: cuint ## default: 10 
    pattern*: cstring        ## default: GIT_DESCRIBE_DEFAULT 
    only_follow_first_parent*: cint
    show_commit_oid_as_fallback*: cint

  git_describe_format_options* {.bycopy.} = object
    version*: cuint
    abbreviated_size*: cuint
    always_use_long_format*: cint
    dirty_suffix*: cstring

  git_odb_foreach_cb* = proc (id: ptr git_oid; payload: pointer): cint {.cdecl.}
  git_odb_foreach_cbNim* = proc (id: ptr git_oid): cint
  git_odb_expand_id* {.bycopy.} = object
    id*: git_oid             ## The object ID to expand 
    length*: cushort
    type_f* {.importc: "type".}: git_object_t

  git_revert_options* {.bycopy.} = object
    version*: cuint
    mainline*: cuint         ## For merge commits, the "mainline" is treated as the parent. 
    merge_opts*: git_merge_options
    checkout_opts*: git_checkout_options ## Options for the merging 
  
  git_blame_flag_t* = enum
    GIT_BLAME_NORMAL = 0,   ## Normal blame, the default 
    GIT_BLAME_TRACK_COPIES_SAME_FILE = 1,
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = 2,
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = 4,
    GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = 8, GIT_BLAME_FIRST_PARENT = 16,
    GIT_BLAME_USE_MAILMAP = 32, GIT_BLAME_IGNORE_WHITESPACE = 64 ## Ignore whitespace differences 
  git_blame_options* {.bycopy.} = object
    version*: cuint
    flags*: uint32           ## A combination of `git_blame_flag_t` 
    min_match_characters*: uint16
    newest_commit*: git_oid  ## The id of the newest commit to consider. The default is HEAD. 
    oldest_commit*: git_oid
    min_line*: size_t
    max_line*: size_t

  git_blame_hunk* {.bycopy.} = object
    lines_in_hunk*: size_t
    final_commit_id*: git_oid
    final_start_line_number*: size_t
    final_signature*: ptr git_signature
    orig_commit_id*: git_oid
    orig_path*: cstring
    orig_start_line_number*: size_t
    orig_signature*: ptr git_signature
    boundary*: char

  git_blob_filter_flag_t* = enum
    GIT_BLOB_FILTER_CHECK_FOR_BINARY = 1, ## When set, filters will not be applied to binary files. 
    GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES = 2,
    GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD = 4
  git_blob_filter_options* {.bycopy.} = object
    version*: cint
    flags*: uint32           ## Flags to control the filtering process, see `git_blob_filter_flag_t` above 
  
  git_tag_foreach_cb* = proc (name: cstring; oid: ptr git_oid; payload: pointer): cint {.
      cdecl.}
  git_tag_foreach_cbNim* = proc (name: cstring; oid: ptr git_oid): cint
  git_oidarray* {.bycopy.} = object
    ## Array of object ids 
    ids*: ptr git_oid
    count*: size_t

  git_submodule_status_t* = enum
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
  git_submodule_update_options* {.bycopy.} = object
    version*: cuint
    checkout_opts*: git_checkout_options
    fetch_opts*: git_fetch_options
    allow_fetch*: cint

  git_revparse_mode_t* = enum
    GIT_REVPARSE_SINGLE = 1, ## The spec targeted a single object. 
    GIT_REVPARSE_RANGE = 2, ## The spec targeted a range of commits. 
    GIT_REVPARSE_MERGE_BASE = 4 ## The spec used the '...' operator, which invokes special semantics. 
  git_revspec* {.bycopy.} = object
    from_f* {.importc: "from".}: ptr git_object ## The left element of the revspec; must be freed by the user 
    to*: ptr git_object      ## The right element of the revspec; must be freed by the user 
    flags*: cuint            ## The intent of the revspec (i.e. `git_revparse_mode_t` flags) 
  