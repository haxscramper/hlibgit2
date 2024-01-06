import "./libgit2_config.nim" ## From gen file
import "./indexer.nim"
import "./oid.nim"
import "./buffer.nim"
import "./types.nim"

type
  c_git_packbuilder_stage_t* {.size: sizeof(cint).} = enum
    c_GIT_PACKBUILDER_ADDING_OBJECTS = 0
    c_GIT_PACKBUILDER_DELTAFICATION  = 1

  git_packbuilder_stage_t* = enum
    GIT_PACKBUILDER_ADDING_OBJECTS
    GIT_PACKBUILDER_DELTAFICATION

  git_packbuilder_foreach_cb* = proc (a0: pointer, a1: csize_t, a2: pointer): cint

  git_packbuilder_progress* = proc (a0: cint, a1: uint32, a2: uint32, a3: pointer): cint



proc git_packbuilder_set_callbacks*(
    pb: ptr git_packbuilder,
    progress_cb: git_packbuilder_progress,
    progress_cb_payload: pointer,
): cint {.git2Proc, importc: "git_packbuilder_set_callbacks".}

proc git_packbuilder_free*(pb: ptr git_packbuilder): void {.git2Proc, importc: "git_packbuilder_free".}

converter toCInt*(arg: c_git_packbuilder_stage_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_packbuilder_stage_t]): cint =
  for value in items(args):
    case value:
      of GIT_PACKBUILDER_ADDING_OBJECTS: result = cint(result or 0)
      of GIT_PACKBUILDER_DELTAFICATION : result = cint(result or 1)

func `-`*(arg: c_git_packbuilder_stage_t, offset: int): cint = cast[c_git_packbuilder_stage_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_packbuilder_stage_t): cint = cast[c_git_packbuilder_stage_t](ord(arg) - offset)

func `+`*(arg: c_git_packbuilder_stage_t, offset: int): cint = cast[c_git_packbuilder_stage_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_packbuilder_stage_t): cint = cast[c_git_packbuilder_stage_t](ord(arg) + offset)

proc git_packbuilder_new*(`out`: ptr ptr git_packbuilder, repo: ptr git_repository): cint {.git2Proc, importc: "git_packbuilder_new".}

proc git_packbuilder_set_threads*(pb: ptr git_packbuilder, n: cuint): cuint {.git2Proc, importc: "git_packbuilder_set_threads".}

proc git_packbuilder_insert*(
    pb: ptr git_packbuilder,
    id: ptr git_oid,
    name: cstring,
): cint {.git2Proc, importc: "git_packbuilder_insert".}

proc git_packbuilder_insert_tree*(pb: ptr git_packbuilder, id: ptr git_oid): cint {.git2Proc, importc: "git_packbuilder_insert_tree".}

proc git_packbuilder_insert_commit*(pb: ptr git_packbuilder, id: ptr git_oid): cint {.git2Proc, importc: "git_packbuilder_insert_commit".}

proc git_packbuilder_insert_walk*(pb: ptr git_packbuilder, walk: ptr git_revwalk): cint {.git2Proc, importc: "git_packbuilder_insert_walk".}

proc git_packbuilder_insert_recur*(
    pb: ptr git_packbuilder,
    id: ptr git_oid,
    name: cstring,
): cint {.git2Proc, importc: "git_packbuilder_insert_recur".}

proc git_packbuilder_write_buf*(buf: ptr git_buf, pb: ptr git_packbuilder): cint {.git2Proc, importc: "git_packbuilder_write_buf".}

proc git_packbuilder_write*(
    pb: ptr git_packbuilder,
    path: cstring,
    mode: cuint,
    progress_cb: git_indexer_progress_cb,
    progress_cb_payload: pointer,
): cint {.git2Proc, importc: "git_packbuilder_write".}

proc git_packbuilder_hash*(pb: ptr git_packbuilder): ptr git_oid {.git2Proc, importc: "git_packbuilder_hash".}

proc git_packbuilder_name*(pb: ptr git_packbuilder): cstring {.git2Proc, importc: "git_packbuilder_name".}

proc git_packbuilder_foreach*(
    pb: ptr git_packbuilder,
    cb: git_packbuilder_foreach_cb,
    payload: pointer,
): cint {.git2Proc, importc: "git_packbuilder_foreach".}

proc git_packbuilder_object_count*(pb: ptr git_packbuilder): csize_t {.git2Proc, importc: "git_packbuilder_object_count".}

proc git_packbuilder_written*(pb: ptr git_packbuilder): csize_t {.git2Proc, importc: "git_packbuilder_written".}