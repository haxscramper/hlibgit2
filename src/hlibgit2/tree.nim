import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./oid.nim"

type
  git_tree_update* {.header: "<tree.h>", importc, bycopy.} = object
    action   *: git_tree_update_t
    id       *: git_oid
    filemode *: git_filemode_t
    path     *: cstring

  c_git_treewalk_mode* {.size: sizeof(cint).} = enum
    c_GIT_TREEWALK_PRE  = 0
    c_GIT_TREEWALK_POST = 1

  git_treewalk_mode* = enum
    GIT_TREEWALK_PRE  = 0
    GIT_TREEWALK_POST = 1

  c_git_tree_update_t* {.size: sizeof(cint).} = enum
    c_GIT_TREE_UPDATE_UPSERT = 0
    c_GIT_TREE_UPDATE_REMOVE = 1

  git_tree_update_t* = enum
    GIT_TREE_UPDATE_UPSERT = 0
    GIT_TREE_UPDATE_REMOVE = 1

  git_treebuilder_filter_cb* = proc (a0: ptr git_tree_entry, a1: pointer): cint

  git_treewalk_cb* = proc (a0: cstring, a1: ptr git_tree_entry, a2: pointer): cint



converter to_git_treewalk_mode*(arg: c_git_treewalk_mode): git_treewalk_mode =
  case arg:
    of c_GIT_TREEWALK_PRE : GIT_TREEWALK_PRE
    of c_GIT_TREEWALK_POST: GIT_TREEWALK_POST

proc to_c_git_treewalk_mode*(arg: git_treewalk_mode): c_git_treewalk_mode =
  case arg:
    of GIT_TREEWALK_PRE : c_GIT_TREEWALK_PRE
    of GIT_TREEWALK_POST: c_GIT_TREEWALK_POST

converter toCInt*(arg: c_git_treewalk_mode): cint = cint(ord(arg))

converter toCInt*(arg: git_treewalk_mode): cint = cint(ord(to_c_git_treewalk_mode(arg)))

converter toCInt*(args: set[git_treewalk_mode]): cint =
  for value in items(args):
    case value:
      of GIT_TREEWALK_PRE : result = cint(result or 0)
      of GIT_TREEWALK_POST: result = cint(result or 1)

func `-`*(arg: c_git_treewalk_mode, offset: int): cint = cast[c_git_treewalk_mode](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_treewalk_mode): cint = cast[c_git_treewalk_mode](ord(arg) - offset)

func `+`*(arg: c_git_treewalk_mode, offset: int): cint = cast[c_git_treewalk_mode](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_treewalk_mode): cint = cast[c_git_treewalk_mode](ord(arg) + offset)

converter to_git_tree_update_t*(arg: c_git_tree_update_t): git_tree_update_t =
  case arg:
    of c_GIT_TREE_UPDATE_UPSERT: GIT_TREE_UPDATE_UPSERT
    of c_GIT_TREE_UPDATE_REMOVE: GIT_TREE_UPDATE_REMOVE

proc to_c_git_tree_update_t*(arg: git_tree_update_t): c_git_tree_update_t =
  case arg:
    of GIT_TREE_UPDATE_UPSERT: c_GIT_TREE_UPDATE_UPSERT
    of GIT_TREE_UPDATE_REMOVE: c_GIT_TREE_UPDATE_REMOVE

converter toCInt*(arg: c_git_tree_update_t): cint = cint(ord(arg))

converter toCInt*(arg: git_tree_update_t): cint = cint(ord(to_c_git_tree_update_t(arg)))

converter toCInt*(args: set[git_tree_update_t]): cint =
  for value in items(args):
    case value:
      of GIT_TREE_UPDATE_UPSERT: result = cint(result or 0)
      of GIT_TREE_UPDATE_REMOVE: result = cint(result or 1)

func `-`*(arg: c_git_tree_update_t, offset: int): cint = cast[c_git_tree_update_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_tree_update_t): cint = cast[c_git_tree_update_t](ord(arg) - offset)

func `+`*(arg: c_git_tree_update_t, offset: int): cint = cast[c_git_tree_update_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_tree_update_t): cint = cast[c_git_tree_update_t](ord(arg) + offset)

proc git_tree_lookup*(
    `out`: ptr ptr git_tree,
    repo: ptr git_repository,
    id: ptr git_oid,
): cint {.importc: "git_tree_lookup", header: "<tree.h>".}

proc git_tree_lookup_prefix*(
    `out`: ptr ptr git_tree,
    repo: ptr git_repository,
    id: ptr git_oid,
    len: csize_t,
): cint {.importc: "git_tree_lookup_prefix", header: "<tree.h>".}

proc git_tree_free*(tree: ptr git_tree): void {.importc: "git_tree_free", header: "<tree.h>".}

proc git_tree_id*(tree: ptr git_tree): ptr git_oid {.importc: "git_tree_id", header: "<tree.h>".}

proc git_tree_owner*(tree: ptr git_tree): ptr git_repository {.importc: "git_tree_owner", header: "<tree.h>".}

proc git_tree_entrycount*(tree: ptr git_tree): csize_t {.importc: "git_tree_entrycount", header: "<tree.h>".}

proc git_tree_entry_byname*(tree: ptr git_tree, filename: cstring): ptr git_tree_entry {.importc: "git_tree_entry_byname", header: "<tree.h>".}

proc git_tree_entry_byindex*(tree: ptr git_tree, idx: csize_t): ptr git_tree_entry {.importc: "git_tree_entry_byindex", header: "<tree.h>".}

proc git_tree_entry_byid*(tree: ptr git_tree, id: ptr git_oid): ptr git_tree_entry {.importc: "git_tree_entry_byid", header: "<tree.h>".}

proc git_tree_entry_bypath*(
    `out`: ptr ptr git_tree_entry,
    root: ptr git_tree,
    path: cstring,
): cint {.importc: "git_tree_entry_bypath", header: "<tree.h>".}

proc git_tree_entry_dup*(dest: ptr ptr git_tree_entry, source: ptr git_tree_entry): cint {.importc: "git_tree_entry_dup", header: "<tree.h>".}

proc git_tree_entry_free*(entry: ptr git_tree_entry): void {.importc: "git_tree_entry_free", header: "<tree.h>".}

proc git_tree_entry_name*(entry: ptr git_tree_entry): cstring {.importc: "git_tree_entry_name", header: "<tree.h>".}

proc git_tree_entry_id*(entry: ptr git_tree_entry): ptr git_oid {.importc: "git_tree_entry_id", header: "<tree.h>".}

proc git_tree_entry_type*(entry: ptr git_tree_entry): git_object_t {.importc: "git_tree_entry_type", header: "<tree.h>".}

proc git_tree_entry_filemode*(entry: ptr git_tree_entry): git_filemode_t {.importc: "git_tree_entry_filemode", header: "<tree.h>".}

proc git_tree_entry_filemode_raw*(entry: ptr git_tree_entry): git_filemode_t {.importc: "git_tree_entry_filemode_raw", header: "<tree.h>".}

proc git_tree_entry_cmp*(e1: ptr git_tree_entry, e2: ptr git_tree_entry): cint {.importc: "git_tree_entry_cmp", header: "<tree.h>".}

proc git_tree_entry_to_object*(
    object_out: ptr ptr git_object,
    repo: ptr git_repository,
    entry: ptr git_tree_entry,
): cint {.importc: "git_tree_entry_to_object", header: "<tree.h>".}

proc git_treebuilder_new*(
    `out`: ptr ptr git_treebuilder,
    repo: ptr git_repository,
    source: ptr git_tree,
): cint {.importc: "git_treebuilder_new", header: "<tree.h>".}

proc git_treebuilder_clear*(bld: ptr git_treebuilder): cint {.importc: "git_treebuilder_clear", header: "<tree.h>".}

proc git_treebuilder_entrycount*(bld: ptr git_treebuilder): csize_t {.importc: "git_treebuilder_entrycount", header: "<tree.h>".}

proc git_treebuilder_free*(bld: ptr git_treebuilder): void {.importc: "git_treebuilder_free", header: "<tree.h>".}

proc git_treebuilder_get*(bld: ptr git_treebuilder, filename: cstring): ptr git_tree_entry {.importc: "git_treebuilder_get", header: "<tree.h>".}

proc git_treebuilder_insert*(
    `out`: ptr ptr git_tree_entry,
    bld: ptr git_treebuilder,
    filename: cstring,
    id: ptr git_oid,
    filemode: git_filemode_t,
): cint {.importc: "git_treebuilder_insert", header: "<tree.h>".}

proc git_treebuilder_remove*(bld: ptr git_treebuilder, filename: cstring): cint {.importc: "git_treebuilder_remove", header: "<tree.h>".}

proc git_treebuilder_filter*(
    bld: ptr git_treebuilder,
    filter: git_treebuilder_filter_cb,
    payload: pointer,
): cint {.importc: "git_treebuilder_filter", header: "<tree.h>".}

proc git_treebuilder_write*(id: ptr git_oid, bld: ptr git_treebuilder): cint {.importc: "git_treebuilder_write", header: "<tree.h>".}

proc git_tree_walk*(
    tree: ptr git_tree,
    mode: git_treewalk_mode,
    callback: git_treewalk_cb,
    payload: pointer,
): cint {.importc: "git_tree_walk", header: "<tree.h>".}

proc git_tree_dup*(`out`: ptr ptr git_tree, source: ptr git_tree): cint {.importc: "git_tree_dup", header: "<tree.h>".}

proc git_tree_create_updated*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    baseline: ptr git_tree,
    nupdates: csize_t,
    updates: ptr git_tree_update,
): cint {.importc: "git_tree_create_updated", header: "<tree.h>".}