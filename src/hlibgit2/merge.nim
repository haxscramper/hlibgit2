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
  git_merge_analysis_t* = enum
    GIT_MERGE_ANALYSIS_NONE = 0 ## No merge is possible.  (Unused.) 
    GIT_MERGE_ANALYSIS_NORMAL = 1
    GIT_MERGE_ANALYSIS_UP_TO_DATE = 2
    GIT_MERGE_ANALYSIS_FASTFORWARD = 4
    GIT_MERGE_ANALYSIS_UNBORN = 8
   
  git_merge_file_favor_t* = enum
    GIT_MERGE_FILE_FAVOR_NORMAL = 0
    GIT_MERGE_FILE_FAVOR_OURS = 1
    GIT_MERGE_FILE_FAVOR_THEIRS = 2
    GIT_MERGE_FILE_FAVOR_UNION = 3
   
  git_merge_file_flag_t* = enum
    GIT_MERGE_FILE_DEFAULT = 0 ## Defaults 
    GIT_MERGE_FILE_STYLE_MERGE = 1 ## Create standard conflicted merge files 
    GIT_MERGE_FILE_STYLE_DIFF3 = 2 ## Create diff3-style files 
    GIT_MERGE_FILE_SIMPLIFY_ALNUM = 4 ## Condense non-alphanumeric regions for simplified diff file 
    GIT_MERGE_FILE_IGNORE_WHITESPACE = 8 ## Ignore all whitespace 
    GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = 16 ## Ignore changes in amount of whitespace 
    GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL = 32 ## Ignore whitespace at end of line 
    GIT_MERGE_FILE_DIFF_PATIENCE = 64 ## Use the "patience diff" algorithm 
    GIT_MERGE_FILE_DIFF_MINIMAL = 128 ## Take extra time to find minimal diff 
   
  git_merge_file_input* {.bycopy, header: "<git2/merge.h>", importc.} = object
    version*: cuint
    ptr_f* {.importc: "ptr".}: cstring ## Pointer to the contents of the file. 
    size*: csize_t ## Size of the contents pointed to in `ptr`. 
    path*: cstring ## File name of the conflicted file, or `NULL` to not merge the path. 
    mode*: cuint ## File mode of the conflicted file, or `0` to not merge the mode. 
   
  git_merge_file_options* {.bycopy, header: "<git2/merge.h>", importc.} = object
    version*: cuint
    ancestor_label*: cstring
    our_label*: cstring
    their_label*: cstring
    favor*: git_merge_file_favor_t ## The file to favor in region conflicts. 
    flags*: uint32 ## see `git_merge_file_flag_t` above 
    marker_size*: cushort
   
  git_merge_file_result* {.bycopy, header: "<git2/merge.h>", importc.} = object
    automergeable*: cuint
    path*: cstring
    mode*: cuint ## The mode that the resultant merge file should use.  
    ptr_f* {.importc: "ptr".}: cstring ## The contents of the merge. 
    len*: csize_t ## The length of the merge contents. 
   
  git_merge_flag_t* = enum
    GIT_MERGE_FIND_RENAMES = 1
    GIT_MERGE_FAIL_ON_CONFLICT = 2
    GIT_MERGE_SKIP_REUC = 4
    GIT_MERGE_NO_RECURSIVE = 8
   
  git_merge_options* {.bycopy, header: "<git2/merge.h>", importc.} = object
    version*: cuint
    flags*: uint32 ## See `git_merge_flag_t` above 
    rename_threshold*: cuint
    target_limit*: cuint
    metric*: ptr git_diff_similarity_metric ## Pluggable similarity metric; pass NULL to use internal metric 
    recursion_limit*: cuint
    default_driver*: cstring
    file_favor*: git_merge_file_favor_t
    file_flags*: uint32 ## see `git_merge_file_flag_t` above 
   
  git_merge_preference_t* = enum
    GIT_MERGE_PREFERENCE_NONE = 0
    GIT_MERGE_PREFERENCE_NO_FASTFORWARD = 1
    GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = 2
   

proc git_merge_file_input_init*(
    opts:    ptr git_merge_file_input,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_file_options_init*(
    opts:    ptr git_merge_file_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_options_init*(
    opts:    ptr git_merge_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_analysis*(
    analysis_out:    ptr git_merge_analysis_t,
    preference_out:  ptr git_merge_preference_t,
    repo:            ptr git_repository,
    their_heads:     ptr ptr git_annotated_commit,
    their_heads_len: csize_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_analysis_for_ref*(
    analysis_out:    ptr git_merge_analysis_t,
    preference_out:  ptr git_merge_preference_t,
    repo:            ptr git_repository,
    our_ref:         ptr git_reference,
    their_heads:     ptr ptr git_annotated_commit,
    their_heads_len: csize_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_base*(
    arg_out: ptr git_oid,
    repo:    ptr git_repository,
    one:     ptr git_oid,
    two:     ptr git_oid
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_bases*(
    arg_out: ptr git_oidarray,
    repo:    ptr git_repository,
    one:     ptr git_oid,
    two:     ptr git_oid
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_base_many*(
    arg_out:     ptr git_oid,
    repo:        ptr git_repository,
    length:      csize_t,
    input_array: ptr UncheckedArray[git_oid]
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_bases_many*(
    arg_out:     ptr git_oidarray,
    repo:        ptr git_repository,
    length:      csize_t,
    input_array: ptr UncheckedArray[git_oid]
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_base_octopus*(
    arg_out:     ptr git_oid,
    repo:        ptr git_repository,
    length:      csize_t,
    input_array: ptr UncheckedArray[git_oid]
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_file*(
    arg_out:  ptr git_merge_file_result,
    ancestor: ptr git_merge_file_input,
    ours:     ptr git_merge_file_input,
    theirs:   ptr git_merge_file_input,
    opts:     ptr git_merge_file_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_file_from_index*(
    arg_out:  ptr git_merge_file_result,
    repo:     ptr git_repository,
    ancestor: ptr git_index_entry,
    ours:     ptr git_index_entry,
    theirs:   ptr git_index_entry,
    opts:     ptr git_merge_file_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_file_result_free*(
    result: ptr git_merge_file_result
  ): void {.dynlib: libgit2Dl, importc.}


proc git_merge_trees*(
    arg_out:       ptr ptr git_index,
    repo:          ptr git_repository,
    ancestor_tree: ptr git_tree,
    our_tree:      ptr git_tree,
    their_tree:    ptr git_tree,
    opts:          ptr git_merge_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge_commits*(
    arg_out:      ptr ptr git_index,
    repo:         ptr git_repository,
    our_commit:   ptr git_commit,
    their_commit: ptr git_commit,
    opts:         ptr git_merge_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_merge*(
    repo:            ptr git_repository,
    their_heads:     ptr ptr git_annotated_commit,
    their_heads_len: csize_t,
    merge_opts:      ptr git_merge_options,
    checkout_opts:   ptr git_checkout_options
  ): cint {.dynlib: libgit2Dl, importc.}


