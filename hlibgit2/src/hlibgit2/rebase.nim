import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./commit.nim"
import "./buffer.nim"
import "./types.nim"
import "./merge.nim"
import "./checkout.nim"

type
  git_rebase_options* {.bycopy.} = object
    version           *: cuint
    quiet             *: cint
    inmemory          *: cint
    rewrite_notes_ref *: cstring
    merge_options     *: git_merge_options
    checkout_options  *: git_checkout_options
    commit_create_cb  *: git_commit_create_cb
    signing_cb        *: proc (a0: ptr git_buf, a1: ptr git_buf, a2: cstring, a3: pointer): cint
    payload           *: pointer

  git_rebase_operation* {.bycopy.} = object
    `type` *: git_rebase_operation_t
    id     *: git_oid
    exec   *: cstring

  c_git_rebase_operation_t* {.size: sizeof(cint).} = enum
    c_GIT_REBASE_OPERATION_PICK   = 0
    c_GIT_REBASE_OPERATION_REWORD = 1
    c_GIT_REBASE_OPERATION_EDIT   = 2
    c_GIT_REBASE_OPERATION_SQUASH = 3
    c_GIT_REBASE_OPERATION_FIXUP  = 4
    c_GIT_REBASE_OPERATION_EXEC   = 5

  git_rebase_operation_t* = enum
    GIT_REBASE_OPERATION_PICK
    GIT_REBASE_OPERATION_REWORD
    GIT_REBASE_OPERATION_EDIT
    GIT_REBASE_OPERATION_SQUASH
    GIT_REBASE_OPERATION_FIXUP
    GIT_REBASE_OPERATION_EXEC



converter toCInt*(arg: c_git_rebase_operation_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_rebase_operation_t]): cint =
  for value in items(args):
    case value:
      of GIT_REBASE_OPERATION_PICK  : result = cint(result or 0)
      of GIT_REBASE_OPERATION_REWORD: result = cint(result or 1)
      of GIT_REBASE_OPERATION_EDIT  : result = cint(result or 2)
      of GIT_REBASE_OPERATION_SQUASH: result = cint(result or 3)
      of GIT_REBASE_OPERATION_FIXUP : result = cint(result or 4)
      of GIT_REBASE_OPERATION_EXEC  : result = cint(result or 5)

func `-`*(arg: c_git_rebase_operation_t, offset: int): cint = cast[c_git_rebase_operation_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_rebase_operation_t): cint = cast[c_git_rebase_operation_t](ord(arg) - offset)

func `+`*(arg: c_git_rebase_operation_t, offset: int): cint = cast[c_git_rebase_operation_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_rebase_operation_t): cint = cast[c_git_rebase_operation_t](ord(arg) + offset)

proc git_rebase_options_init*(opts: ptr git_rebase_options, version: cuint): cint {.git2Proc, importc: "git_rebase_options_init".}

proc git_rebase_init*(
    `out`: ptr ptr git_rebase,
    repo: ptr git_repository,
    branch: ptr git_annotated_commit,
    upstream: ptr git_annotated_commit,
    onto: ptr git_annotated_commit,
    opts: ptr git_rebase_options,
): cint {.git2Proc, importc: "git_rebase_init".}

proc git_rebase_open*(
    `out`: ptr ptr git_rebase,
    repo: ptr git_repository,
    opts: ptr git_rebase_options,
): cint {.git2Proc, importc: "git_rebase_open".}

proc git_rebase_orig_head_name*(rebase: ptr git_rebase): cstring {.git2Proc, importc: "git_rebase_orig_head_name".}

proc git_rebase_orig_head_id*(rebase: ptr git_rebase): ptr git_oid {.git2Proc, importc: "git_rebase_orig_head_id".}

proc git_rebase_onto_name*(rebase: ptr git_rebase): cstring {.git2Proc, importc: "git_rebase_onto_name".}

proc git_rebase_onto_id*(rebase: ptr git_rebase): ptr git_oid {.git2Proc, importc: "git_rebase_onto_id".}

proc git_rebase_operation_entrycount*(rebase: ptr git_rebase): csize_t {.git2Proc, importc: "git_rebase_operation_entrycount".}

proc git_rebase_operation_current*(rebase: ptr git_rebase): csize_t {.git2Proc, importc: "git_rebase_operation_current".}

proc git_rebase_operation_byindex*(rebase: ptr git_rebase, idx: csize_t): ptr git_rebase_operation {.git2Proc, importc: "git_rebase_operation_byindex".}

proc git_rebase_next*(operation: ptr ptr git_rebase_operation, rebase: ptr git_rebase): cint {.git2Proc, importc: "git_rebase_next".}

proc git_rebase_inmemory_index*(index: ptr ptr git_index, rebase: ptr git_rebase): cint {.git2Proc, importc: "git_rebase_inmemory_index".}

proc git_rebase_commit*(
    id: ptr git_oid,
    rebase: ptr git_rebase,
    author: ptr git_signature,
    committer: ptr git_signature,
    message_encoding: cstring,
    message: cstring,
): cint {.git2Proc, importc: "git_rebase_commit".}

proc git_rebase_abort*(rebase: ptr git_rebase): cint {.git2Proc, importc: "git_rebase_abort".}

proc git_rebase_finish*(rebase: ptr git_rebase, signature: ptr git_signature): cint {.git2Proc, importc: "git_rebase_finish".}

proc git_rebase_free*(rebase: ptr git_rebase): void {.git2Proc, importc: "git_rebase_free".}