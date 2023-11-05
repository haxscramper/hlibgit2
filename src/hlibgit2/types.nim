{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  c_git_branch_t* {.size: sizeof(cint).} = enum
    c_GIT_BRANCH_LOCAL  = 1
    c_GIT_BRANCH_REMOTE = 2
    c_GIT_BRANCH_ALL    = 3

  c_git_filemode_t* {.size: sizeof(cint).} = enum
    c_GIT_FILEMODE_UNREADABLE      = 0
    c_GIT_FILEMODE_TREE            = 40000
    c_GIT_FILEMODE_BLOB            = 100644
    c_GIT_FILEMODE_BLOB_EXECUTABLE = 100755
    c_GIT_FILEMODE_LINK            = 120000
    c_GIT_FILEMODE_COMMIT          = 160000

  c_git_object_t* {.size: sizeof(cint).} = enum
    c_GIT_OBJECT_ANY       = -2
    c_GIT_OBJECT_INVALID   = -1 ## Object can be any of the following
    c_GIT_OBJECT_COMMIT    = 1  ## Object is invalid.
    c_GIT_OBJECT_TREE      = 2  ## A commit object.
    c_GIT_OBJECT_BLOB      = 3  ## A tree (directory listing) object.
    c_GIT_OBJECT_TAG       = 4  ## A file revision object.
    c_GIT_OBJECT_OFS_DELTA = 6  ## An annotated tag object.
    c_GIT_OBJECT_REF_DELTA = 7  ## A delta, base is given by an offset.

  c_git_reference_t* {.size: sizeof(cint).} = enum
    c_GIT_REFERENCE_INVALID  = 0
    c_GIT_REFERENCE_DIRECT   = 1 ## Invalid reference
    c_GIT_REFERENCE_SYMBOLIC = 2 ## A reference that points at an object id
    c_GIT_REFERENCE_ALL      = 3 ## A reference that points at another reference

  c_git_submodule_ignore_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_IGNORE_UNSPECIFIED = -1
    c_GIT_SUBMODULE_IGNORE_NONE        = 1  ## use the submodule's configuration
    c_GIT_SUBMODULE_IGNORE_UNTRACKED   = 2  ## any change or untracked == dirty
    c_GIT_SUBMODULE_IGNORE_DIRTY       = 3  ## dirty if tracked files change
    c_GIT_SUBMODULE_IGNORE_ALL         = 4  ## only dirty if HEAD moved

  c_git_submodule_recurse_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_RECURSE_NO       = 0 shl 0
    c_GIT_SUBMODULE_RECURSE_YES      = 1 shl 0
    c_GIT_SUBMODULE_RECURSE_ONDEMAND = 1 shl 1

  c_git_submodule_update_t* {.size: sizeof(cint).} = enum
    c_GIT_SUBMODULE_UPDATE_DEFAULT  = 0
    c_GIT_SUBMODULE_UPDATE_CHECKOUT = 1
    c_GIT_SUBMODULE_UPDATE_REBASE   = 2
    c_GIT_SUBMODULE_UPDATE_MERGE    = 3
    c_GIT_SUBMODULE_UPDATE_NONE     = 4

  git_annotated_commit* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_blob* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_branch_t* = enum
    GIT_BRANCH_LOCAL
    GIT_BRANCH_REMOTE
    GIT_BRANCH_ALL

  git_commit* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_commit_graph* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_commit_graph_writer* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_config* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_config_backend* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_filemode_t* = enum
    GIT_FILEMODE_UNREADABLE
    GIT_FILEMODE_TREE
    GIT_FILEMODE_BLOB
    GIT_FILEMODE_BLOB_EXECUTABLE
    GIT_FILEMODE_LINK
    GIT_FILEMODE_COMMIT

  git_index* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_index_conflict_iterator* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_index_iterator* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_mailmap* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_midx_writer* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_note* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_object* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_object_size_t* = uint64

  git_object_t* = enum
    GIT_OBJECT_ANY
    GIT_OBJECT_INVALID   ## Object can be any of the following
    GIT_OBJECT_COMMIT    ## Object is invalid.
    GIT_OBJECT_TREE      ## A commit object.
    GIT_OBJECT_BLOB      ## A tree (directory listing) object.
    GIT_OBJECT_TAG       ## A file revision object.
    GIT_OBJECT_OFS_DELTA ## An annotated tag object.
    GIT_OBJECT_REF_DELTA ## A delta, base is given by an offset.

  git_odb* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_odb_backend* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_odb_object* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_off_t* = int64

  git_packbuilder* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_push* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_rebase* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_refdb* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_refdb_backend* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_reference* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_reference_iterator* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_reference_t* = enum
    GIT_REFERENCE_INVALID
    GIT_REFERENCE_DIRECT   ## Invalid reference
    GIT_REFERENCE_SYMBOLIC ## A reference that points at an object id
    GIT_REFERENCE_ALL      ## A reference that points at another reference

  git_reflog* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_reflog_entry* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_refspec* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_remote* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_repository* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_revwalk* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_signature* {.bycopy, header: "<git2/types.h>", importc.} = object
    ## An action signature (e.g. for committers, taggers, etc)
    name*:                       cstring
    email*:                      cstring  ## full name of the author
    when_f* {.importc: "when".}: git_time ## email of the author
                                          ## time when the action happened

  git_status_list* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_submodule* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_submodule_ignore_t* = enum
    GIT_SUBMODULE_IGNORE_UNSPECIFIED
    GIT_SUBMODULE_IGNORE_NONE        ## use the submodule's configuration
    GIT_SUBMODULE_IGNORE_UNTRACKED   ## any change or untracked == dirty
    GIT_SUBMODULE_IGNORE_DIRTY       ## dirty if tracked files change
    GIT_SUBMODULE_IGNORE_ALL         ## only dirty if HEAD moved

  git_submodule_recurse_t* {.size: sizeof(cint).} = enum
    GIT_SUBMODULE_RECURSE_NO
    GIT_SUBMODULE_RECURSE_YES
    GIT_SUBMODULE_RECURSE_ONDEMAND

  git_submodule_update_t* = enum
    GIT_SUBMODULE_UPDATE_DEFAULT
    GIT_SUBMODULE_UPDATE_CHECKOUT
    GIT_SUBMODULE_UPDATE_REBASE
    GIT_SUBMODULE_UPDATE_MERGE
    GIT_SUBMODULE_UPDATE_NONE

  git_tag* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_time* {.bycopy, header: "<git2/types.h>", importc.} = object
    ## Time in a signature
    time*:   git_time_t
    offset*: cint       ## time in seconds from epoch
    sign*:   char       ## timezone offset, in minutes
                        ## indicator for questionable '-0000' offsets in signature

  git_time_t* = int64

  git_transaction* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_transport* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_tree* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_tree_entry* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_treebuilder* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_worktree* {.bycopy, incompleteStruct, header: "<git2/types.h>", importc.} = object


  git_writestream* {.bycopy, header: "<git2/types.h>", importc.} = object
    ## A type to write in a streaming fashion, for example, for filters.
    write*: proc(stream: ptr git_writestream,
                 buffer: cstring,
                 len:    csize_t): cint{.cdecl.}
    close*: proc(stream: ptr git_writestream): cint{.cdecl.}
    free*:  proc(stream: ptr git_writestream): void{.cdecl.}


proc to_c_git_object_t*(arg: git_object_t): c_git_object_t =
  case arg:
    of GIT_OBJECT_ANY:       c_GIT_OBJECT_ANY
    of GIT_OBJECT_INVALID:   c_GIT_OBJECT_INVALID
    of GIT_OBJECT_COMMIT:    c_GIT_OBJECT_COMMIT
    of GIT_OBJECT_TREE:      c_GIT_OBJECT_TREE
    of GIT_OBJECT_BLOB:      c_GIT_OBJECT_BLOB
    of GIT_OBJECT_TAG:       c_GIT_OBJECT_TAG
    of GIT_OBJECT_OFS_DELTA: c_GIT_OBJECT_OFS_DELTA
    of GIT_OBJECT_REF_DELTA: c_GIT_OBJECT_REF_DELTA


converter to_git_object_t*(arg: c_git_object_t): git_object_t =
  case arg:
    of c_GIT_OBJECT_ANY:       GIT_OBJECT_ANY
    of c_GIT_OBJECT_INVALID:   GIT_OBJECT_INVALID
    of c_GIT_OBJECT_COMMIT:    GIT_OBJECT_COMMIT
    of c_GIT_OBJECT_TREE:      GIT_OBJECT_TREE
    of c_GIT_OBJECT_BLOB:      GIT_OBJECT_BLOB
    of c_GIT_OBJECT_TAG:       GIT_OBJECT_TAG
    of c_GIT_OBJECT_OFS_DELTA: GIT_OBJECT_OFS_DELTA
    of c_GIT_OBJECT_REF_DELTA: GIT_OBJECT_REF_DELTA


converter toCint*(arg: c_git_object_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_object_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_object_t(arg)))

func `+`*(arg: c_git_object_t, offset: int): c_git_object_t =
  cast[c_git_object_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_object_t): c_git_object_t =
  cast[c_git_object_t](ord(arg) + offset)

func `-`*(arg: c_git_object_t, offset: int): c_git_object_t =
  cast[c_git_object_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_object_t): c_git_object_t =
  cast[c_git_object_t](ord(arg) - offset)


proc to_c_git_reference_t*(arg: git_reference_t): c_git_reference_t =
  case arg:
    of GIT_REFERENCE_INVALID:  c_GIT_REFERENCE_INVALID
    of GIT_REFERENCE_DIRECT:   c_GIT_REFERENCE_DIRECT
    of GIT_REFERENCE_SYMBOLIC: c_GIT_REFERENCE_SYMBOLIC
    of GIT_REFERENCE_ALL:      c_GIT_REFERENCE_ALL


converter to_git_reference_t*(arg: c_git_reference_t): git_reference_t =
  case arg:
    of c_GIT_REFERENCE_INVALID:  GIT_REFERENCE_INVALID
    of c_GIT_REFERENCE_DIRECT:   GIT_REFERENCE_DIRECT
    of c_GIT_REFERENCE_SYMBOLIC: GIT_REFERENCE_SYMBOLIC
    of c_GIT_REFERENCE_ALL:      GIT_REFERENCE_ALL


converter toCint*(arg: c_git_reference_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_reference_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_reference_t(arg)))

func `+`*(arg: c_git_reference_t, offset: int): c_git_reference_t =
  cast[c_git_reference_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_reference_t): c_git_reference_t =
  cast[c_git_reference_t](ord(arg) + offset)

func `-`*(arg: c_git_reference_t, offset: int): c_git_reference_t =
  cast[c_git_reference_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_reference_t): c_git_reference_t =
  cast[c_git_reference_t](ord(arg) - offset)


proc to_c_git_branch_t*(arg: git_branch_t): c_git_branch_t =
  case arg:
    of GIT_BRANCH_LOCAL:  c_GIT_BRANCH_LOCAL
    of GIT_BRANCH_REMOTE: c_GIT_BRANCH_REMOTE
    of GIT_BRANCH_ALL:    c_GIT_BRANCH_ALL


converter to_git_branch_t*(arg: c_git_branch_t): git_branch_t =
  case arg:
    of c_GIT_BRANCH_LOCAL:  GIT_BRANCH_LOCAL
    of c_GIT_BRANCH_REMOTE: GIT_BRANCH_REMOTE
    of c_GIT_BRANCH_ALL:    GIT_BRANCH_ALL


converter toCint*(arg: c_git_branch_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_branch_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_branch_t(arg)))

func `+`*(arg: c_git_branch_t, offset: int): c_git_branch_t =
  cast[c_git_branch_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_branch_t): c_git_branch_t =
  cast[c_git_branch_t](ord(arg) + offset)

func `-`*(arg: c_git_branch_t, offset: int): c_git_branch_t =
  cast[c_git_branch_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_branch_t): c_git_branch_t =
  cast[c_git_branch_t](ord(arg) - offset)


proc to_c_git_filemode_t*(arg: git_filemode_t): c_git_filemode_t =
  case arg:
    of GIT_FILEMODE_UNREADABLE:      c_GIT_FILEMODE_UNREADABLE
    of GIT_FILEMODE_TREE:            c_GIT_FILEMODE_TREE
    of GIT_FILEMODE_BLOB:            c_GIT_FILEMODE_BLOB
    of GIT_FILEMODE_BLOB_EXECUTABLE: c_GIT_FILEMODE_BLOB_EXECUTABLE
    of GIT_FILEMODE_LINK:            c_GIT_FILEMODE_LINK
    of GIT_FILEMODE_COMMIT:          c_GIT_FILEMODE_COMMIT


converter to_git_filemode_t*(arg: c_git_filemode_t): git_filemode_t =
  case arg:
    of c_GIT_FILEMODE_UNREADABLE:      GIT_FILEMODE_UNREADABLE
    of c_GIT_FILEMODE_TREE:            GIT_FILEMODE_TREE
    of c_GIT_FILEMODE_BLOB:            GIT_FILEMODE_BLOB
    of c_GIT_FILEMODE_BLOB_EXECUTABLE: GIT_FILEMODE_BLOB_EXECUTABLE
    of c_GIT_FILEMODE_LINK:            GIT_FILEMODE_LINK
    of c_GIT_FILEMODE_COMMIT:          GIT_FILEMODE_COMMIT


converter toCint*(arg: c_git_filemode_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_filemode_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_filemode_t(arg)))

func `+`*(arg: c_git_filemode_t, offset: int): c_git_filemode_t =
  cast[c_git_filemode_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_filemode_t): c_git_filemode_t =
  cast[c_git_filemode_t](ord(arg) + offset)

func `-`*(arg: c_git_filemode_t, offset: int): c_git_filemode_t =
  cast[c_git_filemode_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_filemode_t): c_git_filemode_t =
  cast[c_git_filemode_t](ord(arg) - offset)


proc to_c_git_submodule_update_t*(
    arg: git_submodule_update_t
  ): c_git_submodule_update_t =
  case arg:
    of GIT_SUBMODULE_UPDATE_DEFAULT:  c_GIT_SUBMODULE_UPDATE_DEFAULT
    of GIT_SUBMODULE_UPDATE_CHECKOUT: c_GIT_SUBMODULE_UPDATE_CHECKOUT
    of GIT_SUBMODULE_UPDATE_REBASE:   c_GIT_SUBMODULE_UPDATE_REBASE
    of GIT_SUBMODULE_UPDATE_MERGE:    c_GIT_SUBMODULE_UPDATE_MERGE
    of GIT_SUBMODULE_UPDATE_NONE:     c_GIT_SUBMODULE_UPDATE_NONE


converter to_git_submodule_update_t*(
    arg: c_git_submodule_update_t
  ): git_submodule_update_t =
  case arg:
    of c_GIT_SUBMODULE_UPDATE_DEFAULT:  GIT_SUBMODULE_UPDATE_DEFAULT
    of c_GIT_SUBMODULE_UPDATE_CHECKOUT: GIT_SUBMODULE_UPDATE_CHECKOUT
    of c_GIT_SUBMODULE_UPDATE_REBASE:   GIT_SUBMODULE_UPDATE_REBASE
    of c_GIT_SUBMODULE_UPDATE_MERGE:    GIT_SUBMODULE_UPDATE_MERGE
    of c_GIT_SUBMODULE_UPDATE_NONE:     GIT_SUBMODULE_UPDATE_NONE


converter toCint*(arg: c_git_submodule_update_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_submodule_update_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_submodule_update_t(arg)))

func `+`*(
    arg:    c_git_submodule_update_t,
    offset: int
  ): c_git_submodule_update_t =
  cast[c_git_submodule_update_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_submodule_update_t
  ): c_git_submodule_update_t =
  cast[c_git_submodule_update_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_submodule_update_t,
    offset: int
  ): c_git_submodule_update_t =
  cast[c_git_submodule_update_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_submodule_update_t
  ): c_git_submodule_update_t =
  cast[c_git_submodule_update_t](ord(arg) - offset)


proc to_c_git_submodule_ignore_t*(
    arg: git_submodule_ignore_t
  ): c_git_submodule_ignore_t =
  case arg:
    of GIT_SUBMODULE_IGNORE_UNSPECIFIED: c_GIT_SUBMODULE_IGNORE_UNSPECIFIED
    of GIT_SUBMODULE_IGNORE_NONE:        c_GIT_SUBMODULE_IGNORE_NONE
    of GIT_SUBMODULE_IGNORE_UNTRACKED:   c_GIT_SUBMODULE_IGNORE_UNTRACKED
    of GIT_SUBMODULE_IGNORE_DIRTY:       c_GIT_SUBMODULE_IGNORE_DIRTY
    of GIT_SUBMODULE_IGNORE_ALL:         c_GIT_SUBMODULE_IGNORE_ALL


converter to_git_submodule_ignore_t*(
    arg: c_git_submodule_ignore_t
  ): git_submodule_ignore_t =
  case arg:
    of c_GIT_SUBMODULE_IGNORE_UNSPECIFIED: GIT_SUBMODULE_IGNORE_UNSPECIFIED
    of c_GIT_SUBMODULE_IGNORE_NONE:        GIT_SUBMODULE_IGNORE_NONE
    of c_GIT_SUBMODULE_IGNORE_UNTRACKED:   GIT_SUBMODULE_IGNORE_UNTRACKED
    of c_GIT_SUBMODULE_IGNORE_DIRTY:       GIT_SUBMODULE_IGNORE_DIRTY
    of c_GIT_SUBMODULE_IGNORE_ALL:         GIT_SUBMODULE_IGNORE_ALL


converter toCint*(arg: c_git_submodule_ignore_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_submodule_ignore_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_submodule_ignore_t(arg)))

func `+`*(
    arg:    c_git_submodule_ignore_t,
    offset: int
  ): c_git_submodule_ignore_t =
  cast[c_git_submodule_ignore_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_submodule_ignore_t
  ): c_git_submodule_ignore_t =
  cast[c_git_submodule_ignore_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_submodule_ignore_t,
    offset: int
  ): c_git_submodule_ignore_t =
  cast[c_git_submodule_ignore_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_submodule_ignore_t
  ): c_git_submodule_ignore_t =
  cast[c_git_submodule_ignore_t](ord(arg) - offset)


proc to_c_git_submodule_recurse_t*(
    arg: git_submodule_recurse_t
  ): c_git_submodule_recurse_t =
  case arg:
    of GIT_SUBMODULE_RECURSE_NO:       c_GIT_SUBMODULE_RECURSE_NO
    of GIT_SUBMODULE_RECURSE_YES:      c_GIT_SUBMODULE_RECURSE_YES
    of GIT_SUBMODULE_RECURSE_ONDEMAND: c_GIT_SUBMODULE_RECURSE_ONDEMAND


converter to_git_submodule_recurse_t*(
    arg: c_git_submodule_recurse_t
  ): git_submodule_recurse_t =
  case arg:
    of c_GIT_SUBMODULE_RECURSE_NO:       GIT_SUBMODULE_RECURSE_NO
    of c_GIT_SUBMODULE_RECURSE_YES:      GIT_SUBMODULE_RECURSE_YES
    of c_GIT_SUBMODULE_RECURSE_ONDEMAND: GIT_SUBMODULE_RECURSE_ONDEMAND


converter toCint*(arg: c_git_submodule_recurse_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_submodule_recurse_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_submodule_recurse_t(arg)))

func `+`*(
    arg:    c_git_submodule_recurse_t,
    offset: int
  ): c_git_submodule_recurse_t =
  cast[c_git_submodule_recurse_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_submodule_recurse_t
  ): c_git_submodule_recurse_t =
  cast[c_git_submodule_recurse_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_submodule_recurse_t,
    offset: int
  ): c_git_submodule_recurse_t =
  cast[c_git_submodule_recurse_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_submodule_recurse_t
  ): c_git_submodule_recurse_t =
  cast[c_git_submodule_recurse_t](ord(arg) - offset)


converter toCint*(args: set[git_submodule_recurse_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_SUBMODULE_RECURSE_NO:       result = cint(result or (0 shl 0))
      of GIT_SUBMODULE_RECURSE_YES:      result = cint(result or (1 shl 0))
      of GIT_SUBMODULE_RECURSE_ONDEMAND: result = cint(result or (1 shl 1))


