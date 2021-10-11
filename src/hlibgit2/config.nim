{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./types

type
  git_config_entry* {.bycopy, header: "<git2/config.h>", importc.} = object
    name*: cstring
    value*: cstring ## Name of the entry (normalised) 
    include_depth*: cuint ## String value of the entry 
    level*: git_config_level_t ## Depth of includes where this variable was found 
    free*: proc(entry: ptr git_config_entry): void{.cdecl.} ## Which config file this was found in 
    payload*: pointer ## Free function for this entry 
   
  git_config_foreach_cb* = proc(entry: ptr git_config_entry, payload: pointer): cint{.cdecl.}
   
  git_config_foreach_cbNim* = proc(entry: ptr git_config_entry): cint
   
  git_config_iterator* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_config_level_t* = enum
    GIT_CONFIG_HIGHEST_LEVEL = -1
    GIT_CONFIG_LEVEL_PROGRAMDATA = 1 ## System-wide on Windows, for compatibility with portable git 
    GIT_CONFIG_LEVEL_SYSTEM = 2 ## System-wide configuration file; /etc/gitconfig on Linux systems 
    GIT_CONFIG_LEVEL_XDG = 3 ## XDG compatible configuration file; typically ~/.config/git/config 
    GIT_CONFIG_LEVEL_GLOBAL = 4
    GIT_CONFIG_LEVEL_LOCAL = 5
    GIT_CONFIG_LEVEL_APP = 6
   
  git_configmap* {.bycopy, header: "<git2/config.h>", importc.} = object
    type_f* {.importc: "type".}: git_configmap_t
    str_match*: cstring
    map_value*: cint
   
  git_configmap_t* = enum
    GIT_CONFIGMAP_FALSE = 0
    GIT_CONFIGMAP_TRUE = 1
    GIT_CONFIGMAP_INT32 = 2
    GIT_CONFIGMAP_STRING = 3
   

proc git_config_entry_free*(
    a0: ptr git_config_entry
  ): void {.dynlib: libgit2Dl, importc.}


proc git_config_find_global*(
    arg_out: ptr git_buf
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_find_xdg*(
    arg_out: ptr git_buf
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_find_system*(
    arg_out: ptr git_buf
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_find_programdata*(
    arg_out: ptr git_buf
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_open_default*(
    arg_out: ptr ptr git_config
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_new*(
    arg_out: ptr ptr git_config
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_add_file_ondisk*(
    cfg:   ptr git_config,
    path:  cstring,
    level: git_config_level_t,
    repo:  ptr git_repository,
    force: cint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_open_ondisk*(
    arg_out: ptr ptr git_config,
    path:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_open_level*(
    arg_out: ptr ptr git_config,
    parent:  ptr git_config,
    level:   git_config_level_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_open_global*(
    arg_out: ptr ptr git_config,
    config:  ptr git_config
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_snapshot*(
    arg_out: ptr ptr git_config,
    config:  ptr git_config
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_free*(cfg: ptr git_config): void {.dynlib: libgit2Dl, importc.}


proc git_config_get_entry*(
    arg_out: ptr ptr git_config_entry,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_get_int32*(
    arg_out: ptr int32,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_get_int64*(
    arg_out: ptr int64,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_get_bool*(
    arg_out: ptr cint,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_get_path*(
    arg_out: ptr git_buf,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_get_string*(
    arg_out: ptr cstring,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_get_string_buf*(
    arg_out: ptr git_buf,
    cfg:     ptr git_config,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_get_multivar_foreach*(
    cfg:      ptr git_config,
    name:     cstring,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_multivar_iterator_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config,
    name:    cstring,
    regexp:  cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_next*(
    entry: ptr ptr git_config_entry,
    iter:  ptr git_config_iterator
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_iterator_free*(
    iter: ptr git_config_iterator
  ): void {.dynlib: libgit2Dl, importc.}


proc git_config_set_int32*(
    cfg:   ptr git_config,
    name:  cstring,
    value: int32
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_set_int64*(
    cfg:   ptr git_config,
    name:  cstring,
    value: int64
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_set_bool*(
    cfg:   ptr git_config,
    name:  cstring,
    value: cint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_set_string*(
    cfg:   ptr git_config,
    name:  cstring,
    value: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_set_multivar*(
    cfg:    ptr git_config,
    name:   cstring,
    regexp: cstring,
    value:  cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_delete_entry*(
    cfg:  ptr git_config,
    name: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_delete_multivar*(
    cfg:    ptr git_config,
    name:   cstring,
    regexp: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_foreach*(
    cfg:      ptr git_config,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_iterator_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_iterator_glob_new*(
    arg_out: ptr ptr git_config_iterator,
    cfg:     ptr git_config,
    regexp:  cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_foreach_match*(
    cfg:      ptr git_config,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_get_mapped*(
    arg_out: ptr cint,
    cfg:     ptr git_config,
    name:    cstring,
    maps:    ptr git_configmap,
    map_n:   csize_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_lookup_map_value*(
    arg_out: ptr cint,
    maps:    ptr git_configmap,
    map_n:   csize_t,
    value:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_parse_bool*(
    arg_out: ptr cint,
    value:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_parse_int32*(
    arg_out: ptr int32,
    value:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_parse_int64*(
    arg_out: ptr int64,
    value:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_parse_path*(
    arg_out: ptr git_buf,
    value:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_backend_foreach_match*(
    backend:  ptr git_config_backend,
    regexp:   cstring,
    callback: git_config_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_config_lock*(
    tx:  ptr ptr git_transaction,
    cfg: ptr git_config
  ): cint {.dynlib: libgit2Dl, importc.}


