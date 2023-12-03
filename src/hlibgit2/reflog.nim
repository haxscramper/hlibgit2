import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./types.nim"
proc git_reflog_read*(`out`: ptr ptr git_reflog, repo: ptr git_repository, name: cstring): cint {.git2Proc, importc: "git_reflog_read".}

proc git_reflog_write*(reflog: ptr git_reflog): cint {.git2Proc, importc: "git_reflog_write".}

proc git_reflog_append*(reflog: ptr git_reflog, id: ptr git_oid, committer: ptr git_signature, msg: cstring): cint {.git2Proc, importc: "git_reflog_append".}

proc git_reflog_rename*(repo: ptr git_repository, old_name: cstring, name: cstring): cint {.git2Proc, importc: "git_reflog_rename".}

proc git_reflog_delete*(repo: ptr git_repository, name: cstring): cint {.git2Proc, importc: "git_reflog_delete".}

proc git_reflog_entrycount*(reflog: ptr git_reflog): csize_t {.git2Proc, importc: "git_reflog_entrycount".}

proc git_reflog_entry_byindex*(reflog: ptr git_reflog, idx: csize_t): ptr git_reflog_entry {.git2Proc, importc: "git_reflog_entry_byindex".}

proc git_reflog_drop*(reflog: ptr git_reflog, idx: csize_t, rewrite_previous_entry: cint): cint {.git2Proc, importc: "git_reflog_drop".}

proc git_reflog_entry_id_old*(entry: ptr git_reflog_entry): ptr git_oid {.git2Proc, importc: "git_reflog_entry_id_old".}

proc git_reflog_entry_id_new*(entry: ptr git_reflog_entry): ptr git_oid {.git2Proc, importc: "git_reflog_entry_id_new".}

proc git_reflog_entry_committer*(entry: ptr git_reflog_entry): ptr git_signature {.git2Proc, importc: "git_reflog_entry_committer".}

proc git_reflog_entry_message*(entry: ptr git_reflog_entry): cstring {.git2Proc, importc: "git_reflog_entry_message".}

proc git_reflog_free*(reflog: ptr git_reflog): void {.git2Proc, importc: "git_reflog_free".}