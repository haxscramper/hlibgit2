{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_tree_update_t* {.size: sizeof(cint).} = enum
    c_GIT_TREE_UPDATE_UPSERT = 0 shl 0 ## Update or insert an entry at the specified path
    c_GIT_TREE_UPDATE_REMOVE = 1 shl 0 ## Remove an entry from the specified path

  c_git_treewalk_mode* {.size: sizeof(cint).} = enum
    c_GIT_TREEWALK_PRE  = 0 shl 0
    c_GIT_TREEWALK_POST = 1 shl 0 ## Pre-order

  git_tree_update* {.bycopy, header: "<git2/tree.h>", importc.} = object
    action*:   c_git_tree_update_t ## Update action. If it's an removal, only the path is looked at
    id*:       git_oid             ## The entry's id
    filemode*: c_git_filemode_t    ## The filemode/kind of object
    path*:     cstring             ## The full path from the root tree

  git_tree_update_t* {.size: sizeof(cint).} = enum
    GIT_TREE_UPDATE_UPSERT ## Update or insert an entry at the specified path
    GIT_TREE_UPDATE_REMOVE ## Remove an entry from the specified path

  git_treebuilder_filter_cb* = proc(entry:   ptr git_tree_entry,
                                    payload: pointer): cint{.cdecl.}

  git_treewalk_cb* = proc(root:    cstring,
                          entry:   ptr git_tree_entry,
                          payload: pointer): cint{.cdecl.}

  git_treewalk_mode* {.size: sizeof(cint).} = enum
    GIT_TREEWALK_PRE
    GIT_TREEWALK_POST ## Pre-order


proc git_tree_lookup*(
    arg_out: ptr ptr git_tree,
    repo:    ptr git_repository,
    id:      ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_tree_lookup_prefix*(
    arg_out: ptr ptr git_tree,
    repo:    ptr git_repository,
    id:      ptr git_oid,
    len:     csize_t
  ): cint {.git2Proc, importc.}



proc git_tree_free*(tree: ptr git_tree): void {.git2Proc, importc.}



proc git_tree_id*(tree: ptr git_tree): ptr git_oid {.git2Proc, importc.}



proc git_tree_owner*(
    tree: ptr git_tree
  ): ptr git_repository {.git2Proc, importc.}



proc git_tree_entrycount*(tree: ptr git_tree): csize_t {.git2Proc, importc.}



proc git_tree_entry_byname*(
    tree:     ptr git_tree,
    filename: cstring
  ): ptr git_tree_entry {.git2Proc, importc.}



proc git_tree_entry_byindex*(
    tree: ptr git_tree,
    idx:  csize_t
  ): ptr git_tree_entry {.git2Proc, importc.}



proc git_tree_entry_byid*(
    tree: ptr git_tree,
    id:   ptr git_oid
  ): ptr git_tree_entry {.git2Proc, importc.}



proc git_tree_entry_bypath*(
    arg_out: ptr ptr git_tree_entry,
    root:    ptr git_tree,
    path:    cstring
  ): cint {.git2Proc, importc.}



proc git_tree_entry_dup*(
    dest:   ptr ptr git_tree_entry,
    source: ptr git_tree_entry
  ): cint {.git2Proc, importc.}



proc git_tree_entry_free*(entry: ptr git_tree_entry): void {.git2Proc, importc.}



proc git_tree_entry_name*(
    entry: ptr git_tree_entry
  ): cstring {.git2Proc, importc.}



proc git_tree_entry_id*(
    entry: ptr git_tree_entry
  ): ptr git_oid {.git2Proc, importc.}



proc git_tree_entry_type*(
    entry: ptr git_tree_entry
  ): c_git_object_t {.git2Proc, importc.}



proc git_tree_entry_filemode*(
    entry: ptr git_tree_entry
  ): c_git_filemode_t {.git2Proc, importc.}



proc git_tree_entry_filemode_raw*(
    entry: ptr git_tree_entry
  ): c_git_filemode_t {.git2Proc, importc.}



proc git_tree_entry_cmp*(
    e1: ptr git_tree_entry,
    e2: ptr git_tree_entry
  ): cint {.git2Proc, importc.}



proc git_tree_entry_to_object*(
    object_out: ptr ptr git_object,
    repo:       ptr git_repository,
    entry:      ptr git_tree_entry
  ): cint {.git2Proc, importc.}



proc git_treebuilder_new*(
    arg_out: ptr ptr git_treebuilder,
    repo:    ptr git_repository,
    source:  ptr git_tree
  ): cint {.git2Proc, importc.}



proc git_treebuilder_clear*(
    bld: ptr git_treebuilder
  ): cint {.git2Proc, importc.}



proc git_treebuilder_entrycount*(
    bld: ptr git_treebuilder
  ): csize_t {.git2Proc, importc.}



proc git_treebuilder_free*(bld: ptr git_treebuilder): void {.git2Proc, importc.}



proc git_treebuilder_get*(
    bld:      ptr git_treebuilder,
    filename: cstring
  ): ptr git_tree_entry {.git2Proc, importc.}



proc git_treebuilder_insert*(
    arg_out:  ptr ptr git_tree_entry,
    bld:      ptr git_treebuilder,
    filename: cstring,
    id:       ptr git_oid,
    filemode: c_git_filemode_t
  ): cint {.git2Proc, importc.}



proc git_treebuilder_remove*(
    bld:      ptr git_treebuilder,
    filename: cstring
  ): cint {.git2Proc, importc.}



proc git_treebuilder_filter*(
    bld:     ptr git_treebuilder,
    filter:  git_treebuilder_filter_cb,
    payload: pointer
  ): cint {.git2Proc, importc.}



proc git_treebuilder_write*(
    id:  ptr git_oid,
    bld: ptr git_treebuilder
  ): cint {.git2Proc, importc.}



proc to_c_git_treewalk_mode*(arg: git_treewalk_mode): c_git_treewalk_mode =
  case arg:
    of GIT_TREEWALK_PRE:  c_GIT_TREEWALK_PRE
    of GIT_TREEWALK_POST: c_GIT_TREEWALK_POST


converter to_git_treewalk_mode*(arg: c_git_treewalk_mode): git_treewalk_mode =
  case arg:
    of c_GIT_TREEWALK_PRE:  GIT_TREEWALK_PRE
    of c_GIT_TREEWALK_POST: GIT_TREEWALK_POST


converter toCint*(arg: c_git_treewalk_mode): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_treewalk_mode): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_treewalk_mode(arg)))

func `+`*(arg: c_git_treewalk_mode, offset: int): c_git_treewalk_mode =
  cast[c_git_treewalk_mode](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_treewalk_mode): c_git_treewalk_mode =
  cast[c_git_treewalk_mode](ord(arg) + offset)

func `-`*(arg: c_git_treewalk_mode, offset: int): c_git_treewalk_mode =
  cast[c_git_treewalk_mode](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_treewalk_mode): c_git_treewalk_mode =
  cast[c_git_treewalk_mode](ord(arg) - offset)


converter toCint*(args: set[git_treewalk_mode]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_TREEWALK_PRE:  result = cint(result or (0 shl 0))
      of GIT_TREEWALK_POST: result = cint(result or (1 shl 0))


proc git_tree_walk*(
    tree:     ptr git_tree,
    mode:     c_git_treewalk_mode,
    callback: git_treewalk_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_tree_dup*(
    arg_out: ptr ptr git_tree,
    source:  ptr git_tree
  ): cint {.git2Proc, importc.}



proc to_c_git_tree_update_t*(arg: git_tree_update_t): c_git_tree_update_t =
  case arg:
    of GIT_TREE_UPDATE_UPSERT: c_GIT_TREE_UPDATE_UPSERT
    of GIT_TREE_UPDATE_REMOVE: c_GIT_TREE_UPDATE_REMOVE


converter to_git_tree_update_t*(arg: c_git_tree_update_t): git_tree_update_t =
  case arg:
    of c_GIT_TREE_UPDATE_UPSERT: GIT_TREE_UPDATE_UPSERT
    of c_GIT_TREE_UPDATE_REMOVE: GIT_TREE_UPDATE_REMOVE


converter toCint*(arg: c_git_tree_update_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_tree_update_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_tree_update_t(arg)))

func `+`*(arg: c_git_tree_update_t, offset: int): c_git_tree_update_t =
  cast[c_git_tree_update_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_tree_update_t): c_git_tree_update_t =
  cast[c_git_tree_update_t](ord(arg) + offset)

func `-`*(arg: c_git_tree_update_t, offset: int): c_git_tree_update_t =
  cast[c_git_tree_update_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_tree_update_t): c_git_tree_update_t =
  cast[c_git_tree_update_t](ord(arg) - offset)


converter toCint*(args: set[git_tree_update_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_TREE_UPDATE_UPSERT: result = cint(result or (0 shl 0))
      of GIT_TREE_UPDATE_REMOVE: result = cint(result or (1 shl 0))


proc git_tree_create_updated*(
    arg_out:  ptr git_oid,
    repo:     ptr git_repository,
    baseline: ptr git_tree,
    nupdates: csize_t,
    updates:  ptr git_tree_update
  ): cint {.git2Proc, importc.}



