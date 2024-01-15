type
  git_odb* {.importc, incompleteStruct.} = object


  git_odb_object* {.importc, incompleteStruct.} = object


  git_midx_writer* {.importc, incompleteStruct.} = object


  git_refdb* {.importc, incompleteStruct.} = object


  git_commit_graph* {.importc, incompleteStruct.} = object


  git_commit_graph_writer* {.importc, incompleteStruct.} = object


  git_repository* {.importc, incompleteStruct.} = object


  git_worktree* {.importc, incompleteStruct.} = object


  git_object* {.importc, incompleteStruct.} = object


  git_revwalk* {.importc, incompleteStruct.} = object


  git_tag* {.importc, incompleteStruct.} = object


  git_blob* {.importc, incompleteStruct.} = object


  git_commit* {.importc, incompleteStruct.} = object


  git_tree_entry* {.importc, incompleteStruct.} = object


  git_tree* {.importc, incompleteStruct.} = object


  git_treebuilder* {.importc, incompleteStruct.} = object


  git_index* {.importc, incompleteStruct.} = object


  git_index_iterator* {.importc, incompleteStruct.} = object


  git_index_conflict_iterator* {.importc, incompleteStruct.} = object


  git_config* {.importc, incompleteStruct.} = object


  git_reflog_entry* {.importc, incompleteStruct.} = object


  git_reflog* {.importc, incompleteStruct.} = object


  git_note* {.importc, incompleteStruct.} = object


  git_packbuilder* {.importc, incompleteStruct.} = object


  git_time* {.importc, bycopy.} = object
    time   *: git_time_t
    offset *: cint
    sign   *: char

  git_signature* {.importc, bycopy.} = object
    name   *: ptr char
    email  *: ptr char
    `when` *: git_time

  git_reference* {.importc, incompleteStruct.} = object


  git_transaction* {.importc, incompleteStruct.} = object


  git_annotated_commit* {.importc, incompleteStruct.} = object


  git_status_list* {.importc, incompleteStruct.} = object


  git_rebase* {.importc, incompleteStruct.} = object


  git_refspec* {.importc, incompleteStruct.} = object


  git_remote* {.importc, incompleteStruct.} = object


  git_push* {.importc, incompleteStruct.} = object


  git_submodule* {.importc, incompleteStruct.} = object


  git_writestream* {.importc, bycopy.} = object
    write *: proc (a0: ptr git_writestream, a1: cstring, a2: csize_t): cint
    close *: proc (a0: ptr git_writestream): cint
    free  *: proc (a0: ptr git_writestream): void

  git_mailmap* {.importc, incompleteStruct.} = object


  c_git_object_t* {.size: sizeof(cint).} = enum
    c_GIT_OBJECT_ANY       = -2
    c_GIT_OBJECT_INVALID   = -1
    c_GIT_OBJECT_COMMIT    = 1 shl 0
    c_GIT_OBJECT_TREE      = 1 shl 1
    c_GIT_OBJECT_BLOB      = 3
    c_GIT_OBJECT_TAG       = 1 shl 2
    c_GIT_OBJECT_OFS_DELTA = 6
    c_GIT_OBJECT_REF_DELTA = 7

  git_object_t* = enum
    GIT_OBJECT_ANY       = 0
    GIT_OBJECT_INVALID   = 1
    GIT_OBJECT_COMMIT    = 2
    GIT_OBJECT_TREE      = 3
    GIT_OBJECT_BLOB      = 4
    GIT_OBJECT_TAG       = 5
    GIT_OBJECT_OFS_DELTA = 6
    GIT_OBJECT_REF_DELTA = 7

  c_git_reference_t* {.size: sizeof(cint).} = enum
    c_GIT_REFERENCE_INVALID  = 0
    c_GIT_REFERENCE_DIRECT   = 1
    c_GIT_REFERENCE_SYMBOLIC = 2
    c_GIT_REFERENCE_ALL      = 3

  git_reference_t* = enum
    GIT_REFERENCE_INVALID  = 0
    GIT_REFERENCE_DIRECT   = 1
    GIT_REFERENCE_SYMBOLIC = 2
    GIT_REFERENCE_ALL      = 3

  c_git_branch_t* {.size: sizeof(cint).} = enum
    c_GIT_BRANCH_LOCAL  = 1 shl 0
    c_GIT_BRANCH_REMOTE = 1 shl 1
    c_GIT_BRANCH_ALL    = 3

  git_branch_t* = enum
    GIT_BRANCH_LOCAL  = 0
    GIT_BRANCH_REMOTE = 1
    GIT_BRANCH_ALL    = 2

  c_git_filemode_t* {.size: sizeof(cint).} = enum
    c_GIT_FILEMODE_UNREADABLE      = 0
    c_GIT_FILEMODE_TREE            = 1 shl 14
    c_GIT_FILEMODE_BLOB            = 33188
    c_GIT_FILEMODE_BLOB_EXECUTABLE = 33261
    c_GIT_FILEMODE_LINK            = 40960
    c_GIT_FILEMODE_COMMIT          = 57344

  git_filemode_t* = enum
    GIT_FILEMODE_UNREADABLE      = 0
    GIT_FILEMODE_TREE            = 1
    GIT_FILEMODE_BLOB            = 2
    GIT_FILEMODE_BLOB_EXECUTABLE = 3
    GIT_FILEMODE_LINK            = 4
    GIT_FILEMODE_COMMIT          = 5

  c_git_submodule_update_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_UPDATE_DEFAULT  = 0
    c_GIT_SUBMODULE_UPDATE_CHECKOUT = 1
    c_GIT_SUBMODULE_UPDATE_REBASE   = 2
    c_GIT_SUBMODULE_UPDATE_MERGE    = 3
    c_GIT_SUBMODULE_UPDATE_NONE     = 4

  git_submodule_update_t* = enum
    GIT_SUBMODULE_UPDATE_DEFAULT  = 0
    GIT_SUBMODULE_UPDATE_CHECKOUT = 1
    GIT_SUBMODULE_UPDATE_REBASE   = 2
    GIT_SUBMODULE_UPDATE_MERGE    = 3
    GIT_SUBMODULE_UPDATE_NONE     = 4

  c_git_submodule_ignore_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_IGNORE_UNSPECIFIED = -1
    c_GIT_SUBMODULE_IGNORE_NONE        = 1
    c_GIT_SUBMODULE_IGNORE_UNTRACKED   = 2
    c_GIT_SUBMODULE_IGNORE_DIRTY       = 3
    c_GIT_SUBMODULE_IGNORE_ALL         = 4

  git_submodule_ignore_t* = enum
    GIT_SUBMODULE_IGNORE_UNSPECIFIED = 0
    GIT_SUBMODULE_IGNORE_NONE        = 1
    GIT_SUBMODULE_IGNORE_UNTRACKED   = 2
    GIT_SUBMODULE_IGNORE_DIRTY       = 3
    GIT_SUBMODULE_IGNORE_ALL         = 4

  c_git_submodule_recurse_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_RECURSE_NO       = 0
    c_GIT_SUBMODULE_RECURSE_YES      = 1
    c_GIT_SUBMODULE_RECURSE_ONDEMAND = 2

  git_submodule_recurse_t* = enum
    GIT_SUBMODULE_RECURSE_NO       = 0
    GIT_SUBMODULE_RECURSE_YES      = 1
    GIT_SUBMODULE_RECURSE_ONDEMAND = 2

  git_off_t* = int64

  git_time_t* = int64

  git_object_size_t* = uint64



converter to_git_object_t*(arg: c_git_object_t): git_object_t =
  case arg:
    of c_GIT_OBJECT_ANY      : GIT_OBJECT_ANY
    of c_GIT_OBJECT_INVALID  : GIT_OBJECT_INVALID
    of c_GIT_OBJECT_COMMIT   : GIT_OBJECT_COMMIT
    of c_GIT_OBJECT_TREE     : GIT_OBJECT_TREE
    of c_GIT_OBJECT_BLOB     : GIT_OBJECT_BLOB
    of c_GIT_OBJECT_TAG      : GIT_OBJECT_TAG
    of c_GIT_OBJECT_OFS_DELTA: GIT_OBJECT_OFS_DELTA
    of c_GIT_OBJECT_REF_DELTA: GIT_OBJECT_REF_DELTA

proc to_c_git_object_t*(arg: git_object_t): c_git_object_t =
  case arg:
    of GIT_OBJECT_ANY      : c_GIT_OBJECT_ANY
    of GIT_OBJECT_INVALID  : c_GIT_OBJECT_INVALID
    of GIT_OBJECT_COMMIT   : c_GIT_OBJECT_COMMIT
    of GIT_OBJECT_TREE     : c_GIT_OBJECT_TREE
    of GIT_OBJECT_BLOB     : c_GIT_OBJECT_BLOB
    of GIT_OBJECT_TAG      : c_GIT_OBJECT_TAG
    of GIT_OBJECT_OFS_DELTA: c_GIT_OBJECT_OFS_DELTA
    of GIT_OBJECT_REF_DELTA: c_GIT_OBJECT_REF_DELTA

converter toCInt*(arg: c_git_object_t): cint = cint(ord(arg))

converter toCInt*(arg: git_object_t): cint = cint(ord(to_c_git_object_t(arg)))

converter toCInt*(args: set[git_object_t]): cint =
  for value in items(args):
    case value:
      of GIT_OBJECT_ANY      : result = cint(result or -2)
      of GIT_OBJECT_INVALID  : result = cint(result or -1)
      of GIT_OBJECT_COMMIT   : result = cint(result or 1)
      of GIT_OBJECT_TREE     : result = cint(result or 2)
      of GIT_OBJECT_BLOB     : result = cint(result or 3)
      of GIT_OBJECT_TAG      : result = cint(result or 4)
      of GIT_OBJECT_OFS_DELTA: result = cint(result or 6)
      of GIT_OBJECT_REF_DELTA: result = cint(result or 7)

func `-`*(arg: c_git_object_t, offset: int): cint = cast[c_git_object_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_object_t): cint = cast[c_git_object_t](ord(arg) - offset)

func `+`*(arg: c_git_object_t, offset: int): cint = cast[c_git_object_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_object_t): cint = cast[c_git_object_t](ord(arg) + offset)

converter to_git_reference_t*(arg: c_git_reference_t): git_reference_t =
  case arg:
    of c_GIT_REFERENCE_INVALID : GIT_REFERENCE_INVALID
    of c_GIT_REFERENCE_DIRECT  : GIT_REFERENCE_DIRECT
    of c_GIT_REFERENCE_SYMBOLIC: GIT_REFERENCE_SYMBOLIC
    of c_GIT_REFERENCE_ALL     : GIT_REFERENCE_ALL

proc to_c_git_reference_t*(arg: git_reference_t): c_git_reference_t =
  case arg:
    of GIT_REFERENCE_INVALID : c_GIT_REFERENCE_INVALID
    of GIT_REFERENCE_DIRECT  : c_GIT_REFERENCE_DIRECT
    of GIT_REFERENCE_SYMBOLIC: c_GIT_REFERENCE_SYMBOLIC
    of GIT_REFERENCE_ALL     : c_GIT_REFERENCE_ALL

converter toCInt*(arg: c_git_reference_t): cint = cint(ord(arg))

converter toCInt*(arg: git_reference_t): cint = cint(ord(to_c_git_reference_t(arg)))

converter toCInt*(args: set[git_reference_t]): cint =
  for value in items(args):
    case value:
      of GIT_REFERENCE_INVALID : result = cint(result or 0)
      of GIT_REFERENCE_DIRECT  : result = cint(result or 1)
      of GIT_REFERENCE_SYMBOLIC: result = cint(result or 2)
      of GIT_REFERENCE_ALL     : result = cint(result or 3)

func `-`*(arg: c_git_reference_t, offset: int): cint = cast[c_git_reference_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_reference_t): cint = cast[c_git_reference_t](ord(arg) - offset)

func `+`*(arg: c_git_reference_t, offset: int): cint = cast[c_git_reference_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_reference_t): cint = cast[c_git_reference_t](ord(arg) + offset)

converter to_git_branch_t*(arg: c_git_branch_t): git_branch_t =
  case arg:
    of c_GIT_BRANCH_LOCAL : GIT_BRANCH_LOCAL
    of c_GIT_BRANCH_REMOTE: GIT_BRANCH_REMOTE
    of c_GIT_BRANCH_ALL   : GIT_BRANCH_ALL

proc to_c_git_branch_t*(arg: git_branch_t): c_git_branch_t =
  case arg:
    of GIT_BRANCH_LOCAL : c_GIT_BRANCH_LOCAL
    of GIT_BRANCH_REMOTE: c_GIT_BRANCH_REMOTE
    of GIT_BRANCH_ALL   : c_GIT_BRANCH_ALL

converter toCInt*(arg: c_git_branch_t): cint = cint(ord(arg))

converter toCInt*(arg: git_branch_t): cint = cint(ord(to_c_git_branch_t(arg)))

converter toCInt*(args: set[git_branch_t]): cint =
  for value in items(args):
    case value:
      of GIT_BRANCH_LOCAL : result = cint(result or 1)
      of GIT_BRANCH_REMOTE: result = cint(result or 2)
      of GIT_BRANCH_ALL   : result = cint(result or 3)

func `-`*(arg: c_git_branch_t, offset: int): cint = cast[c_git_branch_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_branch_t): cint = cast[c_git_branch_t](ord(arg) - offset)

func `+`*(arg: c_git_branch_t, offset: int): cint = cast[c_git_branch_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_branch_t): cint = cast[c_git_branch_t](ord(arg) + offset)

converter to_git_filemode_t*(arg: c_git_filemode_t): git_filemode_t =
  case arg:
    of c_GIT_FILEMODE_UNREADABLE     : GIT_FILEMODE_UNREADABLE
    of c_GIT_FILEMODE_TREE           : GIT_FILEMODE_TREE
    of c_GIT_FILEMODE_BLOB           : GIT_FILEMODE_BLOB
    of c_GIT_FILEMODE_BLOB_EXECUTABLE: GIT_FILEMODE_BLOB_EXECUTABLE
    of c_GIT_FILEMODE_LINK           : GIT_FILEMODE_LINK
    of c_GIT_FILEMODE_COMMIT         : GIT_FILEMODE_COMMIT

proc to_c_git_filemode_t*(arg: git_filemode_t): c_git_filemode_t =
  case arg:
    of GIT_FILEMODE_UNREADABLE     : c_GIT_FILEMODE_UNREADABLE
    of GIT_FILEMODE_TREE           : c_GIT_FILEMODE_TREE
    of GIT_FILEMODE_BLOB           : c_GIT_FILEMODE_BLOB
    of GIT_FILEMODE_BLOB_EXECUTABLE: c_GIT_FILEMODE_BLOB_EXECUTABLE
    of GIT_FILEMODE_LINK           : c_GIT_FILEMODE_LINK
    of GIT_FILEMODE_COMMIT         : c_GIT_FILEMODE_COMMIT

converter toCInt*(arg: c_git_filemode_t): cint = cint(ord(arg))

converter toCInt*(arg: git_filemode_t): cint = cint(ord(to_c_git_filemode_t(arg)))

converter toCInt*(args: set[git_filemode_t]): cint =
  for value in items(args):
    case value:
      of GIT_FILEMODE_UNREADABLE     : result = cint(result or 0)
      of GIT_FILEMODE_TREE           : result = cint(result or 16384)
      of GIT_FILEMODE_BLOB           : result = cint(result or 33188)
      of GIT_FILEMODE_BLOB_EXECUTABLE: result = cint(result or 33261)
      of GIT_FILEMODE_LINK           : result = cint(result or 40960)
      of GIT_FILEMODE_COMMIT         : result = cint(result or 57344)

func `-`*(arg: c_git_filemode_t, offset: int): cint = cast[c_git_filemode_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_filemode_t): cint = cast[c_git_filemode_t](ord(arg) - offset)

func `+`*(arg: c_git_filemode_t, offset: int): cint = cast[c_git_filemode_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_filemode_t): cint = cast[c_git_filemode_t](ord(arg) + offset)

converter to_git_submodule_update_t*(arg: c_git_submodule_update_t): git_submodule_update_t =
  case arg:
    of c_GIT_SUBMODULE_UPDATE_DEFAULT : GIT_SUBMODULE_UPDATE_DEFAULT
    of c_GIT_SUBMODULE_UPDATE_CHECKOUT: GIT_SUBMODULE_UPDATE_CHECKOUT
    of c_GIT_SUBMODULE_UPDATE_REBASE  : GIT_SUBMODULE_UPDATE_REBASE
    of c_GIT_SUBMODULE_UPDATE_MERGE   : GIT_SUBMODULE_UPDATE_MERGE
    of c_GIT_SUBMODULE_UPDATE_NONE    : GIT_SUBMODULE_UPDATE_NONE

proc to_c_git_submodule_update_t*(arg: git_submodule_update_t): c_git_submodule_update_t =
  case arg:
    of GIT_SUBMODULE_UPDATE_DEFAULT : c_GIT_SUBMODULE_UPDATE_DEFAULT
    of GIT_SUBMODULE_UPDATE_CHECKOUT: c_GIT_SUBMODULE_UPDATE_CHECKOUT
    of GIT_SUBMODULE_UPDATE_REBASE  : c_GIT_SUBMODULE_UPDATE_REBASE
    of GIT_SUBMODULE_UPDATE_MERGE   : c_GIT_SUBMODULE_UPDATE_MERGE
    of GIT_SUBMODULE_UPDATE_NONE    : c_GIT_SUBMODULE_UPDATE_NONE

converter toCInt*(arg: c_git_submodule_update_t): cint = cint(ord(arg))

converter toCInt*(arg: git_submodule_update_t): cint = cint(ord(to_c_git_submodule_update_t(arg)))

converter toCInt*(args: set[git_submodule_update_t]): cint =
  for value in items(args):
    case value:
      of GIT_SUBMODULE_UPDATE_DEFAULT : result = cint(result or 0)
      of GIT_SUBMODULE_UPDATE_CHECKOUT: result = cint(result or 1)
      of GIT_SUBMODULE_UPDATE_REBASE  : result = cint(result or 2)
      of GIT_SUBMODULE_UPDATE_MERGE   : result = cint(result or 3)
      of GIT_SUBMODULE_UPDATE_NONE    : result = cint(result or 4)

func `-`*(arg: c_git_submodule_update_t, offset: int): cint = cast[c_git_submodule_update_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_submodule_update_t): cint = cast[c_git_submodule_update_t](ord(arg) - offset)

func `+`*(arg: c_git_submodule_update_t, offset: int): cint = cast[c_git_submodule_update_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_submodule_update_t): cint = cast[c_git_submodule_update_t](ord(arg) + offset)

converter to_git_submodule_ignore_t*(arg: c_git_submodule_ignore_t): git_submodule_ignore_t =
  case arg:
    of c_GIT_SUBMODULE_IGNORE_UNSPECIFIED: GIT_SUBMODULE_IGNORE_UNSPECIFIED
    of c_GIT_SUBMODULE_IGNORE_NONE       : GIT_SUBMODULE_IGNORE_NONE
    of c_GIT_SUBMODULE_IGNORE_UNTRACKED  : GIT_SUBMODULE_IGNORE_UNTRACKED
    of c_GIT_SUBMODULE_IGNORE_DIRTY      : GIT_SUBMODULE_IGNORE_DIRTY
    of c_GIT_SUBMODULE_IGNORE_ALL        : GIT_SUBMODULE_IGNORE_ALL

proc to_c_git_submodule_ignore_t*(arg: git_submodule_ignore_t): c_git_submodule_ignore_t =
  case arg:
    of GIT_SUBMODULE_IGNORE_UNSPECIFIED: c_GIT_SUBMODULE_IGNORE_UNSPECIFIED
    of GIT_SUBMODULE_IGNORE_NONE       : c_GIT_SUBMODULE_IGNORE_NONE
    of GIT_SUBMODULE_IGNORE_UNTRACKED  : c_GIT_SUBMODULE_IGNORE_UNTRACKED
    of GIT_SUBMODULE_IGNORE_DIRTY      : c_GIT_SUBMODULE_IGNORE_DIRTY
    of GIT_SUBMODULE_IGNORE_ALL        : c_GIT_SUBMODULE_IGNORE_ALL

converter toCInt*(arg: c_git_submodule_ignore_t): cint = cint(ord(arg))

converter toCInt*(arg: git_submodule_ignore_t): cint = cint(ord(to_c_git_submodule_ignore_t(arg)))

converter toCInt*(args: set[git_submodule_ignore_t]): cint =
  for value in items(args):
    case value:
      of GIT_SUBMODULE_IGNORE_UNSPECIFIED: result = cint(result or -1)
      of GIT_SUBMODULE_IGNORE_NONE       : result = cint(result or 1)
      of GIT_SUBMODULE_IGNORE_UNTRACKED  : result = cint(result or 2)
      of GIT_SUBMODULE_IGNORE_DIRTY      : result = cint(result or 3)
      of GIT_SUBMODULE_IGNORE_ALL        : result = cint(result or 4)

func `-`*(arg: c_git_submodule_ignore_t, offset: int): cint = cast[c_git_submodule_ignore_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_submodule_ignore_t): cint = cast[c_git_submodule_ignore_t](ord(arg) - offset)

func `+`*(arg: c_git_submodule_ignore_t, offset: int): cint = cast[c_git_submodule_ignore_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_submodule_ignore_t): cint = cast[c_git_submodule_ignore_t](ord(arg) + offset)

converter to_git_submodule_recurse_t*(arg: c_git_submodule_recurse_t): git_submodule_recurse_t =
  case arg:
    of c_GIT_SUBMODULE_RECURSE_NO      : GIT_SUBMODULE_RECURSE_NO
    of c_GIT_SUBMODULE_RECURSE_YES     : GIT_SUBMODULE_RECURSE_YES
    of c_GIT_SUBMODULE_RECURSE_ONDEMAND: GIT_SUBMODULE_RECURSE_ONDEMAND

proc to_c_git_submodule_recurse_t*(arg: git_submodule_recurse_t): c_git_submodule_recurse_t =
  case arg:
    of GIT_SUBMODULE_RECURSE_NO      : c_GIT_SUBMODULE_RECURSE_NO
    of GIT_SUBMODULE_RECURSE_YES     : c_GIT_SUBMODULE_RECURSE_YES
    of GIT_SUBMODULE_RECURSE_ONDEMAND: c_GIT_SUBMODULE_RECURSE_ONDEMAND

converter toCInt*(arg: c_git_submodule_recurse_t): cint = cint(ord(arg))

converter toCInt*(arg: git_submodule_recurse_t): cint = cint(ord(to_c_git_submodule_recurse_t(arg)))

converter toCInt*(args: set[git_submodule_recurse_t]): cint =
  for value in items(args):
    case value:
      of GIT_SUBMODULE_RECURSE_NO      : result = cint(result or 0)
      of GIT_SUBMODULE_RECURSE_YES     : result = cint(result or 1)
      of GIT_SUBMODULE_RECURSE_ONDEMAND: result = cint(result or 2)

func `-`*(arg: c_git_submodule_recurse_t, offset: int): cint = cast[c_git_submodule_recurse_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_submodule_recurse_t): cint = cast[c_git_submodule_recurse_t](ord(arg) - offset)

func `+`*(arg: c_git_submodule_recurse_t, offset: int): cint = cast[c_git_submodule_recurse_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_submodule_recurse_t): cint = cast[c_git_submodule_recurse_t](ord(arg) + offset)