import "./libgit2_config.nim" ## From gen file

type
  git_oid* {.header: "<oid.h>", importc, bycopy.} = object
    id *: array[20, char]

  git_oid_shorten* {.header: "<oid.h>", importc, incompleteStruct.} = object


  c_git_oid_t* {.size: sizeof(cint).} = enum
    c_GIT_OID_SHA1 = 1 shl 0

  git_oid_t* = enum
    GIT_OID_SHA1 = 0



converter to_git_oid_t*(arg: c_git_oid_t): git_oid_t =
  case arg:
    of c_GIT_OID_SHA1: GIT_OID_SHA1

proc to_c_git_oid_t*(arg: git_oid_t): c_git_oid_t =
  case arg:
    of GIT_OID_SHA1: c_GIT_OID_SHA1

converter toCInt*(arg: c_git_oid_t): cint = cint(ord(arg))

converter toCInt*(arg: git_oid_t): cint = cint(ord(to_c_git_oid_t(arg)))

converter toCInt*(args: set[git_oid_t]): cint =
  for value in items(args):
    case value:
      of GIT_OID_SHA1: result = cint(result or 1)

func `-`*(arg: c_git_oid_t, offset: int): cint = cast[c_git_oid_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_oid_t): cint = cast[c_git_oid_t](ord(arg) - offset)

func `+`*(arg: c_git_oid_t, offset: int): cint = cast[c_git_oid_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_oid_t): cint = cast[c_git_oid_t](ord(arg) + offset)

proc git_oid_fromstr*(`out`: ptr git_oid, str: cstring): cint {.importc: "git_oid_fromstr", header: "<oid.h>".}

proc git_oid_fromstrp*(`out`: ptr git_oid, str: cstring): cint {.importc: "git_oid_fromstrp", header: "<oid.h>".}

proc git_oid_fromstrn*(
    `out`: ptr git_oid,
    str: cstring,
    length: csize_t,
): cint {.importc: "git_oid_fromstrn", header: "<oid.h>".}

proc git_oid_fromraw*(`out`: ptr git_oid, raw: cstring): cint {.importc: "git_oid_fromraw", header: "<oid.h>".}

proc git_oid_fmt*(`out`: ptr char, id: ptr git_oid): cint {.importc: "git_oid_fmt", header: "<oid.h>".}

proc git_oid_nfmt*(
    `out`: ptr char,
    n: csize_t,
    id: ptr git_oid,
): cint {.importc: "git_oid_nfmt", header: "<oid.h>".}

proc git_oid_pathfmt*(`out`: ptr char, id: ptr git_oid): cint {.importc: "git_oid_pathfmt", header: "<oid.h>".}

proc git_oid_tostr_s*(oid: ptr git_oid): ptr char {.importc: "git_oid_tostr_s", header: "<oid.h>".}

proc git_oid_tostr*(
    `out`: ptr char,
    n: csize_t,
    id: ptr git_oid,
): ptr char {.importc: "git_oid_tostr", header: "<oid.h>".}

proc git_oid_cpy*(`out`: ptr git_oid, src: ptr git_oid): cint {.importc: "git_oid_cpy", header: "<oid.h>".}

proc git_oid_cmp*(a: ptr git_oid, b: ptr git_oid): cint {.importc: "git_oid_cmp", header: "<oid.h>".}

proc git_oid_equal*(a: ptr git_oid, b: ptr git_oid): cint {.importc: "git_oid_equal", header: "<oid.h>".}

proc git_oid_ncmp*(
    a: ptr git_oid,
    b: ptr git_oid,
    len: csize_t,
): cint {.importc: "git_oid_ncmp", header: "<oid.h>".}

proc git_oid_streq*(id: ptr git_oid, str: cstring): cint {.importc: "git_oid_streq", header: "<oid.h>".}

proc git_oid_strcmp*(id: ptr git_oid, str: cstring): cint {.importc: "git_oid_strcmp", header: "<oid.h>".}

proc git_oid_is_zero*(id: ptr git_oid): cint {.importc: "git_oid_is_zero", header: "<oid.h>".}

proc git_oid_shorten_new*(min_length: csize_t): ptr git_oid_shorten {.importc: "git_oid_shorten_new", header: "<oid.h>".}

proc git_oid_shorten_add*(os: ptr git_oid_shorten, text_id: cstring): cint {.importc: "git_oid_shorten_add", header: "<oid.h>".}

proc git_oid_shorten_free*(os: ptr git_oid_shorten): void {.importc: "git_oid_shorten_free", header: "<oid.h>".}