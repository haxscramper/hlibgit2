import "./libgit2_config.nim" ## From gen file

type
  git_odb* {.importc, bycopy, incompleteStruct.} = object


  git_odb_object* {.importc, bycopy, incompleteStruct.} = object


  git_midx_writer* {.importc, bycopy, incompleteStruct.} = object


  git_refdb* {.importc, bycopy, incompleteStruct.} = object


  git_commit_graph* {.importc, bycopy, incompleteStruct.} = object


  git_commit_graph_writer* {.importc, bycopy, incompleteStruct.} = object


  git_repository* {.importc, bycopy, incompleteStruct.} = object


  git_worktree* {.importc, bycopy, incompleteStruct.} = object


  git_object* {.importc, bycopy, incompleteStruct.} = object


  git_revwalk* {.importc, bycopy, incompleteStruct.} = object


  git_tag* {.importc, bycopy, incompleteStruct.} = object


  git_blob* {.importc, bycopy, incompleteStruct.} = object


  git_commit* {.importc, bycopy, incompleteStruct.} = object


  git_tree_entry* {.importc, bycopy, incompleteStruct.} = object


  git_tree* {.importc, bycopy, incompleteStruct.} = object


  git_treebuilder* {.importc, bycopy, incompleteStruct.} = object


  git_index* {.importc, bycopy, incompleteStruct.} = object


  git_index_iterator* {.importc, bycopy, incompleteStruct.} = object


  git_index_conflict_iterator* {.importc, bycopy, incompleteStruct.} = object


  git_config* {.importc, bycopy, incompleteStruct.} = object


  git_reflog_entry* {.importc, bycopy, incompleteStruct.} = object


  git_reflog* {.importc, bycopy, incompleteStruct.} = object


  git_note* {.importc, bycopy, incompleteStruct.} = object


  git_packbuilder* {.importc, bycopy, incompleteStruct.} = object


  git_time* {.importc, bycopy.} = object
    time   *: git_time_t
    offset *: cint
    sign   *: char

  git_signature* {.importc, bycopy.} = object
    name   *: `ptr` char
    email  *: `ptr` char
    `when` *: git_time

  git_reference* {.importc, bycopy, incompleteStruct.} = object


  git_transaction* {.importc, bycopy, incompleteStruct.} = object


  git_annotated_commit* {.importc, bycopy, incompleteStruct.} = object


  git_status_list* {.importc, bycopy, incompleteStruct.} = object


  git_rebase* {.importc, bycopy, incompleteStruct.} = object


  git_refspec* {.importc, bycopy, incompleteStruct.} = object


  git_remote* {.importc, bycopy, incompleteStruct.} = object


  git_push* {.importc, bycopy, incompleteStruct.} = object


  git_submodule* {.importc, bycopy, incompleteStruct.} = object


  git_writestream* {.importc, bycopy, incompleteStruct.} = object
    write *: proc (a0: `ptr` git_writestream, a1: cstring, a2: csize_t): cint
    close *: proc (a0: `ptr` git_writestream): cint
    free  *: proc (a0: `ptr` git_writestream): void

  git_mailmap* {.importc, bycopy, incompleteStruct.} = object


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
    GIT_OBJECT_ANY
    GIT_OBJECT_INVALID
    GIT_OBJECT_COMMIT
    GIT_OBJECT_TREE
    GIT_OBJECT_BLOB
    GIT_OBJECT_TAG
    GIT_OBJECT_OFS_DELTA
    GIT_OBJECT_REF_DELTA

  c_git_reference_t* {.size: sizeof(cint).} = enum
    c_GIT_REFERENCE_INVALID  = 0
    c_GIT_REFERENCE_DIRECT   = 1
    c_GIT_REFERENCE_SYMBOLIC = 2
    c_GIT_REFERENCE_ALL      = 3

  git_reference_t* = enum
    GIT_REFERENCE_INVALID
    GIT_REFERENCE_DIRECT
    GIT_REFERENCE_SYMBOLIC
    GIT_REFERENCE_ALL

  c_git_branch_t* {.size: sizeof(cint).} = enum
    c_GIT_BRANCH_LOCAL  = 1 shl 0
    c_GIT_BRANCH_REMOTE = 1 shl 1
    c_GIT_BRANCH_ALL    = 3

  git_branch_t* = enum
    GIT_BRANCH_LOCAL
    GIT_BRANCH_REMOTE
    GIT_BRANCH_ALL

  c_git_filemode_t* {.size: sizeof(cint).} = enum
    c_GIT_FILEMODE_UNREADABLE      = 0
    c_GIT_FILEMODE_TREE            = 1 shl 14
    c_GIT_FILEMODE_BLOB            = 33188
    c_GIT_FILEMODE_BLOB_EXECUTABLE = 33261
    c_GIT_FILEMODE_LINK            = 40960
    c_GIT_FILEMODE_COMMIT          = 57344

  git_filemode_t* = enum
    GIT_FILEMODE_UNREADABLE
    GIT_FILEMODE_TREE
    GIT_FILEMODE_BLOB
    GIT_FILEMODE_BLOB_EXECUTABLE
    GIT_FILEMODE_LINK
    GIT_FILEMODE_COMMIT

  c_git_submodule_update_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_UPDATE_DEFAULT  = 0
    c_GIT_SUBMODULE_UPDATE_CHECKOUT = 1
    c_GIT_SUBMODULE_UPDATE_REBASE   = 2
    c_GIT_SUBMODULE_UPDATE_MERGE    = 3
    c_GIT_SUBMODULE_UPDATE_NONE     = 4

  git_submodule_update_t* = enum
    GIT_SUBMODULE_UPDATE_CHECKOUT
    GIT_SUBMODULE_UPDATE_REBASE
    GIT_SUBMODULE_UPDATE_MERGE
    GIT_SUBMODULE_UPDATE_NONE
    GIT_SUBMODULE_UPDATE_DEFAULT

  c_git_submodule_ignore_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_IGNORE_UNSPECIFIED = -1
    c_GIT_SUBMODULE_IGNORE_NONE        = 1
    c_GIT_SUBMODULE_IGNORE_UNTRACKED   = 2
    c_GIT_SUBMODULE_IGNORE_DIRTY       = 3
    c_GIT_SUBMODULE_IGNORE_ALL         = 4

  git_submodule_ignore_t* = enum
    GIT_SUBMODULE_IGNORE_UNSPECIFIED
    GIT_SUBMODULE_IGNORE_NONE
    GIT_SUBMODULE_IGNORE_UNTRACKED
    GIT_SUBMODULE_IGNORE_DIRTY
    GIT_SUBMODULE_IGNORE_ALL

  c_git_submodule_recurse_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_RECURSE_NO       = 0
    c_GIT_SUBMODULE_RECURSE_YES      = 1
    c_GIT_SUBMODULE_RECURSE_ONDEMAND = 2

  git_submodule_recurse_t* = enum
    GIT_SUBMODULE_RECURSE_NO
    GIT_SUBMODULE_RECURSE_YES
    GIT_SUBMODULE_RECURSE_ONDEMAND

  git_off_t* = int64

  git_time_t* = int64

  git_object_size_t* = uint64



converter toCInt*(arg: c_git_object_t): cint = cint(ord(arg))

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

converter toCInt*(arg: c_git_reference_t): cint = cint(ord(arg))

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

converter toCInt*(arg: c_git_branch_t): cint = cint(ord(arg))

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

converter toCInt*(arg: c_git_filemode_t): cint = cint(ord(arg))

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

converter toCInt*(arg: c_git_submodule_update_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_submodule_update_t]): cint =
  for value in items(args):
    case value:
      of GIT_SUBMODULE_UPDATE_CHECKOUT: result = cint(result or 1)
      of GIT_SUBMODULE_UPDATE_REBASE  : result = cint(result or 2)
      of GIT_SUBMODULE_UPDATE_MERGE   : result = cint(result or 3)
      of GIT_SUBMODULE_UPDATE_NONE    : result = cint(result or 4)
      of GIT_SUBMODULE_UPDATE_DEFAULT : result = cint(result or 0)

func `-`*(arg: c_git_submodule_update_t, offset: int): cint = cast[c_git_submodule_update_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_submodule_update_t): cint = cast[c_git_submodule_update_t](ord(arg) - offset)

func `+`*(arg: c_git_submodule_update_t, offset: int): cint = cast[c_git_submodule_update_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_submodule_update_t): cint = cast[c_git_submodule_update_t](ord(arg) + offset)

converter toCInt*(arg: c_git_submodule_ignore_t): cint = cint(ord(arg))

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

converter toCInt*(arg: c_git_submodule_recurse_t): cint = cint(ord(arg))

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