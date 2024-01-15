import "./types.nim"
import "./oid.nim"

type
  git_indexer* {.importc, incompleteStruct.} = object


  git_indexer_progress* {.importc, bycopy.} = object
    total_objects    *: cuint
    indexed_objects  *: cuint
    received_objects *: cuint
    local_objects    *: cuint
    total_deltas     *: cuint
    indexed_deltas   *: cuint
    received_bytes   *: csize_t

  git_indexer_options* {.importc, bycopy.} = object
    version             *: cuint
    progress_cb         *: git_indexer_progress_cb
    progress_cb_payload *: pointer
    verify              *: char

  git_indexer_progress_cb* = proc (a0: ptr git_indexer_progress, a1: pointer): cint



proc git_indexer_hash*(idx: ptr git_indexer): ptr git_oid {.importc: "git_indexer_hash".}

proc git_indexer_name*(idx: ptr git_indexer): cstring {.importc: "git_indexer_name".}

proc git_indexer_free*(idx: ptr git_indexer): void {.importc: "git_indexer_free".}

proc git_indexer_options_init*(opts: ptr git_indexer_options, version: cuint): cint {.importc: "git_indexer_options_init".}

proc git_indexer_new*(
    `out`: ptr ptr git_indexer,
    path: cstring,
    mode: cuint,
    odb: ptr git_odb,
    opts: ptr git_indexer_options,
): cint {.importc: "git_indexer_new".}

proc git_indexer_append*(
    idx: ptr git_indexer,
    data: pointer,
    size: csize_t,
    stats: ptr git_indexer_progress,
): cint {.importc: "git_indexer_append".}

proc git_indexer_commit*(idx: ptr git_indexer, stats: ptr git_indexer_progress): cint {.importc: "git_indexer_commit".}