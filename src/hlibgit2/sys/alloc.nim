type

  git_allocator* {.importc, bycopy.} = object
    gmalloc  *: proc (a0: csize_t, a1: cstring, a2: cint): ptr void
    grealloc *: proc (a0: ptr void, a1: csize_t, a2: cstring, a3: cint): ptr void
    gfree    *: proc (a0: ptr void): void



proc `git_stdalloc_init_allocator`*(allocator: ptr git_allocator): cint {.git2Proc, importc.}

proc `git_win32_crtdbg_init_allocator`*(allocator: ptr git_allocator): cint {.git2Proc, importc.}