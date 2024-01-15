type
  git_hashsig* {.incompleteStruct.} = object


  c_git_hashsig_option_t* {.size: sizeof(cint).} = enum
    c_GIT_HASHSIG_NORMAL            = 0
    c_GIT_HASHSIG_IGNORE_WHITESPACE = 1
    c_GIT_HASHSIG_SMART_WHITESPACE  = 2
    c_GIT_HASHSIG_ALLOW_SMALL_FILES = 1 shl 2

  git_hashsig_option_t* = enum
    GIT_HASHSIG_NORMAL            = 0
    GIT_HASHSIG_IGNORE_WHITESPACE = 1
    GIT_HASHSIG_SMART_WHITESPACE  = 2
    GIT_HASHSIG_ALLOW_SMALL_FILES = 3



converter to_git_hashsig_option_t*(arg: c_git_hashsig_option_t): git_hashsig_option_t =
  case arg:
    of c_GIT_HASHSIG_NORMAL           : GIT_HASHSIG_NORMAL
    of c_GIT_HASHSIG_IGNORE_WHITESPACE: GIT_HASHSIG_IGNORE_WHITESPACE
    of c_GIT_HASHSIG_SMART_WHITESPACE : GIT_HASHSIG_SMART_WHITESPACE
    of c_GIT_HASHSIG_ALLOW_SMALL_FILES: GIT_HASHSIG_ALLOW_SMALL_FILES

proc to_c_git_hashsig_option_t*(arg: git_hashsig_option_t): c_git_hashsig_option_t =
  case arg:
    of GIT_HASHSIG_NORMAL           : c_GIT_HASHSIG_NORMAL
    of GIT_HASHSIG_IGNORE_WHITESPACE: c_GIT_HASHSIG_IGNORE_WHITESPACE
    of GIT_HASHSIG_SMART_WHITESPACE : c_GIT_HASHSIG_SMART_WHITESPACE
    of GIT_HASHSIG_ALLOW_SMALL_FILES: c_GIT_HASHSIG_ALLOW_SMALL_FILES

converter toCInt*(arg: c_git_hashsig_option_t): cint = cint(ord(arg))

converter toCInt*(arg: git_hashsig_option_t): cint = cint(ord(to_c_git_hashsig_option_t(arg)))

converter toCInt*(args: set[git_hashsig_option_t]): cint =
  for value in items(args):
    case value:
      of GIT_HASHSIG_NORMAL           : result = cint(result or 0)
      of GIT_HASHSIG_IGNORE_WHITESPACE: result = cint(result or 1)
      of GIT_HASHSIG_SMART_WHITESPACE : result = cint(result or 2)
      of GIT_HASHSIG_ALLOW_SMALL_FILES: result = cint(result or 4)

func `-`*(arg: c_git_hashsig_option_t, offset: int): cint = cast[c_git_hashsig_option_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_hashsig_option_t): cint = cast[c_git_hashsig_option_t](ord(arg) - offset)

func `+`*(arg: c_git_hashsig_option_t, offset: int): cint = cast[c_git_hashsig_option_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_hashsig_option_t): cint = cast[c_git_hashsig_option_t](ord(arg) + offset)

proc git_hashsig_create*(
    `out`: ptr ptr git_hashsig,
    buf: cstring,
    buflen: csize_t,
    opts: git_hashsig_option_t,
): cint {.importc: "git_hashsig_create".}

proc git_hashsig_create_fromfile*(
    `out`: ptr ptr git_hashsig,
    path: cstring,
    opts: git_hashsig_option_t,
): cint {.importc: "git_hashsig_create_fromfile".}

proc git_hashsig_free*(sig: ptr git_hashsig): void {.importc: "git_hashsig_free".}

proc git_hashsig_compare*(a: ptr git_hashsig, b: ptr git_hashsig): cint {.importc: "git_hashsig_compare".}