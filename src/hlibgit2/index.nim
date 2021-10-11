{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./strarray,
  ./types

type
  git_index_add_option_t* = enum
    GIT_INDEX_ADD_DEFAULT = 0
    GIT_INDEX_ADD_FORCE = 1
    GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 2
    GIT_INDEX_ADD_CHECK_PATHSPEC = 4
   
  git_index_capability_t* = enum
    GIT_INDEX_CAPABILITY_FROM_OWNER = -1
    GIT_INDEX_CAPABILITY_IGNORE_CASE = 1
    GIT_INDEX_CAPABILITY_NO_FILEMODE = 2
    GIT_INDEX_CAPABILITY_NO_SYMLINKS = 4
   
  git_index_entry* {.bycopy, header: "<git2/index.h>", importc.} = object
    ctime*: git_index_time
    mtime*: git_index_time
    dev*: uint32
    ino*: uint32
    mode*: uint32
    uid*: uint32
    gid*: uint32
    file_size*: uint32
    id*: git_oid
    flags*: uint16
    flags_extended*: uint16
    path*: cstring
   
  git_index_entry_extended_flag_t* = enum
    GIT_INDEX_ENTRY_UPTODATE = 4
    GIT_INDEX_ENTRY_INTENT_TO_ADD = 8192
    GIT_INDEX_ENTRY_SKIP_WORKTREE = 16384
    GIT_INDEX_ENTRY_EXTENDED_FLAGS = 24576
   
  git_index_entry_flag_t* = enum
    GIT_INDEX_ENTRY_EXTENDED = 0
   
  git_index_matched_path_cb* = proc(path: cstring, matched_pathspec: cstring, payload: pointer): cint{.cdecl.}
   
  git_index_matched_path_cbNim* = proc(path: cstring, matched_pathspec: cstring): cint
   
  git_index_stage_t* = enum
    GIT_INDEX_STAGE_ANY = -1
    GIT_INDEX_STAGE_NORMAL = 0 ## A normal staged file in the index. 
    GIT_INDEX_STAGE_ANCESTOR = 1 ## The ancestor side of a conflict. 
    GIT_INDEX_STAGE_OURS = 2 ## The "ours" side of a conflict. 
    GIT_INDEX_STAGE_THEIRS = 3 ## The "theirs" side of a conflict. 
   
  git_index_time* {.bycopy, header: "<git2/index.h>", importc.} = object
    ## Time structure used in a git index entry 
    seconds*: int32
    nanoseconds*: uint32 ## nsec should not be stored as time_t compatible 
   

proc git_index_open*(
    arg_out:    ptr ptr git_index,
    index_path: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_new*(
    arg_out: ptr ptr git_index
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_free*(index: ptr git_index): void {.dynlib: libgit2Dl, importc.}


proc git_index_owner*(
    index: ptr git_index
  ): ptr git_repository {.dynlib: libgit2Dl, importc.}


proc git_index_caps*(index: ptr git_index): cint {.dynlib: libgit2Dl, importc.}


proc git_index_set_caps*(
    index: ptr git_index,
    caps:  cint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_version*(
    index: ptr git_index
  ): cuint {.dynlib: libgit2Dl, importc.}


proc git_index_set_version*(
    index:   ptr git_index,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_read*(
    index: ptr git_index,
    force: cint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_write*(index: ptr git_index): cint {.dynlib: libgit2Dl, importc.}


proc git_index_path*(
    index: ptr git_index
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_index_checksum*(
    index: ptr git_index
  ): ptr git_oid {.dynlib: libgit2Dl, importc.}


proc git_index_read_tree*(
    index: ptr git_index,
    tree:  ptr git_tree
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_write_tree*(
    arg_out: ptr git_oid,
    index:   ptr git_index
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_write_tree_to*(
    arg_out: ptr git_oid,
    index:   ptr git_index,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_entrycount*(
    index: ptr git_index
  ): csize_t {.dynlib: libgit2Dl, importc.}


proc git_index_clear*(index: ptr git_index): cint {.dynlib: libgit2Dl, importc.}


proc git_index_get_byindex*(
    index: ptr git_index,
    n:     csize_t
  ): ptr git_index_entry {.dynlib: libgit2Dl, importc.}


proc git_index_get_bypath*(
    index: ptr git_index,
    path:  cstring,
    stage: cint
  ): ptr git_index_entry {.dynlib: libgit2Dl, importc.}


proc git_index_remove*(
    index: ptr git_index,
    path:  cstring,
    stage: cint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_remove_directory*(
    index: ptr git_index,
    dir:   cstring,
    stage: cint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_add*(
    index:        ptr git_index,
    source_entry: ptr git_index_entry
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_entry_stage*(
    entry: ptr git_index_entry
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_entry_is_conflict*(
    entry: ptr git_index_entry
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_iterator_new*(
    iterator_out: ptr ptr git_index_iterator,
    index:        ptr git_index
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_iterator_next*(
    arg_out:      ptr ptr git_index_entry,
    arg_iterator: ptr git_index_iterator
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_iterator_free*(
    arg_iterator: ptr git_index_iterator
  ): void {.dynlib: libgit2Dl, importc.}


proc git_index_add_bypath*(
    index: ptr git_index,
    path:  cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_add_from_buffer*(
    index:  ptr git_index,
    entry:  ptr git_index_entry,
    buffer: pointer,
    len:    csize_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_remove_bypath*(
    index: ptr git_index,
    path:  cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_add_all*(
    index:    ptr git_index,
    pathspec: ptr git_strarray,
    flags:    cuint,
    callback: git_index_matched_path_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_remove_all*(
    index:    ptr git_index,
    pathspec: ptr git_strarray,
    callback: git_index_matched_path_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_update_all*(
    index:    ptr git_index,
    pathspec: ptr git_strarray,
    callback: git_index_matched_path_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_find*(
    at_pos: ptr csize_t,
    index:  ptr git_index,
    path:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_find_prefix*(
    at_pos: ptr csize_t,
    index:  ptr git_index,
    prefix: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_conflict_add*(
    index:          ptr git_index,
    ancestor_entry: ptr git_index_entry,
    our_entry:      ptr git_index_entry,
    their_entry:    ptr git_index_entry
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_conflict_get*(
    ancestor_out: ptr ptr git_index_entry,
    our_out:      ptr ptr git_index_entry,
    their_out:    ptr ptr git_index_entry,
    index:        ptr git_index,
    path:         cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_conflict_remove*(
    index: ptr git_index,
    path:  cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_conflict_cleanup*(
    index: ptr git_index
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_has_conflicts*(
    index: ptr git_index
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_conflict_iterator_new*(
    iterator_out: ptr ptr git_index_conflict_iterator,
    index:        ptr git_index
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_conflict_next*(
    ancestor_out: ptr ptr git_index_entry,
    our_out:      ptr ptr git_index_entry,
    their_out:    ptr ptr git_index_entry,
    arg_iterator: ptr git_index_conflict_iterator
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_index_conflict_iterator_free*(
    arg_iterator: ptr git_index_conflict_iterator
  ): void {.dynlib: libgit2Dl, importc.}


