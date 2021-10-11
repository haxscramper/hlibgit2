{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./types

type
  git_blame* {.bycopy, incompleteStruct, importc.} = object
    
   
  git_blame_flag_t* = enum
    GIT_BLAME_NORMAL = 0 ## Normal blame, the default 
    GIT_BLAME_TRACK_COPIES_SAME_FILE = 1
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = 2
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = 4
    GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = 8
    GIT_BLAME_FIRST_PARENT = 16
    GIT_BLAME_USE_MAILMAP = 32
    GIT_BLAME_IGNORE_WHITESPACE = 64 ## Ignore whitespace differences 
   
  git_blame_hunk* {.bycopy, header: "<git2/blame.h>", importc.} = object
    lines_in_hunk*: csize_t
    final_commit_id*: git_oid
    final_start_line_number*: csize_t
    final_signature*: ptr git_signature
    orig_commit_id*: git_oid
    orig_path*: cstring
    orig_start_line_number*: csize_t
    orig_signature*: ptr git_signature
    boundary*: char
   
  git_blame_options* {.bycopy, header: "<git2/blame.h>", importc.} = object
    version*: cuint
    flags*: uint32 ## A combination of `git_blame_flag_t` 
    min_match_characters*: uint16
    newest_commit*: git_oid ## The id of the newest commit to consider. The default is HEAD. 
    oldest_commit*: git_oid
    min_line*: csize_t
    max_line*: csize_t
   

proc git_blame_options_init*(
    opts:    ptr git_blame_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blame_get_hunk_count*(
    blame: ptr git_blame
  ): uint32 {.dynlib: libgit2Dl, importc.}


proc git_blame_get_hunk_byindex*(
    blame: ptr git_blame,
    index: uint32
  ): ptr git_blame_hunk {.dynlib: libgit2Dl, importc.}


proc git_blame_get_hunk_byline*(
    blame:  ptr git_blame,
    lineno: csize_t
  ): ptr git_blame_hunk {.dynlib: libgit2Dl, importc.}


proc git_blame_file*(
    arg_out: ptr ptr git_blame,
    repo:    ptr git_repository,
    path:    cstring,
    options: ptr git_blame_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blame_buffer*(
    arg_out:    ptr ptr git_blame,
    reference:  ptr git_blame,
    buffer:     cstring,
    buffer_len: csize_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_blame_free*(blame: ptr git_blame): void {.dynlib: libgit2Dl, importc.}


