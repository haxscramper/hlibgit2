
type
  git_oid* {.importc, bycopy.} = object
    id *:

  git_oid_shorten* {.importc, bycopy.} = object


  c_git_oid_t {.size: sizeof(cint).} = enum
    c_GIT_OID_SHA1 = 1 shl 0

  git_oid_t = enum
    GIT_OID_SHA1



proc git_oid_fromstr*(out: ptr git_oid, str: cstring): cint {.git2Proc, importc.}

proc git_oid_fromstrp*(out: ptr git_oid, str: cstring): cint {.git2Proc, importc.}

proc git_oid_fromstrn*(out: ptr git_oid, str: cstring, length: csize_t): cint {.git2Proc, importc.}

proc git_oid_fromraw*(out: ptr git_oid, raw: cstring): cint {.git2Proc, importc.}

proc git_oid_fmt*(out: ptr char, id: ptr git_oid): cint {.git2Proc, importc.}

proc git_oid_nfmt*(out: ptr char, n: csize_t, id: ptr git_oid): cint {.git2Proc, importc.}

proc git_oid_pathfmt*(out: ptr char, id: ptr git_oid): cint {.git2Proc, importc.}

proc git_oid_tostr_s*(oid: ptr git_oid): ptr char {.git2Proc, importc.}

proc git_oid_tostr*(out: ptr char, n: csize_t, id: ptr git_oid): ptr char {.git2Proc, importc.}

proc git_oid_cpy*(out: ptr git_oid, src: ptr git_oid): cint {.git2Proc, importc.}

proc git_oid_cmp*(a: ptr git_oid, b: ptr git_oid): cint {.git2Proc, importc.}

proc git_oid_equal*(a: ptr git_oid, b: ptr git_oid): cint {.git2Proc, importc.}

proc git_oid_ncmp*(a: ptr git_oid, b: ptr git_oid, len: csize_t): cint {.git2Proc, importc.}

proc git_oid_streq*(id: ptr git_oid, str: cstring): cint {.git2Proc, importc.}

proc git_oid_strcmp*(id: ptr git_oid, str: cstring): cint {.git2Proc, importc.}

proc git_oid_is_zero*(id: ptr git_oid): cint {.git2Proc, importc.}

converter toCInt*(arg: c_git_oid_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_oid_t)): cint =
  for value in items(args):
    case value:
      of GIT_OID_SHA1: result = cint(result or 1)

func `-`*(arg: c_git_oid_t, offset: int): cint = cast[c_git_oid_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_oid_t): cint = cast[c_git_oid_t](ord(arg) - offset)

func `+`*(arg: c_git_oid_t, offset: int): cint = cast[c_git_oid_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_oid_t): cint = cast[c_git_oid_t](ord(arg) + offset)

proc git_oid_shorten_new*(min_length: csize_t): ptr git_oid_shorten {.git2Proc, importc.}

proc git_oid_shorten_add*(os: ptr git_oid_shorten, text_id: cstring): cint {.git2Proc, importc.}

proc git_oid_shorten_free*(os: ptr git_oid_shorten): void {.git2Proc, importc.}