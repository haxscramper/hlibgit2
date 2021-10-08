
type
  git_feature_t* = enum ## Declare a public function exported for application use. 
                         ## Declare a callback function for application use. 
                         ## Declare a function as deprecated. 
                         ## Declare a function's takes printf style arguments.
    GIT_FEATURE_THREADS = 1, GIT_FEATURE_HTTPS = 2, GIT_FEATURE_SSH = 4,
    GIT_FEATURE_NSEC = 8
  git_libgit2_opt_t* = enum
    GIT_OPT_GET_MWINDOW_SIZE = 0, GIT_OPT_SET_MWINDOW_SIZE = 1,
    GIT_OPT_GET_MWINDOW_MAPPED_LIMIT = 2, GIT_OPT_SET_MWINDOW_MAPPED_LIMIT = 3,
    GIT_OPT_GET_SEARCH_PATH = 4, GIT_OPT_SET_SEARCH_PATH = 5,
    GIT_OPT_SET_CACHE_OBJECT_LIMIT = 6, GIT_OPT_SET_CACHE_MAX_SIZE = 7,
    GIT_OPT_ENABLE_CACHING = 8, GIT_OPT_GET_CACHED_MEMORY = 9,
    GIT_OPT_GET_TEMPLATE_PATH = 10, GIT_OPT_SET_TEMPLATE_PATH = 11,
    GIT_OPT_SET_SSL_CERT_LOCATIONS = 12, GIT_OPT_SET_USER_AGENT = 13,
    GIT_OPT_ENABLE_STRICT_OBJECT_CREATION = 14,
    GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION = 15,
    GIT_OPT_SET_SSL_CIPHERS = 16, GIT_OPT_GET_USER_AGENT = 17,
    GIT_OPT_ENABLE_OFS_DELTA = 18, GIT_OPT_ENABLE_FSYNC_GITDIR = 19,
    GIT_OPT_GET_WINDOWS_SHAREMODE = 20, GIT_OPT_SET_WINDOWS_SHAREMODE = 21,
    GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION = 22, GIT_OPT_SET_ALLOCATOR = 23,
    GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY = 24, GIT_OPT_GET_PACK_MAX_OBJECTS = 25,
    GIT_OPT_SET_PACK_MAX_OBJECTS = 26,
    GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS = 27,
    GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE = 28,
    GIT_OPT_GET_MWINDOW_FILE_LIMIT = 29, GIT_OPT_SET_MWINDOW_FILE_LIMIT = 30
proc git_libgit2_version*(major: ptr cint; minor: ptr cint; rev: ptr cint): cint {.
    dynlib: libgitDl, importc.}
proc git_libgit2_features*(a0: void): cint {.dynlib: libgitDl, importc.}
proc git_libgit2_opts*(option: cint): cint {.dynlib: libgitDl, importc.}