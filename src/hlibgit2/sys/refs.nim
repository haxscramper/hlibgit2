proc `git_reference__alloc`*(name: cstring, oid: ptr git_oid, peel: ptr git_oid): ptr git_reference {.git2Proc, importc.}

proc `git_reference__alloc_symbolic`*(name: cstring, target: cstring): ptr git_reference {.git2Proc, importc.}