{.push warning[UnusedImport]:off.}

import
  ./checkout,
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_stash_apply_flags* {.size: sizeof(cint).} = enum
    c_GIT_STASH_APPLY_DEFAULT         = 0 shl 0
    c_GIT_STASH_APPLY_REINSTATE_INDEX = 1 shl 0

  c_git_stash_apply_progress_t* {.size: sizeof(cint).} = enum
    c_GIT_STASH_APPLY_PROGRESS_NONE               = 0
    c_GIT_STASH_APPLY_PROGRESS_LOADING_STASH      = 1 ## Loading the stashed data from the object database.
    c_GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX      = 2 ## The stored index is being analyzed.
    c_GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED   = 3 ## The modified files are being analyzed.
    c_GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED  = 4 ## The untracked and ignored files are being analyzed.
    c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = 5 ## The untracked files are being written to disk.
    c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED  = 6 ## The modified files are being written to disk.
    c_GIT_STASH_APPLY_PROGRESS_DONE               = 7 ## The stash was applied successfully.

  c_git_stash_flags* {.size: sizeof(cint).} = enum
    c_GIT_STASH_DEFAULT           = 0 shl 0
    c_GIT_STASH_KEEP_INDEX        = 1 shl 0
    c_GIT_STASH_INCLUDE_UNTRACKED = 1 shl 1
    c_GIT_STASH_INCLUDE_IGNORED   = 1 shl 2

  git_stash_apply_flags* {.size: sizeof(cint).} = enum
    GIT_STASH_APPLY_DEFAULT
    GIT_STASH_APPLY_REINSTATE_INDEX

  git_stash_apply_options* {.bycopy, header: "<git2/stash.h>", importc.} = object
    version*:          cuint
    flags*:            uint32                      ## See `git_stash_apply_flags`, above.
    checkout_options*: git_checkout_options        ## Options to use when writing files to the working directory.
    progress_cb*:      git_stash_apply_progress_cb ## Optional callback to notify the consumer of application progress.
    progress_payload*: pointer

  git_stash_apply_progress_cb* = proc(progress: c_git_stash_apply_progress_t,
                                      payload:  pointer): cint{.cdecl.}

  git_stash_apply_progress_t* = enum
    GIT_STASH_APPLY_PROGRESS_NONE
    GIT_STASH_APPLY_PROGRESS_LOADING_STASH      ## Loading the stashed data from the object database.
    GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX      ## The stored index is being analyzed.
    GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED   ## The modified files are being analyzed.
    GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED  ## The untracked and ignored files are being analyzed.
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED ## The untracked files are being written to disk.
    GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED  ## The modified files are being written to disk.
    GIT_STASH_APPLY_PROGRESS_DONE               ## The stash was applied successfully.

  git_stash_cb* = proc(index:    csize_t,
                       message:  cstring,
                       stash_id: ptr git_oid,
                       payload:  pointer): cint{.cdecl.}

  git_stash_flags* {.size: sizeof(cint).} = enum
    GIT_STASH_DEFAULT
    GIT_STASH_KEEP_INDEX
    GIT_STASH_INCLUDE_UNTRACKED
    GIT_STASH_INCLUDE_IGNORED


proc to_c_git_stash_flags*(arg: git_stash_flags): c_git_stash_flags =
  case arg:
    of GIT_STASH_DEFAULT:           c_GIT_STASH_DEFAULT
    of GIT_STASH_KEEP_INDEX:        c_GIT_STASH_KEEP_INDEX
    of GIT_STASH_INCLUDE_UNTRACKED: c_GIT_STASH_INCLUDE_UNTRACKED
    of GIT_STASH_INCLUDE_IGNORED:   c_GIT_STASH_INCLUDE_IGNORED


converter to_git_stash_flags*(arg: c_git_stash_flags): git_stash_flags =
  case arg:
    of c_GIT_STASH_DEFAULT:           GIT_STASH_DEFAULT
    of c_GIT_STASH_KEEP_INDEX:        GIT_STASH_KEEP_INDEX
    of c_GIT_STASH_INCLUDE_UNTRACKED: GIT_STASH_INCLUDE_UNTRACKED
    of c_GIT_STASH_INCLUDE_IGNORED:   GIT_STASH_INCLUDE_IGNORED


converter toCint*(arg: c_git_stash_flags): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_stash_flags): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_stash_flags(arg)))

func `+`*(arg: c_git_stash_flags, offset: int): c_git_stash_flags =
  cast[c_git_stash_flags](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_stash_flags): c_git_stash_flags =
  cast[c_git_stash_flags](ord(arg) + offset)

func `-`*(arg: c_git_stash_flags, offset: int): c_git_stash_flags =
  cast[c_git_stash_flags](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_stash_flags): c_git_stash_flags =
  cast[c_git_stash_flags](ord(arg) - offset)


converter toCint*(args: set[git_stash_flags]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_STASH_DEFAULT:           result = cint(result or (0 shl 0))
      of GIT_STASH_KEEP_INDEX:        result = cint(result or (1 shl 0))
      of GIT_STASH_INCLUDE_UNTRACKED: result = cint(result or (1 shl 1))
      of GIT_STASH_INCLUDE_IGNORED:   result = cint(result or (1 shl 2))


proc git_stash_save*(
    arg_out: ptr git_oid,
    repo:    ptr git_repository,
    stasher: ptr git_signature,
    message: cstring,
    flags:   uint32
  ): cint {.git2Proc, importc.}



proc to_c_git_stash_apply_flags*(
    arg: git_stash_apply_flags
  ): c_git_stash_apply_flags =
  case arg:
    of GIT_STASH_APPLY_DEFAULT:         c_GIT_STASH_APPLY_DEFAULT
    of GIT_STASH_APPLY_REINSTATE_INDEX: c_GIT_STASH_APPLY_REINSTATE_INDEX


converter to_git_stash_apply_flags*(
    arg: c_git_stash_apply_flags
  ): git_stash_apply_flags =
  case arg:
    of c_GIT_STASH_APPLY_DEFAULT:         GIT_STASH_APPLY_DEFAULT
    of c_GIT_STASH_APPLY_REINSTATE_INDEX: GIT_STASH_APPLY_REINSTATE_INDEX


converter toCint*(arg: c_git_stash_apply_flags): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_stash_apply_flags): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_stash_apply_flags(arg)))

func `+`*(arg: c_git_stash_apply_flags, offset: int): c_git_stash_apply_flags =
  cast[c_git_stash_apply_flags](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_stash_apply_flags): c_git_stash_apply_flags =
  cast[c_git_stash_apply_flags](ord(arg) + offset)

func `-`*(arg: c_git_stash_apply_flags, offset: int): c_git_stash_apply_flags =
  cast[c_git_stash_apply_flags](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_stash_apply_flags): c_git_stash_apply_flags =
  cast[c_git_stash_apply_flags](ord(arg) - offset)


converter toCint*(args: set[git_stash_apply_flags]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_STASH_APPLY_DEFAULT:         result = cint(result or (0 shl 0))
      of GIT_STASH_APPLY_REINSTATE_INDEX: result = cint(result or (1 shl 0))


proc to_c_git_stash_apply_progress_t*(
    arg: git_stash_apply_progress_t
  ): c_git_stash_apply_progress_t =
  case arg:
    of GIT_STASH_APPLY_PROGRESS_NONE:               c_GIT_STASH_APPLY_PROGRESS_NONE
    of GIT_STASH_APPLY_PROGRESS_LOADING_STASH:      c_GIT_STASH_APPLY_PROGRESS_LOADING_STASH
    of GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX:      c_GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX
    of GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED:   c_GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED
    of GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED:  c_GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED
    of GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED: c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED
    of GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED:  c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED
    of GIT_STASH_APPLY_PROGRESS_DONE:               c_GIT_STASH_APPLY_PROGRESS_DONE


converter to_git_stash_apply_progress_t*(
    arg: c_git_stash_apply_progress_t
  ): git_stash_apply_progress_t =
  case arg:
    of c_GIT_STASH_APPLY_PROGRESS_NONE:               GIT_STASH_APPLY_PROGRESS_NONE
    of c_GIT_STASH_APPLY_PROGRESS_LOADING_STASH:      GIT_STASH_APPLY_PROGRESS_LOADING_STASH
    of c_GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX:      GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX
    of c_GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED:   GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED
    of c_GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED:  GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED
    of c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED: GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED
    of c_GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED:  GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED
    of c_GIT_STASH_APPLY_PROGRESS_DONE:               GIT_STASH_APPLY_PROGRESS_DONE


converter toCint*(arg: c_git_stash_apply_progress_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_stash_apply_progress_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_stash_apply_progress_t(arg)))

func `+`*(
    arg:    c_git_stash_apply_progress_t,
    offset: int
  ): c_git_stash_apply_progress_t =
  cast[c_git_stash_apply_progress_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_stash_apply_progress_t
  ): c_git_stash_apply_progress_t =
  cast[c_git_stash_apply_progress_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_stash_apply_progress_t,
    offset: int
  ): c_git_stash_apply_progress_t =
  cast[c_git_stash_apply_progress_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_stash_apply_progress_t
  ): c_git_stash_apply_progress_t =
  cast[c_git_stash_apply_progress_t](ord(arg) - offset)


proc git_stash_apply_options_init*(
    opts:    ptr git_stash_apply_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_stash_apply*(
    repo:    ptr git_repository,
    index:   csize_t,
    options: ptr git_stash_apply_options
  ): cint {.git2Proc, importc.}



proc git_stash_foreach*(
    repo:     ptr git_repository,
    callback: git_stash_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_stash_drop*(
    repo:  ptr git_repository,
    index: csize_t
  ): cint {.git2Proc, importc.}



proc git_stash_pop*(
    repo:    ptr git_repository,
    index:   csize_t,
    options: ptr git_stash_apply_options
  ): cint {.git2Proc, importc.}



