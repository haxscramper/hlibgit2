import "../libgit2_config.nim" ## From gen file
proc git_error_set*(error_class: cint, fmt: cstring): void {.importc: "git_error_set".}

proc git_error_set_str*(error_class: cint, string: cstring): cint {.importc: "git_error_set_str".}

proc git_error_set_oom*(): void {.importc: "git_error_set_oom".}

proc git_error_clear*(): void {.importc: "git_error_clear".}