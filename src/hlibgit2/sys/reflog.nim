import "../libgit2_config.nim" ## From gen file
import "../types.nim"
proc git_reflog_entry_alloc*(): ptr git_reflog_entry {.importc: "git_reflog_entry__alloc".}

proc git_reflog_entry_free*(entry: ptr git_reflog_entry): void {.importc: "git_reflog_entry__free".}