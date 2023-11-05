{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  c_git_feature_t* {.size: sizeof(cint).} = enum
    c_GIT_FEATURE_THREADS = 1 shl 0
    c_GIT_FEATURE_HTTPS   = 1 shl 1
    c_GIT_FEATURE_SSH     = 1 shl 2
    c_GIT_FEATURE_NSEC    = 1 shl 3

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

  git_feature_t* {.size: sizeof(cint).} = enum
    GIT_FEATURE_THREADS
    GIT_FEATURE_HTTPS
    GIT_FEATURE_SSH
    GIT_FEATURE_NSEC

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


proc git_libgit2_version*(
    major: ptr cint,
    minor: ptr cint,
    rev:   ptr cint
  ): cint {.git2Proc, importc.}



proc to_c_git_feature_t*(arg: git_feature_t): c_git_feature_t =
  case arg:
    of GIT_FEATURE_THREADS: c_GIT_FEATURE_THREADS
    of GIT_FEATURE_HTTPS:   c_GIT_FEATURE_HTTPS
    of GIT_FEATURE_SSH:     c_GIT_FEATURE_SSH
    of GIT_FEATURE_NSEC:    c_GIT_FEATURE_NSEC


converter to_git_feature_t*(arg: c_git_feature_t): git_feature_t =
  case arg:
    of c_GIT_FEATURE_THREADS: GIT_FEATURE_THREADS
    of c_GIT_FEATURE_HTTPS:   GIT_FEATURE_HTTPS
    of c_GIT_FEATURE_SSH:     GIT_FEATURE_SSH
    of c_GIT_FEATURE_NSEC:    GIT_FEATURE_NSEC


converter toCint*(arg: c_git_feature_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_feature_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_feature_t(arg)))

func `+`*(arg: c_git_feature_t, offset: int): c_git_feature_t =
  cast[c_git_feature_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_feature_t): c_git_feature_t =
  cast[c_git_feature_t](ord(arg) + offset)

func `-`*(arg: c_git_feature_t, offset: int): c_git_feature_t =
  cast[c_git_feature_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_feature_t): c_git_feature_t =
  cast[c_git_feature_t](ord(arg) - offset)


converter toCint*(args: set[git_feature_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc git_libgit2_features*(a0: void): cint {.git2Proc, importc.}



proc to_c_git_libgit2_opt_t*(arg: git_libgit2_opt_t): c_git_libgit2_opt_t =
  case arg:
    of GIT_OPT_GET_MWINDOW_SIZE:                    c_GIT_OPT_GET_MWINDOW_SIZE
    of GIT_OPT_SET_MWINDOW_SIZE:                    c_GIT_OPT_SET_MWINDOW_SIZE
    of GIT_OPT_GET_MWINDOW_MAPPED_LIMIT:            c_GIT_OPT_GET_MWINDOW_MAPPED_LIMIT
    of GIT_OPT_SET_MWINDOW_MAPPED_LIMIT:            c_GIT_OPT_SET_MWINDOW_MAPPED_LIMIT
    of GIT_OPT_GET_SEARCH_PATH:                     c_GIT_OPT_GET_SEARCH_PATH
    of GIT_OPT_SET_SEARCH_PATH:                     c_GIT_OPT_SET_SEARCH_PATH
    of GIT_OPT_SET_CACHE_OBJECT_LIMIT:              c_GIT_OPT_SET_CACHE_OBJECT_LIMIT
    of GIT_OPT_SET_CACHE_MAX_SIZE:                  c_GIT_OPT_SET_CACHE_MAX_SIZE
    of GIT_OPT_ENABLE_CACHING:                      c_GIT_OPT_ENABLE_CACHING
    of GIT_OPT_GET_CACHED_MEMORY:                   c_GIT_OPT_GET_CACHED_MEMORY
    of GIT_OPT_GET_TEMPLATE_PATH:                   c_GIT_OPT_GET_TEMPLATE_PATH
    of GIT_OPT_SET_TEMPLATE_PATH:                   c_GIT_OPT_SET_TEMPLATE_PATH
    of GIT_OPT_SET_SSL_CERT_LOCATIONS:              c_GIT_OPT_SET_SSL_CERT_LOCATIONS
    of GIT_OPT_SET_USER_AGENT:                      c_GIT_OPT_SET_USER_AGENT
    of GIT_OPT_ENABLE_STRICT_OBJECT_CREATION:       c_GIT_OPT_ENABLE_STRICT_OBJECT_CREATION
    of GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION: c_GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION
    of GIT_OPT_SET_SSL_CIPHERS:                     c_GIT_OPT_SET_SSL_CIPHERS
    of GIT_OPT_GET_USER_AGENT:                      c_GIT_OPT_GET_USER_AGENT
    of GIT_OPT_ENABLE_OFS_DELTA:                    c_GIT_OPT_ENABLE_OFS_DELTA
    of GIT_OPT_ENABLE_FSYNC_GITDIR:                 c_GIT_OPT_ENABLE_FSYNC_GITDIR
    of GIT_OPT_GET_WINDOWS_SHAREMODE:               c_GIT_OPT_GET_WINDOWS_SHAREMODE
    of GIT_OPT_SET_WINDOWS_SHAREMODE:               c_GIT_OPT_SET_WINDOWS_SHAREMODE
    of GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION:     c_GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION
    of GIT_OPT_SET_ALLOCATOR:                       c_GIT_OPT_SET_ALLOCATOR
    of GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY:         c_GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY
    of GIT_OPT_GET_PACK_MAX_OBJECTS:                c_GIT_OPT_GET_PACK_MAX_OBJECTS
    of GIT_OPT_SET_PACK_MAX_OBJECTS:                c_GIT_OPT_SET_PACK_MAX_OBJECTS
    of GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS:       c_GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS
    of GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE:         c_GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE
    of GIT_OPT_GET_MWINDOW_FILE_LIMIT:              c_GIT_OPT_GET_MWINDOW_FILE_LIMIT
    of GIT_OPT_SET_MWINDOW_FILE_LIMIT:              c_GIT_OPT_SET_MWINDOW_FILE_LIMIT
    of GIT_OPT_SET_ODB_PACKED_PRIORITY:             c_GIT_OPT_SET_ODB_PACKED_PRIORITY
    of GIT_OPT_SET_ODB_LOOSE_PRIORITY:              c_GIT_OPT_SET_ODB_LOOSE_PRIORITY


converter to_git_libgit2_opt_t*(arg: c_git_libgit2_opt_t): git_libgit2_opt_t =
  case arg:
    of c_GIT_OPT_GET_MWINDOW_SIZE:                    GIT_OPT_GET_MWINDOW_SIZE
    of c_GIT_OPT_SET_MWINDOW_SIZE:                    GIT_OPT_SET_MWINDOW_SIZE
    of c_GIT_OPT_GET_MWINDOW_MAPPED_LIMIT:            GIT_OPT_GET_MWINDOW_MAPPED_LIMIT
    of c_GIT_OPT_SET_MWINDOW_MAPPED_LIMIT:            GIT_OPT_SET_MWINDOW_MAPPED_LIMIT
    of c_GIT_OPT_GET_SEARCH_PATH:                     GIT_OPT_GET_SEARCH_PATH
    of c_GIT_OPT_SET_SEARCH_PATH:                     GIT_OPT_SET_SEARCH_PATH
    of c_GIT_OPT_SET_CACHE_OBJECT_LIMIT:              GIT_OPT_SET_CACHE_OBJECT_LIMIT
    of c_GIT_OPT_SET_CACHE_MAX_SIZE:                  GIT_OPT_SET_CACHE_MAX_SIZE
    of c_GIT_OPT_ENABLE_CACHING:                      GIT_OPT_ENABLE_CACHING
    of c_GIT_OPT_GET_CACHED_MEMORY:                   GIT_OPT_GET_CACHED_MEMORY
    of c_GIT_OPT_GET_TEMPLATE_PATH:                   GIT_OPT_GET_TEMPLATE_PATH
    of c_GIT_OPT_SET_TEMPLATE_PATH:                   GIT_OPT_SET_TEMPLATE_PATH
    of c_GIT_OPT_SET_SSL_CERT_LOCATIONS:              GIT_OPT_SET_SSL_CERT_LOCATIONS
    of c_GIT_OPT_SET_USER_AGENT:                      GIT_OPT_SET_USER_AGENT
    of c_GIT_OPT_ENABLE_STRICT_OBJECT_CREATION:       GIT_OPT_ENABLE_STRICT_OBJECT_CREATION
    of c_GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION: GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION
    of c_GIT_OPT_SET_SSL_CIPHERS:                     GIT_OPT_SET_SSL_CIPHERS
    of c_GIT_OPT_GET_USER_AGENT:                      GIT_OPT_GET_USER_AGENT
    of c_GIT_OPT_ENABLE_OFS_DELTA:                    GIT_OPT_ENABLE_OFS_DELTA
    of c_GIT_OPT_ENABLE_FSYNC_GITDIR:                 GIT_OPT_ENABLE_FSYNC_GITDIR
    of c_GIT_OPT_GET_WINDOWS_SHAREMODE:               GIT_OPT_GET_WINDOWS_SHAREMODE
    of c_GIT_OPT_SET_WINDOWS_SHAREMODE:               GIT_OPT_SET_WINDOWS_SHAREMODE
    of c_GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION:     GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION
    of c_GIT_OPT_SET_ALLOCATOR:                       GIT_OPT_SET_ALLOCATOR
    of c_GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY:         GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY
    of c_GIT_OPT_GET_PACK_MAX_OBJECTS:                GIT_OPT_GET_PACK_MAX_OBJECTS
    of c_GIT_OPT_SET_PACK_MAX_OBJECTS:                GIT_OPT_SET_PACK_MAX_OBJECTS
    of c_GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS:       GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS
    of c_GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE:         GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE
    of c_GIT_OPT_GET_MWINDOW_FILE_LIMIT:              GIT_OPT_GET_MWINDOW_FILE_LIMIT
    of c_GIT_OPT_SET_MWINDOW_FILE_LIMIT:              GIT_OPT_SET_MWINDOW_FILE_LIMIT
    of c_GIT_OPT_SET_ODB_PACKED_PRIORITY:             GIT_OPT_SET_ODB_PACKED_PRIORITY
    of c_GIT_OPT_SET_ODB_LOOSE_PRIORITY:              GIT_OPT_SET_ODB_LOOSE_PRIORITY


converter toCint*(arg: c_git_libgit2_opt_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_libgit2_opt_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_libgit2_opt_t(arg)))

func `+`*(arg: c_git_libgit2_opt_t, offset: int): c_git_libgit2_opt_t =
  cast[c_git_libgit2_opt_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_libgit2_opt_t): c_git_libgit2_opt_t =
  cast[c_git_libgit2_opt_t](ord(arg) + offset)

func `-`*(arg: c_git_libgit2_opt_t, offset: int): c_git_libgit2_opt_t =
  cast[c_git_libgit2_opt_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_libgit2_opt_t): c_git_libgit2_opt_t =
  cast[c_git_libgit2_opt_t](ord(arg) - offset)


proc git_libgit2_opts*(option: cint): cint {.varargs, git2Proc, importc.}



