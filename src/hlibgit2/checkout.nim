{.push warning[UnusedImport]:off.}

import
  ./diff,
  ./libgit2_config,
  ./strarray,
  ./types

type
  git_checkout_notify_cb* = proc(why: git_checkout_notify_t, path: cstring, baseline: ptr git_diff_file, target: ptr git_diff_file, workdir: ptr git_diff_file, payload: pointer): cint{.cdecl.}
   
  git_checkout_notify_cbNim* = proc(why: git_checkout_notify_t, path: cstring, baseline: ptr git_diff_file, target: ptr git_diff_file, workdir: ptr git_diff_file): cint
   
  git_checkout_notify_t* = enum
    GIT_CHECKOUT_NOTIFY_NONE = 0
    GIT_CHECKOUT_NOTIFY_CONFLICT = 1
    GIT_CHECKOUT_NOTIFY_DIRTY = 2
    GIT_CHECKOUT_NOTIFY_UPDATED = 4
    GIT_CHECKOUT_NOTIFY_UNTRACKED = 8
    GIT_CHECKOUT_NOTIFY_IGNORED = 16
   
  git_checkout_options* {.bycopy, header: "<git2/checkout.h>", importc.} = object
    ## Checkout notification callback function 
    ## Checkout progress notification function 
    ## Checkout perfdata notification function 
    version*: cuint
    checkout_strategy*: cuint ## The version 
    disable_filters*: cint ## default will be a safe checkout 
    dir_mode*: cuint ## don't apply filters like CRLF conversion 
    file_mode*: cuint ## default is 0755 
    file_open_flags*: cint ## default is 0644 or 0755 as dictated by blob 
    notify_flags*: cuint ## default is O_CREAT | O_TRUNC | O_WRONLY 
    notify_cb*: git_checkout_notify_cb ## see `git_checkout_notify_t` above 
    notify_payload*: pointer ## Payload passed to notify_cb 
    progress_cb*: git_checkout_progress_cb ## Optional callback to notify the consumer of checkout progress. 
    progress_payload*: pointer ## Payload passed to progress_cb 
    paths*: git_strarray
    baseline*: ptr git_tree
    baseline_index*: ptr git_index
    target_directory*: cstring
    ancestor_label*: cstring ## alternative checkout path to workdir 
    our_label*: cstring ## the name of the common ancestor side of conflicts 
    their_label*: cstring ## the name of the "our" side of conflicts 
    perfdata_cb*: git_checkout_perfdata_cb ## the name of the "their" side of conflicts 
                                           ## Optional callback to notify the consumer of performance data. 
    perfdata_payload*: pointer ## Payload passed to perfdata_cb 
   
  git_checkout_perfdata* {.bycopy, header: "<git2/checkout.h>", importc.} = object
    ## Checkout performance-reporting structure 
    mkdir_calls*: csize_t
    stat_calls*: csize_t
    chmod_calls*: csize_t
   
  git_checkout_perfdata_cb* = proc(perfdata: ptr git_checkout_perfdata, payload: pointer): void{.cdecl.}
   
  git_checkout_perfdata_cbNim* = proc(perfdata: ptr git_checkout_perfdata): void
   
  git_checkout_progress_cb* = proc(path: cstring, completed_steps: csize_t, total_steps: csize_t, payload: pointer): void{.cdecl.}
   
  git_checkout_progress_cbNim* = proc(path: cstring, completed_steps: csize_t, total_steps: csize_t): void
   
  git_checkout_strategy_t* = enum
    GIT_CHECKOUT_NONE = 0
    GIT_CHECKOUT_SAFE = 1 ## default is a dry run, no actual updates 
    GIT_CHECKOUT_FORCE = 2
    GIT_CHECKOUT_RECREATE_MISSING = 4 ## Allow checkout to recreate missing files 
    GIT_CHECKOUT_ALLOW_CONFLICTS = 16 ## Allow checkout to make safe updates even if conflicts are found 
    GIT_CHECKOUT_REMOVE_UNTRACKED = 32 ## Remove untracked files not in index (that are not ignored) 
    GIT_CHECKOUT_REMOVE_IGNORED = 64 ## Remove ignored files not in index 
    GIT_CHECKOUT_UPDATE_ONLY = 128 ## Only update existing files, don't create new ones 
    GIT_CHECKOUT_DONT_UPDATE_INDEX = 256
    GIT_CHECKOUT_NO_REFRESH = 512 ## Don't refresh index/config/etc before doing checkout 
    GIT_CHECKOUT_SKIP_UNMERGED = 1024 ## Allow checkout to skip unmerged files 
    GIT_CHECKOUT_USE_OURS = 2048 ## For unmerged files, checkout stage 2 from index 
    GIT_CHECKOUT_USE_THEIRS = 4096 ## For unmerged files, checkout stage 3 from index 
    GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = 8192 ## Treat pathspec as simple list of exact match file paths 
    GIT_CHECKOUT_UPDATE_SUBMODULES = 65536 ## Recursively checkout submodules with same options (NOT IMPLEMENTED) 
    GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 131072 ## Recursively checkout submodules if HEAD moved in super repo (NOT IMPLEMENTED) 
    GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = 262144 ## Ignore directories in use, they will be left empty 
    GIT_CHECKOUT_DONT_OVERWRITE_IGNORED = 524288 ## Don't overwrite ignored files that exist in the checkout target 
    GIT_CHECKOUT_CONFLICT_STYLE_MERGE = 1048576 ## Write normal merge files for conflicts 
    GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 = 2097152 ## Include common ancestor data in diff3 format files for conflicts 
    GIT_CHECKOUT_DONT_REMOVE_EXISTING = 4194304 ## Don't overwrite existing files or folders 
    GIT_CHECKOUT_DONT_WRITE_INDEX = 8388608 ## Normally checkout writes the index upon completion; this prevents that. 
   

proc git_checkout_options_init*(
    opts:    ptr git_checkout_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_checkout_head*(
    repo: ptr git_repository,
    opts: ptr git_checkout_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_checkout_index*(
    repo:  ptr git_repository,
    index: ptr git_index,
    opts:  ptr git_checkout_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_checkout_tree*(
    repo:    ptr git_repository,
    treeish: ptr git_object,
    opts:    ptr git_checkout_options
  ): cint {.dynlib: libgit2Dl, importc.}


