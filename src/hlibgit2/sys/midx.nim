import "../libgit2_config.nim" ## From gen file
import "../types.nim"
import "../buffer.nim"
proc git_midx_writer_new*(`out`: ptr ptr git_midx_writer, pack_dir: cstring): cint {.importc: "git_midx_writer_new".}

proc git_midx_writer_free*(w: ptr git_midx_writer): void {.importc: "git_midx_writer_free".}

proc git_midx_writer_add*(w: ptr git_midx_writer, idx_path: cstring): cint {.importc: "git_midx_writer_add".}

proc git_midx_writer_commit*(w: ptr git_midx_writer): cint {.importc: "git_midx_writer_commit".}

proc git_midx_writer_dump*(midx: ptr git_buf, w: ptr git_midx_writer): cint {.importc: "git_midx_writer_dump".}