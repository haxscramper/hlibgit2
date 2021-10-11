{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./types

type
  git_describe_format_options* {.bycopy, header: "<git2/describe.h>", importc.} = object
    version*: cuint
    abbreviated_size*: cuint
    always_use_long_format*: cint
    dirty_suffix*: cstring
   
  git_describe_options* {.bycopy, header: "<git2/describe.h>", importc.} = object
    version*: cuint
    max_candidates_tags*: cuint
    describe_strategy*: cuint ## default: 10 
    pattern*: cstring ## default: GIT_DESCRIBE_DEFAULT 
    only_follow_first_parent*: cint
    show_commit_oid_as_fallback*: cint
   
  git_describe_result* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_describe_strategy_t* = enum
    GIT_DESCRIBE_DEFAULT = 0
    GIT_DESCRIBE_TAGS = 1
    GIT_DESCRIBE_ALL = 2
   

proc git_describe_options_init*(
    opts:    ptr git_describe_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_describe_format_options_init*(
    opts:    ptr git_describe_format_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_describe_commit*(
    result:     ptr ptr git_describe_result,
    committish: ptr git_object,
    opts:       ptr git_describe_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_describe_workdir*(
    arg_out: ptr ptr git_describe_result,
    repo:    ptr git_repository,
    opts:    ptr git_describe_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_describe_format*(
    arg_out: ptr git_buf,
    result:  ptr git_describe_result,
    opts:    ptr git_describe_format_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_describe_result_free*(
    result: ptr git_describe_result
  ): void {.dynlib: libgit2Dl, importc.}


