type

  git_index_name_entry* {.importc, bycopy.} = object
    ancestor *: ptr char
    ours     *: ptr char
    theirs   *: ptr char
  git_index_reuc_entry* {.importc, bycopy.} = object
    mode *:
    oid  *:
    path *: ptr char



proc `git_index_name_entrycount`*(index: ptr git_index): csize_t {.git2Proc, importc.}

proc `git_index_name_get_byindex`*(index: ptr git_index, n: csize_t): ptr git_index_name_entry {.git2Proc, importc.}

proc `git_index_name_add`*(index: ptr git_index, ancestor: cstring, ours: cstring, theirs: cstring): cint {.git2Proc, importc.}

proc `git_index_name_clear`*(index: ptr git_index): cint {.git2Proc, importc.}

proc `git_index_reuc_entrycount`*(index: ptr git_index): csize_t {.git2Proc, importc.}

proc `git_index_reuc_find`*(at_pos: ptr csize_t, index: ptr git_index, path: cstring): cint {.git2Proc, importc.}

proc `git_index_reuc_get_bypath`*(index: ptr git_index, path: cstring): ptr git_index_reuc_entry {.git2Proc, importc.}

proc `git_index_reuc_get_byindex`*(index: ptr git_index, n: csize_t): ptr git_index_reuc_entry {.git2Proc, importc.}

proc `git_index_reuc_add`*(index: ptr git_index, path: cstring, ancestor_mode: cint, ancestor_id: ptr git_oid, our_mode: cint, our_id: ptr git_oid, their_mode: cint, their_id: ptr git_oid): cint {.git2Proc, importc.}

proc `git_index_reuc_remove`*(index: ptr git_index, n: csize_t): cint {.git2Proc, importc.}

proc `git_index_reuc_clear`*(index: ptr git_index): cint {.git2Proc, importc.}