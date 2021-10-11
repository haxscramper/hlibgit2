{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./oid

import
  ./buffer

import
  ./indexer

type
  git_packbuilder_foreach_cb* = proc(buf: pointer, size: csize_t, payload: pointer): cint{.cdecl.}
   
  git_packbuilder_foreach_cbNim* = proc(buf: pointer, size: csize_t): cint
   
  git_packbuilder_progress* = proc(stage: cint, current: uint32, total: uint32, payload: pointer): cint{.cdecl.}
   
  git_packbuilder_progressNim* = proc(stage: cint, current: uint32, total: uint32): cint
   
  git_packbuilder_stage_t* = enum
    GIT_PACKBUILDER_ADDING_OBJECTS = 0
    GIT_PACKBUILDER_DELTAFICATION = 1
   

proc git_packbuilder_new*(
    arg_out: ptr ptr git_packbuilder,
    repo:    ptr git_repository
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_set_threads*(
    pb: ptr git_packbuilder,
    n:  cuint
  ): cuint {.dynlib: libgitDl, importc.}


proc git_packbuilder_insert*(
    pb:   ptr git_packbuilder,
    id:   ptr git_oid,
    name: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_insert_tree*(
    pb: ptr git_packbuilder,
    id: ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_insert_commit*(
    pb: ptr git_packbuilder,
    id: ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_insert_walk*(
    pb:   ptr git_packbuilder,
    walk: ptr git_revwalk
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_insert_recur*(
    pb:   ptr git_packbuilder,
    id:   ptr git_oid,
    name: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_write_buf*(
    buf: ptr git_buf,
    pb:  ptr git_packbuilder
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_write*(
    pb:                  ptr git_packbuilder,
    path:                cstring,
    mode:                cuint,
    progress_cb:         git_indexer_progress_cb,
    progress_cb_payload: pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_hash*(
    pb: ptr git_packbuilder
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_packbuilder_foreach*(
    pb:      ptr git_packbuilder,
    cb:      git_packbuilder_foreach_cb,
    payload: pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_object_count*(
    pb: ptr git_packbuilder
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_packbuilder_written*(
    pb: ptr git_packbuilder
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_packbuilder_set_callbacks*(
    pb:                  ptr git_packbuilder,
    progress_cb:         git_packbuilder_progress,
    progress_cb_payload: pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_packbuilder_free*(
    pb: ptr git_packbuilder
  ): void {.dynlib: libgitDl, importc.}


