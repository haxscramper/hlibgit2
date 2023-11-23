import "./libgit2_config.nim"

type
  c_git_feature_t* {.size: sizeof(cint).} = enum
    c_GIT_FEATURE_THREADS = 1 shl 0
    c_GIT_FEATURE_HTTPS   = 1 shl 1
    c_GIT_FEATURE_SSH     = 1 shl 2
    c_GIT_FEATURE_NSEC    = 1 shl 3

  git_feature_t* = enum
    GIT_FEATURE_THREADS
    GIT_FEATURE_HTTPS
    GIT_FEATURE_SSH
    GIT_FEATURE_NSEC

  c_git_libgit2_opt_t* {.size: sizeof(cint).} = enum
    c_GIT_OPT_GET_MWINDOW_SIZE                    = 0
    c_GIT_OPT_SET_MWINDOW_SIZE                    = 1
    c_GIT_OPT_GET_MWINDOW_MAPPED_LIMIT            = 2
    c_GIT_OPT_SET_MWINDOW_MAPPED_LIMIT            = 3
    c_GIT_OPT_GET_SEARCH_PATH                     = 4
    c_GIT_OPT_SET_SEARCH_PATH                     = 5
    c_GIT_OPT_SET_CACHE_OBJECT_LIMIT              = 6
    c_GIT_OPT_SET_CACHE_MAX_SIZE                  = 7
    c_GIT_OPT_ENABLE_CACHING                      = 8
    c_GIT_OPT_GET_CACHED_MEMORY                   = 9
    c_GIT_OPT_GET_TEMPLATE_PATH                   = 10
    c_GIT_OPT_SET_TEMPLATE_PATH                   = 11
    c_GIT_OPT_SET_SSL_CERT_LOCATIONS              = 12
    c_GIT_OPT_SET_USER_AGENT                      = 13
    c_GIT_OPT_ENABLE_STRICT_OBJECT_CREATION       = 14
    c_GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION = 15
    c_GIT_OPT_SET_SSL_CIPHERS                     = 16
    c_GIT_OPT_GET_USER_AGENT                      = 17
    c_GIT_OPT_ENABLE_OFS_DELTA                    = 18
    c_GIT_OPT_ENABLE_FSYNC_GITDIR                 = 19
    c_GIT_OPT_GET_WINDOWS_SHAREMODE               = 20
    c_GIT_OPT_SET_WINDOWS_SHAREMODE               = 21
    c_GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION     = 22
    c_GIT_OPT_SET_ALLOCATOR                       = 23
    c_GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY         = 24
    c_GIT_OPT_GET_PACK_MAX_OBJECTS                = 25
    c_GIT_OPT_SET_PACK_MAX_OBJECTS                = 26
    c_GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS       = 27
    c_GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE         = 28
    c_GIT_OPT_GET_MWINDOW_FILE_LIMIT              = 29
    c_GIT_OPT_SET_MWINDOW_FILE_LIMIT              = 30
    c_GIT_OPT_SET_ODB_PACKED_PRIORITY             = 31
    c_GIT_OPT_SET_ODB_LOOSE_PRIORITY              = 32
    c_GIT_OPT_GET_EXTENSIONS                      = 33
    c_GIT_OPT_SET_EXTENSIONS                      = 34
    c_GIT_OPT_GET_OWNER_VALIDATION                = 35
    c_GIT_OPT_SET_OWNER_VALIDATION                = 36
    c_GIT_OPT_GET_HOMEDIR                         = 37
    c_GIT_OPT_SET_HOMEDIR                         = 38
    c_GIT_OPT_SET_SERVER_CONNECT_TIMEOUT          = 39
    c_GIT_OPT_GET_SERVER_CONNECT_TIMEOUT          = 40
    c_GIT_OPT_SET_SERVER_TIMEOUT                  = 41
    c_GIT_OPT_GET_SERVER_TIMEOUT                  = 42

  git_libgit2_opt_t* = enum
    GIT_OPT_GET_MWINDOW_SIZE
    GIT_OPT_SET_MWINDOW_SIZE
    GIT_OPT_GET_MWINDOW_MAPPED_LIMIT
    GIT_OPT_SET_MWINDOW_MAPPED_LIMIT
    GIT_OPT_GET_SEARCH_PATH
    GIT_OPT_SET_SEARCH_PATH
    GIT_OPT_SET_CACHE_OBJECT_LIMIT
    GIT_OPT_SET_CACHE_MAX_SIZE
    GIT_OPT_ENABLE_CACHING
    GIT_OPT_GET_CACHED_MEMORY
    GIT_OPT_GET_TEMPLATE_PATH
    GIT_OPT_SET_TEMPLATE_PATH
    GIT_OPT_SET_SSL_CERT_LOCATIONS
    GIT_OPT_SET_USER_AGENT
    GIT_OPT_ENABLE_STRICT_OBJECT_CREATION
    GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION
    GIT_OPT_SET_SSL_CIPHERS
    GIT_OPT_GET_USER_AGENT
    GIT_OPT_ENABLE_OFS_DELTA
    GIT_OPT_ENABLE_FSYNC_GITDIR
    GIT_OPT_GET_WINDOWS_SHAREMODE
    GIT_OPT_SET_WINDOWS_SHAREMODE
    GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION
    GIT_OPT_SET_ALLOCATOR
    GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY
    GIT_OPT_GET_PACK_MAX_OBJECTS
    GIT_OPT_SET_PACK_MAX_OBJECTS
    GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS
    GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE
    GIT_OPT_GET_MWINDOW_FILE_LIMIT
    GIT_OPT_SET_MWINDOW_FILE_LIMIT
    GIT_OPT_SET_ODB_PACKED_PRIORITY
    GIT_OPT_SET_ODB_LOOSE_PRIORITY
    GIT_OPT_GET_EXTENSIONS
    GIT_OPT_SET_EXTENSIONS
    GIT_OPT_GET_OWNER_VALIDATION
    GIT_OPT_SET_OWNER_VALIDATION
    GIT_OPT_GET_HOMEDIR
    GIT_OPT_SET_HOMEDIR
    GIT_OPT_SET_SERVER_CONNECT_TIMEOUT
    GIT_OPT_GET_SERVER_CONNECT_TIMEOUT
    GIT_OPT_SET_SERVER_TIMEOUT
    GIT_OPT_GET_SERVER_TIMEOUT



converter toCInt*(arg: c_git_feature_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_feature_t]): cint =
  for value in items(args):
    case value:
      of GIT_FEATURE_THREADS: result = cint(result or 1)
      of GIT_FEATURE_HTTPS  : result = cint(result or 2)
      of GIT_FEATURE_SSH    : result = cint(result or 4)
      of GIT_FEATURE_NSEC   : result = cint(result or 8)

func `-`*(arg: c_git_feature_t, offset: int): cint = cast[c_git_feature_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_feature_t): cint = cast[c_git_feature_t](ord(arg) - offset)

func `+`*(arg: c_git_feature_t, offset: int): cint = cast[c_git_feature_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_feature_t): cint = cast[c_git_feature_t](ord(arg) + offset)

converter toCInt*(arg: c_git_libgit2_opt_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_libgit2_opt_t]): cint =
  for value in items(args):
    case value:
      of GIT_OPT_GET_MWINDOW_SIZE                   : result = cint(result or 0)
      of GIT_OPT_SET_MWINDOW_SIZE                   : result = cint(result or 1)
      of GIT_OPT_GET_MWINDOW_MAPPED_LIMIT           : result = cint(result or 2)
      of GIT_OPT_SET_MWINDOW_MAPPED_LIMIT           : result = cint(result or 3)
      of GIT_OPT_GET_SEARCH_PATH                    : result = cint(result or 4)
      of GIT_OPT_SET_SEARCH_PATH                    : result = cint(result or 5)
      of GIT_OPT_SET_CACHE_OBJECT_LIMIT             : result = cint(result or 6)
      of GIT_OPT_SET_CACHE_MAX_SIZE                 : result = cint(result or 7)
      of GIT_OPT_ENABLE_CACHING                     : result = cint(result or 8)
      of GIT_OPT_GET_CACHED_MEMORY                  : result = cint(result or 9)
      of GIT_OPT_GET_TEMPLATE_PATH                  : result = cint(result or 10)
      of GIT_OPT_SET_TEMPLATE_PATH                  : result = cint(result or 11)
      of GIT_OPT_SET_SSL_CERT_LOCATIONS             : result = cint(result or 12)
      of GIT_OPT_SET_USER_AGENT                     : result = cint(result or 13)
      of GIT_OPT_ENABLE_STRICT_OBJECT_CREATION      : result = cint(result or 14)
      of GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION: result = cint(result or 15)
      of GIT_OPT_SET_SSL_CIPHERS                    : result = cint(result or 16)
      of GIT_OPT_GET_USER_AGENT                     : result = cint(result or 17)
      of GIT_OPT_ENABLE_OFS_DELTA                   : result = cint(result or 18)
      of GIT_OPT_ENABLE_FSYNC_GITDIR                : result = cint(result or 19)
      of GIT_OPT_GET_WINDOWS_SHAREMODE              : result = cint(result or 20)
      of GIT_OPT_SET_WINDOWS_SHAREMODE              : result = cint(result or 21)
      of GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION    : result = cint(result or 22)
      of GIT_OPT_SET_ALLOCATOR                      : result = cint(result or 23)
      of GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY        : result = cint(result or 24)
      of GIT_OPT_GET_PACK_MAX_OBJECTS               : result = cint(result or 25)
      of GIT_OPT_SET_PACK_MAX_OBJECTS               : result = cint(result or 26)
      of GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS      : result = cint(result or 27)
      of GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE        : result = cint(result or 28)
      of GIT_OPT_GET_MWINDOW_FILE_LIMIT             : result = cint(result or 29)
      of GIT_OPT_SET_MWINDOW_FILE_LIMIT             : result = cint(result or 30)
      of GIT_OPT_SET_ODB_PACKED_PRIORITY            : result = cint(result or 31)
      of GIT_OPT_SET_ODB_LOOSE_PRIORITY             : result = cint(result or 32)
      of GIT_OPT_GET_EXTENSIONS                     : result = cint(result or 33)
      of GIT_OPT_SET_EXTENSIONS                     : result = cint(result or 34)
      of GIT_OPT_GET_OWNER_VALIDATION               : result = cint(result or 35)
      of GIT_OPT_SET_OWNER_VALIDATION               : result = cint(result or 36)
      of GIT_OPT_GET_HOMEDIR                        : result = cint(result or 37)
      of GIT_OPT_SET_HOMEDIR                        : result = cint(result or 38)
      of GIT_OPT_SET_SERVER_CONNECT_TIMEOUT         : result = cint(result or 39)
      of GIT_OPT_GET_SERVER_CONNECT_TIMEOUT         : result = cint(result or 40)
      of GIT_OPT_SET_SERVER_TIMEOUT                 : result = cint(result or 41)
      of GIT_OPT_GET_SERVER_TIMEOUT                 : result = cint(result or 42)

func `-`*(arg: c_git_libgit2_opt_t, offset: int): cint = cast[c_git_libgit2_opt_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_libgit2_opt_t): cint = cast[c_git_libgit2_opt_t](ord(arg) - offset)

func `+`*(arg: c_git_libgit2_opt_t, offset: int): cint = cast[c_git_libgit2_opt_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_libgit2_opt_t): cint = cast[c_git_libgit2_opt_t](ord(arg) + offset)

proc git_libgit2_version*(major: `ptr` cint, minor: `ptr` cint, rev: `ptr` cint): cint {.git2Proc, importc.}

proc git_libgit2_prerelease*(): cstring {.git2Proc, importc.}

proc git_libgit2_features*(): cint {.git2Proc, importc.}

proc git_libgit2_opts*(option: cint): cint {.git2Proc, importc.}