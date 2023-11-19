import "../buffer.nim"
import "../checkout.nim"
import "../strarray.nim"
import "../types.nim"

type
  git_worktree_add_options* {.importc, bycopy.} = object
    version          *: cuint
    lock             *: cint
    ref              *: ptr git_reference
    checkout_options *: git_checkout_options

  git_worktree_prune_options* {.importc, bycopy.} = object
    version *: cuint
    flags   *: uint32

  c_git_worktree_prune_t {.size: sizeof(cint).} = enum
    c_GIT_WORKTREE_PRUNE_VALID        = 1 shl 0
    c_GIT_WORKTREE_PRUNE_LOCKED       = 1 shl 1
    c_GIT_WORKTREE_PRUNE_WORKING_TREE = 1 shl 2

  git_worktree_prune_t = enum
    GIT_WORKTREE_PRUNE_VALID
    GIT_WORKTREE_PRUNE_LOCKED
    GIT_WORKTREE_PRUNE_WORKING_TREE



converter toCInt*(arg: c_git_worktree_prune_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_worktree_prune_t)): cint =
  for value in items(args):
    case value:
      of GIT_WORKTREE_PRUNE_VALID       : result = cint(result or 1)
      of GIT_WORKTREE_PRUNE_LOCKED      : result = cint(result or 2)
      of GIT_WORKTREE_PRUNE_WORKING_TREE: result = cint(result or 4)

func `-`*(arg: c_git_worktree_prune_t, offset: int): cint = cast[c_git_worktree_prune_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_worktree_prune_t): cint = cast[c_git_worktree_prune_t](ord(arg) - offset)

func `+`*(arg: c_git_worktree_prune_t, offset: int): cint = cast[c_git_worktree_prune_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_worktree_prune_t): cint = cast[c_git_worktree_prune_t](ord(arg) + offset)

proc git_worktree_list*(out: ptr git_strarray, repo: ptr git_repository): cint {.git2Proc, importc.}

proc git_worktree_lookup*(out: ptr git_worktree, repo: ptr git_repository, name: cstring): cint {.git2Proc, importc.}

proc git_worktree_open_from_repository*(out: ptr git_worktree, repo: ptr git_repository): cint {.git2Proc, importc.}

proc git_worktree_free*(wt: ptr git_worktree): void {.git2Proc, importc.}

proc git_worktree_validate*(wt: ptr git_worktree): cint {.git2Proc, importc.}

proc git_worktree_add_options_init*(opts: ptr git_worktree_add_options, version: cuint): cint {.git2Proc, importc.}

proc git_worktree_add*(out: ptr git_worktree, repo: ptr git_repository, name: cstring, path: cstring, opts: ptr git_worktree_add_options): cint {.git2Proc, importc.}

proc git_worktree_lock*(wt: ptr git_worktree, reason: cstring): cint {.git2Proc, importc.}

proc git_worktree_unlock*(wt: ptr git_worktree): cint {.git2Proc, importc.}

proc git_worktree_is_locked*(reason: ptr git_buf, wt: ptr git_worktree): cint {.git2Proc, importc.}

proc git_worktree_name*(wt: ptr git_worktree): cstring {.git2Proc, importc.}

proc git_worktree_path*(wt: ptr git_worktree): cstring {.git2Proc, importc.}

proc git_worktree_prune_options_init*(opts: ptr git_worktree_prune_options, version: cuint): cint {.git2Proc, importc.}

proc git_worktree_is_prunable*(wt: ptr git_worktree, opts: ptr git_worktree_prune_options): cint {.git2Proc, importc.}

proc git_worktree_prune*(wt: ptr git_worktree, opts: ptr git_worktree_prune_options): cint {.git2Proc, importc.}