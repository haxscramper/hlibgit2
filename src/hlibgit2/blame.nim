{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_blame_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_BLAME_NORMAL                          = 0 shl 0 ## Normal blame, the default
    c_GIT_BLAME_TRACK_COPIES_SAME_FILE          = 1 shl 0
    c_GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES  = 1 shl 1
    c_GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = 1 shl 2
    c_GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES  = 1 shl 3
    c_GIT_BLAME_FIRST_PARENT                    = 1 shl 4
    c_GIT_BLAME_USE_MAILMAP                     = 1 shl 5
    c_GIT_BLAME_IGNORE_WHITESPACE               = 1 shl 6 ## Ignore whitespace differences

  git_blame* {.bycopy, incompleteStruct, header: "<git2/blame.h>", importc.} = object


  git_blame_flag_t* {.size: sizeof(cint).} = enum
    GIT_BLAME_NORMAL                          ## Normal blame, the default
    GIT_BLAME_TRACK_COPIES_SAME_FILE
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES
    GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES
    GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES
    GIT_BLAME_FIRST_PARENT
    GIT_BLAME_USE_MAILMAP
    GIT_BLAME_IGNORE_WHITESPACE               ## Ignore whitespace differences

  git_blame_hunk* {.bycopy, header: "<git2/blame.h>", importc.} = object
    lines_in_hunk*:           csize_t
    final_commit_id*:         git_oid
    final_start_line_number*: csize_t
    final_signature*:         ptr git_signature
    orig_commit_id*:          git_oid
    orig_path*:               cstring
    orig_start_line_number*:  csize_t
    orig_signature*:          ptr git_signature
    boundary*:                char

  git_blame_options* {.bycopy, header: "<git2/blame.h>", importc.} = object
    version*:              cuint
    flags*:                uint32  ## A combination of `git_blame_flag_t`
    min_match_characters*: uint16
    newest_commit*:        git_oid ## The id of the newest commit to consider. The default is HEAD.
    oldest_commit*:        git_oid
    min_line*:             csize_t
    max_line*:             csize_t


proc to_c_git_blame_flag_t*(arg: git_blame_flag_t): c_git_blame_flag_t =
  case arg:
    of GIT_BLAME_NORMAL:                          c_GIT_BLAME_NORMAL
    of GIT_BLAME_TRACK_COPIES_SAME_FILE:          c_GIT_BLAME_TRACK_COPIES_SAME_FILE
    of GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES:  c_GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES
    of GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES: c_GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES
    of GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES:  c_GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES
    of GIT_BLAME_FIRST_PARENT:                    c_GIT_BLAME_FIRST_PARENT
    of GIT_BLAME_USE_MAILMAP:                     c_GIT_BLAME_USE_MAILMAP
    of GIT_BLAME_IGNORE_WHITESPACE:               c_GIT_BLAME_IGNORE_WHITESPACE


converter to_git_blame_flag_t*(arg: c_git_blame_flag_t): git_blame_flag_t =
  case arg:
    of c_GIT_BLAME_NORMAL:                          GIT_BLAME_NORMAL
    of c_GIT_BLAME_TRACK_COPIES_SAME_FILE:          GIT_BLAME_TRACK_COPIES_SAME_FILE
    of c_GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES:  GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES
    of c_GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES: GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES
    of c_GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES:  GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES
    of c_GIT_BLAME_FIRST_PARENT:                    GIT_BLAME_FIRST_PARENT
    of c_GIT_BLAME_USE_MAILMAP:                     GIT_BLAME_USE_MAILMAP
    of c_GIT_BLAME_IGNORE_WHITESPACE:               GIT_BLAME_IGNORE_WHITESPACE


converter toCint*(arg: c_git_blame_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_blame_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_blame_flag_t(arg)))

func `+`*(arg: c_git_blame_flag_t, offset: int): c_git_blame_flag_t =
  cast[c_git_blame_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_blame_flag_t): c_git_blame_flag_t =
  cast[c_git_blame_flag_t](ord(arg) + offset)

func `-`*(arg: c_git_blame_flag_t, offset: int): c_git_blame_flag_t =
  cast[c_git_blame_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_blame_flag_t): c_git_blame_flag_t =
  cast[c_git_blame_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_blame_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_BLAME_NORMAL:                          result = cint(result or (0 shl 0))
      of GIT_BLAME_TRACK_COPIES_SAME_FILE:          result = cint(result or (1 shl 0))
      of GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES:  result = cint(result or (1 shl 1))
      of GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES: result = cint(result or (1 shl 2))
      of GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES:  result = cint(result or (1 shl 3))
      of GIT_BLAME_FIRST_PARENT:                    result = cint(result or (1 shl 4))
      of GIT_BLAME_USE_MAILMAP:                     result = cint(result or (1 shl 5))
      of GIT_BLAME_IGNORE_WHITESPACE:               result = cint(result or (1 shl 6))


proc git_blame_options_init*(
    opts:    ptr git_blame_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_blame_get_hunk_count*(
    blame: ptr git_blame
  ): uint32 {.git2Proc, importc.}



proc git_blame_get_hunk_byindex*(
    blame: ptr git_blame,
    index: uint32
  ): ptr git_blame_hunk {.git2Proc, importc.}



proc git_blame_get_hunk_byline*(
    blame:  ptr git_blame,
    lineno: csize_t
  ): ptr git_blame_hunk {.git2Proc, importc.}



proc git_blame_file*(
    arg_out: ptr ptr git_blame,
    repo:    ptr git_repository,
    path:    cstring,
    options: ptr git_blame_options
  ): cint {.git2Proc, importc.}



proc git_blame_buffer*(
    arg_out:    ptr ptr git_blame,
    reference:  ptr git_blame,
    buffer:     cstring,
    buffer_len: csize_t
  ): cint {.git2Proc, importc.}



proc git_blame_free*(blame: ptr git_blame): void {.git2Proc, importc.}



