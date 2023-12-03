import "./libgit2_config.nim" ## From gen file
import "./buffer.nim"
import "./types.nim"

type
  git_describe_options* {.importc, bycopy.} = object
    version                     *: cuint
    max_candidates_tags         *: cuint
    describe_strategy           *: cuint
    pattern                     *: cstring
    only_follow_first_parent    *: cint
    show_commit_oid_as_fallback *: cint

  git_describe_format_options* {.importc, bycopy.} = object
    version                *: cuint
    abbreviated_size       *: cuint
    always_use_long_format *: cint
    dirty_suffix           *: cstring

  git_describe_result* {.importc, bycopy, incompleteStruct.} = object


  c_git_describe_strategy_t* {.size: sizeof(cint).} = enum
    c_GIT_DESCRIBE_DEFAULT = 0
    c_GIT_DESCRIBE_TAGS    = 1
    c_GIT_DESCRIBE_ALL     = 2

  git_describe_strategy_t* = enum
    GIT_DESCRIBE_DEFAULT
    GIT_DESCRIBE_TAGS
    GIT_DESCRIBE_ALL



converter toCInt*(arg: c_git_describe_strategy_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_describe_strategy_t]): cint =
  for value in items(args):
    case value:
      of GIT_DESCRIBE_DEFAULT: result = cint(result or 0)
      of GIT_DESCRIBE_TAGS   : result = cint(result or 1)
      of GIT_DESCRIBE_ALL    : result = cint(result or 2)

func `-`*(arg: c_git_describe_strategy_t, offset: int): cint = cast[c_git_describe_strategy_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_describe_strategy_t): cint = cast[c_git_describe_strategy_t](ord(arg) - offset)

func `+`*(arg: c_git_describe_strategy_t, offset: int): cint = cast[c_git_describe_strategy_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_describe_strategy_t): cint = cast[c_git_describe_strategy_t](ord(arg) + offset)

proc git_describe_options_init*(opts: ptr git_describe_options, version: cuint): cint {.git2Proc, importc: "git_describe_options_init".}

proc git_describe_format_options_init*(opts: ptr git_describe_format_options, version: cuint): cint {.git2Proc, importc: "git_describe_format_options_init".}

proc git_describe_commit*(
    result: ptr ptr git_describe_result,
    committish: ptr git_object,
    opts: ptr git_describe_options,
): cint {.git2Proc, importc: "git_describe_commit".}

proc git_describe_workdir*(
    `out`: ptr ptr git_describe_result,
    repo: ptr git_repository,
    opts: ptr git_describe_options,
): cint {.git2Proc, importc: "git_describe_workdir".}

proc git_describe_format*(
    `out`: ptr git_buf,
    result: ptr git_describe_result,
    opts: ptr git_describe_format_options,
): cint {.git2Proc, importc: "git_describe_format".}

proc git_describe_result_free*(result: ptr git_describe_result): void {.git2Proc, importc: "git_describe_result_free".}