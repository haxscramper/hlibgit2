import "../libgit2_config.nim" ## From gen file
import "../types.nim"
import "../oid.nim"

type
  git_index_name_entry* {.header: "<sys/index.h>", importc, bycopy.} = object
    ancestor *: ptr char
    ours     *: ptr char
    theirs   *: ptr char

  git_index_reuc_entry* {.header: "<sys/index.h>", importc, bycopy.} = object
    mode *: array[3, uint32]
    oid  *: array[3, git_oid]
    path *: ptr char



proc git_index_name_entrycount*(index: ptr git_index): csize_t {.importc: "git_index_name_entrycount", header: "<sys/index.h>".}

proc git_index_name_get_byindex*(index: ptr git_index, n: csize_t): ptr git_index_name_entry {.importc: "git_index_name_get_byindex", header: "<sys/index.h>".}

proc git_index_name_add*(
    index: ptr git_index,
    ancestor: cstring,
    ours: cstring,
    theirs: cstring,
): cint {.importc: "git_index_name_add", header: "<sys/index.h>".}

proc git_index_name_clear*(index: ptr git_index): cint {.importc: "git_index_name_clear", header: "<sys/index.h>".}

proc git_index_reuc_entrycount*(index: ptr git_index): csize_t {.importc: "git_index_reuc_entrycount", header: "<sys/index.h>".}

proc git_index_reuc_find*(
    at_pos: ptr csize_t,
    index: ptr git_index,
    path: cstring,
): cint {.importc: "git_index_reuc_find", header: "<sys/index.h>".}

proc git_index_reuc_get_bypath*(index: ptr git_index, path: cstring): ptr git_index_reuc_entry {.importc: "git_index_reuc_get_bypath", header: "<sys/index.h>".}

proc git_index_reuc_get_byindex*(index: ptr git_index, n: csize_t): ptr git_index_reuc_entry {.importc: "git_index_reuc_get_byindex", header: "<sys/index.h>".}

proc git_index_reuc_add*(
    index: ptr git_index,
    path: cstring,
    ancestor_mode: cint,
    ancestor_id: ptr git_oid,
    our_mode: cint,
    our_id: ptr git_oid,
    their_mode: cint,
    their_id: ptr git_oid,
): cint {.importc: "git_index_reuc_add", header: "<sys/index.h>".}

proc git_index_reuc_remove*(index: ptr git_index, n: csize_t): cint {.importc: "git_index_reuc_remove", header: "<sys/index.h>".}

proc git_index_reuc_clear*(index: ptr git_index): cint {.importc: "git_index_reuc_clear", header: "<sys/index.h>".}