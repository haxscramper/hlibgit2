{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  git_error* {.bycopy, header: "<git2/errors.h>", importc.} = object
    ## Patch application failed 
    message*: cstring
    klass*: cint
   
  git_error_code* = enum
    GIT_EAPPLYFAIL = -35 ## Unsaved changes in the index would be overwritten 
    GIT_EINDEXDIRTY = -34 ## Hashsum mismatch in object 
    GIT_EMISMATCH = -33 ## Internal only 
    GIT_RETRY = -32 ## Signals end of iteration with iterator 
    GIT_ITEROVER = -31 ## A user-configured callback refused to act 
    GIT_PASSTHROUGH = -30 ## A merge conflict exists and cannot continue 
    GIT_EMERGECONFLICT = -24 ## The operation is not valid for a directory 
    GIT_EDIRECTORY = -23 ## Uncommitted changes in index prevented operation 
    GIT_EUNCOMMITTED = -22 ## Invalid operation or input 
    GIT_EINVALID = -21 ## Unexpected EOF 
    GIT_EEOF = -20 ## The requested peel operation is not possible 
    GIT_EPEEL = -19 ## Patch/merge has already been applied 
    GIT_EAPPLIED = -18 ## Server certificate is invalid 
    GIT_ECERTIFICATE = -17 ## Authentication error 
    GIT_EAUTH = -16 ## Reference value does not match expected 
    GIT_EMODIFIED = -15 ## Lock file prevented operation 
    GIT_ELOCKED = -14 ## Checkout conflicts prevented operation 
    GIT_ECONFLICT = -13 ## Name/ref spec was not in a valid format 
    GIT_EINVALIDSPEC = -12 ## Reference was not fast-forwardable 
    GIT_ENONFASTFORWARD = -11 ## Merge in progress prevented operation 
    GIT_EUNMERGED = -10 ## HEAD refers to branch with no commits 
    GIT_EUNBORNBRANCH = -9 ## Operation not allowed on bare repository 
    GIT_EBAREREPO = -8
    GIT_EUSER = -7 ## Output buffer too short to hold data 
    GIT_EBUFS = -6 ## More than one object matches 
    GIT_EAMBIGUOUS = -5 ## Object exists preventing operation 
    GIT_EEXISTS = -4 ## Requested object could not be found 
    GIT_ENOTFOUND = -3 ## Generic error 
    GIT_ERROR = -1 ## No error 
    GIT_OK = 0
   
  git_error_t* = enum
    GIT_ERROR_NONE = 0
    GIT_ERROR_NOMEMORY = 1
    GIT_ERROR_OS = 2
    GIT_ERROR_INVALID = 3
    GIT_ERROR_REFERENCE = 4
    GIT_ERROR_ZLIB = 5
    GIT_ERROR_REPOSITORY = 6
    GIT_ERROR_CONFIG = 7
    GIT_ERROR_REGEX = 8
    GIT_ERROR_ODB = 9
    GIT_ERROR_INDEX = 10
    GIT_ERROR_OBJECT = 11
    GIT_ERROR_NET = 12
    GIT_ERROR_TAG = 13
    GIT_ERROR_TREE = 14
    GIT_ERROR_INDEXER = 15
    GIT_ERROR_SSL = 16
    GIT_ERROR_SUBMODULE = 17
    GIT_ERROR_THREAD = 18
    GIT_ERROR_STASH = 19
    GIT_ERROR_CHECKOUT = 20
    GIT_ERROR_FETCHHEAD = 21
    GIT_ERROR_MERGE = 22
    GIT_ERROR_SSH = 23
    GIT_ERROR_FILTER = 24
    GIT_ERROR_REVERT = 25
    GIT_ERROR_CALLBACK = 26
    GIT_ERROR_CHERRYPICK = 27
    GIT_ERROR_DESCRIBE = 28
    GIT_ERROR_REBASE = 29
    GIT_ERROR_FILESYSTEM = 30
    GIT_ERROR_PATCH = 31
    GIT_ERROR_WORKTREE = 32
    GIT_ERROR_SHA1 = 33
    GIT_ERROR_HTTP = 34
    GIT_ERROR_INTERNAL = 35
   

proc git_error_last*(a0: void): ptr git_error {.dynlib: libgit2Dl, importc.}


proc git_error_clear*(a0: void): void {.dynlib: libgit2Dl, importc.}


proc git_error_set_str*(
    error_class: cint,
    arg_string:  cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_error_set_oom*(a0: void): void {.dynlib: libgit2Dl, importc.}


