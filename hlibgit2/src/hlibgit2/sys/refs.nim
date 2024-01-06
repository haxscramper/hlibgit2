import "../libgit2_config.nim" ## From gen file
import "../oid.nim"
import "../types.nim"
proc git_reference_alloc*(
    name: cstring,
    oid: ptr git_oid,
    peel: ptr git_oid,
): ptr git_reference {.git2Proc, importc: "git_reference__alloc".}

proc git_reference_alloc_symbolic*(name: cstring, target: cstring): ptr git_reference {.git2Proc, importc: "git_reference__alloc_symbolic".}