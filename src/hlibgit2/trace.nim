{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  c_git_trace_level_t* {.size: sizeof(cint).} = enum
    c_GIT_TRACE_NONE  = 0 ## No tracing will be performed.
    c_GIT_TRACE_FATAL = 1 ## Severe errors that may impact the program's execution
    c_GIT_TRACE_ERROR = 2 ## Errors that do not impact the program's execution
    c_GIT_TRACE_WARN  = 3 ## Warnings that suggest abnormal data
    c_GIT_TRACE_INFO  = 4 ## Informational messages about program execution
    c_GIT_TRACE_DEBUG = 5 ## Detailed data that allows for debugging
    c_GIT_TRACE_TRACE = 6 ## Exceptionally detailed debugging data

  git_trace_cb* = proc(level: c_git_trace_level_t,
                       msg:   cstring): void{.cdecl.}

  git_trace_level_t* = enum
    GIT_TRACE_NONE  ## No tracing will be performed.
    GIT_TRACE_FATAL ## Severe errors that may impact the program's execution
    GIT_TRACE_ERROR ## Errors that do not impact the program's execution
    GIT_TRACE_WARN  ## Warnings that suggest abnormal data
    GIT_TRACE_INFO  ## Informational messages about program execution
    GIT_TRACE_DEBUG ## Detailed data that allows for debugging
    GIT_TRACE_TRACE ## Exceptionally detailed debugging data


proc to_c_git_trace_level_t*(arg: git_trace_level_t): c_git_trace_level_t =
  case arg:
    of GIT_TRACE_NONE:  c_GIT_TRACE_NONE
    of GIT_TRACE_FATAL: c_GIT_TRACE_FATAL
    of GIT_TRACE_ERROR: c_GIT_TRACE_ERROR
    of GIT_TRACE_WARN:  c_GIT_TRACE_WARN
    of GIT_TRACE_INFO:  c_GIT_TRACE_INFO
    of GIT_TRACE_DEBUG: c_GIT_TRACE_DEBUG
    of GIT_TRACE_TRACE: c_GIT_TRACE_TRACE


converter to_git_trace_level_t*(arg: c_git_trace_level_t): git_trace_level_t =
  case arg:
    of c_GIT_TRACE_NONE:  GIT_TRACE_NONE
    of c_GIT_TRACE_FATAL: GIT_TRACE_FATAL
    of c_GIT_TRACE_ERROR: GIT_TRACE_ERROR
    of c_GIT_TRACE_WARN:  GIT_TRACE_WARN
    of c_GIT_TRACE_INFO:  GIT_TRACE_INFO
    of c_GIT_TRACE_DEBUG: GIT_TRACE_DEBUG
    of c_GIT_TRACE_TRACE: GIT_TRACE_TRACE


converter toCint*(arg: c_git_trace_level_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_trace_level_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_trace_level_t(arg)))

func `+`*(arg: c_git_trace_level_t, offset: int): c_git_trace_level_t =
  cast[c_git_trace_level_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_trace_level_t): c_git_trace_level_t =
  cast[c_git_trace_level_t](ord(arg) + offset)

func `-`*(arg: c_git_trace_level_t, offset: int): c_git_trace_level_t =
  cast[c_git_trace_level_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_trace_level_t): c_git_trace_level_t =
  cast[c_git_trace_level_t](ord(arg) - offset)


proc git_trace_set*(
    level: c_git_trace_level_t,
    cb:    git_trace_cb
  ): cint {.git2Proc, importc.}



