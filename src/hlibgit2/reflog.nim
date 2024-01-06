import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./oid.nim"
proc git_reflog_read*(
    `out`: ptr ptr git_reflog,
    repo: ptr git_repository,
    name: cstring,
): cint {.importc: "git_reflog_read", header: "<reflog.h>".}

proc git_reflog_write*(reflog: ptr git_reflog): cint {.importc: "git_reflog_write", header: "<reflog.h>".}

proc git_reflog_append*(
    reflog: ptr git_reflog,
    id: ptr git_oid,
    committer: ptr git_signature,
    msg: cstring,
): cint {.importc: "git_reflog_append", header: "<reflog.h>".}

proc git_reflog_rename*(
    repo: ptr git_repository,
    old_name: cstring,
    name: cstring,
): cint {.importc: "git_reflog_rename", header: "<reflog.h>".}

proc git_reflog_delete*(repo: ptr git_repository, name: cstring): cint {.importc: "git_reflog_delete", header: "<reflog.h>".}

proc git_reflog_entrycount*(reflog: ptr git_reflog): csize_t {.importc: "git_reflog_entrycount", header: "<reflog.h>".}

proc git_reflog_entry_byindex*(reflog: ptr git_reflog, idx: csize_t): ptr git_reflog_entry {.importc: "git_reflog_entry_byindex", header: "<reflog.h>".}

proc git_reflog_drop*(
    reflog: ptr git_reflog,
    idx: csize_t,
    rewrite_previous_entry: cint,
): cint {.importc: "git_reflog_drop", header: "<reflog.h>".}

proc git_reflog_entry_id_old*(entry: ptr git_reflog_entry): ptr git_oid {.importc: "git_reflog_entry_id_old", header: "<reflog.h>".}

proc git_reflog_entry_id_new*(entry: ptr git_reflog_entry): ptr git_oid {.importc: "git_reflog_entry_id_new", header: "<reflog.h>".}

proc git_reflog_entry_committer*(entry: ptr git_reflog_entry): ptr git_signature {.importc: "git_reflog_entry_committer", header: "<reflog.h>".}

proc git_reflog_entry_message*(entry: ptr git_reflog_entry): cstring {.importc: "git_reflog_entry_message", header: "<reflog.h>".}

proc git_reflog_free*(reflog: ptr git_reflog): void {.importc: "git_reflog_free", header: "<reflog.h>".}