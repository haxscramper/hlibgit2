import "../oid.nim"
import "../types.nim"

type
  git_tree_update* {.importc, bycopy.} = object
    action   *: git_tree_update_t
    id       *: git_oid
    filemode *: git_filemode_t
    path     *: cstring

  c_git_tree_update_t {.size: sizeof(cint).} = enum
    c_GIT_TREE_UPDATE_UPSERT = 0 shl 0
    c_GIT_TREE_UPDATE_REMOVE = 1 shl 0

  git_tree_update_t = enum
    GIT_TREE_UPDATE_UPSERT
    GIT_TREE_UPDATE_REMOVE

  c_git_treewalk_mode {.size: sizeof(cint).} = enum
    c_GIT_TREEWALK_PRE  = 0 shl 0
    c_GIT_TREEWALK_POST = 1 shl 0

  git_treewalk_mode = enum
    GIT_TREEWALK_PRE
    GIT_TREEWALK_POST

  git_treebuilder_filter_cb = proc (a0: ptr git_tree_entry, a1: ptr void): cint

  git_treewalk_cb = proc (a0: cstring, a1: ptr git_tree_entry, a2: ptr void): cint



converter toCInt*(arg: c_git_tree_update_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_tree_update_t)): cint =
  for value in items(args):
    case value:
      of GIT_TREE_UPDATE_UPSERT: result = cint(result or 0)
      of GIT_TREE_UPDATE_REMOVE: result = cint(result or 1)

func `-`*(arg: c_git_tree_update_t, offset: int): cint = cast[c_git_tree_update_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_tree_update_t): cint = cast[c_git_tree_update_t](ord(arg) - offset)

func `+`*(arg: c_git_tree_update_t, offset: int): cint = cast[c_git_tree_update_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_tree_update_t): cint = cast[c_git_tree_update_t](ord(arg) + offset)

converter toCInt*(arg: c_git_treewalk_mode): cint = cint(ord(arg))

converter toCInt*(args: set(git_treewalk_mode)): cint =
  for value in items(args):
    case value:
      of GIT_TREEWALK_PRE : result = cint(result or 0)
      of GIT_TREEWALK_POST: result = cint(result or 1)

func `-`*(arg: c_git_treewalk_mode, offset: int): cint = cast[c_git_treewalk_mode](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_treewalk_mode): cint = cast[c_git_treewalk_mode](ord(arg) - offset)

func `+`*(arg: c_git_treewalk_mode, offset: int): cint = cast[c_git_treewalk_mode](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_treewalk_mode): cint = cast[c_git_treewalk_mode](ord(arg) + offset)

proc git_tree_lookup*(out: ptr git_tree, repo: ptr git_repository, id: ptr git_oid): cint {.git2Proc, importc.}

proc git_tree_lookup_prefix*(out: ptr git_tree, repo: ptr git_repository, id: ptr git_oid, len: csize_t): cint {.git2Proc, importc.}

proc git_tree_free*(tree: ptr git_tree): void {.git2Proc, importc.}

proc git_tree_id*(tree: ptr git_tree): ptr git_oid {.git2Proc, importc.}

proc git_tree_owner*(tree: ptr git_tree): ptr git_repository {.git2Proc, importc.}

proc git_tree_entrycount*(tree: ptr git_tree): csize_t {.git2Proc, importc.}

proc git_tree_entry_byname*(tree: ptr git_tree, filename: cstring): ptr git_tree_entry {.git2Proc, importc.}

proc git_tree_entry_byindex*(tree: ptr git_tree, idx: csize_t): ptr git_tree_entry {.git2Proc, importc.}

proc git_tree_entry_byid*(tree: ptr git_tree, id: ptr git_oid): ptr git_tree_entry {.git2Proc, importc.}

proc git_tree_entry_bypath*(out: ptr git_tree_entry, root: ptr git_tree, path: cstring): cint {.git2Proc, importc.}

proc git_tree_entry_dup*(dest: ptr git_tree_entry, source: ptr git_tree_entry): cint {.git2Proc, importc.}

proc git_tree_entry_free*(entry: ptr git_tree_entry): void {.git2Proc, importc.}

proc git_tree_entry_name*(entry: ptr git_tree_entry): cstring {.git2Proc, importc.}

proc git_tree_entry_id*(entry: ptr git_tree_entry): ptr git_oid {.git2Proc, importc.}

proc git_tree_entry_type*(entry: ptr git_tree_entry): git_object_t {.git2Proc, importc.}

proc git_tree_entry_filemode*(entry: ptr git_tree_entry): git_filemode_t {.git2Proc, importc.}

proc git_tree_entry_filemode_raw*(entry: ptr git_tree_entry): git_filemode_t {.git2Proc, importc.}

proc git_tree_entry_cmp*(e1: ptr git_tree_entry, e2: ptr git_tree_entry): cint {.git2Proc, importc.}

proc git_tree_entry_to_object*(object_out: ptr git_object, repo: ptr git_repository, entry: ptr git_tree_entry): cint {.git2Proc, importc.}

proc git_treebuilder_new*(out: ptr git_treebuilder, repo: ptr git_repository, source: ptr git_tree): cint {.git2Proc, importc.}

proc git_treebuilder_clear*(bld: ptr git_treebuilder): cint {.git2Proc, importc.}

proc git_treebuilder_entrycount*(bld: ptr git_treebuilder): csize_t {.git2Proc, importc.}

proc git_treebuilder_free*(bld: ptr git_treebuilder): void {.git2Proc, importc.}

proc git_treebuilder_get*(bld: ptr git_treebuilder, filename: cstring): ptr git_tree_entry {.git2Proc, importc.}

proc git_treebuilder_insert*(out: ptr git_tree_entry, bld: ptr git_treebuilder, filename: cstring, id: ptr git_oid, filemode: git_filemode_t): cint {.git2Proc, importc.}

proc git_treebuilder_remove*(bld: ptr git_treebuilder, filename: cstring): cint {.git2Proc, importc.}

proc git_treebuilder_filter*(bld: ptr git_treebuilder, filter: git_treebuilder_filter_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_treebuilder_write*(id: ptr git_oid, bld: ptr git_treebuilder): cint {.git2Proc, importc.}

proc git_tree_walk*(tree: ptr git_tree, mode: git_treewalk_mode, callback: git_treewalk_cb, payload: ptr void): cint {.git2Proc, importc.}

proc git_tree_dup*(out: ptr git_tree, source: ptr git_tree): cint {.git2Proc, importc.}

proc git_tree_create_updated*(out: ptr git_oid, repo: ptr git_repository, baseline: ptr git_tree, nupdates: csize_t, updates: ptr git_tree_update): cint {.git2Proc, importc.}