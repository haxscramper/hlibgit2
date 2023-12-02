import "../libgit2_config.nim" ## From gen file
import "../odb.nim"
import "../buffer.nim"
import "../types.nim"
proc git_mempack_new*(`out`: `ptr` git_odb_backend): cint {.git2Proc, importc: "git_mempack_new".}

proc git_mempack_dump*(pack: `ptr` git_buf, repo: `ptr` git_repository, backend: `ptr` git_odb_backend): cint {.git2Proc, importc: "git_mempack_dump".}

proc git_mempack_reset*(backend: `ptr` git_odb_backend): cint {.git2Proc, importc: "git_mempack_reset".}