proc `git_signature_new`*(out: ptr git_signature, name: cstring, email: cstring, time: git_time_t, offset: cint): cint {.git2Proc, importc.}

proc `git_signature_now`*(out: ptr git_signature, name: cstring, email: cstring): cint {.git2Proc, importc.}

proc `git_signature_default`*(out: ptr git_signature, repo: ptr git_repository): cint {.git2Proc, importc.}

proc `git_signature_from_buffer`*(out: ptr git_signature, buf: cstring): cint {.git2Proc, importc.}

proc `git_signature_dup`*(dest: ptr git_signature, sig: ptr git_signature): cint {.git2Proc, importc.}

proc `git_signature_free`*(sig: ptr git_signature): void {.git2Proc, importc.}