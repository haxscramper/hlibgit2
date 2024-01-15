type
  git_email_create_options* {.bycopy.} = object
    version        *: cuint
    flags          *: uint32
    diff_opts      *: cint
    diff_find_opts *: cint
    subject_prefix *: cstring
    start_number   *: csize_t
    reroll_number  *: csize_t

  c_git_email_create_flags_t* {.size: sizeof(cint).} = enum
    c_GIT_EMAIL_CREATE_DEFAULT       = 0
    c_GIT_EMAIL_CREATE_OMIT_NUMBERS  = 1
    c_GIT_EMAIL_CREATE_ALWAYS_NUMBER = 2
    c_GIT_EMAIL_CREATE_NO_RENAMES    = 1 shl 2

  git_email_create_flags_t* = enum
    GIT_EMAIL_CREATE_DEFAULT       = 0
    GIT_EMAIL_CREATE_OMIT_NUMBERS  = 1
    GIT_EMAIL_CREATE_ALWAYS_NUMBER = 2
    GIT_EMAIL_CREATE_NO_RENAMES    = 3



converter to_git_email_create_flags_t*(arg: c_git_email_create_flags_t): git_email_create_flags_t =
  case arg:
    of c_GIT_EMAIL_CREATE_DEFAULT      : GIT_EMAIL_CREATE_DEFAULT
    of c_GIT_EMAIL_CREATE_OMIT_NUMBERS : GIT_EMAIL_CREATE_OMIT_NUMBERS
    of c_GIT_EMAIL_CREATE_ALWAYS_NUMBER: GIT_EMAIL_CREATE_ALWAYS_NUMBER
    of c_GIT_EMAIL_CREATE_NO_RENAMES   : GIT_EMAIL_CREATE_NO_RENAMES

proc to_c_git_email_create_flags_t*(arg: git_email_create_flags_t): c_git_email_create_flags_t =
  case arg:
    of GIT_EMAIL_CREATE_DEFAULT      : c_GIT_EMAIL_CREATE_DEFAULT
    of GIT_EMAIL_CREATE_OMIT_NUMBERS : c_GIT_EMAIL_CREATE_OMIT_NUMBERS
    of GIT_EMAIL_CREATE_ALWAYS_NUMBER: c_GIT_EMAIL_CREATE_ALWAYS_NUMBER
    of GIT_EMAIL_CREATE_NO_RENAMES   : c_GIT_EMAIL_CREATE_NO_RENAMES

converter toCInt*(arg: c_git_email_create_flags_t): cint = cint(ord(arg))

converter toCInt*(arg: git_email_create_flags_t): cint = cint(ord(to_c_git_email_create_flags_t(arg)))

converter toCInt*(args: set[git_email_create_flags_t]): cint =
  for value in items(args):
    case value:
      of GIT_EMAIL_CREATE_DEFAULT      : result = cint(result or 0)
      of GIT_EMAIL_CREATE_OMIT_NUMBERS : result = cint(result or 1)
      of GIT_EMAIL_CREATE_ALWAYS_NUMBER: result = cint(result or 2)
      of GIT_EMAIL_CREATE_NO_RENAMES   : result = cint(result or 4)

func `-`*(arg: c_git_email_create_flags_t, offset: int): c_git_email_create_flags_t = cast[c_git_email_create_flags_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_email_create_flags_t): c_git_email_create_flags_t = cast[c_git_email_create_flags_t](ord(arg) - offset)

func `+`*(arg: c_git_email_create_flags_t, offset: int): c_git_email_create_flags_t = cast[c_git_email_create_flags_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_email_create_flags_t): c_git_email_create_flags_t = cast[c_git_email_create_flags_t](ord(arg) + offset)

proc git_email_create_from_diff*(
    `out`: ptr cint,
    diff: ptr cint,
    patch_idx: csize_t,
    patch_count: csize_t,
    commit_id: ptr cint,
    summary: cstring,
    body: cstring,
    author: ptr cint,
    opts: ptr git_email_create_options,
): cint {.importc: "git_email_create_from_diff".}

proc git_email_create_from_commit*(
    `out`: ptr cint,
    commit: ptr cint,
    opts: ptr git_email_create_options,
): cint {.importc: "git_email_create_from_commit".}