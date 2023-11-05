{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./strarray,
  ./types

type
  c_git_reference_format_t* {.size: sizeof(cint).} = enum
    c_GIT_REFERENCE_FORMAT_NORMAL            = 0 shl 0
    c_GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL    = 1 shl 0
    c_GIT_REFERENCE_FORMAT_REFSPEC_PATTERN   = 1 shl 1
    c_GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 1 shl 2

  git_reference_foreach_cb* = proc(reference: ptr git_reference,
                                   payload:   pointer): cint{.cdecl.}

  git_reference_foreach_name_cb* = proc(name:    cstring,
                                        payload: pointer): cint{.cdecl.}

  git_reference_format_t* {.size: sizeof(cint).} = enum
    GIT_REFERENCE_FORMAT_NORMAL
    GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL
    GIT_REFERENCE_FORMAT_REFSPEC_PATTERN
    GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND


proc git_reference_lookup*(
    arg_out: ptr ptr git_reference,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_reference_name_to_id*(
    arg_out: ptr git_oid,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_reference_dwim*(
    arg_out:   ptr ptr git_reference,
    repo:      ptr git_repository,
    shorthand: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_symbolic_create_matching*(
    arg_out:       ptr ptr git_reference,
    repo:          ptr git_repository,
    name:          cstring,
    target:        cstring,
    force:         cint,
    current_value: cstring,
    log_message:   cstring
  ): cint {.git2Proc, importc.}



proc git_reference_symbolic_create*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    target:      cstring,
    force:       cint,
    log_message: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_create*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    id:          ptr git_oid,
    force:       cint,
    log_message: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_create_matching*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    id:          ptr git_oid,
    force:       cint,
    current_id:  ptr git_oid,
    log_message: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_target*(
    arg_ref: ptr git_reference
  ): ptr git_oid {.git2Proc, importc.}



proc git_reference_target_peel*(
    arg_ref: ptr git_reference
  ): ptr git_oid {.git2Proc, importc.}



proc git_reference_symbolic_target*(
    arg_ref: ptr git_reference
  ): cstring {.git2Proc, importc.}



proc git_reference_type*(
    arg_ref: ptr git_reference
  ): c_git_reference_t {.git2Proc, importc.}



proc git_reference_name*(
    arg_ref: ptr git_reference
  ): cstring {.git2Proc, importc.}



proc git_reference_resolve*(
    arg_out: ptr ptr git_reference,
    arg_ref: ptr git_reference
  ): cint {.git2Proc, importc.}



proc git_reference_owner*(
    arg_ref: ptr git_reference
  ): ptr git_repository {.git2Proc, importc.}



proc git_reference_symbolic_set_target*(
    arg_out:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    target:      cstring,
    log_message: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_set_target*(
    arg_out:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    id:          ptr git_oid,
    log_message: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_rename*(
    new_ref:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    new_name:    cstring,
    force:       cint,
    log_message: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_delete*(
    arg_ref: ptr git_reference
  ): cint {.git2Proc, importc.}



proc git_reference_remove*(
    repo: ptr git_repository,
    name: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_list*(
    array: ptr git_strarray,
    repo:  ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_reference_foreach*(
    repo:     ptr git_repository,
    callback: git_reference_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_reference_foreach_name*(
    repo:     ptr git_repository,
    callback: git_reference_foreach_name_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_reference_dup*(
    dest:   ptr ptr git_reference,
    source: ptr git_reference
  ): cint {.git2Proc, importc.}



proc git_reference_free*(arg_ref: ptr git_reference): void {.git2Proc, importc.}



proc git_reference_cmp*(
    ref1: ptr git_reference,
    ref2: ptr git_reference
  ): cint {.git2Proc, importc.}



proc git_reference_iterator_new*(
    arg_out: ptr ptr git_reference_iterator,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_reference_iterator_glob_new*(
    arg_out: ptr ptr git_reference_iterator,
    repo:    ptr git_repository,
    glob:    cstring
  ): cint {.git2Proc, importc.}



proc git_reference_next*(
    arg_out: ptr ptr git_reference,
    iter:    ptr git_reference_iterator
  ): cint {.git2Proc, importc.}



proc git_reference_next_name*(
    arg_out: ptr cstring,
    iter:    ptr git_reference_iterator
  ): cint {.git2Proc, importc.}



proc git_reference_iterator_free*(
    iter: ptr git_reference_iterator
  ): void {.git2Proc, importc.}



proc git_reference_foreach_glob*(
    repo:     ptr git_repository,
    glob:     cstring,
    callback: git_reference_foreach_name_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_reference_has_log*(
    repo:    ptr git_repository,
    refname: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_ensure_log*(
    repo:    ptr git_repository,
    refname: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_is_branch*(
    arg_ref: ptr git_reference
  ): cint {.git2Proc, importc.}



proc git_reference_is_remote*(
    arg_ref: ptr git_reference
  ): cint {.git2Proc, importc.}



proc git_reference_is_tag*(
    arg_ref: ptr git_reference
  ): cint {.git2Proc, importc.}



proc git_reference_is_note*(
    arg_ref: ptr git_reference
  ): cint {.git2Proc, importc.}



proc to_c_git_reference_format_t*(
    arg: git_reference_format_t
  ): c_git_reference_format_t =
  case arg:
    of GIT_REFERENCE_FORMAT_NORMAL:            c_GIT_REFERENCE_FORMAT_NORMAL
    of GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL:    c_GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL
    of GIT_REFERENCE_FORMAT_REFSPEC_PATTERN:   c_GIT_REFERENCE_FORMAT_REFSPEC_PATTERN
    of GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND: c_GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND


converter to_git_reference_format_t*(
    arg: c_git_reference_format_t
  ): git_reference_format_t =
  case arg:
    of c_GIT_REFERENCE_FORMAT_NORMAL:            GIT_REFERENCE_FORMAT_NORMAL
    of c_GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL:    GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL
    of c_GIT_REFERENCE_FORMAT_REFSPEC_PATTERN:   GIT_REFERENCE_FORMAT_REFSPEC_PATTERN
    of c_GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND: GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND


converter toCint*(arg: c_git_reference_format_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_reference_format_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_reference_format_t(arg)))

func `+`*(
    arg:    c_git_reference_format_t,
    offset: int
  ): c_git_reference_format_t =
  cast[c_git_reference_format_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_reference_format_t
  ): c_git_reference_format_t =
  cast[c_git_reference_format_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_reference_format_t,
    offset: int
  ): c_git_reference_format_t =
  cast[c_git_reference_format_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_reference_format_t
  ): c_git_reference_format_t =
  cast[c_git_reference_format_t](ord(arg) - offset)


converter toCint*(args: set[git_reference_format_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_REFERENCE_FORMAT_NORMAL:            result = cint(result or (0 shl 0))
      of GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL:    result = cint(result or (1 shl 0))
      of GIT_REFERENCE_FORMAT_REFSPEC_PATTERN:   result = cint(result or (1 shl 1))
      of GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND: result = cint(result or (1 shl 2))


proc git_reference_normalize_name*(
    buffer_out:  cstring,
    buffer_size: csize_t,
    name:        cstring,
    flags:       cuint
  ): cint {.git2Proc, importc.}



proc git_reference_peel*(
    arg_out:  ptr ptr git_object,
    arg_ref:  ptr git_reference,
    arg_type: c_git_object_t
  ): cint {.git2Proc, importc.}



proc git_reference_name_is_valid*(
    valid:   ptr cint,
    refname: cstring
  ): cint {.git2Proc, importc.}



proc git_reference_shorthand*(
    arg_ref: ptr git_reference
  ): cstring {.git2Proc, importc.}



