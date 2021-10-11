{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./oid

import
  ./buffer

type
  git_tree_update* {.bycopy, header: "<git2/tree.h>", importc.} = object
    action*: git_tree_update_t ## Update action. If it's an removal, only the path is looked at 
    id*: git_oid ## The entry's id 
    filemode*: git_filemode_t ## The filemode/kind of object 
    path*: cstring ## The full path from the root tree 
   
  git_tree_update_t* = enum
    GIT_TREE_UPDATE_UPSERT = 0 ## Update or insert an entry at the specified path 
    GIT_TREE_UPDATE_REMOVE = 1 ## Remove an entry from the specified path 
   
  git_treebuilder_filter_cb* = proc(entry: ptr git_tree_entry, payload: pointer): cint{.cdecl.}
   
  git_treebuilder_filter_cbNim* = proc(entry: ptr git_tree_entry): cint
   
  git_treewalk_cb* = proc(root: cstring, entry: ptr git_tree_entry, payload: pointer): cint{.cdecl.}
   
  git_treewalk_cbNim* = proc(root: cstring, entry: ptr git_tree_entry): cint
   
  git_treewalk_mode* = enum
    GIT_TREEWALK_PRE = 0
    GIT_TREEWALK_POST = 1 ## Pre-order 
   

proc git_tree_lookup*(
    arg_out: ptr ptr git_tree,
    repo:    ptr git_repository,
    id:      ptr git_oid
  ): cint {.dynlib: libgitDl, importc.}


proc git_tree_lookup_prefix*(
    arg_out: ptr ptr git_tree,
    repo:    ptr git_repository,
    id:      ptr git_oid,
    len:     csize_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_tree_free*(tree: ptr git_tree): void {.dynlib: libgitDl, importc.}


proc git_tree_id*(tree: ptr git_tree): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_tree_owner*(
    tree: ptr git_tree
  ): ptr git_repository {.dynlib: libgitDl, importc.}


proc git_tree_entrycount*(
    tree: ptr git_tree
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_tree_entry_byname*(
    tree:     ptr git_tree,
    filename: cstring
  ): ptr git_tree_entry {.dynlib: libgitDl, importc.}


proc git_tree_entry_byindex*(
    tree: ptr git_tree,
    idx:  csize_t
  ): ptr git_tree_entry {.dynlib: libgitDl, importc.}


proc git_tree_entry_byid*(
    tree: ptr git_tree,
    id:   ptr git_oid
  ): ptr git_tree_entry {.dynlib: libgitDl, importc.}


proc git_tree_entry_bypath*(
    arg_out: ptr ptr git_tree_entry,
    root:    ptr git_tree,
    path:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_tree_entry_dup*(
    dest:   ptr ptr git_tree_entry,
    source: ptr git_tree_entry
  ): cint {.dynlib: libgitDl, importc.}


proc git_tree_entry_free*(
    entry: ptr git_tree_entry
  ): void {.dynlib: libgitDl, importc.}


proc git_tree_entry_name*(
    entry: ptr git_tree_entry
  ): cstring {.dynlib: libgitDl, importc.}


proc git_tree_entry_id*(
    entry: ptr git_tree_entry
  ): ptr git_oid {.dynlib: libgitDl, importc.}


proc git_tree_entry_type*(
    entry: ptr git_tree_entry
  ): git_object_t {.dynlib: libgitDl, importc.}


proc git_tree_entry_filemode*(
    entry: ptr git_tree_entry
  ): git_filemode_t {.dynlib: libgitDl, importc.}


proc git_tree_entry_filemode_raw*(
    entry: ptr git_tree_entry
  ): git_filemode_t {.dynlib: libgitDl, importc.}


proc git_tree_entry_cmp*(
    e1: ptr git_tree_entry,
    e2: ptr git_tree_entry
  ): cint {.dynlib: libgitDl, importc.}


proc git_tree_entry_to_object*(
    object_out: ptr ptr git_object,
    repo:       ptr git_repository,
    entry:      ptr git_tree_entry
  ): cint {.dynlib: libgitDl, importc.}


proc git_treebuilder_new*(
    arg_out: ptr ptr git_treebuilder,
    repo:    ptr git_repository,
    source:  ptr git_tree
  ): cint {.dynlib: libgitDl, importc.}


proc git_treebuilder_clear*(
    bld: ptr git_treebuilder
  ): cint {.dynlib: libgitDl, importc.}


proc git_treebuilder_entrycount*(
    bld: ptr git_treebuilder
  ): csize_t {.dynlib: libgitDl, importc.}


proc git_treebuilder_free*(
    bld: ptr git_treebuilder
  ): void {.dynlib: libgitDl, importc.}


proc git_treebuilder_get*(
    bld:      ptr git_treebuilder,
    filename: cstring
  ): ptr git_tree_entry {.dynlib: libgitDl, importc.}


proc git_treebuilder_insert*(
    arg_out:  ptr ptr git_tree_entry,
    bld:      ptr git_treebuilder,
    filename: cstring,
    id:       ptr git_oid,
    filemode: git_filemode_t
  ): cint {.dynlib: libgitDl, importc.}


proc git_treebuilder_remove*(
    bld:      ptr git_treebuilder,
    filename: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_treebuilder_filter*(
    bld:     ptr git_treebuilder,
    filter:  git_treebuilder_filter_cb,
    payload: pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_treebuilder_write*(
    id:  ptr git_oid,
    bld: ptr git_treebuilder
  ): cint {.dynlib: libgitDl, importc.}


proc git_treebuilder_write_with_buffer*(
    oid:  ptr git_oid,
    bld:  ptr git_treebuilder,
    tree: ptr git_buf
  ): cint {.dynlib: libgitDl, importc.}


proc git_tree_walk*(
    tree:     ptr git_tree,
    mode:     git_treewalk_mode,
    callback: git_treewalk_cb,
    payload:  pointer
  ): cint {.dynlib: libgitDl, importc.}


proc git_tree_dup*(
    arg_out: ptr ptr git_tree,
    source:  ptr git_tree
  ): cint {.dynlib: libgitDl, importc.}


proc git_tree_create_updated*(
    arg_out:  ptr git_oid,
    repo:     ptr git_repository,
    baseline: ptr git_tree,
    nupdates: csize_t,
    updates:  ptr git_tree_update
  ): cint {.dynlib: libgitDl, importc.}


