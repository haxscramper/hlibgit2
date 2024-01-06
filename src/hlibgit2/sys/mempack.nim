import "../libgit2_config.nim" ## From gen file
import "../odb.nim"
import "../types.nim"
import "../buffer.nim"
proc git_mempack_new*(`out`: ptr ptr git_odb_backend): cint {.importc: "git_mempack_new".}

proc git_mempack_dump*(
    pack: ptr git_buf,
    repo: ptr git_repository,
    backend: ptr git_odb_backend,
): cint {.importc: "git_mempack_dump".}

proc git_mempack_reset*(backend: ptr git_odb_backend): cint {.importc: "git_mempack_reset".}