{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./checkout,
  ./commit,
  ./libgit2_config,
  ./merge,
  ./oid,
  ./types

type
  c_git_rebase_operation_t* {.size: sizeof(cint).} = enum
    c_GIT_REBASE_OPERATION_PICK   = 0
    c_GIT_REBASE_OPERATION_REWORD = 1
    c_GIT_REBASE_OPERATION_EDIT   = 2
    c_GIT_REBASE_OPERATION_SQUASH = 3
    c_GIT_REBASE_OPERATION_FIXUP  = 4
    c_GIT_REBASE_OPERATION_EXEC   = 5

  git_rebase_operation* {.bycopy, header: "<git2/rebase.h>", importc.} = object
    ## Indicates that a rebase operation is not (yet) in progress.
    type_f* {.importc: "type".}: c_git_rebase_operation_t ## The type of rebase operation.
    id*:                         git_oid
    exec*:                       cstring

  git_rebase_operation_t* = enum
    GIT_REBASE_OPERATION_PICK
    GIT_REBASE_OPERATION_REWORD
    GIT_REBASE_OPERATION_EDIT
    GIT_REBASE_OPERATION_SQUASH
    GIT_REBASE_OPERATION_FIXUP
    GIT_REBASE_OPERATION_EXEC

  git_rebase_options* {.bycopy, header: "<git2/rebase.h>", importc.} = object
    version*:           cuint
    quiet*:             cint
    inmemory*:          cint
    rewrite_notes_ref*: cstring
    merge_options*:     git_merge_options
    checkout_options*:  git_checkout_options
    commit_create_cb*:  git_commit_create_cb
    signing_cb*:        proc(a0: ptr git_buf,
                             a1: ptr git_buf,
                             a2: cstring,
                             a3: pointer): cint{.cdecl.}
    payload*:           pointer


proc to_c_git_rebase_operation_t*(
    arg: git_rebase_operation_t
  ): c_git_rebase_operation_t =
  case arg:
    of GIT_REBASE_OPERATION_PICK:   c_GIT_REBASE_OPERATION_PICK
    of GIT_REBASE_OPERATION_REWORD: c_GIT_REBASE_OPERATION_REWORD
    of GIT_REBASE_OPERATION_EDIT:   c_GIT_REBASE_OPERATION_EDIT
    of GIT_REBASE_OPERATION_SQUASH: c_GIT_REBASE_OPERATION_SQUASH
    of GIT_REBASE_OPERATION_FIXUP:  c_GIT_REBASE_OPERATION_FIXUP
    of GIT_REBASE_OPERATION_EXEC:   c_GIT_REBASE_OPERATION_EXEC


converter to_git_rebase_operation_t*(
    arg: c_git_rebase_operation_t
  ): git_rebase_operation_t =
  case arg:
    of c_GIT_REBASE_OPERATION_PICK:   GIT_REBASE_OPERATION_PICK
    of c_GIT_REBASE_OPERATION_REWORD: GIT_REBASE_OPERATION_REWORD
    of c_GIT_REBASE_OPERATION_EDIT:   GIT_REBASE_OPERATION_EDIT
    of c_GIT_REBASE_OPERATION_SQUASH: GIT_REBASE_OPERATION_SQUASH
    of c_GIT_REBASE_OPERATION_FIXUP:  GIT_REBASE_OPERATION_FIXUP
    of c_GIT_REBASE_OPERATION_EXEC:   GIT_REBASE_OPERATION_EXEC


converter toCint*(arg: c_git_rebase_operation_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_rebase_operation_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_rebase_operation_t(arg)))

func `+`*(
    arg:    c_git_rebase_operation_t,
    offset: int
  ): c_git_rebase_operation_t =
  cast[c_git_rebase_operation_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_rebase_operation_t
  ): c_git_rebase_operation_t =
  cast[c_git_rebase_operation_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_rebase_operation_t,
    offset: int
  ): c_git_rebase_operation_t =
  cast[c_git_rebase_operation_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_rebase_operation_t
  ): c_git_rebase_operation_t =
  cast[c_git_rebase_operation_t](ord(arg) - offset)


proc git_rebase_options_init*(
    opts:    ptr git_rebase_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_rebase_init*(
    arg_out:  ptr ptr git_rebase,
    repo:     ptr git_repository,
    branch:   ptr git_annotated_commit,
    upstream: ptr git_annotated_commit,
    onto:     ptr git_annotated_commit,
    opts:     ptr git_rebase_options
  ): cint {.git2Proc, importc.}



proc git_rebase_open*(
    arg_out: ptr ptr git_rebase,
    repo:    ptr git_repository,
    opts:    ptr git_rebase_options
  ): cint {.git2Proc, importc.}



proc git_rebase_orig_head_name*(
    rebase: ptr git_rebase
  ): cstring {.git2Proc, importc.}



proc git_rebase_orig_head_id*(
    rebase: ptr git_rebase
  ): ptr git_oid {.git2Proc, importc.}



proc git_rebase_onto_name*(
    rebase: ptr git_rebase
  ): cstring {.git2Proc, importc.}



proc git_rebase_onto_id*(
    rebase: ptr git_rebase
  ): ptr git_oid {.git2Proc, importc.}



proc git_rebase_operation_entrycount*(
    rebase: ptr git_rebase
  ): csize_t {.git2Proc, importc.}



proc git_rebase_operation_current*(
    rebase: ptr git_rebase
  ): csize_t {.git2Proc, importc.}



proc git_rebase_operation_byindex*(
    rebase: ptr git_rebase,
    idx:    csize_t
  ): ptr git_rebase_operation {.git2Proc, importc.}



proc git_rebase_next*(
    operation: ptr ptr git_rebase_operation,
    rebase:    ptr git_rebase
  ): cint {.git2Proc, importc.}



proc git_rebase_inmemory_index*(
    index:  ptr ptr git_index,
    rebase: ptr git_rebase
  ): cint {.git2Proc, importc.}



proc git_rebase_commit*(
    id:               ptr git_oid,
    rebase:           ptr git_rebase,
    author:           ptr git_signature,
    committer:        ptr git_signature,
    message_encoding: cstring,
    message:          cstring
  ): cint {.git2Proc, importc.}



proc git_rebase_abort*(rebase: ptr git_rebase): cint {.git2Proc, importc.}



proc git_rebase_finish*(
    rebase:    ptr git_rebase,
    signature: ptr git_signature
  ): cint {.git2Proc, importc.}



proc git_rebase_free*(rebase: ptr git_rebase): void {.git2Proc, importc.}



