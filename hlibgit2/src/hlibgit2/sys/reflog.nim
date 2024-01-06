import "../libgit2_config.nim" ## From gen file
import "../types.nim"
proc git_reflog_entry_alloc*(): ptr git_reflog_entry {.git2Proc, importc: "git_reflog_entry__alloc".}

proc git_reflog_entry_free*(entry: ptr git_reflog_entry): void {.git2Proc, importc: "git_reflog_entry__free".}