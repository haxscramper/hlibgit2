proc `git_reflog_entry__alloc`*(): ptr git_reflog_entry {.git2Proc, importc.}

proc `git_reflog_entry__free`*(entry: ptr git_reflog_entry): void {.git2Proc, importc.}