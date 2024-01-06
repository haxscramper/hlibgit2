import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./net.nim"
import "./buffer.nim"
proc git_refspec_parse*(
    refspec: ptr ptr git_refspec,
    input: cstring,
    is_fetch: cint,
): cint {.importc: "git_refspec_parse".}

proc git_refspec_free*(refspec: ptr git_refspec): void {.importc: "git_refspec_free".}

proc git_refspec_src*(refspec: ptr git_refspec): cstring {.importc: "git_refspec_src".}

proc git_refspec_dst*(refspec: ptr git_refspec): cstring {.importc: "git_refspec_dst".}

proc git_refspec_string*(refspec: ptr git_refspec): cstring {.importc: "git_refspec_string".}

proc git_refspec_force*(refspec: ptr git_refspec): cint {.importc: "git_refspec_force".}

proc git_refspec_direction*(spec: ptr git_refspec): git_direction {.importc: "git_refspec_direction".}

proc git_refspec_src_matches*(refspec: ptr git_refspec, refname: cstring): cint {.importc: "git_refspec_src_matches".}

proc git_refspec_dst_matches*(refspec: ptr git_refspec, refname: cstring): cint {.importc: "git_refspec_dst_matches".}

proc git_refspec_transform*(
    `out`: ptr git_buf,
    spec: ptr git_refspec,
    name: cstring,
): cint {.importc: "git_refspec_transform".}

proc git_refspec_rtransform*(
    `out`: ptr git_buf,
    spec: ptr git_refspec,
    name: cstring,
): cint {.importc: "git_refspec_rtransform".}