{.push warning[UnusedImport]:off.}

import
  ./diff,
  ./libgit2_config,
  ./types

type
  c_git_apply_flags_t* {.size: sizeof(cint).} = enum
    c_GIT_APPLY_CHECK = 1 shl 0

  c_git_apply_location_t* {.size: sizeof(cint).} = enum
    c_GIT_APPLY_LOCATION_WORKDIR = 0 shl 0
    c_GIT_APPLY_LOCATION_INDEX   = 1 shl 0
    c_GIT_APPLY_LOCATION_BOTH    = 1 shl 1

  git_apply_delta_cb* = proc(delta:   ptr git_diff_delta,
                             payload: pointer): cint{.cdecl.}

  git_apply_flags_t* {.size: sizeof(cint).} = enum
    GIT_APPLY_CHECK

  git_apply_hunk_cb* = proc(hunk:    ptr git_diff_hunk,
                            payload: pointer): cint{.cdecl.}

  git_apply_location_t* {.size: sizeof(cint).} = enum
    GIT_APPLY_LOCATION_WORKDIR
    GIT_APPLY_LOCATION_INDEX
    GIT_APPLY_LOCATION_BOTH

  git_apply_options* {.bycopy, header: "<git2/apply.h>", importc.} = object
    version*:  cuint
    delta_cb*: git_apply_delta_cb ## The version
                                  ## When applying a patch, callback that will be made per delta (file).
    hunk_cb*:  git_apply_hunk_cb  ## When applying a patch, callback that will be made per hunk.
    payload*:  pointer            ## Payload passed to both delta_cb & hunk_cb.
    flags*:    cuint              ## Bitmask of git_apply_flags_t


proc to_c_git_apply_flags_t*(arg: git_apply_flags_t): c_git_apply_flags_t =
  case arg:
    of GIT_APPLY_CHECK: c_GIT_APPLY_CHECK


converter to_git_apply_flags_t*(arg: c_git_apply_flags_t): git_apply_flags_t =
  case arg:
    of c_GIT_APPLY_CHECK: GIT_APPLY_CHECK


converter toCint*(arg: c_git_apply_flags_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_apply_flags_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_apply_flags_t(arg)))

func `+`*(arg: c_git_apply_flags_t, offset: int): c_git_apply_flags_t =
  cast[c_git_apply_flags_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_apply_flags_t): c_git_apply_flags_t =
  cast[c_git_apply_flags_t](ord(arg) + offset)

func `-`*(arg: c_git_apply_flags_t, offset: int): c_git_apply_flags_t =
  cast[c_git_apply_flags_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_apply_flags_t): c_git_apply_flags_t =
  cast[c_git_apply_flags_t](ord(arg) - offset)


converter toCint*(args: set[git_apply_flags_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc git_apply_options_init*(
    opts:    ptr git_apply_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_apply_to_tree*(
    arg_out:  ptr ptr git_index,
    repo:     ptr git_repository,
    preimage: ptr git_tree,
    diff:     ptr git_diff,
    options:  ptr git_apply_options
  ): cint {.git2Proc, importc.}



proc to_c_git_apply_location_t*(
    arg: git_apply_location_t
  ): c_git_apply_location_t =
  case arg:
    of GIT_APPLY_LOCATION_WORKDIR: c_GIT_APPLY_LOCATION_WORKDIR
    of GIT_APPLY_LOCATION_INDEX:   c_GIT_APPLY_LOCATION_INDEX
    of GIT_APPLY_LOCATION_BOTH:    c_GIT_APPLY_LOCATION_BOTH


converter to_git_apply_location_t*(
    arg: c_git_apply_location_t
  ): git_apply_location_t =
  case arg:
    of c_GIT_APPLY_LOCATION_WORKDIR: GIT_APPLY_LOCATION_WORKDIR
    of c_GIT_APPLY_LOCATION_INDEX:   GIT_APPLY_LOCATION_INDEX
    of c_GIT_APPLY_LOCATION_BOTH:    GIT_APPLY_LOCATION_BOTH


converter toCint*(arg: c_git_apply_location_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_apply_location_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_apply_location_t(arg)))

func `+`*(arg: c_git_apply_location_t, offset: int): c_git_apply_location_t =
  cast[c_git_apply_location_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_apply_location_t): c_git_apply_location_t =
  cast[c_git_apply_location_t](ord(arg) + offset)

func `-`*(arg: c_git_apply_location_t, offset: int): c_git_apply_location_t =
  cast[c_git_apply_location_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_apply_location_t): c_git_apply_location_t =
  cast[c_git_apply_location_t](ord(arg) - offset)


converter toCint*(args: set[git_apply_location_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_APPLY_LOCATION_WORKDIR: result = cint(result or (0 shl 0))
      of GIT_APPLY_LOCATION_INDEX:   result = cint(result or (1 shl 0))
      of GIT_APPLY_LOCATION_BOTH:    result = cint(result or (1 shl 1))


proc git_apply*(
    repo:     ptr git_repository,
    diff:     ptr git_diff,
    location: c_git_apply_location_t,
    options:  ptr git_apply_options
  ): cint {.git2Proc, importc.}



