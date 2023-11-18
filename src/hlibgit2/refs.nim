type

  c_git_reference_format_t {.size: sizeof(cint).} = enum
    c_GIT_REFERENCE_FORMAT_NORMAL            = 0 shl 0
    c_GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL    = 1 shl 0
    c_GIT_REFERENCE_FORMAT_REFSPEC_PATTERN   = 1 shl 1
    c_GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 1 shl 2
  git_reference_format_t = enum
    GIT_REFERENCE_FORMAT_NORMAL
    GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL
    GIT_REFERENCE_FORMAT_REFSPEC_PATTERN
    GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND
  git_reference_foreach_cb = proc (a0: ptr git_reference, a1: ptr void): cint
  git_reference_foreach_name_cb = proc (a0: cstring, a1: ptr void): cint



converter toCInt*(arg: c_git_reference_format_t): cint = cint(ord(arg))

converter toCInt*(args: set(git_reference_format_t)): cint =
  for value in items(args):
    case value:
      of GIT_REFERENCE_FORMAT_NORMAL: result = cint(result or 0)
      of GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL: result = cint(result or 1)
      of GIT_REFERENCE_FORMAT_REFSPEC_PATTERN: result = cint(result or 2)
      of GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND: result = cint(result or 4)

func `-`*(arg: c_git_reference_format_t, offset: int): cint = cast[c_git_reference_format_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_reference_format_t): cint = cast[c_git_reference_format_t](ord(arg) - offset)

func `+`*(arg: c_git_reference_format_t, offset: int): cint = cast[c_git_reference_format_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_reference_format_t): cint = cast[c_git_reference_format_t](ord(arg) + offset)

proc `git_reference_lookup`*(out: ptr git_reference, repo: ptr git_repository, name: cstring): cint {.git2Proc, importc.}

proc `git_reference_name_to_id`*(out: ptr git_oid, repo: ptr git_repository, name: cstring): cint {.git2Proc, importc.}

proc `git_reference_dwim`*(out: ptr git_reference, repo: ptr git_repository, shorthand: cstring): cint {.git2Proc, importc.}

proc `git_reference_symbolic_create_matching`*(out: ptr git_reference, repo: ptr git_repository, name: cstring, target: cstring, force: cint, current_value: cstring, log_message: cstring): cint {.git2Proc, importc.}

proc `git_reference_symbolic_create`*(out: ptr git_reference, repo: ptr git_repository, name: cstring, target: cstring, force: cint, log_message: cstring): cint {.git2Proc, importc.}

proc `git_reference_create`*(out: ptr git_reference, repo: ptr git_repository, name: cstring, id: ptr git_oid, force: cint, log_message: cstring): cint {.git2Proc, importc.}

proc `git_reference_create_matching`*(out: ptr git_reference, repo: ptr git_repository, name: cstring, id: ptr git_oid, force: cint, current_id: ptr git_oid, log_message: cstring): cint {.git2Proc, importc.}

proc `git_reference_target`*(ref: ptr git_reference): ptr git_oid {.git2Proc, importc.}

proc `git_reference_target_peel`*(ref: ptr git_reference): ptr git_oid {.git2Proc, importc.}

proc `git_reference_symbolic_target`*(ref: ptr git_reference): cstring {.git2Proc, importc.}

proc `git_reference_type`*(ref: ptr git_reference): git_reference_t {.git2Proc, importc.}

proc `git_reference_name`*(ref: ptr git_reference): cstring {.git2Proc, importc.}

proc `git_reference_resolve`*(out: ptr git_reference, ref: ptr git_reference): cint {.git2Proc, importc.}

proc `git_reference_owner`*(ref: ptr git_reference): ptr git_repository {.git2Proc, importc.}

proc `git_reference_symbolic_set_target`*(out: ptr git_reference, ref: ptr git_reference, target: cstring, log_message: cstring): cint {.git2Proc, importc.}

proc `git_reference_set_target`*(out: ptr git_reference, ref: ptr git_reference, id: ptr git_oid, log_message: cstring): cint {.git2Proc, importc.}

proc `git_reference_rename`*(new_ref: ptr git_reference, ref: ptr git_reference, new_name: cstring, force: cint, log_message: cstring): cint {.git2Proc, importc.}

proc `git_reference_delete`*(ref: ptr git_reference): cint {.git2Proc, importc.}

proc `git_reference_remove`*(repo: ptr git_repository, name: cstring): cint {.git2Proc, importc.}

proc `git_reference_list`*(array: ptr git_strarray, repo: ptr git_repository): cint {.git2Proc, importc.}

proc `git_reference_foreach`*(repo: ptr git_repository, callback: git_reference_foreach_cb, payload: ptr void): cint {.git2Proc, importc.}

proc `git_reference_foreach_name`*(repo: ptr git_repository, callback: git_reference_foreach_name_cb, payload: ptr void): cint {.git2Proc, importc.}

proc `git_reference_dup`*(dest: ptr git_reference, source: ptr git_reference): cint {.git2Proc, importc.}

proc `git_reference_free`*(ref: ptr git_reference): void {.git2Proc, importc.}

proc `git_reference_cmp`*(ref1: ptr git_reference, ref2: ptr git_reference): cint {.git2Proc, importc.}

proc `git_reference_iterator_new`*(out: ptr git_reference_iterator, repo: ptr git_repository): cint {.git2Proc, importc.}

proc `git_reference_iterator_glob_new`*(out: ptr git_reference_iterator, repo: ptr git_repository, glob: cstring): cint {.git2Proc, importc.}

proc `git_reference_next`*(out: ptr git_reference, iter: ptr git_reference_iterator): cint {.git2Proc, importc.}

proc `git_reference_next_name`*(out: cstring, iter: ptr git_reference_iterator): cint {.git2Proc, importc.}

proc `git_reference_iterator_free`*(iter: ptr git_reference_iterator): void {.git2Proc, importc.}

proc `git_reference_foreach_glob`*(repo: ptr git_repository, glob: cstring, callback: git_reference_foreach_name_cb, payload: ptr void): cint {.git2Proc, importc.}

proc `git_reference_has_log`*(repo: ptr git_repository, refname: cstring): cint {.git2Proc, importc.}

proc `git_reference_ensure_log`*(repo: ptr git_repository, refname: cstring): cint {.git2Proc, importc.}

proc `git_reference_is_branch`*(ref: ptr git_reference): cint {.git2Proc, importc.}

proc `git_reference_is_remote`*(ref: ptr git_reference): cint {.git2Proc, importc.}

proc `git_reference_is_tag`*(ref: ptr git_reference): cint {.git2Proc, importc.}

proc `git_reference_is_note`*(ref: ptr git_reference): cint {.git2Proc, importc.}

proc `git_reference_normalize_name`*(buffer_out: ptr char, buffer_size: csize_t, name: cstring, flags: cuint): cint {.git2Proc, importc.}

proc `git_reference_peel`*(out: ptr git_object, ref: ptr git_reference, type: git_object_t): cint {.git2Proc, importc.}

proc `git_reference_name_is_valid`*(valid: ptr cint, refname: cstring): cint {.git2Proc, importc.}

proc `git_reference_shorthand`*(ref: ptr git_reference): cstring {.git2Proc, importc.}