{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./indexer,
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_packbuilder_stage_t* {.size: sizeof(cint).} = enum
    c_GIT_PACKBUILDER_ADDING_OBJECTS = 0 shl 0
    c_GIT_PACKBUILDER_DELTAFICATION  = 1 shl 0

  git_packbuilder_foreach_cb* = proc(buf:     pointer,
                                     size:    csize_t,
                                     payload: pointer): cint{.cdecl.}

  git_packbuilder_progress* = proc(stage:   cint,
                                   current: uint32,
                                   total:   uint32,
                                   payload: pointer): cint{.cdecl.}

  git_packbuilder_stage_t* {.size: sizeof(cint).} = enum
    GIT_PACKBUILDER_ADDING_OBJECTS
    GIT_PACKBUILDER_DELTAFICATION


proc to_c_git_packbuilder_stage_t*(
    arg: git_packbuilder_stage_t
  ): c_git_packbuilder_stage_t =
  case arg:
    of GIT_PACKBUILDER_ADDING_OBJECTS: c_GIT_PACKBUILDER_ADDING_OBJECTS
    of GIT_PACKBUILDER_DELTAFICATION:  c_GIT_PACKBUILDER_DELTAFICATION


converter to_git_packbuilder_stage_t*(
    arg: c_git_packbuilder_stage_t
  ): git_packbuilder_stage_t =
  case arg:
    of c_GIT_PACKBUILDER_ADDING_OBJECTS: GIT_PACKBUILDER_ADDING_OBJECTS
    of c_GIT_PACKBUILDER_DELTAFICATION:  GIT_PACKBUILDER_DELTAFICATION


converter toCint*(arg: c_git_packbuilder_stage_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_packbuilder_stage_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_packbuilder_stage_t(arg)))

func `+`*(
    arg:    c_git_packbuilder_stage_t,
    offset: int
  ): c_git_packbuilder_stage_t =
  cast[c_git_packbuilder_stage_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_packbuilder_stage_t
  ): c_git_packbuilder_stage_t =
  cast[c_git_packbuilder_stage_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_packbuilder_stage_t,
    offset: int
  ): c_git_packbuilder_stage_t =
  cast[c_git_packbuilder_stage_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_packbuilder_stage_t
  ): c_git_packbuilder_stage_t =
  cast[c_git_packbuilder_stage_t](ord(arg) - offset)


converter toCint*(args: set[git_packbuilder_stage_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_PACKBUILDER_ADDING_OBJECTS: result = cint(result or (0 shl 0))
      of GIT_PACKBUILDER_DELTAFICATION:  result = cint(result or (1 shl 0))


proc git_packbuilder_new*(
    arg_out: ptr ptr git_packbuilder,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_packbuilder_set_threads*(
    pb: ptr git_packbuilder,
    n:  cuint
  ): cuint {.git2Proc, importc.}



proc git_packbuilder_insert*(
    pb:   ptr git_packbuilder,
    id:   ptr git_oid,
    name: cstring
  ): cint {.git2Proc, importc.}



proc git_packbuilder_insert_tree*(
    pb: ptr git_packbuilder,
    id: ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_packbuilder_insert_commit*(
    pb: ptr git_packbuilder,
    id: ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_packbuilder_insert_walk*(
    pb:   ptr git_packbuilder,
    walk: ptr git_revwalk
  ): cint {.git2Proc, importc.}



proc git_packbuilder_insert_recur*(
    pb:   ptr git_packbuilder,
    id:   ptr git_oid,
    name: cstring
  ): cint {.git2Proc, importc.}



proc git_packbuilder_write_buf*(
    buf: ptr git_buf,
    pb:  ptr git_packbuilder
  ): cint {.git2Proc, importc.}



proc git_packbuilder_write*(
    pb:                  ptr git_packbuilder,
    path:                cstring,
    mode:                cuint,
    progress_cb:         git_indexer_progress_cb,
    progress_cb_payload: pointer
  ): cint {.git2Proc, importc.}



proc git_packbuilder_hash*(
    pb: ptr git_packbuilder
  ): ptr git_oid {.git2Proc, importc.}



proc git_packbuilder_foreach*(
    pb:      ptr git_packbuilder,
    cb:      git_packbuilder_foreach_cb,
    payload: pointer
  ): cint {.git2Proc, importc.}



proc git_packbuilder_object_count*(
    pb: ptr git_packbuilder
  ): csize_t {.git2Proc, importc.}



proc git_packbuilder_written*(
    pb: ptr git_packbuilder
  ): csize_t {.git2Proc, importc.}



proc git_packbuilder_set_callbacks*(
    pb:                  ptr git_packbuilder,
    progress_cb:         git_packbuilder_progress,
    progress_cb_payload: pointer
  ): cint {.git2Proc, importc.}



proc git_packbuilder_free*(pb: ptr git_packbuilder): void {.git2Proc, importc.}



