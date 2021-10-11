{.push warning[UnusedImport]:off.}

import
  ./libgit_config

type
  git_annotated_commit* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_blob* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_branch_t* = enum
    GIT_BRANCH_LOCAL = 1
    GIT_BRANCH_REMOTE = 2
    GIT_BRANCH_ALL = 3
   
  git_commit* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_config* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_config_backend* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_filemode_t* = enum
    GIT_FILEMODE_UNREADABLE = 0
    GIT_FILEMODE_TREE = 40000
    GIT_FILEMODE_BLOB = 100644
    GIT_FILEMODE_BLOB_EXECUTABLE = 100755
    GIT_FILEMODE_LINK = 120000
    GIT_FILEMODE_COMMIT = 160000
   
  git_index* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_index_conflict_iterator* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_index_iterator* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_mailmap* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_note* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_object* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_object_size_t* = uint64
   
  git_object_t* = enum
    GIT_OBJECT_ANY = -2
    GIT_OBJECT_INVALID = -1 ## Object can be any of the following 
    GIT_OBJECT_COMMIT = 1 ## Object is invalid. 
    GIT_OBJECT_TREE = 2 ## A commit object. 
    GIT_OBJECT_BLOB = 3 ## A tree (directory listing) object. 
    GIT_OBJECT_TAG = 4 ## A file revision object. 
    GIT_OBJECT_OFS_DELTA = 6 ## An annotated tag object. 
    GIT_OBJECT_REF_DELTA = 7 ## A delta, base is given by an offset. 
   
  git_odb* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_odb_backend* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_odb_object* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_off_t* = int64
   
  git_packbuilder* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_push* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_rebase* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_refdb* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_refdb_backend* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_reference* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_reference_iterator* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_reference_t* = enum
    GIT_REFERENCE_INVALID = 0
    GIT_REFERENCE_DIRECT = 1 ## Invalid reference 
    GIT_REFERENCE_SYMBOLIC = 2 ## A reference that points at an object id 
    GIT_REFERENCE_ALL = 3 ## A reference that points at another reference 
   
  git_reflog* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_reflog_entry* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_refspec* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_remote* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_repository* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_revwalk* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_signature* {.bycopy, header: "<git2/types.h>", importc.} = object
    ## indicator for questionable '-0000' offsets in signature 
    ## An action signature (e.g. for committers, taggers, etc) 
    name*: cstring
    email*: cstring ## full name of the author 
    when_f* {.importc: "when".}: git_time ## email of the author 
   
  git_status_list* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_submodule* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_submodule_ignore_t* = enum
    GIT_SUBMODULE_IGNORE_UNSPECIFIED = -1
    GIT_SUBMODULE_IGNORE_NONE = 1 ## use the submodule's configuration 
    GIT_SUBMODULE_IGNORE_UNTRACKED = 2 ## any change or untracked == dirty 
    GIT_SUBMODULE_IGNORE_DIRTY = 3 ## dirty if tracked files change 
    GIT_SUBMODULE_IGNORE_ALL = 4 ## only dirty if HEAD moved 
   
  git_submodule_recurse_t* = enum
    GIT_SUBMODULE_RECURSE_NO = 0
    GIT_SUBMODULE_RECURSE_YES = 1
    GIT_SUBMODULE_RECURSE_ONDEMAND = 2
   
  git_submodule_update_t* = enum
    GIT_SUBMODULE_UPDATE_DEFAULT = 0
    GIT_SUBMODULE_UPDATE_CHECKOUT = 1
    GIT_SUBMODULE_UPDATE_REBASE = 2
    GIT_SUBMODULE_UPDATE_MERGE = 3
    GIT_SUBMODULE_UPDATE_NONE = 4
   
  git_tag* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_time* {.bycopy, header: "<git2/types.h>", importc.} = object
    ## Time in a signature 
    time*: git_time_t
    offset*: cint ## time in seconds from epoch 
    sign*: char ## timezone offset, in minutes 
   
  git_time_t* = int64
   
  git_transaction* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_transport* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_tree* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_tree_entry* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_treebuilder* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_worktree* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_writestream* {.bycopy, header: "<git2/types.h>", importc.} = object
    ## A type to write in a streaming fashion, for example, for filters. 
    write*: proc(stream: ptr git_writestream, buffer: cstring, len: csize_t): cint{.cdecl.}
    close*: proc(stream: ptr git_writestream): cint{.cdecl.}
    free*: proc(stream: ptr git_writestream): void{.cdecl.}
   

