import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./net.nim"
import "./buffer.nim"
proc git_refspec_parse*(
    refspec: ptr ptr git_refspec,
    input: cstring,
    is_fetch: cint,
): cint {.importc: "git_refspec_parse", header: "<refspec.h>".}

proc git_refspec_free*(refspec: ptr git_refspec): void {.importc: "git_refspec_free", header: "<refspec.h>".}

proc git_refspec_src*(refspec: ptr git_refspec): cstring {.importc: "git_refspec_src", header: "<refspec.h>".}

proc git_refspec_dst*(refspec: ptr git_refspec): cstring {.importc: "git_refspec_dst", header: "<refspec.h>".}

proc git_refspec_string*(refspec: ptr git_refspec): cstring {.importc: "git_refspec_string", header: "<refspec.h>".}

proc git_refspec_force*(refspec: ptr git_refspec): cint {.importc: "git_refspec_force", header: "<refspec.h>".}

proc git_refspec_direction*(spec: ptr git_refspec): git_direction {.importc: "git_refspec_direction", header: "<refspec.h>".}

proc git_refspec_src_matches*(refspec: ptr git_refspec, refname: cstring): cint {.importc: "git_refspec_src_matches", header: "<refspec.h>".}

proc git_refspec_dst_matches*(refspec: ptr git_refspec, refname: cstring): cint {.importc: "git_refspec_dst_matches", header: "<refspec.h>".}

proc git_refspec_transform*(
    `out`: ptr git_buf,
    spec: ptr git_refspec,
    name: cstring,
): cint {.importc: "git_refspec_transform", header: "<refspec.h>".}

proc git_refspec_rtransform*(
    `out`: ptr git_buf,
    spec: ptr git_refspec,
    name: cstring,
): cint {.importc: "git_refspec_rtransform", header: "<refspec.h>".}