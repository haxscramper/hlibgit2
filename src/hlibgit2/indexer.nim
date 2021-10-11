{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./types

type
  git_indexer* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_indexer_options* {.bycopy, header: "<git2/indexer.h>", importc.} = object
    version*: cuint
    progress_cb*: git_indexer_progress_cb ## progress_cb function to call with progress information 
    progress_cb_payload*: pointer ## progress_cb_payload payload for the progress callback 
    verify*: uint8 ## Do connectivity checks for the received pack 
   
  git_indexer_progress* {.bycopy, header: "<git2/indexer.h>", importc.} = object
    total_objects*: cuint ## number of objects in the packfile being indexed 
    indexed_objects*: cuint ## received objects that have been hashed 
    received_objects*: cuint ## received_objects: objects which have been downloaded 
    local_objects*: cuint
    total_deltas*: cuint ## number of deltas in the packfile being indexed 
    indexed_deltas*: cuint ## received deltas that have been indexed 
    received_bytes*: csize_t ## size of the packfile received up to now 
   
  git_indexer_progress_cb* = proc(stats: ptr git_indexer_progress, payload: pointer): cint{.cdecl.}
   
  git_indexer_progress_cbNim* = proc(stats: ptr git_indexer_progress): cint
   

proc git_indexer_options_init*(
    opts:    ptr git_indexer_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_indexer_new*(
    arg_out: ptr ptr git_indexer,
    path:    cstring,
    mode:    cuint,
    odb:     ptr git_odb,
    opts:    ptr git_indexer_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_indexer_append*(
    idx:   ptr git_indexer,
    data:  pointer,
    size:  csize_t,
    stats: ptr git_indexer_progress
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_indexer_commit*(
    idx:   ptr git_indexer,
    stats: ptr git_indexer_progress
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_indexer_hash*(
    idx: ptr git_indexer
  ): ptr git_oid {.dynlib: libgit2Dl, importc.}


proc git_indexer_free*(
    idx: ptr git_indexer
  ): void {.dynlib: libgit2Dl, importc.}


