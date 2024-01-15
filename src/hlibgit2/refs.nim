import "./types.nim"
import "./strarray.nim"
import "./oid.nim"
import "./sys/refdb_backend.nim"

type
  c_git_reference_format_t* {.size: sizeof(cint).} = enum
    c_GIT_REFERENCE_FORMAT_NORMAL            = 0
    c_GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL    = 1
    c_GIT_REFERENCE_FORMAT_REFSPEC_PATTERN   = 2
    c_GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 1 shl 2

  git_reference_format_t* = enum
    GIT_REFERENCE_FORMAT_NORMAL            = 0
    GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL    = 1
    GIT_REFERENCE_FORMAT_REFSPEC_PATTERN   = 2
    GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 3

  git_reference_foreach_cb* = proc (a0: ptr git_reference, a1: pointer): cint

  git_reference_foreach_name_cb* = proc (a0: cstring, a1: pointer): cint



proc git_reference_dup*(dest: ptr ptr git_reference, source: ptr git_reference): cint {.importc: "git_reference_dup".}

proc git_reference_free*(`ref`: ptr git_reference): void {.importc: "git_reference_free".}

proc git_reference_cmp*(ref1: ptr git_reference, ref2: ptr git_reference): cint {.importc: "git_reference_cmp".}

proc git_reference_iterator_new*(`out`: ptr ptr git_reference_iterator, repo: ptr git_repository): cint {.importc: "git_reference_iterator_new".}

proc git_reference_iterator_glob_new*(
    `out`: ptr ptr git_reference_iterator,
    repo: ptr git_repository,
    glob: cstring,
): cint {.importc: "git_reference_iterator_glob_new".}

proc git_reference_next*(`out`: ptr ptr git_reference, iter: ptr git_reference_iterator): cint {.importc: "git_reference_next".}

proc git_reference_next_name*(`out`: cstringArray, iter: ptr git_reference_iterator): cint {.importc: "git_reference_next_name".}

proc git_reference_iterator_free*(iter: ptr git_reference_iterator): void {.importc: "git_reference_iterator_free".}

proc git_reference_foreach_glob*(
    repo: ptr git_repository,
    glob: cstring,
    callback: git_reference_foreach_name_cb,
    payload: pointer,
): cint {.importc: "git_reference_foreach_glob".}

proc git_reference_has_log*(repo: ptr git_repository, refname: cstring): cint {.importc: "git_reference_has_log".}

proc git_reference_ensure_log*(repo: ptr git_repository, refname: cstring): cint {.importc: "git_reference_ensure_log".}

proc git_reference_is_branch*(`ref`: ptr git_reference): cint {.importc: "git_reference_is_branch".}

proc git_reference_is_remote*(`ref`: ptr git_reference): cint {.importc: "git_reference_is_remote".}

proc git_reference_is_tag*(`ref`: ptr git_reference): cint {.importc: "git_reference_is_tag".}

proc git_reference_is_note*(`ref`: ptr git_reference): cint {.importc: "git_reference_is_note".}

proc git_reference_normalize_name*(
    buffer_out: ptr char,
    buffer_size: csize_t,
    name: cstring,
    flags: cuint,
): cint {.importc: "git_reference_normalize_name".}

proc git_reference_peel*(
    `out`: ptr ptr git_object,
    `ref`: ptr git_reference,
    `type`: git_object_t,
): cint {.importc: "git_reference_peel".}

proc git_reference_name_is_valid*(valid: ptr cint, refname: cstring): cint {.importc: "git_reference_name_is_valid".}

proc git_reference_shorthand*(`ref`: ptr git_reference): cstring {.importc: "git_reference_shorthand".}

converter to_git_reference_format_t*(arg: c_git_reference_format_t): git_reference_format_t =
  case arg:
    of c_GIT_REFERENCE_FORMAT_NORMAL           : GIT_REFERENCE_FORMAT_NORMAL
    of c_GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL   : GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL
    of c_GIT_REFERENCE_FORMAT_REFSPEC_PATTERN  : GIT_REFERENCE_FORMAT_REFSPEC_PATTERN
    of c_GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND: GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND

proc to_c_git_reference_format_t*(arg: git_reference_format_t): c_git_reference_format_t =
  case arg:
    of GIT_REFERENCE_FORMAT_NORMAL           : c_GIT_REFERENCE_FORMAT_NORMAL
    of GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL   : c_GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL
    of GIT_REFERENCE_FORMAT_REFSPEC_PATTERN  : c_GIT_REFERENCE_FORMAT_REFSPEC_PATTERN
    of GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND: c_GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND

converter toCInt*(arg: c_git_reference_format_t): cint = cint(ord(arg))

converter toCInt*(arg: git_reference_format_t): cint = cint(ord(to_c_git_reference_format_t(arg)))

converter toCInt*(args: set[git_reference_format_t]): cint =
  for value in items(args):
    case value:
      of GIT_REFERENCE_FORMAT_NORMAL           : result = cint(result or 0)
      of GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL   : result = cint(result or 1)
      of GIT_REFERENCE_FORMAT_REFSPEC_PATTERN  : result = cint(result or 2)
      of GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND: result = cint(result or 4)

func `-`*(arg: c_git_reference_format_t, offset: int): cint = cast[c_git_reference_format_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_reference_format_t): cint = cast[c_git_reference_format_t](ord(arg) - offset)

func `+`*(arg: c_git_reference_format_t, offset: int): cint = cast[c_git_reference_format_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_reference_format_t): cint = cast[c_git_reference_format_t](ord(arg) + offset)

proc git_reference_lookup*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    name: cstring,
): cint {.importc: "git_reference_lookup".}

proc git_reference_name_to_id*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    name: cstring,
): cint {.importc: "git_reference_name_to_id".}

proc git_reference_dwim*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    shorthand: cstring,
): cint {.importc: "git_reference_dwim".}

proc git_reference_symbolic_create_matching*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    name: cstring,
    target: cstring,
    force: cint,
    current_value: cstring,
    log_message: cstring,
): cint {.importc: "git_reference_symbolic_create_matching".}

proc git_reference_symbolic_create*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    name: cstring,
    target: cstring,
    force: cint,
    log_message: cstring,
): cint {.importc: "git_reference_symbolic_create".}

proc git_reference_create*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    name: cstring,
    id: ptr git_oid,
    force: cint,
    log_message: cstring,
): cint {.importc: "git_reference_create".}

proc git_reference_create_matching*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    name: cstring,
    id: ptr git_oid,
    force: cint,
    current_id: ptr git_oid,
    log_message: cstring,
): cint {.importc: "git_reference_create_matching".}

proc git_reference_target*(`ref`: ptr git_reference): ptr git_oid {.importc: "git_reference_target".}

proc git_reference_target_peel*(`ref`: ptr git_reference): ptr git_oid {.importc: "git_reference_target_peel".}

proc git_reference_symbolic_target*(`ref`: ptr git_reference): cstring {.importc: "git_reference_symbolic_target".}

proc git_reference_type*(`ref`: ptr git_reference): git_reference_t {.importc: "git_reference_type".}

proc git_reference_name*(`ref`: ptr git_reference): cstring {.importc: "git_reference_name".}

proc git_reference_resolve*(`out`: ptr ptr git_reference, `ref`: ptr git_reference): cint {.importc: "git_reference_resolve".}

proc git_reference_owner*(`ref`: ptr git_reference): ptr git_repository {.importc: "git_reference_owner".}

proc git_reference_symbolic_set_target*(
    `out`: ptr ptr git_reference,
    `ref`: ptr git_reference,
    target: cstring,
    log_message: cstring,
): cint {.importc: "git_reference_symbolic_set_target".}

proc git_reference_set_target*(
    `out`: ptr ptr git_reference,
    `ref`: ptr git_reference,
    id: ptr git_oid,
    log_message: cstring,
): cint {.importc: "git_reference_set_target".}

proc git_reference_rename*(
    new_ref: ptr ptr git_reference,
    `ref`: ptr git_reference,
    new_name: cstring,
    force: cint,
    log_message: cstring,
): cint {.importc: "git_reference_rename".}

proc git_reference_delete*(`ref`: ptr git_reference): cint {.importc: "git_reference_delete".}

proc git_reference_remove*(repo: ptr git_repository, name: cstring): cint {.importc: "git_reference_remove".}

proc git_reference_list*(array: ptr git_strarray, repo: ptr git_repository): cint {.importc: "git_reference_list".}

proc git_reference_foreach*(
    repo: ptr git_repository,
    callback: git_reference_foreach_cb,
    payload: pointer,
): cint {.importc: "git_reference_foreach".}

proc git_reference_foreach_name*(
    repo: ptr git_repository,
    callback: git_reference_foreach_name_cb,
    payload: pointer,
): cint {.importc: "git_reference_foreach_name".}