{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  c_git_error_code* {.size: sizeof(cint).} = enum
    c_GIT_EAPPLYFAIL      = -35 ## Unsaved changes in the index would be overwritten
    c_GIT_EINDEXDIRTY     = -34 ## Hashsum mismatch in object
    c_GIT_EMISMATCH       = -33 ## Internal only
    c_GIT_RETRY           = -32 ## Signals end of iteration with iterator
    c_GIT_ITEROVER        = -31 ## A user-configured callback refused to act
    c_GIT_PASSTHROUGH     = -30 ## A merge conflict exists and cannot continue
    c_GIT_EMERGECONFLICT  = -24 ## The operation is not valid for a directory
    c_GIT_EDIRECTORY      = -23 ## Uncommitted changes in index prevented operation
    c_GIT_EUNCOMMITTED    = -22 ## Invalid operation or input
    c_GIT_EINVALID        = -21 ## Unexpected EOF
    c_GIT_EEOF            = -20 ## The requested peel operation is not possible
    c_GIT_EPEEL           = -19 ## Patch/merge has already been applied
    c_GIT_EAPPLIED        = -18 ## Server certificate is invalid
    c_GIT_ECERTIFICATE    = -17 ## Authentication error
    c_GIT_EAUTH           = -16 ## Reference value does not match expected
    c_GIT_EMODIFIED       = -15 ## Lock file prevented operation
    c_GIT_ELOCKED         = -14 ## Checkout conflicts prevented operation
    c_GIT_ECONFLICT       = -13 ## Name/ref spec was not in a valid format
    c_GIT_EINVALIDSPEC    = -12 ## Reference was not fast-forwardable
    c_GIT_ENONFASTFORWARD = -11 ## Merge in progress prevented operation
    c_GIT_EUNMERGED       = -10 ## HEAD refers to branch with no commits
    c_GIT_EUNBORNBRANCH   = -9  ## Operation not allowed on bare repository
    c_GIT_EBAREREPO       = -8
    c_GIT_EUSER           = -7  ## Output buffer too short to hold data
    c_GIT_EBUFS           = -6  ## More than one object matches
    c_GIT_EAMBIGUOUS      = -5  ## Object exists preventing operation
    c_GIT_EEXISTS         = -4  ## Requested object could not be found
    c_GIT_ENOTFOUND       = -3  ## Generic error
    c_GIT_ERROR           = -1  ## No error
    c_GIT_OK              = 0

  c_git_error_t* {.size: sizeof(cint).} = enum
    c_GIT_ERROR_NONE       = 0
    c_GIT_ERROR_NOMEMORY   = 1
    c_GIT_ERROR_OS         = 2
    c_GIT_ERROR_INVALID    = 3
    c_GIT_ERROR_REFERENCE  = 4
    c_GIT_ERROR_ZLIB       = 5
    c_GIT_ERROR_REPOSITORY = 6
    c_GIT_ERROR_CONFIG     = 7
    c_GIT_ERROR_REGEX      = 8
    c_GIT_ERROR_ODB        = 9
    c_GIT_ERROR_INDEX      = 10
    c_GIT_ERROR_OBJECT     = 11
    c_GIT_ERROR_NET        = 12
    c_GIT_ERROR_TAG        = 13
    c_GIT_ERROR_TREE       = 14
    c_GIT_ERROR_INDEXER    = 15
    c_GIT_ERROR_SSL        = 16
    c_GIT_ERROR_SUBMODULE  = 17
    c_GIT_ERROR_THREAD     = 18
    c_GIT_ERROR_STASH      = 19
    c_GIT_ERROR_CHECKOUT   = 20
    c_GIT_ERROR_FETCHHEAD  = 21
    c_GIT_ERROR_MERGE      = 22
    c_GIT_ERROR_SSH        = 23
    c_GIT_ERROR_FILTER     = 24
    c_GIT_ERROR_REVERT     = 25
    c_GIT_ERROR_CALLBACK   = 26
    c_GIT_ERROR_CHERRYPICK = 27
    c_GIT_ERROR_DESCRIBE   = 28
    c_GIT_ERROR_REBASE     = 29
    c_GIT_ERROR_FILESYSTEM = 30
    c_GIT_ERROR_PATCH      = 31
    c_GIT_ERROR_WORKTREE   = 32
    c_GIT_ERROR_SHA1       = 33
    c_GIT_ERROR_HTTP       = 34
    c_GIT_ERROR_INTERNAL   = 35

  git_error* {.bycopy, header: "<git2/errors.h>", importc.} = object
    ## Patch application failed
    message*: cstring
    klass*:   cint

  git_error_code* = enum
    GIT_EAPPLYFAIL      ## Unsaved changes in the index would be overwritten
    GIT_EINDEXDIRTY     ## Hashsum mismatch in object
    GIT_EMISMATCH       ## Internal only
    GIT_RETRY           ## Signals end of iteration with iterator
    GIT_ITEROVER        ## A user-configured callback refused to act
    GIT_PASSTHROUGH     ## A merge conflict exists and cannot continue
    GIT_EMERGECONFLICT  ## The operation is not valid for a directory
    GIT_EDIRECTORY      ## Uncommitted changes in index prevented operation
    GIT_EUNCOMMITTED    ## Invalid operation or input
    GIT_EINVALID        ## Unexpected EOF
    GIT_EEOF            ## The requested peel operation is not possible
    GIT_EPEEL           ## Patch/merge has already been applied
    GIT_EAPPLIED        ## Server certificate is invalid
    GIT_ECERTIFICATE    ## Authentication error
    GIT_EAUTH           ## Reference value does not match expected
    GIT_EMODIFIED       ## Lock file prevented operation
    GIT_ELOCKED         ## Checkout conflicts prevented operation
    GIT_ECONFLICT       ## Name/ref spec was not in a valid format
    GIT_EINVALIDSPEC    ## Reference was not fast-forwardable
    GIT_ENONFASTFORWARD ## Merge in progress prevented operation
    GIT_EUNMERGED       ## HEAD refers to branch with no commits
    GIT_EUNBORNBRANCH   ## Operation not allowed on bare repository
    GIT_EBAREREPO
    GIT_EUSER           ## Output buffer too short to hold data
    GIT_EBUFS           ## More than one object matches
    GIT_EAMBIGUOUS      ## Object exists preventing operation
    GIT_EEXISTS         ## Requested object could not be found
    GIT_ENOTFOUND       ## Generic error
    GIT_ERROR           ## No error
    GIT_OK

  git_error_t* = enum
    GIT_ERROR_NONE
    GIT_ERROR_NOMEMORY
    GIT_ERROR_OS
    GIT_ERROR_INVALID
    GIT_ERROR_REFERENCE
    GIT_ERROR_ZLIB
    GIT_ERROR_REPOSITORY
    GIT_ERROR_CONFIG
    GIT_ERROR_REGEX
    GIT_ERROR_ODB
    GIT_ERROR_INDEX
    GIT_ERROR_OBJECT
    GIT_ERROR_NET
    GIT_ERROR_TAG
    GIT_ERROR_TREE
    GIT_ERROR_INDEXER
    GIT_ERROR_SSL
    GIT_ERROR_SUBMODULE
    GIT_ERROR_THREAD
    GIT_ERROR_STASH
    GIT_ERROR_CHECKOUT
    GIT_ERROR_FETCHHEAD
    GIT_ERROR_MERGE
    GIT_ERROR_SSH
    GIT_ERROR_FILTER
    GIT_ERROR_REVERT
    GIT_ERROR_CALLBACK
    GIT_ERROR_CHERRYPICK
    GIT_ERROR_DESCRIBE
    GIT_ERROR_REBASE
    GIT_ERROR_FILESYSTEM
    GIT_ERROR_PATCH
    GIT_ERROR_WORKTREE
    GIT_ERROR_SHA1
    GIT_ERROR_HTTP
    GIT_ERROR_INTERNAL


proc to_c_git_error_code*(arg: git_error_code): c_git_error_code =
  case arg:
    of GIT_EAPPLYFAIL:      c_GIT_EAPPLYFAIL
    of GIT_EINDEXDIRTY:     c_GIT_EINDEXDIRTY
    of GIT_EMISMATCH:       c_GIT_EMISMATCH
    of GIT_RETRY:           c_GIT_RETRY
    of GIT_ITEROVER:        c_GIT_ITEROVER
    of GIT_PASSTHROUGH:     c_GIT_PASSTHROUGH
    of GIT_EMERGECONFLICT:  c_GIT_EMERGECONFLICT
    of GIT_EDIRECTORY:      c_GIT_EDIRECTORY
    of GIT_EUNCOMMITTED:    c_GIT_EUNCOMMITTED
    of GIT_EINVALID:        c_GIT_EINVALID
    of GIT_EEOF:            c_GIT_EEOF
    of GIT_EPEEL:           c_GIT_EPEEL
    of GIT_EAPPLIED:        c_GIT_EAPPLIED
    of GIT_ECERTIFICATE:    c_GIT_ECERTIFICATE
    of GIT_EAUTH:           c_GIT_EAUTH
    of GIT_EMODIFIED:       c_GIT_EMODIFIED
    of GIT_ELOCKED:         c_GIT_ELOCKED
    of GIT_ECONFLICT:       c_GIT_ECONFLICT
    of GIT_EINVALIDSPEC:    c_GIT_EINVALIDSPEC
    of GIT_ENONFASTFORWARD: c_GIT_ENONFASTFORWARD
    of GIT_EUNMERGED:       c_GIT_EUNMERGED
    of GIT_EUNBORNBRANCH:   c_GIT_EUNBORNBRANCH
    of GIT_EBAREREPO:       c_GIT_EBAREREPO
    of GIT_EUSER:           c_GIT_EUSER
    of GIT_EBUFS:           c_GIT_EBUFS
    of GIT_EAMBIGUOUS:      c_GIT_EAMBIGUOUS
    of GIT_EEXISTS:         c_GIT_EEXISTS
    of GIT_ENOTFOUND:       c_GIT_ENOTFOUND
    of GIT_ERROR:           c_GIT_ERROR
    of GIT_OK:              c_GIT_OK


converter to_git_error_code*(arg: c_git_error_code): git_error_code =
  case arg:
    of c_GIT_EAPPLYFAIL:      GIT_EAPPLYFAIL
    of c_GIT_EINDEXDIRTY:     GIT_EINDEXDIRTY
    of c_GIT_EMISMATCH:       GIT_EMISMATCH
    of c_GIT_RETRY:           GIT_RETRY
    of c_GIT_ITEROVER:        GIT_ITEROVER
    of c_GIT_PASSTHROUGH:     GIT_PASSTHROUGH
    of c_GIT_EMERGECONFLICT:  GIT_EMERGECONFLICT
    of c_GIT_EDIRECTORY:      GIT_EDIRECTORY
    of c_GIT_EUNCOMMITTED:    GIT_EUNCOMMITTED
    of c_GIT_EINVALID:        GIT_EINVALID
    of c_GIT_EEOF:            GIT_EEOF
    of c_GIT_EPEEL:           GIT_EPEEL
    of c_GIT_EAPPLIED:        GIT_EAPPLIED
    of c_GIT_ECERTIFICATE:    GIT_ECERTIFICATE
    of c_GIT_EAUTH:           GIT_EAUTH
    of c_GIT_EMODIFIED:       GIT_EMODIFIED
    of c_GIT_ELOCKED:         GIT_ELOCKED
    of c_GIT_ECONFLICT:       GIT_ECONFLICT
    of c_GIT_EINVALIDSPEC:    GIT_EINVALIDSPEC
    of c_GIT_ENONFASTFORWARD: GIT_ENONFASTFORWARD
    of c_GIT_EUNMERGED:       GIT_EUNMERGED
    of c_GIT_EUNBORNBRANCH:   GIT_EUNBORNBRANCH
    of c_GIT_EBAREREPO:       GIT_EBAREREPO
    of c_GIT_EUSER:           GIT_EUSER
    of c_GIT_EBUFS:           GIT_EBUFS
    of c_GIT_EAMBIGUOUS:      GIT_EAMBIGUOUS
    of c_GIT_EEXISTS:         GIT_EEXISTS
    of c_GIT_ENOTFOUND:       GIT_ENOTFOUND
    of c_GIT_ERROR:           GIT_ERROR
    of c_GIT_OK:              GIT_OK


converter toCint*(arg: c_git_error_code): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_error_code): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_error_code(arg)))

func `+`*(arg: c_git_error_code, offset: int): c_git_error_code =
  cast[c_git_error_code](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_error_code): c_git_error_code =
  cast[c_git_error_code](ord(arg) + offset)

func `-`*(arg: c_git_error_code, offset: int): c_git_error_code =
  cast[c_git_error_code](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_error_code): c_git_error_code =
  cast[c_git_error_code](ord(arg) - offset)


proc to_c_git_error_t*(arg: git_error_t): c_git_error_t =
  case arg:
    of GIT_ERROR_NONE:       c_GIT_ERROR_NONE
    of GIT_ERROR_NOMEMORY:   c_GIT_ERROR_NOMEMORY
    of GIT_ERROR_OS:         c_GIT_ERROR_OS
    of GIT_ERROR_INVALID:    c_GIT_ERROR_INVALID
    of GIT_ERROR_REFERENCE:  c_GIT_ERROR_REFERENCE
    of GIT_ERROR_ZLIB:       c_GIT_ERROR_ZLIB
    of GIT_ERROR_REPOSITORY: c_GIT_ERROR_REPOSITORY
    of GIT_ERROR_CONFIG:     c_GIT_ERROR_CONFIG
    of GIT_ERROR_REGEX:      c_GIT_ERROR_REGEX
    of GIT_ERROR_ODB:        c_GIT_ERROR_ODB
    of GIT_ERROR_INDEX:      c_GIT_ERROR_INDEX
    of GIT_ERROR_OBJECT:     c_GIT_ERROR_OBJECT
    of GIT_ERROR_NET:        c_GIT_ERROR_NET
    of GIT_ERROR_TAG:        c_GIT_ERROR_TAG
    of GIT_ERROR_TREE:       c_GIT_ERROR_TREE
    of GIT_ERROR_INDEXER:    c_GIT_ERROR_INDEXER
    of GIT_ERROR_SSL:        c_GIT_ERROR_SSL
    of GIT_ERROR_SUBMODULE:  c_GIT_ERROR_SUBMODULE
    of GIT_ERROR_THREAD:     c_GIT_ERROR_THREAD
    of GIT_ERROR_STASH:      c_GIT_ERROR_STASH
    of GIT_ERROR_CHECKOUT:   c_GIT_ERROR_CHECKOUT
    of GIT_ERROR_FETCHHEAD:  c_GIT_ERROR_FETCHHEAD
    of GIT_ERROR_MERGE:      c_GIT_ERROR_MERGE
    of GIT_ERROR_SSH:        c_GIT_ERROR_SSH
    of GIT_ERROR_FILTER:     c_GIT_ERROR_FILTER
    of GIT_ERROR_REVERT:     c_GIT_ERROR_REVERT
    of GIT_ERROR_CALLBACK:   c_GIT_ERROR_CALLBACK
    of GIT_ERROR_CHERRYPICK: c_GIT_ERROR_CHERRYPICK
    of GIT_ERROR_DESCRIBE:   c_GIT_ERROR_DESCRIBE
    of GIT_ERROR_REBASE:     c_GIT_ERROR_REBASE
    of GIT_ERROR_FILESYSTEM: c_GIT_ERROR_FILESYSTEM
    of GIT_ERROR_PATCH:      c_GIT_ERROR_PATCH
    of GIT_ERROR_WORKTREE:   c_GIT_ERROR_WORKTREE
    of GIT_ERROR_SHA1:       c_GIT_ERROR_SHA1
    of GIT_ERROR_HTTP:       c_GIT_ERROR_HTTP
    of GIT_ERROR_INTERNAL:   c_GIT_ERROR_INTERNAL


converter to_git_error_t*(arg: c_git_error_t): git_error_t =
  case arg:
    of c_GIT_ERROR_NONE:       GIT_ERROR_NONE
    of c_GIT_ERROR_NOMEMORY:   GIT_ERROR_NOMEMORY
    of c_GIT_ERROR_OS:         GIT_ERROR_OS
    of c_GIT_ERROR_INVALID:    GIT_ERROR_INVALID
    of c_GIT_ERROR_REFERENCE:  GIT_ERROR_REFERENCE
    of c_GIT_ERROR_ZLIB:       GIT_ERROR_ZLIB
    of c_GIT_ERROR_REPOSITORY: GIT_ERROR_REPOSITORY
    of c_GIT_ERROR_CONFIG:     GIT_ERROR_CONFIG
    of c_GIT_ERROR_REGEX:      GIT_ERROR_REGEX
    of c_GIT_ERROR_ODB:        GIT_ERROR_ODB
    of c_GIT_ERROR_INDEX:      GIT_ERROR_INDEX
    of c_GIT_ERROR_OBJECT:     GIT_ERROR_OBJECT
    of c_GIT_ERROR_NET:        GIT_ERROR_NET
    of c_GIT_ERROR_TAG:        GIT_ERROR_TAG
    of c_GIT_ERROR_TREE:       GIT_ERROR_TREE
    of c_GIT_ERROR_INDEXER:    GIT_ERROR_INDEXER
    of c_GIT_ERROR_SSL:        GIT_ERROR_SSL
    of c_GIT_ERROR_SUBMODULE:  GIT_ERROR_SUBMODULE
    of c_GIT_ERROR_THREAD:     GIT_ERROR_THREAD
    of c_GIT_ERROR_STASH:      GIT_ERROR_STASH
    of c_GIT_ERROR_CHECKOUT:   GIT_ERROR_CHECKOUT
    of c_GIT_ERROR_FETCHHEAD:  GIT_ERROR_FETCHHEAD
    of c_GIT_ERROR_MERGE:      GIT_ERROR_MERGE
    of c_GIT_ERROR_SSH:        GIT_ERROR_SSH
    of c_GIT_ERROR_FILTER:     GIT_ERROR_FILTER
    of c_GIT_ERROR_REVERT:     GIT_ERROR_REVERT
    of c_GIT_ERROR_CALLBACK:   GIT_ERROR_CALLBACK
    of c_GIT_ERROR_CHERRYPICK: GIT_ERROR_CHERRYPICK
    of c_GIT_ERROR_DESCRIBE:   GIT_ERROR_DESCRIBE
    of c_GIT_ERROR_REBASE:     GIT_ERROR_REBASE
    of c_GIT_ERROR_FILESYSTEM: GIT_ERROR_FILESYSTEM
    of c_GIT_ERROR_PATCH:      GIT_ERROR_PATCH
    of c_GIT_ERROR_WORKTREE:   GIT_ERROR_WORKTREE
    of c_GIT_ERROR_SHA1:       GIT_ERROR_SHA1
    of c_GIT_ERROR_HTTP:       GIT_ERROR_HTTP
    of c_GIT_ERROR_INTERNAL:   GIT_ERROR_INTERNAL


converter toCint*(arg: c_git_error_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_error_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_error_t(arg)))

func `+`*(arg: c_git_error_t, offset: int): c_git_error_t =
  cast[c_git_error_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_error_t): c_git_error_t =
  cast[c_git_error_t](ord(arg) + offset)

func `-`*(arg: c_git_error_t, offset: int): c_git_error_t =
  cast[c_git_error_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_error_t): c_git_error_t =
  cast[c_git_error_t](ord(arg) - offset)


proc git_error_last*(a0: void): ptr git_error {.git2Proc, importc.}



proc git_error_clear*(a0: void): void {.git2Proc, importc.}



proc git_error_set_str*(
    error_class: cint,
    arg_string:  cstring
  ): cint {.git2Proc, importc.}



proc git_error_set_oom*(a0: void): void {.git2Proc, importc.}



