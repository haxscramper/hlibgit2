import "../oid.nim"
import "../types.nim"
proc git_transaction_new*(out: ptr git_transaction, repo: ptr git_repository): cint {.git2Proc, importc.}

proc git_transaction_lock_ref*(tx: ptr git_transaction, refname: cstring): cint {.git2Proc, importc.}

proc git_transaction_set_target*(tx: ptr git_transaction, refname: cstring, target: ptr git_oid, sig: ptr git_signature, msg: cstring): cint {.git2Proc, importc.}

proc git_transaction_set_symbolic_target*(tx: ptr git_transaction, refname: cstring, target: cstring, sig: ptr git_signature, msg: cstring): cint {.git2Proc, importc.}

proc git_transaction_set_reflog*(tx: ptr git_transaction, refname: cstring, reflog: ptr git_reflog): cint {.git2Proc, importc.}

proc git_transaction_remove*(tx: ptr git_transaction, refname: cstring): cint {.git2Proc, importc.}

proc git_transaction_commit*(tx: ptr git_transaction): cint {.git2Proc, importc.}

proc git_transaction_free*(tx: ptr git_transaction): void {.git2Proc, importc.}