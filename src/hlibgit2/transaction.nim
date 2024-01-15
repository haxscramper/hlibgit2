import "./types.nim"
import "./oid.nim"
proc git_transaction_new*(`out`: ptr ptr git_transaction, repo: ptr git_repository): cint {.importc: "git_transaction_new".}

proc git_transaction_lock_ref*(tx: ptr git_transaction, refname: cstring): cint {.importc: "git_transaction_lock_ref".}

proc git_transaction_set_target*(
    tx: ptr git_transaction,
    refname: cstring,
    target: ptr git_oid,
    sig: ptr git_signature,
    msg: cstring,
): cint {.importc: "git_transaction_set_target".}

proc git_transaction_set_symbolic_target*(
    tx: ptr git_transaction,
    refname: cstring,
    target: cstring,
    sig: ptr git_signature,
    msg: cstring,
): cint {.importc: "git_transaction_set_symbolic_target".}

proc git_transaction_set_reflog*(
    tx: ptr git_transaction,
    refname: cstring,
    reflog: ptr git_reflog,
): cint {.importc: "git_transaction_set_reflog".}

proc git_transaction_remove*(tx: ptr git_transaction, refname: cstring): cint {.importc: "git_transaction_remove".}

proc git_transaction_commit*(tx: ptr git_transaction): cint {.importc: "git_transaction_commit".}

proc git_transaction_free*(tx: ptr git_transaction): void {.importc: "git_transaction_free".}