{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./types

type
  c_git_describe_strategy_t* {.size: sizeof(cint).} = enum
    c_GIT_DESCRIBE_DEFAULT = 0 shl 0
    c_GIT_DESCRIBE_TAGS    = 1 shl 0
    c_GIT_DESCRIBE_ALL     = 1 shl 1

  git_describe_format_options* {.bycopy, header: "<git2/describe.h>", importc.} = object
    version*:                cuint
    abbreviated_size*:       cuint
    always_use_long_format*: cint
    dirty_suffix*:           cstring

  git_describe_options* {.bycopy, header: "<git2/describe.h>", importc.} = object
    version*:                     cuint
    max_candidates_tags*:         cuint
    describe_strategy*:           cuint   ## default: 10
    pattern*:                     cstring ## default: GIT_DESCRIBE_DEFAULT
    only_follow_first_parent*:    cint
    show_commit_oid_as_fallback*: cint

  git_describe_result* {.bycopy, incompleteStruct, header: "<git2/describe.h>", importc.} = object


  git_describe_strategy_t* {.size: sizeof(cint).} = enum
    GIT_DESCRIBE_DEFAULT
    GIT_DESCRIBE_TAGS
    GIT_DESCRIBE_ALL


proc to_c_git_describe_strategy_t*(
    arg: git_describe_strategy_t
  ): c_git_describe_strategy_t =
  case arg:
    of GIT_DESCRIBE_DEFAULT: c_GIT_DESCRIBE_DEFAULT
    of GIT_DESCRIBE_TAGS:    c_GIT_DESCRIBE_TAGS
    of GIT_DESCRIBE_ALL:     c_GIT_DESCRIBE_ALL


converter to_git_describe_strategy_t*(
    arg: c_git_describe_strategy_t
  ): git_describe_strategy_t =
  case arg:
    of c_GIT_DESCRIBE_DEFAULT: GIT_DESCRIBE_DEFAULT
    of c_GIT_DESCRIBE_TAGS:    GIT_DESCRIBE_TAGS
    of c_GIT_DESCRIBE_ALL:     GIT_DESCRIBE_ALL


converter toCint*(arg: c_git_describe_strategy_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_describe_strategy_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_describe_strategy_t(arg)))

func `+`*(
    arg:    c_git_describe_strategy_t,
    offset: int
  ): c_git_describe_strategy_t =
  cast[c_git_describe_strategy_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_describe_strategy_t
  ): c_git_describe_strategy_t =
  cast[c_git_describe_strategy_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_describe_strategy_t,
    offset: int
  ): c_git_describe_strategy_t =
  cast[c_git_describe_strategy_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_describe_strategy_t
  ): c_git_describe_strategy_t =
  cast[c_git_describe_strategy_t](ord(arg) - offset)


converter toCint*(args: set[git_describe_strategy_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_DESCRIBE_DEFAULT: result = cint(result or (0 shl 0))
      of GIT_DESCRIBE_TAGS:    result = cint(result or (1 shl 0))
      of GIT_DESCRIBE_ALL:     result = cint(result or (1 shl 1))


proc git_describe_options_init*(
    opts:    ptr git_describe_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_describe_format_options_init*(
    opts:    ptr git_describe_format_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_describe_commit*(
    result:     ptr ptr git_describe_result,
    committish: ptr git_object,
    opts:       ptr git_describe_options
  ): cint {.git2Proc, importc.}



proc git_describe_workdir*(
    arg_out: ptr ptr git_describe_result,
    repo:    ptr git_repository,
    opts:    ptr git_describe_options
  ): cint {.git2Proc, importc.}



proc git_describe_format*(
    arg_out: ptr git_buf,
    result:  ptr git_describe_result,
    opts:    ptr git_describe_format_options
  ): cint {.git2Proc, importc.}



proc git_describe_result_free*(
    result: ptr git_describe_result
  ): void {.git2Proc, importc.}



