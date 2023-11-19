import "../../buffer.nim"
import "../../types.nim"
proc git_midx_writer_new*(out: ptr git_midx_writer, pack_dir: cstring): cint {.git2Proc, importc.}

proc git_midx_writer_free*(w: ptr git_midx_writer): void {.git2Proc, importc.}

proc git_midx_writer_add*(w: ptr git_midx_writer, idx_path: cstring): cint {.git2Proc, importc.}

proc git_midx_writer_commit*(w: ptr git_midx_writer): cint {.git2Proc, importc.}

proc git_midx_writer_dump*(midx: ptr git_buf, w: ptr git_midx_writer): cint {.git2Proc, importc.}