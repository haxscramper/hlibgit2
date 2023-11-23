import "./libgit2_config.nim"

type
  git_error* {.importc, bycopy.} = object
    message *: `ptr` char
    klass   *: cint

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
    GIT_OK
    GIT_ERROR
    GIT_ENOTFOUND
    GIT_EEXISTS
    GIT_EAMBIGUOUS
    GIT_EBUFS
    GIT_EUSER
    GIT_EBAREREPO
    GIT_EUNBORNBRANCH
    GIT_EUNMERGED
    GIT_ENONFASTFORWARD
    GIT_EINVALIDSPEC
    GIT_ECONFLICT
    GIT_ELOCKED
    GIT_EMODIFIED
    GIT_EAUTH
    GIT_ECERTIFICATE
    GIT_EAPPLIED
    GIT_EPEEL
    GIT_EEOF
    GIT_EINVALID
    GIT_EUNCOMMITTED
    GIT_EDIRECTORY
    GIT_EMERGECONFLICT
    GIT_PASSTHROUGH
    GIT_ITEROVER
    GIT_RETRY
    GIT_EMISMATCH
    GIT_EINDEXDIRTY
    GIT_EAPPLYFAIL
    GIT_EOWNER
    GIT_TIMEOUT

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
    GIT_ERROR_SHA
    GIT_ERROR_HTTP
    GIT_ERROR_INTERNAL
    GIT_ERROR_GRAFTS



proc git_error_clear*(): void {.git2Proc, importc.}

proc git_error_set*(error_class: cint, fmt: cstring): void {.git2Proc, importc.}

proc git_error_set_str*(error_class: cint, string: cstring): cint {.git2Proc, importc.}

proc git_error_set_oom*(): void {.git2Proc, importc.}

converter toCInt*(arg: c_git_error_code): cint = cint(ord(arg))

converter toCInt*(args: set[git_error_code]): cint =
  for value in items(args):
    case value:
      of GIT_OK             : result = cint(result or 0)
      of GIT_ERROR          : result = cint(result or -1)
      of GIT_ENOTFOUND      : result = cint(result or -3)
      of GIT_EEXISTS        : result = cint(result or -4)
      of GIT_EAMBIGUOUS     : result = cint(result or -5)
      of GIT_EBUFS          : result = cint(result or -6)
      of GIT_EUSER          : result = cint(result or -7)
      of GIT_EBAREREPO      : result = cint(result or -8)
      of GIT_EUNBORNBRANCH  : result = cint(result or -9)
      of GIT_EUNMERGED      : result = cint(result or -10)
      of GIT_ENONFASTFORWARD: result = cint(result or -11)
      of GIT_EINVALIDSPEC   : result = cint(result or -12)
      of GIT_ECONFLICT      : result = cint(result or -13)
      of GIT_ELOCKED        : result = cint(result or -14)
      of GIT_EMODIFIED      : result = cint(result or -15)
      of GIT_EAUTH          : result = cint(result or -16)
      of GIT_ECERTIFICATE   : result = cint(result or -17)
      of GIT_EAPPLIED       : result = cint(result or -18)
      of GIT_EPEEL          : result = cint(result or -19)
      of GIT_EEOF           : result = cint(result or -20)
      of GIT_EINVALID       : result = cint(result or -21)
      of GIT_EUNCOMMITTED   : result = cint(result or -22)
      of GIT_EDIRECTORY     : result = cint(result or -23)
      of GIT_EMERGECONFLICT : result = cint(result or -24)
      of GIT_PASSTHROUGH    : result = cint(result or -30)
      of GIT_ITEROVER       : result = cint(result or -31)
      of GIT_RETRY          : result = cint(result or -32)
      of GIT_EMISMATCH      : result = cint(result or -33)
      of GIT_EINDEXDIRTY    : result = cint(result or -34)
      of GIT_EAPPLYFAIL     : result = cint(result or -35)
      of GIT_EOWNER         : result = cint(result or -36)
      of GIT_TIMEOUT        : result = cint(result or -37)

func `-`*(arg: c_git_error_code, offset: int): cint = cast[c_git_error_code](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_error_code): cint = cast[c_git_error_code](ord(arg) - offset)

func `+`*(arg: c_git_error_code, offset: int): cint = cast[c_git_error_code](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_error_code): cint = cast[c_git_error_code](ord(arg) + offset)

converter toCInt*(arg: c_git_error_t): cint = cint(ord(arg))

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

proc git_error_last*(): `ptr` git_error {.git2Proc, importc.}