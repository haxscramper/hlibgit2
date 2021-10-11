{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./merge

import
  ./oid

import
  ./checkout

import
  ./commit

type
  git_rebase_operation* {.bycopy, header: "<git2/rebase.h>", importc.} = object
    ## Indicates that a rebase operation is not (yet) in progress. 
    type_f* {.importc: "type".}: git_rebase_operation_t ## The type of rebase operation. 
    id*: git_oid
    exec*: cstring
   
  git_rebase_operation_t* = enum
    GIT_REBASE_OPERATION_PICK = 0
    GIT_REBASE_OPERATION_REWORD = 1
    GIT_REBASE_OPERATION_EDIT = 2
    GIT_REBASE_OPERATION_SQUASH = 3
    GIT_REBASE_OPERATION_FIXUP = 4
    GIT_REBASE_OPERATION_EXEC = 5
   
  git_rebase_options* {.bycopy, header: "<git2/rebase.h>", importc.} = object
    version*: cuint
    quiet*: cint
    inmemory*: cint
    rewrite_notes_ref*: cstring
    merge_options*: git_merge_options
    checkout_options*: git_checkout_options
    signing_cb*: git_commit_signing_cb
    payload*: pointer
   

proc git_rebase_options_init*(
    opts:    ptr git_rebase_options,
    version: cuint
  ): cint {.dynlib: libgitDl, importc.}


proc git_rebase_init*(
    arg_out:  ptr ptr git_rebase,
    repo:     ptr git_repository,
    branch:   ptr git_annotated_commit,
    upstream: ptr git_annotated_commit,
    onto:     ptr git_annotated_commit,
    opts:     ptr git_rebase_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_rebase_open*(
    arg_out: ptr ptr git_rebase,
    repo:    ptr git_repository,
    opts:    ptr git_rebase_options
  ): cint {.dynlib: libgitDl, importc.}


proc git_rebase_orig_head_name*(
    rebase: ptr git_rebase
  ): cstring {.dynlib: libgitDl, importc.}


proc git_rebase_orig_head_id*(
    rebase: ptr git_rebase
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_rebase_onto_name*(
    rebase: ptr git_rebase
  ): cstring {.dynlib: libgitDl, importc.}


proc git_rebase_onto_id*(
    rebase: ptr git_rebase
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_rebase_operation_entrycount*(
    rebase: ptr git_rebase
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_rebase_operation_current*(
    rebase: ptr git_rebase
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_rebase_operation_byindex*(
    rebase: ptr git_rebase,
    idx:    csize_t
  ): ptr git_rebase_operation {.dynlib: libgitDl, importc.}


proc git_rebase_next*(
    operation: ptr ptr git_rebase_operation,
    rebase:    ptr git_rebase
  ): cint {.dynlib: libgitDl, importc.}


proc git_rebase_inmemory_index*(
    index:  ptr ptr git_index,
    rebase: ptr git_rebase
  ): cint {.dynlib: libgitDl, importc.}


proc git_rebase_commit*(
    id:               ptr git_oid,
    rebase:           ptr git_rebase,
    author:           ptr git_signature,
    committer:        ptr git_signature,
    message_encoding: cstring,
    message:          cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_rebase_abort*(
    rebase: ptr git_rebase
  ): cint {.dynlib: libgitDl, importc.}


proc git_rebase_finish*(
    rebase:    ptr git_rebase,
    signature: ptr git_signature
  ): cint {.dynlib: libgitDl, importc.}


proc git_rebase_free*(
    rebase: ptr git_rebase
  ): void {.dynlib: libgitDl, importc.}


