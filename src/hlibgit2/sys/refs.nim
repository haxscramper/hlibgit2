import "../libgit2_config.nim" ## From gen file
import "../types.nim"
import "../oid.nim"
proc git_reference_alloc*(
    name: cstring,
    oid: ptr git_oid,
    peel: ptr git_oid,
): ptr git_reference {.importc: "git_reference__alloc", header: "<sys/refs.h>".}

proc git_reference_alloc_symbolic*(name: cstring, target: cstring): ptr git_reference {.importc: "git_reference__alloc_symbolic", header: "<sys/refs.h>".}