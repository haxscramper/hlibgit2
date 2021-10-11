{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./types

proc git_transaction_new*(
    arg_out: ptr ptr git_transaction,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_transaction_lock_ref*(
    tx:      ptr git_transaction,
    refname: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_transaction_set_target*(
    tx:      ptr git_transaction,
    refname: cstring,
    target:  ptr git_oid,
    sig:     ptr git_signature,
    msg:     cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_transaction_set_symbolic_target*(
    tx:      ptr git_transaction,
    refname: cstring,
    target:  cstring,
    sig:     ptr git_signature,
    msg:     cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_transaction_set_reflog*(
    tx:      ptr git_transaction,
    refname: cstring,
    reflog:  ptr git_reflog
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_transaction_remove*(
    tx:      ptr git_transaction,
    refname: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_transaction_commit*(
    tx: ptr git_transaction
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_transaction_free*(
    tx: ptr git_transaction
  ): void {.dynlib: libgit2Dl, importc.}


