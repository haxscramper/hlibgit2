import "../../buffer.nim"
import "../../types.nim"
proc git_mempack_new*(out: ptr git_odb_backend): cint {.git2Proc, importc.}

proc git_mempack_dump*(pack: ptr git_buf, repo: ptr git_repository, backend: ptr git_odb_backend): cint {.git2Proc, importc.}

proc git_mempack_reset*(backend: ptr git_odb_backend): cint {.git2Proc, importc.}