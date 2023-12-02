import "./libgit2_config.nim" ## From gen file
import "./buffer.nim"
import "./types.nim"

type
  git_config_backend* {.importc, bycopy, incompleteStruct.} = object
    version      *: cuint
    readonly     *: cint
    cfg          *: `ptr` git_config
    open         *: proc (a0: `ptr` git_config_backend, a1: git_config_level_t, a2: `ptr` git_repository): cint
    get          *: proc (a0: `ptr` git_config_backend, a1: cstring, a2: `ptr` git_config_entry): cint
    set          *: proc (a0: `ptr` git_config_backend, a1: cstring, a2: cstring): cint
    set_multivar *: proc (a0: `ptr` git_config_backend, a1: cstring, a2: cstring, a3: cstring): cint
    del          *: proc (a0: `ptr` git_config_backend, a1: cstring): cint
    del_multivar *: proc (a0: `ptr` git_config_backend, a1: cstring, a2: cstring): cint
    `iterator`   *: proc (a0: `ptr` git_config_iterator, a1: `ptr` git_config_backend): cint
    snapshot     *: proc (a0: `ptr` git_config_backend, a1: `ptr` git_config_backend): cint
    lock         *: proc (a0: `ptr` git_config_backend): cint
    unlock       *: proc (a0: `ptr` git_config_backend, a1: cint): cint
    free         *: proc (a0: `ptr` git_config_backend): void

  git_config_entry* {.importc, bycopy.} = object
    name          *: cstring
    value         *: cstring
    include_depth *: cuint
    level         *: git_config_level_t
    free          *: proc (a0: `ptr` git_config_entry): void
    payload       *: pointer

  git_config_iterator* {.importc, bycopy, incompleteStruct.} = object
    backend *: `ptr` git_config_backend
    flags   *: cuint
    next    *: proc (a0: `ptr` git_config_entry, a1: `ptr` git_config_iterator): cint
    free    *: proc (a0: `ptr` git_config_iterator): void

  git_configmap* {.importc, bycopy.} = object
    `type`    *: git_configmap_t
    str_match *: cstring
    map_value *: cint

  c_git_config_level_t* {.size: sizeof(cint).} = enum
    c_GIT_CONFIG_HIGHEST_LEVEL     = -1
    c_GIT_CONFIG_LEVEL_PROGRAMDATA = 1
    c_GIT_CONFIG_LEVEL_SYSTEM      = 2
    c_GIT_CONFIG_LEVEL_XDG         = 3
    c_GIT_CONFIG_LEVEL_GLOBAL      = 4
    c_GIT_CONFIG_LEVEL_LOCAL       = 5
    c_GIT_CONFIG_LEVEL_APP         = 6

  git_config_level_t* = enum
    GIT_CONFIG_LEVEL_PROGRAMDATA
    GIT_CONFIG_LEVEL_SYSTEM
    GIT_CONFIG_LEVEL_XDG
    GIT_CONFIG_LEVEL_GLOBAL
    GIT_CONFIG_LEVEL_LOCAL
    GIT_CONFIG_LEVEL_APP
    GIT_CONFIG_HIGHEST_LEVEL

  c_git_configmap_t* {.size: sizeof(cint).} = enum
    c_GIT_CONFIGMAP_FALSE  = 0
    c_GIT_CONFIGMAP_TRUE   = 1
    c_GIT_CONFIGMAP_INT32  = 2
    c_GIT_CONFIGMAP_STRING = 3

  git_configmap_t* = enum
    GIT_CONFIGMAP_FALSE
    GIT_CONFIGMAP_TRUE
    GIT_CONFIGMAP_INT32
    GIT_CONFIGMAP_STRING

  git_config_foreach_cb* = proc (a0: `ptr` git_config_entry, a1: pointer): cint



proc git_config_init_backend*(backend: `ptr` git_config_backend, version: cuint): cint {.git2Proc, importc: "git_config_init_backend".}

proc git_config_add_backend*(cfg: `ptr` git_config, file: `ptr` git_config_backend, level: git_config_level_t, repo: `ptr` git_repository, force: cint): cint {.git2Proc, importc: "git_config_add_backend".}

converter toCInt*(arg: c_git_config_level_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_config_level_t]): cint =
  for value in items(args):
    case value:
      of GIT_CONFIG_LEVEL_PROGRAMDATA: result = cint(result or 1)
      of GIT_CONFIG_LEVEL_SYSTEM     : result = cint(result or 2)
      of GIT_CONFIG_LEVEL_XDG        : result = cint(result or 3)
      of GIT_CONFIG_LEVEL_GLOBAL     : result = cint(result or 4)
      of GIT_CONFIG_LEVEL_LOCAL      : result = cint(result or 5)
      of GIT_CONFIG_LEVEL_APP        : result = cint(result or 6)
      of GIT_CONFIG_HIGHEST_LEVEL    : result = cint(result or -1)

func `-`*(arg: c_git_config_level_t, offset: int): cint = cast[c_git_config_level_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_config_level_t): cint = cast[c_git_config_level_t](ord(arg) - offset)

func `+`*(arg: c_git_config_level_t, offset: int): cint = cast[c_git_config_level_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_config_level_t): cint = cast[c_git_config_level_t](ord(arg) + offset)

converter toCInt*(arg: c_git_configmap_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_configmap_t]): cint =
  for value in items(args):
    case value:
      of GIT_CONFIGMAP_FALSE : result = cint(result or 0)
      of GIT_CONFIGMAP_TRUE  : result = cint(result or 1)
      of GIT_CONFIGMAP_INT32 : result = cint(result or 2)
      of GIT_CONFIGMAP_STRING: result = cint(result or 3)

func `-`*(arg: c_git_configmap_t, offset: int): cint = cast[c_git_configmap_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_configmap_t): cint = cast[c_git_configmap_t](ord(arg) - offset)

func `+`*(arg: c_git_configmap_t, offset: int): cint = cast[c_git_configmap_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_configmap_t): cint = cast[c_git_configmap_t](ord(arg) + offset)

proc git_config_entry_free*(entry: `ptr` git_config_entry): void {.git2Proc, importc: "git_config_entry_free".}

proc git_config_find_global*(`out`: `ptr` git_buf): cint {.git2Proc, importc: "git_config_find_global".}

proc git_config_find_xdg*(`out`: `ptr` git_buf): cint {.git2Proc, importc: "git_config_find_xdg".}

proc git_config_find_system*(`out`: `ptr` git_buf): cint {.git2Proc, importc: "git_config_find_system".}

proc git_config_find_programdata*(`out`: `ptr` git_buf): cint {.git2Proc, importc: "git_config_find_programdata".}

proc git_config_open_default*(`out`: `ptr` git_config): cint {.git2Proc, importc: "git_config_open_default".}

proc git_config_new*(`out`: `ptr` git_config): cint {.git2Proc, importc: "git_config_new".}

proc git_config_add_file_ondisk*(cfg: `ptr` git_config, path: cstring, level: git_config_level_t, repo: `ptr` git_repository, force: cint): cint {.git2Proc, importc: "git_config_add_file_ondisk".}

proc git_config_open_ondisk*(`out`: `ptr` git_config, path: cstring): cint {.git2Proc, importc: "git_config_open_ondisk".}

proc git_config_open_level*(`out`: `ptr` git_config, parent: `ptr` git_config, level: git_config_level_t): cint {.git2Proc, importc: "git_config_open_level".}

proc git_config_open_global*(`out`: `ptr` git_config, config: `ptr` git_config): cint {.git2Proc, importc: "git_config_open_global".}

proc git_config_snapshot*(`out`: `ptr` git_config, config: `ptr` git_config): cint {.git2Proc, importc: "git_config_snapshot".}

proc git_config_free*(cfg: `ptr` git_config): void {.git2Proc, importc: "git_config_free".}

proc git_config_get_entry*(`out`: `ptr` git_config_entry, cfg: `ptr` git_config, name: cstring): cint {.git2Proc, importc: "git_config_get_entry".}

proc git_config_get_int32*(`out`: `ptr` int32, cfg: `ptr` git_config, name: cstring): cint {.git2Proc, importc: "git_config_get_int32".}

proc git_config_get_int64*(`out`: `ptr` int64, cfg: `ptr` git_config, name: cstring): cint {.git2Proc, importc: "git_config_get_int64".}

proc git_config_get_bool*(`out`: `ptr` cint, cfg: `ptr` git_config, name: cstring): cint {.git2Proc, importc: "git_config_get_bool".}

proc git_config_get_path*(`out`: `ptr` git_buf, cfg: `ptr` git_config, name: cstring): cint {.git2Proc, importc: "git_config_get_path".}

proc git_config_get_string*(`out`: cstring, cfg: `ptr` git_config, name: cstring): cint {.git2Proc, importc: "git_config_get_string".}

proc git_config_get_string_buf*(`out`: `ptr` git_buf, cfg: `ptr` git_config, name: cstring): cint {.git2Proc, importc: "git_config_get_string_buf".}

proc git_config_get_multivar_foreach*(cfg: `ptr` git_config, name: cstring, regexp: cstring, callback: git_config_foreach_cb, payload: pointer): cint {.git2Proc, importc: "git_config_get_multivar_foreach".}

proc git_config_multivar_iterator_new*(`out`: `ptr` git_config_iterator, cfg: `ptr` git_config, name: cstring, regexp: cstring): cint {.git2Proc, importc: "git_config_multivar_iterator_new".}

proc git_config_next*(entry: `ptr` git_config_entry, iter: `ptr` git_config_iterator): cint {.git2Proc, importc: "git_config_next".}

proc git_config_iterator_free*(iter: `ptr` git_config_iterator): void {.git2Proc, importc: "git_config_iterator_free".}

proc git_config_set_int32*(cfg: `ptr` git_config, name: cstring, value: int32): cint {.git2Proc, importc: "git_config_set_int32".}

proc git_config_set_int64*(cfg: `ptr` git_config, name: cstring, value: int64): cint {.git2Proc, importc: "git_config_set_int64".}

proc git_config_set_bool*(cfg: `ptr` git_config, name: cstring, value: cint): cint {.git2Proc, importc: "git_config_set_bool".}

proc git_config_set_string*(cfg: `ptr` git_config, name: cstring, value: cstring): cint {.git2Proc, importc: "git_config_set_string".}

proc git_config_set_multivar*(cfg: `ptr` git_config, name: cstring, regexp: cstring, value: cstring): cint {.git2Proc, importc: "git_config_set_multivar".}

proc git_config_delete_entry*(cfg: `ptr` git_config, name: cstring): cint {.git2Proc, importc: "git_config_delete_entry".}

proc git_config_delete_multivar*(cfg: `ptr` git_config, name: cstring, regexp: cstring): cint {.git2Proc, importc: "git_config_delete_multivar".}

proc git_config_foreach*(cfg: `ptr` git_config, callback: git_config_foreach_cb, payload: pointer): cint {.git2Proc, importc: "git_config_foreach".}

proc git_config_iterator_new*(`out`: `ptr` git_config_iterator, cfg: `ptr` git_config): cint {.git2Proc, importc: "git_config_iterator_new".}

proc git_config_iterator_glob_new*(`out`: `ptr` git_config_iterator, cfg: `ptr` git_config, regexp: cstring): cint {.git2Proc, importc: "git_config_iterator_glob_new".}

proc git_config_foreach_match*(cfg: `ptr` git_config, regexp: cstring, callback: git_config_foreach_cb, payload: pointer): cint {.git2Proc, importc: "git_config_foreach_match".}

proc git_config_get_mapped*(`out`: `ptr` cint, cfg: `ptr` git_config, name: cstring, maps: `ptr` git_configmap, map_n: csize_t): cint {.git2Proc, importc: "git_config_get_mapped".}

proc git_config_lookup_map_value*(`out`: `ptr` cint, maps: `ptr` git_configmap, map_n: csize_t, value: cstring): cint {.git2Proc, importc: "git_config_lookup_map_value".}

proc git_config_parse_bool*(`out`: `ptr` cint, value: cstring): cint {.git2Proc, importc: "git_config_parse_bool".}

proc git_config_parse_int32*(`out`: `ptr` int32, value: cstring): cint {.git2Proc, importc: "git_config_parse_int32".}

proc git_config_parse_int64*(`out`: `ptr` int64, value: cstring): cint {.git2Proc, importc: "git_config_parse_int64".}

proc git_config_parse_path*(`out`: `ptr` git_buf, value: cstring): cint {.git2Proc, importc: "git_config_parse_path".}

proc git_config_backend_foreach_match*(backend: `ptr` git_config_backend, regexp: cstring, callback: git_config_foreach_cb, payload: pointer): cint {.git2Proc, importc: "git_config_backend_foreach_match".}

proc git_config_lock*(tx: `ptr` git_transaction, cfg: `ptr` git_config): cint {.git2Proc, importc: "git_config_lock".}