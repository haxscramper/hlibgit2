import "./buffer.nim"
import "./libgit2_config.nim"
import "./net.nim"
import "./types.nim"
proc git_refspec_string*(refspec: `ptr` git_refspec): cstring {.git2Proc, importc.}

proc git_refspec_force*(refspec: `ptr` git_refspec): cint {.git2Proc, importc.}

proc git_refspec_direction*(spec: `ptr` git_refspec): git_direction {.git2Proc, importc.}

proc git_refspec_src_matches*(refspec: `ptr` git_refspec, refname: cstring): cint {.git2Proc, importc.}

proc git_refspec_dst_matches*(refspec: `ptr` git_refspec, refname: cstring): cint {.git2Proc, importc.}

proc git_refspec_transform*(`out`: `ptr` git_buf, spec: `ptr` git_refspec, name: cstring): cint {.git2Proc, importc.}

proc git_refspec_rtransform*(`out`: `ptr` git_buf, spec: `ptr` git_refspec, name: cstring): cint {.git2Proc, importc.}

proc git_refspec_parse*(refspec: `ptr` git_refspec, input: cstring, is_fetch: cint): cint {.git2Proc, importc.}

proc git_refspec_free*(refspec: `ptr` git_refspec): void {.git2Proc, importc.}

proc git_refspec_src*(refspec: `ptr` git_refspec): cstring {.git2Proc, importc.}

proc git_refspec_dst*(refspec: `ptr` git_refspec): cstring {.git2Proc, importc.}