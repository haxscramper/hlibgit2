{.push warning[UnusedImport]:off.}

import
  ./libgit_config

type
  git_trace_cb* = proc(level: git_trace_level_t, msg: cstring): void{.cdecl.}
   
  git_trace_level_t* = enum
    GIT_TRACE_NONE = 0 ## No tracing will be performed. 
    GIT_TRACE_FATAL = 1 ## Severe errors that may impact the program's execution 
    GIT_TRACE_ERROR = 2 ## Errors that do not impact the program's execution 
    GIT_TRACE_WARN = 3 ## Warnings that suggest abnormal data 
    GIT_TRACE_INFO = 4 ## Informational messages about program execution 
    GIT_TRACE_DEBUG = 5 ## Detailed data that allows for debugging 
    GIT_TRACE_TRACE = 6 ## Exceptionally detailed debugging data 
   

proc git_trace_set*(
    level: git_trace_level_t,
    cb:    git_trace_cb
  ): cint {.dynlib: libgitDl, importc.}


