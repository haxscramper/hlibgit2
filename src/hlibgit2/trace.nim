import "./libgit2_config.nim"

type
  git_trace_cb* = proc (a0: git_trace_level_t, a1: cstring): void

  c_git_trace_level_t* {.size: sizeof(cint).} = enum
    c_GIT_TRACE_NONE  = 0
    c_GIT_TRACE_FATAL = 1
    c_GIT_TRACE_ERROR = 2
    c_GIT_TRACE_WARN  = 3
    c_GIT_TRACE_INFO  = 4
    c_GIT_TRACE_DEBUG = 5
    c_GIT_TRACE_TRACE = 6

  git_trace_level_t* = enum
    GIT_TRACE_NONE
    GIT_TRACE_FATAL
    GIT_TRACE_ERROR
    GIT_TRACE_WARN
    GIT_TRACE_INFO
    GIT_TRACE_DEBUG
    GIT_TRACE_TRACE



proc git_trace_set*(level: git_trace_level_t, cb: git_trace_cb): cint {.git2Proc, importc.}

converter toCInt*(arg: c_git_trace_level_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_trace_level_t]): cint =
  for value in items(args):
    case value:
      of GIT_TRACE_NONE : result = cint(result or 0)
      of GIT_TRACE_FATAL: result = cint(result or 1)
      of GIT_TRACE_ERROR: result = cint(result or 2)
      of GIT_TRACE_WARN : result = cint(result or 3)
      of GIT_TRACE_INFO : result = cint(result or 4)
      of GIT_TRACE_DEBUG: result = cint(result or 5)
      of GIT_TRACE_TRACE: result = cint(result or 6)

func `-`*(arg: c_git_trace_level_t, offset: int): cint = cast[c_git_trace_level_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_trace_level_t): cint = cast[c_git_trace_level_t](ord(arg) - offset)

func `+`*(arg: c_git_trace_level_t, offset: int): cint = cast[c_git_trace_level_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_trace_level_t): cint = cast[c_git_trace_level_t](ord(arg) + offset)