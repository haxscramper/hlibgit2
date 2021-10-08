
import
  . / config

proc git_refdb_new*(arg_out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_open*(arg_out: ptr ptr git_refdb; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc.}
proc git_refdb_compress*(refdb: ptr git_refdb): cint {.dynlib: libgitDl, importc.}
proc git_refdb_free*(refdb: ptr git_refdb): void {.dynlib: libgitDl, importc.}