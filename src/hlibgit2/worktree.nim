{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./strarray,
  ./types

type
  c_git_worktree_prune_t* {.size: sizeof(cint).} = enum
    c_GIT_WORKTREE_PRUNE_VALID        = 1 shl 0 ## Prune working tree even if working tree is valid
    c_GIT_WORKTREE_PRUNE_LOCKED       = 1 shl 1 ## Prune working tree even if it is locked
    c_GIT_WORKTREE_PRUNE_WORKING_TREE = 1 shl 2 ## Prune checked out working tree

  git_worktree_add_options* {.bycopy, header: "<git2/worktree.h>", importc.} = object
    version*:                  cuint
    lock*:                     cint
    ref_f* {.importc: "ref".}: ptr git_reference ## lock newly created worktree
                                                 ## reference to use for the new worktree HEAD

  git_worktree_prune_options* {.bycopy, header: "<git2/worktree.h>", importc.} = object
    version*: cuint
    flags*:   uint32 ## A combination of `git_worktree_prune_t`

  git_worktree_prune_t* {.size: sizeof(cint).} = enum
    GIT_WORKTREE_PRUNE_VALID        ## Prune working tree even if working tree is valid
    GIT_WORKTREE_PRUNE_LOCKED       ## Prune working tree even if it is locked
    GIT_WORKTREE_PRUNE_WORKING_TREE ## Prune checked out working tree


proc git_worktree_list*(
    arg_out: ptr git_strarray,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_worktree_lookup*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_worktree_open_from_repository*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_worktree_free*(wt: ptr git_worktree): void {.git2Proc, importc.}



proc git_worktree_validate*(wt: ptr git_worktree): cint {.git2Proc, importc.}



proc git_worktree_add_options_init*(
    opts:    ptr git_worktree_add_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_worktree_add*(
    arg_out: ptr ptr git_worktree,
    repo:    ptr git_repository,
    name:    cstring,
    path:    cstring,
    opts:    ptr git_worktree_add_options
  ): cint {.git2Proc, importc.}



proc git_worktree_lock*(
    wt:     ptr git_worktree,
    reason: cstring
  ): cint {.git2Proc, importc.}



proc git_worktree_unlock*(wt: ptr git_worktree): cint {.git2Proc, importc.}



proc git_worktree_is_locked*(
    reason: ptr git_buf,
    wt:     ptr git_worktree
  ): cint {.git2Proc, importc.}



proc git_worktree_name*(wt: ptr git_worktree): cstring {.git2Proc, importc.}



proc git_worktree_path*(wt: ptr git_worktree): cstring {.git2Proc, importc.}



proc to_c_git_worktree_prune_t*(
    arg: git_worktree_prune_t
  ): c_git_worktree_prune_t =
  case arg:
    of GIT_WORKTREE_PRUNE_VALID:        c_GIT_WORKTREE_PRUNE_VALID
    of GIT_WORKTREE_PRUNE_LOCKED:       c_GIT_WORKTREE_PRUNE_LOCKED
    of GIT_WORKTREE_PRUNE_WORKING_TREE: c_GIT_WORKTREE_PRUNE_WORKING_TREE


converter to_git_worktree_prune_t*(
    arg: c_git_worktree_prune_t
  ): git_worktree_prune_t =
  case arg:
    of c_GIT_WORKTREE_PRUNE_VALID:        GIT_WORKTREE_PRUNE_VALID
    of c_GIT_WORKTREE_PRUNE_LOCKED:       GIT_WORKTREE_PRUNE_LOCKED
    of c_GIT_WORKTREE_PRUNE_WORKING_TREE: GIT_WORKTREE_PRUNE_WORKING_TREE


converter toCint*(arg: c_git_worktree_prune_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_worktree_prune_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_worktree_prune_t(arg)))

func `+`*(arg: c_git_worktree_prune_t, offset: int): c_git_worktree_prune_t =
  cast[c_git_worktree_prune_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_worktree_prune_t): c_git_worktree_prune_t =
  cast[c_git_worktree_prune_t](ord(arg) + offset)

func `-`*(arg: c_git_worktree_prune_t, offset: int): c_git_worktree_prune_t =
  cast[c_git_worktree_prune_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_worktree_prune_t): c_git_worktree_prune_t =
  cast[c_git_worktree_prune_t](ord(arg) - offset)


converter toCint*(args: set[git_worktree_prune_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc git_worktree_prune_options_init*(
    opts:    ptr git_worktree_prune_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_worktree_is_prunable*(
    wt:   ptr git_worktree,
    opts: ptr git_worktree_prune_options
  ): cint {.git2Proc, importc.}



proc git_worktree_prune*(
    wt:   ptr git_worktree,
    opts: ptr git_worktree_prune_options
  ): cint {.git2Proc, importc.}



