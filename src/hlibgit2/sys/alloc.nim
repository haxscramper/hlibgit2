type
  git_allocator* {.importc, bycopy.} = object
    gmalloc  *: proc (a0: csize_t, a1: cstring, a2: cint): pointer
    grealloc *: proc (a0: pointer, a1: csize_t, a2: cstring, a3: cint): pointer
    gfree    *: proc (a0: pointer): void



proc git_stdalloc_init_allocator*(allocator: ptr git_allocator): cint {.importc: "git_stdalloc_init_allocator".}

proc git_win32_crtdbg_init_allocator*(allocator: ptr git_allocator): cint {.importc: "git_win32_crtdbg_init_allocator".}