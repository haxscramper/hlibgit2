{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./types

type
  c_git_config_level_t* {.size: sizeof(cint).} = enum
    c_GIT_CONFIG_HIGHEST_LEVEL     = -1
    c_GIT_CONFIG_LEVEL_PROGRAMDATA = 1  ## System-wide on Windows, for compatibility with portable git
    c_GIT_CONFIG_LEVEL_SYSTEM      = 2  ## System-wide configuration file; /etc/gitconfig on Linux systems
    c_GIT_CONFIG_LEVEL_XDG         = 3  ## XDG compatible configuration file; typically ~/.config/git/config
    c_GIT_CONFIG_LEVEL_GLOBAL      = 4
    c_GIT_CONFIG_LEVEL_LOCAL       = 5
    c_GIT_CONFIG_LEVEL_APP         = 6

  c_git_configmap_t* {.size: sizeof(cint).} = enum
    c_GIT_CONFIGMAP_FALSE  = 0
    c_GIT_CONFIGMAP_TRUE   = 1
    c_GIT_CONFIGMAP_INT32  = 2
    c_GIT_CONFIGMAP_STRING = 3

  git_config_entry* {.bycopy, header: "<git2/config.h>", importc.} = object
    name*:          cstring
    value*:         cstring                                          ## Name of the entry (normalised)
    include_depth*: cuint                                            ## String value of the entry
    level*:         c_git_config_level_t                             ## Depth of includes where this variable was found
    free*:          proc(entry: ptr git_config_entry): void{.cdecl.} ## Which config file this was found in
    payload*:       pointer                                          ## Free function for this entry
                                                                     ## Opaque value for the free function. Do not read or write

  git_config_foreach_cb* = proc(entry:   ptr git_config_entry,
                                payload: pointer): cint{.cdecl.}

  git_config_iterator* {.bycopy, incompleteStruct, header: "<git2/config.h>", importc.} = object


  git_config_level_t* = enum
    GIT_CONFIG_HIGHEST_LEVEL
    GIT_CONFIG_LEVEL_PROGRAMDATA ## System-wide on Windows, for compatibility with portable git
    GIT_CONFIG_LEVEL_SYSTEM      ## System-wide configuration file; /etc/gitconfig on Linux systems
    GIT_CONFIG_LEVEL_XDG         ## XDG compatible configuration file; typically ~/.config/git/config
    GIT_CONFIG_LEVEL_GLOBAL
    GIT_CONFIG_LEVEL_LOCAL
    GIT_CONFIG_LEVEL_APP

  git_configmap* {.bycopy, header: "<git2/config.h>", importc.} = object
    type_f* {.importc: "type".}: c_git_configmap_t
    str_match*:                  cstring
    map_value*:                  cint

  git_configmap_t* = enum
    GIT_CONFIGMAP_FALSE
    GIT_CONFIGMAP_TRUE
    GIT_CONFIGMAP_INT32
    GIT_CONFIGMAP_STRING


proc to_c_git_config_level_t*(arg: git_config_level_t): c_git_config_level_t =
  case arg:
    of GIT_CONFIG_HIGHEST_LEVEL:     c_GIT_CONFIG_HIGHEST_LEVEL
    of GIT_CONFIG_LEVEL_PROGRAMDATA: c_GIT_CONFIG_LEVEL_PROGRAMDATA
    of GIT_CONFIG_LEVEL_SYSTEM:      c_GIT_CONFIG_LEVEL_SYSTEM
    of GIT_CONFIG_LEVEL_XDG:         c_GIT_CONFIG_LEVEL_XDG
    of GIT_CONFIG_LEVEL_GLOBAL:      c_GIT_CONFIG_LEVEL_GLOBAL
    of GIT_CONFIG_LEVEL_LOCAL:       c_GIT_CONFIG_LEVEL_LOCAL
    of GIT_CONFIG_LEVEL_APP:         c_GIT_CONFIG_LEVEL_APP


converter to_git_config_level_t*(
    arg: c_git_config_level_t
  ): git_config_level_t =
  case arg:
    of c_GIT_CONFIG_HIGHEST_LEVEL:     GIT_CONFIG_HIGHEST_LEVEL
    of c_GIT_CONFIG_LEVEL_PROGRAMDATA: GIT_CONFIG_LEVEL_PROGRAMDATA
    of c_GIT_CONFIG_LEVEL_SYSTEM:      GIT_CONFIG_LEVEL_SYSTEM
    of c_GIT_CONFIG_LEVEL_XDG:         GIT_CONFIG_LEVEL_XDG
    of c_GIT_CONFIG_LEVEL_GLOBAL:      GIT_CONFIG_LEVEL_GLOBAL
    of c_GIT_CONFIG_LEVEL_LOCAL:       GIT_CONFIG_LEVEL_LOCAL
    of c_GIT_CONFIG_LEVEL_APP:         GIT_CONFIG_LEVEL_APP


converter toCint*(arg: c_git_config_level_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_config_level_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_config_level_t(arg)))

func `+`*(arg: c_git_config_level_t, offset: int): c_git_config_level_t =
  cast[c_git_config_level_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_config_level_t): c_git_config_level_t =
  cast[c_git_config_level_t](ord(arg) + offset)

func `-`*(arg: c_git_config_level_t, offset: int): c_git_config_level_t =
  cast[c_git_config_level_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_config_level_t): c_git_config_level_t =
  cast[c_git_config_level_t](ord(arg) - offset)


proc git_config_entry_free*(
    a0: ptr git_config_entry
  ): void {.git2Proc, importc.}



proc to_c_git_configmap_t*(arg: git_configmap_t): c_git_configmap_t =
  case arg:
    of GIT_CONFIGMAP_FALSE:  c_GIT_CONFIGMAP_FALSE
    of GIT_CONFIGMAP_TRUE:   c_GIT_CONFIGMAP_TRUE
    of GIT_CONFIGMAP_INT32:  c_GIT_CONFIGMAP_INT32
    of GIT_CONFIGMAP_STRING: c_GIT_CONFIGMAP_STRING


converter to_git_configmap_t*(arg: c_git_configmap_t): git_configmap_t =
  case arg:
    of c_GIT_CONFIGMAP_FALSE:  GIT_CONFIGMAP_FALSE
    of c_GIT_CONFIGMAP_TRUE:   GIT_CONFIGMAP_TRUE
    of c_GIT_CONFIGMAP_INT32:  GIT_CONFIGMAP_INT32
    of c_GIT_CONFIGMAP_STRING: GIT_CONFIGMAP_STRING


converter toCint*(arg: c_git_configmap_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_configmap_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_configmap_t(arg)))

func `+`*(arg: c_git_configmap_t, offset: int): c_git_configmap_t =
  cast[c_git_configmap_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_configmap_t): c_git_configmap_t =
  cast[c_git_configmap_t](ord(arg) + offset)

func `-`*(arg: c_git_configmap_t, offset: int): c_git_configmap_t =
  cast[c_git_configmap_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_configmap_t): c_git_configmap_t =
  cast[c_git_configmap_t](ord(arg) - offset)


proc git_config_find_global*(arg_out: ptr git_buf): cint {.git2Proc, importc.}



proc git_config_find_xdg*(arg_out: ptr git_buf): cint {.git2Proc, importc.}



proc git_config_find_system*(arg_out: ptr git_buf): cint {.git2Proc, importc.}



proc git_config_find_programdata*(
    arg_out: ptr git_buf
  ): cint {.git2Proc, importc.}



proc git_config_open_default*(
    arg_out: ptr ptr git_config
  ): cint {.git2Proc, importc.}



proc git_config_new*(arg_out: ptr ptr git_config): cint {.git2Proc, importc.}



proc git_config_add_file_ondisk*(
    cfg:   ptr git_config,
    path:  cstring,
    level: c_git_config_level_t,
    repo:  ptr git_repository,
    force: cint
  ): cint {.git2Proc, importc.}



proc git_config_open_ondisk*(
    arg_out: ptr ptr git_config,
    path:    cstring
  ): cint {.git2Proc, importc.}



proc git_config_open_level*(
    arg_out: ptr ptr git_config,
    parent:  ptr git_config,
    level:   c_git_config_level_t
  ): cint {.git2Proc, importc.}



proc git_config_open_global*(
    arg_out: ptr ptr git_config,
    config:  ptr git_config
  ): cint {.git2Proc, importc.}



proc git_config_snapshot*(
    arg_out: ptr ptr git_config,
    config:  ptr git_config
  ): cint {.git2Proc, importc.}



proc git_config_free*(cfg: ptr git_config): void {.git2Proc, importc.}



proc git_config_get_entry*(
    arg_out: ptr ptr git_config_entry,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_config_get_int32*(
    arg_out: ptr int32,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_config_get_int64*(
    arg_out: ptr int64,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_config_get_bool*(
    arg_out: ptr cint,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_config_get_path*(
    arg_out: ptr git_buf,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_config_get_string*(
    arg_out: ptr cstring,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_config_get_string_buf*(
    arg_out: ptr git_buf,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_config_get_multivar_foreach*(
    cfg:      ptr git_config,
    name:     cstring,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_config_multivar_iterator_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config,
    name:    cstring,
    regexp:  cstring
  ): cint {.git2Proc, importc.}



proc git_config_next*(
    entry: ptr ptr git_config_entry,
    iter:  ptr git_config_iterator
  ): cint {.git2Proc, importc.}



proc git_config_iterator_free*(
    iter: ptr git_config_iterator
  ): void {.git2Proc, importc.}



proc git_config_set_int32*(
    cfg:   ptr git_config,
    name:  cstring,
    value: int32
  ): cint {.git2Proc, importc.}



proc git_config_set_int64*(
    cfg:   ptr git_config,
    name:  cstring,
    value: int64
  ): cint {.git2Proc, importc.}



proc git_config_set_bool*(
    cfg:   ptr git_config,
    name:  cstring,
    value: cint
  ): cint {.git2Proc, importc.}



proc git_config_set_string*(
    cfg:   ptr git_config,
    name:  cstring,
    value: cstring
  ): cint {.git2Proc, importc.}



proc git_config_set_multivar*(
    cfg:    ptr git_config,
    name:   cstring,
    regexp: cstring,
    value:  cstring
  ): cint {.git2Proc, importc.}



proc git_config_delete_entry*(
    cfg:  ptr git_config,
    name: cstring
  ): cint {.git2Proc, importc.}



proc git_config_delete_multivar*(
    cfg:    ptr git_config,
    name:   cstring,
    regexp: cstring
  ): cint {.git2Proc, importc.}



proc git_config_foreach*(
    cfg:      ptr git_config,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_config_iterator_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config
  ): cint {.git2Proc, importc.}



proc git_config_iterator_glob_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config,
    regexp:  cstring
  ): cint {.git2Proc, importc.}



proc git_config_foreach_match*(
    cfg:      ptr git_config,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_config_get_mapped*(
    arg_out: ptr cint,
    cfg:     ptr git_config,
    name:    cstring,
    maps:    ptr git_configmap,
    map_n:   csize_t
  ): cint {.git2Proc, importc.}



proc git_config_lookup_map_value*(
    arg_out: ptr cint,
    maps:    ptr git_configmap,
    map_n:   csize_t,
    value:   cstring
  ): cint {.git2Proc, importc.}



proc git_config_parse_bool*(
    arg_out: ptr cint,
    value:   cstring
  ): cint {.git2Proc, importc.}



proc git_config_parse_int32*(
    arg_out: ptr int32,
    value:   cstring
  ): cint {.git2Proc, importc.}



proc git_config_parse_int64*(
    arg_out: ptr int64,
    value:   cstring
  ): cint {.git2Proc, importc.}



proc git_config_parse_path*(
    arg_out: ptr git_buf,
    value:   cstring
  ): cint {.git2Proc, importc.}



proc git_config_backend_foreach_match*(
    backend:  ptr git_config_backend,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_config_lock*(
    tx:  ptr ptr git_transaction,
    cfg: ptr git_config
  ): cint {.git2Proc, importc.}



