{.push warning[UnusedImport]:off.}

import
  ./diff,
  ./libgit2_config,
  ./strarray,
  ./types

type
  c_git_checkout_notify_t* {.size: sizeof(cint).} = enum
    c_GIT_CHECKOUT_NOTIFY_NONE      = 0 shl 0
    c_GIT_CHECKOUT_NOTIFY_CONFLICT  = 1 shl 0
    c_GIT_CHECKOUT_NOTIFY_DIRTY     = 1 shl 1
    c_GIT_CHECKOUT_NOTIFY_UPDATED   = 1 shl 2
    c_GIT_CHECKOUT_NOTIFY_UNTRACKED = 1 shl 3
    c_GIT_CHECKOUT_NOTIFY_IGNORED   = 1 shl 4

  c_git_checkout_strategy_t* {.size: sizeof(cint).} = enum
    c_GIT_CHECKOUT_NONE                         = 0 shl 0
    c_GIT_CHECKOUT_SAFE                         = 1 shl 0  ## default is a dry run, no actual updates
    c_GIT_CHECKOUT_FORCE                        = 1 shl 1
    c_GIT_CHECKOUT_RECREATE_MISSING             = 1 shl 2  ## Allow checkout to recreate missing files
    c_GIT_CHECKOUT_ALLOW_CONFLICTS              = 1 shl 4  ## Allow checkout to make safe updates even if conflicts are found
    c_GIT_CHECKOUT_REMOVE_UNTRACKED             = 1 shl 5  ## Remove untracked files not in index (that are not ignored)
    c_GIT_CHECKOUT_REMOVE_IGNORED               = 1 shl 6  ## Remove ignored files not in index
    c_GIT_CHECKOUT_UPDATE_ONLY                  = 1 shl 7  ## Only update existing files, don't create new ones
    c_GIT_CHECKOUT_DONT_UPDATE_INDEX            = 1 shl 8
    c_GIT_CHECKOUT_NO_REFRESH                   = 1 shl 9  ## Don't refresh index/config/etc before doing checkout
    c_GIT_CHECKOUT_SKIP_UNMERGED                = 1 shl 10 ## Allow checkout to skip unmerged files
    c_GIT_CHECKOUT_USE_OURS                     = 1 shl 11 ## For unmerged files, checkout stage 2 from index
    c_GIT_CHECKOUT_USE_THEIRS                   = 1 shl 12 ## For unmerged files, checkout stage 3 from index
    c_GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH       = 1 shl 13 ## Treat pathspec as simple list of exact match file paths
    c_GIT_CHECKOUT_UPDATE_SUBMODULES            = 1 shl 16 ## Recursively checkout submodules with same options (NOT IMPLEMENTED)
    c_GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 1 shl 17 ## Recursively checkout submodules if HEAD moved in super repo (NOT IMPLEMENTED)
    c_GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES      = 1 shl 18 ## Ignore directories in use, they will be left empty
    c_GIT_CHECKOUT_DONT_OVERWRITE_IGNORED       = 1 shl 19 ## Don't overwrite ignored files that exist in the checkout target
    c_GIT_CHECKOUT_CONFLICT_STYLE_MERGE         = 1 shl 20 ## Write normal merge files for conflicts
    c_GIT_CHECKOUT_CONFLICT_STYLE_DIFF3         = 1 shl 21 ## Include common ancestor data in diff3 format files for conflicts
    c_GIT_CHECKOUT_DONT_REMOVE_EXISTING         = 1 shl 22 ## Don't overwrite existing files or folders
    c_GIT_CHECKOUT_DONT_WRITE_INDEX             = 1 shl 23 ## Normally checkout writes the index upon completion; this prevents that.
    c_GIT_CHECKOUT_DRY_RUN                      = 1 shl 24

  git_checkout_notify_cb* = proc(why:      c_git_checkout_notify_t,
                                 path:     cstring,
                                 baseline: ptr git_diff_file,
                                 target:   ptr git_diff_file,
                                 workdir:  ptr git_diff_file,
                                 payload:  pointer): cint{.cdecl.}

  git_checkout_notify_t* {.size: sizeof(cint).} = enum
    GIT_CHECKOUT_NOTIFY_NONE
    GIT_CHECKOUT_NOTIFY_CONFLICT
    GIT_CHECKOUT_NOTIFY_DIRTY
    GIT_CHECKOUT_NOTIFY_UPDATED
    GIT_CHECKOUT_NOTIFY_UNTRACKED
    GIT_CHECKOUT_NOTIFY_IGNORED

  git_checkout_options* {.bycopy, header: "<git2/checkout.h>", importc.} = object
    ## Checkout notification callback function
    ## Checkout progress notification function
    ## Checkout perfdata notification function
    version*:           cuint
    checkout_strategy*: cuint                    ## The version
    disable_filters*:   cint                     ## default will be a safe checkout
    dir_mode*:          cuint                    ## don't apply filters like CRLF conversion
    file_mode*:         cuint                    ## default is 0755
    file_open_flags*:   cint                     ## default is 0644 or 0755 as dictated by blob
    notify_flags*:      cuint                    ## default is O_CREAT | O_TRUNC | O_WRONLY
    notify_cb*:         git_checkout_notify_cb   ## see `git_checkout_notify_t` above
    notify_payload*:    pointer                  ## Payload passed to notify_cb
    progress_cb*:       git_checkout_progress_cb ## Optional callback to notify the consumer of checkout progress.
    progress_payload*:  pointer                  ## Payload passed to progress_cb
    paths*:             git_strarray
    baseline*:          ptr git_tree
    baseline_index*:    ptr git_index
    target_directory*:  cstring
    ancestor_label*:    cstring                  ## alternative checkout path to workdir
    our_label*:         cstring                  ## the name of the common ancestor side of conflicts
    their_label*:       cstring                  ## the name of the "our" side of conflicts
    perfdata_cb*:       git_checkout_perfdata_cb ## the name of the "their" side of conflicts
                                                 ## Optional callback to notify the consumer of performance data.
    perfdata_payload*:  pointer                  ## Payload passed to perfdata_cb

  git_checkout_perfdata* {.bycopy, header: "<git2/checkout.h>", importc.} = object
    ## Checkout performance-reporting structure
    mkdir_calls*: csize_t
    stat_calls*:  csize_t
    chmod_calls*: csize_t

  git_checkout_perfdata_cb* = proc(perfdata: ptr git_checkout_perfdata,
                                   payload:  pointer): void{.cdecl.}

  git_checkout_progress_cb* = proc(path:            cstring,
                                   completed_steps: csize_t,
                                   total_steps:     csize_t,
                                   payload:         pointer): void{.cdecl.}

  git_checkout_strategy_t* {.size: sizeof(cint).} = enum
    GIT_CHECKOUT_NONE
    GIT_CHECKOUT_SAFE                         ## default is a dry run, no actual updates
    GIT_CHECKOUT_FORCE
    GIT_CHECKOUT_RECREATE_MISSING             ## Allow checkout to recreate missing files
    GIT_CHECKOUT_ALLOW_CONFLICTS              ## Allow checkout to make safe updates even if conflicts are found
    GIT_CHECKOUT_REMOVE_UNTRACKED             ## Remove untracked files not in index (that are not ignored)
    GIT_CHECKOUT_REMOVE_IGNORED               ## Remove ignored files not in index
    GIT_CHECKOUT_UPDATE_ONLY                  ## Only update existing files, don't create new ones
    GIT_CHECKOUT_DONT_UPDATE_INDEX
    GIT_CHECKOUT_NO_REFRESH                   ## Don't refresh index/config/etc before doing checkout
    GIT_CHECKOUT_SKIP_UNMERGED                ## Allow checkout to skip unmerged files
    GIT_CHECKOUT_USE_OURS                     ## For unmerged files, checkout stage 2 from index
    GIT_CHECKOUT_USE_THEIRS                   ## For unmerged files, checkout stage 3 from index
    GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH       ## Treat pathspec as simple list of exact match file paths
    GIT_CHECKOUT_UPDATE_SUBMODULES            ## Recursively checkout submodules with same options (NOT IMPLEMENTED)
    GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED ## Recursively checkout submodules if HEAD moved in super repo (NOT IMPLEMENTED)
    GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES      ## Ignore directories in use, they will be left empty
    GIT_CHECKOUT_DONT_OVERWRITE_IGNORED       ## Don't overwrite ignored files that exist in the checkout target
    GIT_CHECKOUT_CONFLICT_STYLE_MERGE         ## Write normal merge files for conflicts
    GIT_CHECKOUT_CONFLICT_STYLE_DIFF3         ## Include common ancestor data in diff3 format files for conflicts
    GIT_CHECKOUT_DONT_REMOVE_EXISTING         ## Don't overwrite existing files or folders
    GIT_CHECKOUT_DONT_WRITE_INDEX             ## Normally checkout writes the index upon completion; this prevents that.
    GIT_CHECKOUT_DRY_RUN


proc to_c_git_checkout_strategy_t*(
    arg: git_checkout_strategy_t
  ): c_git_checkout_strategy_t =
  case arg:
    of GIT_CHECKOUT_NONE:                         c_GIT_CHECKOUT_NONE
    of GIT_CHECKOUT_SAFE:                         c_GIT_CHECKOUT_SAFE
    of GIT_CHECKOUT_FORCE:                        c_GIT_CHECKOUT_FORCE
    of GIT_CHECKOUT_RECREATE_MISSING:             c_GIT_CHECKOUT_RECREATE_MISSING
    of GIT_CHECKOUT_ALLOW_CONFLICTS:              c_GIT_CHECKOUT_ALLOW_CONFLICTS
    of GIT_CHECKOUT_REMOVE_UNTRACKED:             c_GIT_CHECKOUT_REMOVE_UNTRACKED
    of GIT_CHECKOUT_REMOVE_IGNORED:               c_GIT_CHECKOUT_REMOVE_IGNORED
    of GIT_CHECKOUT_UPDATE_ONLY:                  c_GIT_CHECKOUT_UPDATE_ONLY
    of GIT_CHECKOUT_DONT_UPDATE_INDEX:            c_GIT_CHECKOUT_DONT_UPDATE_INDEX
    of GIT_CHECKOUT_NO_REFRESH:                   c_GIT_CHECKOUT_NO_REFRESH
    of GIT_CHECKOUT_SKIP_UNMERGED:                c_GIT_CHECKOUT_SKIP_UNMERGED
    of GIT_CHECKOUT_USE_OURS:                     c_GIT_CHECKOUT_USE_OURS
    of GIT_CHECKOUT_USE_THEIRS:                   c_GIT_CHECKOUT_USE_THEIRS
    of GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH:       c_GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH
    of GIT_CHECKOUT_UPDATE_SUBMODULES:            c_GIT_CHECKOUT_UPDATE_SUBMODULES
    of GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED: c_GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED
    of GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES:      c_GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES
    of GIT_CHECKOUT_DONT_OVERWRITE_IGNORED:       c_GIT_CHECKOUT_DONT_OVERWRITE_IGNORED
    of GIT_CHECKOUT_CONFLICT_STYLE_MERGE:         c_GIT_CHECKOUT_CONFLICT_STYLE_MERGE
    of GIT_CHECKOUT_CONFLICT_STYLE_DIFF3:         c_GIT_CHECKOUT_CONFLICT_STYLE_DIFF3
    of GIT_CHECKOUT_DONT_REMOVE_EXISTING:         c_GIT_CHECKOUT_DONT_REMOVE_EXISTING
    of GIT_CHECKOUT_DONT_WRITE_INDEX:             c_GIT_CHECKOUT_DONT_WRITE_INDEX
    of GIT_CHECKOUT_DRY_RUN:                      c_GIT_CHECKOUT_DRY_RUN


converter to_git_checkout_strategy_t*(
    arg: c_git_checkout_strategy_t
  ): git_checkout_strategy_t =
  case arg:
    of c_GIT_CHECKOUT_NONE:                         GIT_CHECKOUT_NONE
    of c_GIT_CHECKOUT_SAFE:                         GIT_CHECKOUT_SAFE
    of c_GIT_CHECKOUT_FORCE:                        GIT_CHECKOUT_FORCE
    of c_GIT_CHECKOUT_RECREATE_MISSING:             GIT_CHECKOUT_RECREATE_MISSING
    of c_GIT_CHECKOUT_ALLOW_CONFLICTS:              GIT_CHECKOUT_ALLOW_CONFLICTS
    of c_GIT_CHECKOUT_REMOVE_UNTRACKED:             GIT_CHECKOUT_REMOVE_UNTRACKED
    of c_GIT_CHECKOUT_REMOVE_IGNORED:               GIT_CHECKOUT_REMOVE_IGNORED
    of c_GIT_CHECKOUT_UPDATE_ONLY:                  GIT_CHECKOUT_UPDATE_ONLY
    of c_GIT_CHECKOUT_DONT_UPDATE_INDEX:            GIT_CHECKOUT_DONT_UPDATE_INDEX
    of c_GIT_CHECKOUT_NO_REFRESH:                   GIT_CHECKOUT_NO_REFRESH
    of c_GIT_CHECKOUT_SKIP_UNMERGED:                GIT_CHECKOUT_SKIP_UNMERGED
    of c_GIT_CHECKOUT_USE_OURS:                     GIT_CHECKOUT_USE_OURS
    of c_GIT_CHECKOUT_USE_THEIRS:                   GIT_CHECKOUT_USE_THEIRS
    of c_GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH:       GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH
    of c_GIT_CHECKOUT_UPDATE_SUBMODULES:            GIT_CHECKOUT_UPDATE_SUBMODULES
    of c_GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED: GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED
    of c_GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES:      GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES
    of c_GIT_CHECKOUT_DONT_OVERWRITE_IGNORED:       GIT_CHECKOUT_DONT_OVERWRITE_IGNORED
    of c_GIT_CHECKOUT_CONFLICT_STYLE_MERGE:         GIT_CHECKOUT_CONFLICT_STYLE_MERGE
    of c_GIT_CHECKOUT_CONFLICT_STYLE_DIFF3:         GIT_CHECKOUT_CONFLICT_STYLE_DIFF3
    of c_GIT_CHECKOUT_DONT_REMOVE_EXISTING:         GIT_CHECKOUT_DONT_REMOVE_EXISTING
    of c_GIT_CHECKOUT_DONT_WRITE_INDEX:             GIT_CHECKOUT_DONT_WRITE_INDEX
    of c_GIT_CHECKOUT_DRY_RUN:                      GIT_CHECKOUT_DRY_RUN


converter toCint*(arg: c_git_checkout_strategy_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_checkout_strategy_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_checkout_strategy_t(arg)))

func `+`*(
    arg:    c_git_checkout_strategy_t,
    offset: int
  ): c_git_checkout_strategy_t =
  cast[c_git_checkout_strategy_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_checkout_strategy_t
  ): c_git_checkout_strategy_t =
  cast[c_git_checkout_strategy_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_checkout_strategy_t,
    offset: int
  ): c_git_checkout_strategy_t =
  cast[c_git_checkout_strategy_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_checkout_strategy_t
  ): c_git_checkout_strategy_t =
  cast[c_git_checkout_strategy_t](ord(arg) - offset)


converter toCint*(args: set[git_checkout_strategy_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_CHECKOUT_NONE:                         result = cint(result or (0 shl 0))
      of GIT_CHECKOUT_SAFE:                         result = cint(result or (1 shl 0))
      of GIT_CHECKOUT_FORCE:                        result = cint(result or (1 shl 1))
      of GIT_CHECKOUT_RECREATE_MISSING:             result = cint(result or (1 shl 2))
      of GIT_CHECKOUT_ALLOW_CONFLICTS:              result = cint(result or (1 shl 4))
      of GIT_CHECKOUT_REMOVE_UNTRACKED:             result = cint(result or (1 shl 5))
      of GIT_CHECKOUT_REMOVE_IGNORED:               result = cint(result or (1 shl 6))
      of GIT_CHECKOUT_UPDATE_ONLY:                  result = cint(result or (1 shl 7))
      of GIT_CHECKOUT_DONT_UPDATE_INDEX:            result = cint(result or (1 shl 8))
      of GIT_CHECKOUT_NO_REFRESH:                   result = cint(result or (1 shl 9))
      of GIT_CHECKOUT_SKIP_UNMERGED:                result = cint(result or (1 shl 10))
      of GIT_CHECKOUT_USE_OURS:                     result = cint(result or (1 shl 11))
      of GIT_CHECKOUT_USE_THEIRS:                   result = cint(result or (1 shl 12))
      of GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH:       result = cint(result or (1 shl 13))
      of GIT_CHECKOUT_UPDATE_SUBMODULES:            result = cint(result or (1 shl 16))
      of GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED: result = cint(result or (1 shl 17))
      of GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES:      result = cint(result or (1 shl 18))
      of GIT_CHECKOUT_DONT_OVERWRITE_IGNORED:       result = cint(result or (1 shl 19))
      of GIT_CHECKOUT_CONFLICT_STYLE_MERGE:         result = cint(result or (1 shl 20))
      of GIT_CHECKOUT_CONFLICT_STYLE_DIFF3:         result = cint(result or (1 shl 21))
      of GIT_CHECKOUT_DONT_REMOVE_EXISTING:         result = cint(result or (1 shl 22))
      of GIT_CHECKOUT_DONT_WRITE_INDEX:             result = cint(result or (1 shl 23))
      of GIT_CHECKOUT_DRY_RUN:                      result = cint(result or (1 shl 24))


proc to_c_git_checkout_notify_t*(
    arg: git_checkout_notify_t
  ): c_git_checkout_notify_t =
  case arg:
    of GIT_CHECKOUT_NOTIFY_NONE:      c_GIT_CHECKOUT_NOTIFY_NONE
    of GIT_CHECKOUT_NOTIFY_CONFLICT:  c_GIT_CHECKOUT_NOTIFY_CONFLICT
    of GIT_CHECKOUT_NOTIFY_DIRTY:     c_GIT_CHECKOUT_NOTIFY_DIRTY
    of GIT_CHECKOUT_NOTIFY_UPDATED:   c_GIT_CHECKOUT_NOTIFY_UPDATED
    of GIT_CHECKOUT_NOTIFY_UNTRACKED: c_GIT_CHECKOUT_NOTIFY_UNTRACKED
    of GIT_CHECKOUT_NOTIFY_IGNORED:   c_GIT_CHECKOUT_NOTIFY_IGNORED


converter to_git_checkout_notify_t*(
    arg: c_git_checkout_notify_t
  ): git_checkout_notify_t =
  case arg:
    of c_GIT_CHECKOUT_NOTIFY_NONE:      GIT_CHECKOUT_NOTIFY_NONE
    of c_GIT_CHECKOUT_NOTIFY_CONFLICT:  GIT_CHECKOUT_NOTIFY_CONFLICT
    of c_GIT_CHECKOUT_NOTIFY_DIRTY:     GIT_CHECKOUT_NOTIFY_DIRTY
    of c_GIT_CHECKOUT_NOTIFY_UPDATED:   GIT_CHECKOUT_NOTIFY_UPDATED
    of c_GIT_CHECKOUT_NOTIFY_UNTRACKED: GIT_CHECKOUT_NOTIFY_UNTRACKED
    of c_GIT_CHECKOUT_NOTIFY_IGNORED:   GIT_CHECKOUT_NOTIFY_IGNORED


converter toCint*(arg: c_git_checkout_notify_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_checkout_notify_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_checkout_notify_t(arg)))

func `+`*(arg: c_git_checkout_notify_t, offset: int): c_git_checkout_notify_t =
  cast[c_git_checkout_notify_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_checkout_notify_t): c_git_checkout_notify_t =
  cast[c_git_checkout_notify_t](ord(arg) + offset)

func `-`*(arg: c_git_checkout_notify_t, offset: int): c_git_checkout_notify_t =
  cast[c_git_checkout_notify_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_checkout_notify_t): c_git_checkout_notify_t =
  cast[c_git_checkout_notify_t](ord(arg) - offset)


converter toCint*(args: set[git_checkout_notify_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_CHECKOUT_NOTIFY_NONE:      result = cint(result or (0 shl 0))
      of GIT_CHECKOUT_NOTIFY_CONFLICT:  result = cint(result or (1 shl 0))
      of GIT_CHECKOUT_NOTIFY_DIRTY:     result = cint(result or (1 shl 1))
      of GIT_CHECKOUT_NOTIFY_UPDATED:   result = cint(result or (1 shl 2))
      of GIT_CHECKOUT_NOTIFY_UNTRACKED: result = cint(result or (1 shl 3))
      of GIT_CHECKOUT_NOTIFY_IGNORED:   result = cint(result or (1 shl 4))


proc git_checkout_options_init*(
    opts:    ptr git_checkout_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_checkout_head*(
    repo: ptr git_repository,
    opts: ptr git_checkout_options
  ): cint {.git2Proc, importc.}



proc git_checkout_index*(
    repo:  ptr git_repository,
    index: ptr git_index,
    opts:  ptr git_checkout_options
  ): cint {.git2Proc, importc.}



proc git_checkout_tree*(
    repo:    ptr git_repository,
    treeish: ptr git_object,
    opts:    ptr git_checkout_options
  ): cint {.git2Proc, importc.}



