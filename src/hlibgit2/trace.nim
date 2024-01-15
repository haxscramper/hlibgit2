type
  c_git_trace_level_t* {.size: sizeof(cint).} = enum
    c_GIT_TRACE_NONE  = 0
    c_GIT_TRACE_FATAL = 1
    c_GIT_TRACE_ERROR = 2
    c_GIT_TRACE_WARN  = 3
    c_GIT_TRACE_INFO  = 4
    c_GIT_TRACE_DEBUG = 5
    c_GIT_TRACE_TRACE = 6

  git_trace_level_t* = enum
    GIT_TRACE_NONE  = 0
    GIT_TRACE_FATAL = 1
    GIT_TRACE_ERROR = 2
    GIT_TRACE_WARN  = 3
    GIT_TRACE_INFO  = 4
    GIT_TRACE_DEBUG = 5
    GIT_TRACE_TRACE = 6

  git_trace_cb* = proc (a0: git_trace_level_t, a1: cstring): void



proc git_trace_set*(level: git_trace_level_t, cb: git_trace_cb): cint {.importc: "git_trace_set".}

converter to_git_trace_level_t*(arg: c_git_trace_level_t): git_trace_level_t =
  case arg:
    of c_GIT_TRACE_NONE : GIT_TRACE_NONE
    of c_GIT_TRACE_FATAL: GIT_TRACE_FATAL
    of c_GIT_TRACE_ERROR: GIT_TRACE_ERROR
    of c_GIT_TRACE_WARN : GIT_TRACE_WARN
    of c_GIT_TRACE_INFO : GIT_TRACE_INFO
    of c_GIT_TRACE_DEBUG: GIT_TRACE_DEBUG
    of c_GIT_TRACE_TRACE: GIT_TRACE_TRACE

proc to_c_git_trace_level_t*(arg: git_trace_level_t): c_git_trace_level_t =
  case arg:
    of GIT_TRACE_NONE : c_GIT_TRACE_NONE
    of GIT_TRACE_FATAL: c_GIT_TRACE_FATAL
    of GIT_TRACE_ERROR: c_GIT_TRACE_ERROR
    of GIT_TRACE_WARN : c_GIT_TRACE_WARN
    of GIT_TRACE_INFO : c_GIT_TRACE_INFO
    of GIT_TRACE_DEBUG: c_GIT_TRACE_DEBUG
    of GIT_TRACE_TRACE: c_GIT_TRACE_TRACE

converter toCInt*(arg: c_git_trace_level_t): cint = cint(ord(arg))

converter toCInt*(arg: git_trace_level_t): cint = cint(ord(to_c_git_trace_level_t(arg)))

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