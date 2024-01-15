type
  c_git_error_code* {.size: sizeof(cint).} = enum
    c_GIT_TIMEOUT         = -37
    c_GIT_EOWNER          = -36
    c_GIT_EAPPLYFAIL      = -35
    c_GIT_EINDEXDIRTY     = -34
    c_GIT_EMISMATCH       = -33
    c_GIT_RETRY           = -32
    c_GIT_ITEROVER        = -31
    c_GIT_PASSTHROUGH     = -30
    c_GIT_EMERGECONFLICT  = -24
    c_GIT_EDIRECTORY      = -23
    c_GIT_EUNCOMMITTED    = -22
    c_GIT_EINVALID        = -21
    c_GIT_EEOF            = -20
    c_GIT_EPEEL           = -19
    c_GIT_EAPPLIED        = -18
    c_GIT_ECERTIFICATE    = -17
    c_GIT_EAUTH           = -16
    c_GIT_EMODIFIED       = -15
    c_GIT_ELOCKED         = -14
    c_GIT_ECONFLICT       = -13
    c_GIT_EINVALIDSPEC    = -12
    c_GIT_ENONFASTFORWARD = -11
    c_GIT_EUNMERGED       = -10
    c_GIT_EUNBORNBRANCH   = -9
    c_GIT_EBAREREPO       = -8
    c_GIT_EUSER           = -7
    c_GIT_EBUFS           = -6
    c_GIT_EAMBIGUOUS      = -5
    c_GIT_EEXISTS         = -4
    c_GIT_ENOTFOUND       = -3
    c_GIT_ERROR           = -1
    c_GIT_OK              = 0 shl 0

  git_error_code* = enum
    GIT_TIMEOUT         = 0
    GIT_EOWNER          = 1
    GIT_EAPPLYFAIL      = 2
    GIT_EINDEXDIRTY     = 3
    GIT_EMISMATCH       = 4
    GIT_RETRY           = 5
    GIT_ITEROVER        = 6
    GIT_PASSTHROUGH     = 7
    GIT_EMERGECONFLICT  = 8
    GIT_EDIRECTORY      = 9
    GIT_EUNCOMMITTED    = 10
    GIT_EINVALID        = 11
    GIT_EEOF            = 12
    GIT_EPEEL           = 13
    GIT_EAPPLIED        = 14
    GIT_ECERTIFICATE    = 15
    GIT_EAUTH           = 16
    GIT_EMODIFIED       = 17
    GIT_ELOCKED         = 18
    GIT_ECONFLICT       = 19
    GIT_EINVALIDSPEC    = 20
    GIT_ENONFASTFORWARD = 21
    GIT_EUNMERGED       = 22
    GIT_EUNBORNBRANCH   = 23
    GIT_EBAREREPO       = 24
    GIT_EUSER           = 25
    GIT_EBUFS           = 26
    GIT_EAMBIGUOUS      = 27
    GIT_EEXISTS         = 28
    GIT_ENOTFOUND       = 29
    GIT_ERROR           = 30
    GIT_OK              = 31

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
    c_GIT_ERROR_SHA        = 33
    c_GIT_ERROR_HTTP       = 34
    c_GIT_ERROR_INTERNAL   = 35
    c_GIT_ERROR_GRAFTS     = 36

  git_error_t* = enum
    GIT_ERROR_NONE       = 0
    GIT_ERROR_NOMEMORY   = 1
    GIT_ERROR_OS         = 2
    GIT_ERROR_INVALID    = 3
    GIT_ERROR_REFERENCE  = 4
    GIT_ERROR_ZLIB       = 5
    GIT_ERROR_REPOSITORY = 6
    GIT_ERROR_CONFIG     = 7
    GIT_ERROR_REGEX      = 8
    GIT_ERROR_ODB        = 9
    GIT_ERROR_INDEX      = 10
    GIT_ERROR_OBJECT     = 11
    GIT_ERROR_NET        = 12
    GIT_ERROR_TAG        = 13
    GIT_ERROR_TREE       = 14
    GIT_ERROR_INDEXER    = 15
    GIT_ERROR_SSL        = 16
    GIT_ERROR_SUBMODULE  = 17
    GIT_ERROR_THREAD     = 18
    GIT_ERROR_STASH      = 19
    GIT_ERROR_CHECKOUT   = 20
    GIT_ERROR_FETCHHEAD  = 21
    GIT_ERROR_MERGE      = 22
    GIT_ERROR_SSH        = 23
    GIT_ERROR_FILTER     = 24
    GIT_ERROR_REVERT     = 25
    GIT_ERROR_CALLBACK   = 26
    GIT_ERROR_CHERRYPICK = 27
    GIT_ERROR_DESCRIBE   = 28
    GIT_ERROR_REBASE     = 29
    GIT_ERROR_FILESYSTEM = 30
    GIT_ERROR_PATCH      = 31
    GIT_ERROR_WORKTREE   = 32
    GIT_ERROR_SHA        = 33
    GIT_ERROR_HTTP       = 34
    GIT_ERROR_INTERNAL   = 35
    GIT_ERROR_GRAFTS     = 36

  git_error* {.importc, bycopy.} = object
    message *: ptr char
    klass   *: cint



converter to_git_error_code*(arg: c_git_error_code): git_error_code =
  case arg:
    of c_GIT_TIMEOUT        : GIT_TIMEOUT
    of c_GIT_EOWNER         : GIT_EOWNER
    of c_GIT_EAPPLYFAIL     : GIT_EAPPLYFAIL
    of c_GIT_EINDEXDIRTY    : GIT_EINDEXDIRTY
    of c_GIT_EMISMATCH      : GIT_EMISMATCH
    of c_GIT_RETRY          : GIT_RETRY
    of c_GIT_ITEROVER       : GIT_ITEROVER
    of c_GIT_PASSTHROUGH    : GIT_PASSTHROUGH
    of c_GIT_EMERGECONFLICT : GIT_EMERGECONFLICT
    of c_GIT_EDIRECTORY     : GIT_EDIRECTORY
    of c_GIT_EUNCOMMITTED   : GIT_EUNCOMMITTED
    of c_GIT_EINVALID       : GIT_EINVALID
    of c_GIT_EEOF           : GIT_EEOF
    of c_GIT_EPEEL          : GIT_EPEEL
    of c_GIT_EAPPLIED       : GIT_EAPPLIED
    of c_GIT_ECERTIFICATE   : GIT_ECERTIFICATE
    of c_GIT_EAUTH          : GIT_EAUTH
    of c_GIT_EMODIFIED      : GIT_EMODIFIED
    of c_GIT_ELOCKED        : GIT_ELOCKED
    of c_GIT_ECONFLICT      : GIT_ECONFLICT
    of c_GIT_EINVALIDSPEC   : GIT_EINVALIDSPEC
    of c_GIT_ENONFASTFORWARD: GIT_ENONFASTFORWARD
    of c_GIT_EUNMERGED      : GIT_EUNMERGED
    of c_GIT_EUNBORNBRANCH  : GIT_EUNBORNBRANCH
    of c_GIT_EBAREREPO      : GIT_EBAREREPO
    of c_GIT_EUSER          : GIT_EUSER
    of c_GIT_EBUFS          : GIT_EBUFS
    of c_GIT_EAMBIGUOUS     : GIT_EAMBIGUOUS
    of c_GIT_EEXISTS        : GIT_EEXISTS
    of c_GIT_ENOTFOUND      : GIT_ENOTFOUND
    of c_GIT_ERROR          : GIT_ERROR
    of c_GIT_OK             : GIT_OK

proc to_c_git_error_code*(arg: git_error_code): c_git_error_code =
  case arg:
    of GIT_TIMEOUT        : c_GIT_TIMEOUT
    of GIT_EOWNER         : c_GIT_EOWNER
    of GIT_EAPPLYFAIL     : c_GIT_EAPPLYFAIL
    of GIT_EINDEXDIRTY    : c_GIT_EINDEXDIRTY
    of GIT_EMISMATCH      : c_GIT_EMISMATCH
    of GIT_RETRY          : c_GIT_RETRY
    of GIT_ITEROVER       : c_GIT_ITEROVER
    of GIT_PASSTHROUGH    : c_GIT_PASSTHROUGH
    of GIT_EMERGECONFLICT : c_GIT_EMERGECONFLICT
    of GIT_EDIRECTORY     : c_GIT_EDIRECTORY
    of GIT_EUNCOMMITTED   : c_GIT_EUNCOMMITTED
    of GIT_EINVALID       : c_GIT_EINVALID
    of GIT_EEOF           : c_GIT_EEOF
    of GIT_EPEEL          : c_GIT_EPEEL
    of GIT_EAPPLIED       : c_GIT_EAPPLIED
    of GIT_ECERTIFICATE   : c_GIT_ECERTIFICATE
    of GIT_EAUTH          : c_GIT_EAUTH
    of GIT_EMODIFIED      : c_GIT_EMODIFIED
    of GIT_ELOCKED        : c_GIT_ELOCKED
    of GIT_ECONFLICT      : c_GIT_ECONFLICT
    of GIT_EINVALIDSPEC   : c_GIT_EINVALIDSPEC
    of GIT_ENONFASTFORWARD: c_GIT_ENONFASTFORWARD
    of GIT_EUNMERGED      : c_GIT_EUNMERGED
    of GIT_EUNBORNBRANCH  : c_GIT_EUNBORNBRANCH
    of GIT_EBAREREPO      : c_GIT_EBAREREPO
    of GIT_EUSER          : c_GIT_EUSER
    of GIT_EBUFS          : c_GIT_EBUFS
    of GIT_EAMBIGUOUS     : c_GIT_EAMBIGUOUS
    of GIT_EEXISTS        : c_GIT_EEXISTS
    of GIT_ENOTFOUND      : c_GIT_ENOTFOUND
    of GIT_ERROR          : c_GIT_ERROR
    of GIT_OK             : c_GIT_OK

converter toCInt*(arg: c_git_error_code): cint = cint(ord(arg))

converter toCInt*(arg: git_error_code): cint = cint(ord(to_c_git_error_code(arg)))

converter toCInt*(args: set[git_error_code]): cint =
  for value in items(args):
    case value:
      of GIT_TIMEOUT        : result = cint(result or -37)
      of GIT_EOWNER         : result = cint(result or -36)
      of GIT_EAPPLYFAIL     : result = cint(result or -35)
      of GIT_EINDEXDIRTY    : result = cint(result or -34)
      of GIT_EMISMATCH      : result = cint(result or -33)
      of GIT_RETRY          : result = cint(result or -32)
      of GIT_ITEROVER       : result = cint(result or -31)
      of GIT_PASSTHROUGH    : result = cint(result or -30)
      of GIT_EMERGECONFLICT : result = cint(result or -24)
      of GIT_EDIRECTORY     : result = cint(result or -23)
      of GIT_EUNCOMMITTED   : result = cint(result or -22)
      of GIT_EINVALID       : result = cint(result or -21)
      of GIT_EEOF           : result = cint(result or -20)
      of GIT_EPEEL          : result = cint(result or -19)
      of GIT_EAPPLIED       : result = cint(result or -18)
      of GIT_ECERTIFICATE   : result = cint(result or -17)
      of GIT_EAUTH          : result = cint(result or -16)
      of GIT_EMODIFIED      : result = cint(result or -15)
      of GIT_ELOCKED        : result = cint(result or -14)
      of GIT_ECONFLICT      : result = cint(result or -13)
      of GIT_EINVALIDSPEC   : result = cint(result or -12)
      of GIT_ENONFASTFORWARD: result = cint(result or -11)
      of GIT_EUNMERGED      : result = cint(result or -10)
      of GIT_EUNBORNBRANCH  : result = cint(result or -9)
      of GIT_EBAREREPO      : result = cint(result or -8)
      of GIT_EUSER          : result = cint(result or -7)
      of GIT_EBUFS          : result = cint(result or -6)
      of GIT_EAMBIGUOUS     : result = cint(result or -5)
      of GIT_EEXISTS        : result = cint(result or -4)
      of GIT_ENOTFOUND      : result = cint(result or -3)
      of GIT_ERROR          : result = cint(result or -1)
      of GIT_OK             : result = cint(result or 0)

func `-`*(arg: c_git_error_code, offset: int): cint = cast[c_git_error_code](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_error_code): cint = cast[c_git_error_code](ord(arg) - offset)

func `+`*(arg: c_git_error_code, offset: int): cint = cast[c_git_error_code](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_error_code): cint = cast[c_git_error_code](ord(arg) + offset)

converter to_git_error_t*(arg: c_git_error_t): git_error_t =
  case arg:
    of c_GIT_ERROR_NONE      : GIT_ERROR_NONE
    of c_GIT_ERROR_NOMEMORY  : GIT_ERROR_NOMEMORY
    of c_GIT_ERROR_OS        : GIT_ERROR_OS
    of c_GIT_ERROR_INVALID   : GIT_ERROR_INVALID
    of c_GIT_ERROR_REFERENCE : GIT_ERROR_REFERENCE
    of c_GIT_ERROR_ZLIB      : GIT_ERROR_ZLIB
    of c_GIT_ERROR_REPOSITORY: GIT_ERROR_REPOSITORY
    of c_GIT_ERROR_CONFIG    : GIT_ERROR_CONFIG
    of c_GIT_ERROR_REGEX     : GIT_ERROR_REGEX
    of c_GIT_ERROR_ODB       : GIT_ERROR_ODB
    of c_GIT_ERROR_INDEX     : GIT_ERROR_INDEX
    of c_GIT_ERROR_OBJECT    : GIT_ERROR_OBJECT
    of c_GIT_ERROR_NET       : GIT_ERROR_NET
    of c_GIT_ERROR_TAG       : GIT_ERROR_TAG
    of c_GIT_ERROR_TREE      : GIT_ERROR_TREE
    of c_GIT_ERROR_INDEXER   : GIT_ERROR_INDEXER
    of c_GIT_ERROR_SSL       : GIT_ERROR_SSL
    of c_GIT_ERROR_SUBMODULE : GIT_ERROR_SUBMODULE
    of c_GIT_ERROR_THREAD    : GIT_ERROR_THREAD
    of c_GIT_ERROR_STASH     : GIT_ERROR_STASH
    of c_GIT_ERROR_CHECKOUT  : GIT_ERROR_CHECKOUT
    of c_GIT_ERROR_FETCHHEAD : GIT_ERROR_FETCHHEAD
    of c_GIT_ERROR_MERGE     : GIT_ERROR_MERGE
    of c_GIT_ERROR_SSH       : GIT_ERROR_SSH
    of c_GIT_ERROR_FILTER    : GIT_ERROR_FILTER
    of c_GIT_ERROR_REVERT    : GIT_ERROR_REVERT
    of c_GIT_ERROR_CALLBACK  : GIT_ERROR_CALLBACK
    of c_GIT_ERROR_CHERRYPICK: GIT_ERROR_CHERRYPICK
    of c_GIT_ERROR_DESCRIBE  : GIT_ERROR_DESCRIBE
    of c_GIT_ERROR_REBASE    : GIT_ERROR_REBASE
    of c_GIT_ERROR_FILESYSTEM: GIT_ERROR_FILESYSTEM
    of c_GIT_ERROR_PATCH     : GIT_ERROR_PATCH
    of c_GIT_ERROR_WORKTREE  : GIT_ERROR_WORKTREE
    of c_GIT_ERROR_SHA       : GIT_ERROR_SHA
    of c_GIT_ERROR_HTTP      : GIT_ERROR_HTTP
    of c_GIT_ERROR_INTERNAL  : GIT_ERROR_INTERNAL
    of c_GIT_ERROR_GRAFTS    : GIT_ERROR_GRAFTS

proc to_c_git_error_t*(arg: git_error_t): c_git_error_t =
  case arg:
    of GIT_ERROR_NONE      : c_GIT_ERROR_NONE
    of GIT_ERROR_NOMEMORY  : c_GIT_ERROR_NOMEMORY
    of GIT_ERROR_OS        : c_GIT_ERROR_OS
    of GIT_ERROR_INVALID   : c_GIT_ERROR_INVALID
    of GIT_ERROR_REFERENCE : c_GIT_ERROR_REFERENCE
    of GIT_ERROR_ZLIB      : c_GIT_ERROR_ZLIB
    of GIT_ERROR_REPOSITORY: c_GIT_ERROR_REPOSITORY
    of GIT_ERROR_CONFIG    : c_GIT_ERROR_CONFIG
    of GIT_ERROR_REGEX     : c_GIT_ERROR_REGEX
    of GIT_ERROR_ODB       : c_GIT_ERROR_ODB
    of GIT_ERROR_INDEX     : c_GIT_ERROR_INDEX
    of GIT_ERROR_OBJECT    : c_GIT_ERROR_OBJECT
    of GIT_ERROR_NET       : c_GIT_ERROR_NET
    of GIT_ERROR_TAG       : c_GIT_ERROR_TAG
    of GIT_ERROR_TREE      : c_GIT_ERROR_TREE
    of GIT_ERROR_INDEXER   : c_GIT_ERROR_INDEXER
    of GIT_ERROR_SSL       : c_GIT_ERROR_SSL
    of GIT_ERROR_SUBMODULE : c_GIT_ERROR_SUBMODULE
    of GIT_ERROR_THREAD    : c_GIT_ERROR_THREAD
    of GIT_ERROR_STASH     : c_GIT_ERROR_STASH
    of GIT_ERROR_CHECKOUT  : c_GIT_ERROR_CHECKOUT
    of GIT_ERROR_FETCHHEAD : c_GIT_ERROR_FETCHHEAD
    of GIT_ERROR_MERGE     : c_GIT_ERROR_MERGE
    of GIT_ERROR_SSH       : c_GIT_ERROR_SSH
    of GIT_ERROR_FILTER    : c_GIT_ERROR_FILTER
    of GIT_ERROR_REVERT    : c_GIT_ERROR_REVERT
    of GIT_ERROR_CALLBACK  : c_GIT_ERROR_CALLBACK
    of GIT_ERROR_CHERRYPICK: c_GIT_ERROR_CHERRYPICK
    of GIT_ERROR_DESCRIBE  : c_GIT_ERROR_DESCRIBE
    of GIT_ERROR_REBASE    : c_GIT_ERROR_REBASE
    of GIT_ERROR_FILESYSTEM: c_GIT_ERROR_FILESYSTEM
    of GIT_ERROR_PATCH     : c_GIT_ERROR_PATCH
    of GIT_ERROR_WORKTREE  : c_GIT_ERROR_WORKTREE
    of GIT_ERROR_SHA       : c_GIT_ERROR_SHA
    of GIT_ERROR_HTTP      : c_GIT_ERROR_HTTP
    of GIT_ERROR_INTERNAL  : c_GIT_ERROR_INTERNAL
    of GIT_ERROR_GRAFTS    : c_GIT_ERROR_GRAFTS

converter toCInt*(arg: c_git_error_t): cint = cint(ord(arg))

converter toCInt*(arg: git_error_t): cint = cint(ord(to_c_git_error_t(arg)))

converter toCInt*(args: set[git_error_t]): cint =
  for value in items(args):
    case value:
      of GIT_ERROR_NONE      : result = cint(result or 0)
      of GIT_ERROR_NOMEMORY  : result = cint(result or 1)
      of GIT_ERROR_OS        : result = cint(result or 2)
      of GIT_ERROR_INVALID   : result = cint(result or 3)
      of GIT_ERROR_REFERENCE : result = cint(result or 4)
      of GIT_ERROR_ZLIB      : result = cint(result or 5)
      of GIT_ERROR_REPOSITORY: result = cint(result or 6)
      of GIT_ERROR_CONFIG    : result = cint(result or 7)
      of GIT_ERROR_REGEX     : result = cint(result or 8)
      of GIT_ERROR_ODB       : result = cint(result or 9)
      of GIT_ERROR_INDEX     : result = cint(result or 10)
      of GIT_ERROR_OBJECT    : result = cint(result or 11)
      of GIT_ERROR_NET       : result = cint(result or 12)
      of GIT_ERROR_TAG       : result = cint(result or 13)
      of GIT_ERROR_TREE      : result = cint(result or 14)
      of GIT_ERROR_INDEXER   : result = cint(result or 15)
      of GIT_ERROR_SSL       : result = cint(result or 16)
      of GIT_ERROR_SUBMODULE : result = cint(result or 17)
      of GIT_ERROR_THREAD    : result = cint(result or 18)
      of GIT_ERROR_STASH     : result = cint(result or 19)
      of GIT_ERROR_CHECKOUT  : result = cint(result or 20)
      of GIT_ERROR_FETCHHEAD : result = cint(result or 21)
      of GIT_ERROR_MERGE     : result = cint(result or 22)
      of GIT_ERROR_SSH       : result = cint(result or 23)
      of GIT_ERROR_FILTER    : result = cint(result or 24)
      of GIT_ERROR_REVERT    : result = cint(result or 25)
      of GIT_ERROR_CALLBACK  : result = cint(result or 26)
      of GIT_ERROR_CHERRYPICK: result = cint(result or 27)
      of GIT_ERROR_DESCRIBE  : result = cint(result or 28)
      of GIT_ERROR_REBASE    : result = cint(result or 29)
      of GIT_ERROR_FILESYSTEM: result = cint(result or 30)
      of GIT_ERROR_PATCH     : result = cint(result or 31)
      of GIT_ERROR_WORKTREE  : result = cint(result or 32)
      of GIT_ERROR_SHA       : result = cint(result or 33)
      of GIT_ERROR_HTTP      : result = cint(result or 34)
      of GIT_ERROR_INTERNAL  : result = cint(result or 35)
      of GIT_ERROR_GRAFTS    : result = cint(result or 36)

func `-`*(arg: c_git_error_t, offset: int): cint = cast[c_git_error_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_error_t): cint = cast[c_git_error_t](ord(arg) - offset)

func `+`*(arg: c_git_error_t, offset: int): cint = cast[c_git_error_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_error_t): cint = cast[c_git_error_t](ord(arg) + offset)

proc git_error_last*(): ptr git_error {.importc: "git_error_last".}