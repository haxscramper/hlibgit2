
type
  git_hashsig* {.importc, bycopy.} = object


  c_git_hashsig_option_t {.size: sizeof(cint).} = enum
    c_GIT_HASHSIG_NORMAL            = 0 shl 0
    c_GIT_HASHSIG_IGNORE_WHITESPACE = 1 shl 0
    c_GIT_HASHSIG_SMART_WHITESPACE  = 1 shl 1
    c_GIT_HASHSIG_ALLOW_SMALL_FILES = 1 shl 2

  git_hashsig_option_t = enum
    GIT_HASHSIG_NORMAL
    GIT_HASHSIG_IGNORE_WHITESPACE
    GIT_HASHSIG_SMART_WHITESPACE
    GIT_HASHSIG_ALLOW_SMALL_FILES



converter toCInt*(arg: c_git_hashsig_option_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_hashsig_option_t)): cint =
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

proc git_hashsig_create*(out: ptr git_hashsig, buf: cstring, buflen: csize_t, opts: git_hashsig_option_t): cint {.git2Proc, importc.}

proc git_hashsig_create_fromfile*(out: ptr git_hashsig, path: cstring, opts: git_hashsig_option_t): cint {.git2Proc, importc.}

proc git_hashsig_free*(sig: ptr git_hashsig): void {.git2Proc, importc.}

proc git_hashsig_compare*(a: ptr git_hashsig, b: ptr git_hashsig): cint {.git2Proc, importc.}