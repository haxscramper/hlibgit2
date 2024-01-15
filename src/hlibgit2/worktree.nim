import "./types.nim"
import "./strarray.nim"
import "./buffer.nim"

type
  git_worktree_add_options* {.bycopy.} = object
    version          *: cuint
    lock             *: cint
    `ref`            *: ptr git_reference
    checkout_options *: cint

  git_worktree_prune_options* {.bycopy.} = object
    version *: cuint
    flags   *: uint32

  c_git_worktree_prune_t* {.size: sizeof(cint).} = enum
    c_GIT_WORKTREE_PRUNE_VALID        = 1 shl 0
    c_GIT_WORKTREE_PRUNE_LOCKED       = 1 shl 1
    c_GIT_WORKTREE_PRUNE_WORKING_TREE = 1 shl 2

  git_worktree_prune_t* = enum
    GIT_WORKTREE_PRUNE_VALID        = 0
    GIT_WORKTREE_PRUNE_LOCKED       = 1
    GIT_WORKTREE_PRUNE_WORKING_TREE = 2



converter to_git_worktree_prune_t*(arg: c_git_worktree_prune_t): git_worktree_prune_t =
  case arg:
    of c_GIT_WORKTREE_PRUNE_VALID       : GIT_WORKTREE_PRUNE_VALID
    of c_GIT_WORKTREE_PRUNE_LOCKED      : GIT_WORKTREE_PRUNE_LOCKED
    of c_GIT_WORKTREE_PRUNE_WORKING_TREE: GIT_WORKTREE_PRUNE_WORKING_TREE

proc to_c_git_worktree_prune_t*(arg: git_worktree_prune_t): c_git_worktree_prune_t =
  case arg:
    of GIT_WORKTREE_PRUNE_VALID       : c_GIT_WORKTREE_PRUNE_VALID
    of GIT_WORKTREE_PRUNE_LOCKED      : c_GIT_WORKTREE_PRUNE_LOCKED
    of GIT_WORKTREE_PRUNE_WORKING_TREE: c_GIT_WORKTREE_PRUNE_WORKING_TREE

converter toCInt*(arg: c_git_worktree_prune_t): cint = cint(ord(arg))

converter toCInt*(arg: git_worktree_prune_t): cint = cint(ord(to_c_git_worktree_prune_t(arg)))

converter toCInt*(args: set[git_worktree_prune_t]): cint =
  for value in items(args):
    case value:
      of GIT_WORKTREE_PRUNE_VALID       : result = cint(result or 1)
      of GIT_WORKTREE_PRUNE_LOCKED      : result = cint(result or 2)
      of GIT_WORKTREE_PRUNE_WORKING_TREE: result = cint(result or 4)

func `-`*(arg: c_git_worktree_prune_t, offset: int): cint = cast[c_git_worktree_prune_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_worktree_prune_t): cint = cast[c_git_worktree_prune_t](ord(arg) - offset)

func `+`*(arg: c_git_worktree_prune_t, offset: int): cint = cast[c_git_worktree_prune_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_worktree_prune_t): cint = cast[c_git_worktree_prune_t](ord(arg) + offset)

proc git_worktree_list*(`out`: ptr git_strarray, repo: ptr git_repository): cint {.importc: "git_worktree_list".}

proc git_worktree_lookup*(
    `out`: ptr ptr git_worktree,
    repo: ptr git_repository,
    name: cstring,
): cint {.importc: "git_worktree_lookup".}

proc git_worktree_open_from_repository*(`out`: ptr ptr git_worktree, repo: ptr git_repository): cint {.importc: "git_worktree_open_from_repository".}

proc git_worktree_free*(wt: ptr git_worktree): void {.importc: "git_worktree_free".}

proc git_worktree_validate*(wt: ptr git_worktree): cint {.importc: "git_worktree_validate".}

proc git_worktree_add_options_init*(opts: ptr git_worktree_add_options, version: cuint): cint {.importc: "git_worktree_add_options_init".}

proc git_worktree_add*(
    `out`: ptr ptr git_worktree,
    repo: ptr git_repository,
    name: cstring,
    path: cstring,
    opts: ptr git_worktree_add_options,
): cint {.importc: "git_worktree_add".}

proc git_worktree_lock*(wt: ptr git_worktree, reason: cstring): cint {.importc: "git_worktree_lock".}

proc git_worktree_unlock*(wt: ptr git_worktree): cint {.importc: "git_worktree_unlock".}

proc git_worktree_is_locked*(reason: ptr git_buf, wt: ptr git_worktree): cint {.importc: "git_worktree_is_locked".}

proc git_worktree_name*(wt: ptr git_worktree): cstring {.importc: "git_worktree_name".}

proc git_worktree_path*(wt: ptr git_worktree): cstring {.importc: "git_worktree_path".}

proc git_worktree_prune_options_init*(opts: ptr git_worktree_prune_options, version: cuint): cint {.importc: "git_worktree_prune_options_init".}

proc git_worktree_is_prunable*(wt: ptr git_worktree, opts: ptr git_worktree_prune_options): cint {.importc: "git_worktree_is_prunable".}

proc git_worktree_prune*(wt: ptr git_worktree, opts: ptr git_worktree_prune_options): cint {.importc: "git_worktree_prune".}