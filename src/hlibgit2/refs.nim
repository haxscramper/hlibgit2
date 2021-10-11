{.push warning[UnusedImport]:off.}

import
  ./libgit2_config,
  ./oid,
  ./strarray,
  ./types

type
  git_reference_foreach_cb* = proc(reference: ptr git_reference, payload: pointer): cint{.cdecl.}
   
  git_reference_foreach_cbNim* = proc(reference: ptr git_reference): cint
   
  git_reference_foreach_name_cb* = proc(name: cstring, payload: pointer): cint{.cdecl.}
   
  git_reference_foreach_name_cbNim* = proc(name: cstring): cint
   
  git_reference_format_t* = enum
    GIT_REFERENCE_FORMAT_NORMAL = 0
    GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL = 1
    GIT_REFERENCE_FORMAT_REFSPEC_PATTERN = 2
    GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 4
   

proc git_reference_lookup*(
    arg_out: ptr ptr git_reference,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_name_to_id*(
    arg_out: ptr git_oid,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_dwim*(
    arg_out:   ptr ptr git_reference,
    repo:      ptr git_repository,
    shorthand: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_symbolic_create_matching*(
    arg_out:       ptr ptr git_reference,
    repo:          ptr git_repository,
    name:          cstring,
    target:        cstring,
    force:         cint,
    current_value: cstring,
    log_message:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_symbolic_create*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    target:      cstring,
    force:       cint,
    log_message: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_create*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    id:          ptr git_oid,
    force:       cint,
    log_message: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_create_matching*(
    arg_out:     ptr ptr git_reference,
    repo:        ptr git_repository,
    name:        cstring,
    id:          ptr git_oid,
    force:       cint,
    current_id:  ptr git_oid,
    log_message: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_target*(
    arg_ref: ptr git_reference
  ): ptr git_oid {.dynlib: libgit2Dl, importc.}


proc git_reference_target_peel*(
    arg_ref: ptr git_reference
  ): ptr git_oid {.dynlib: libgit2Dl, importc.}


proc git_reference_symbolic_target*(
    arg_ref: ptr git_reference
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_reference_type*(
    arg_ref: ptr git_reference
  ): git_reference_t {.dynlib: libgit2Dl, importc.}


proc git_reference_name*(
    arg_ref: ptr git_reference
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_reference_resolve*(
    arg_out: ptr ptr git_reference,
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_owner*(
    arg_ref: ptr git_reference
  ): ptr git_repository {.dynlib: libgit2Dl, importc.}


proc git_reference_symbolic_set_target*(
    arg_out:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    target:      cstring,
    log_message: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_set_target*(
    arg_out:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    id:          ptr git_oid,
    log_message: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_rename*(
    new_ref:     ptr ptr git_reference,
    arg_ref:     ptr git_reference,
    new_name:    cstring,
    force:       cint,
    log_message: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_delete*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_remove*(
    repo: ptr git_repository,
    name: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_list*(
    array: ptr git_strarray,
    repo:  ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_foreach*(
    repo:     ptr git_repository,
    callback: git_reference_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_foreach_name*(
    repo:     ptr git_repository,
    callback: git_reference_foreach_name_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_dup*(
    dest:   ptr ptr git_reference,
    source: ptr git_reference
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_free*(
    arg_ref: ptr git_reference
  ): void {.dynlib: libgit2Dl, importc.}


proc git_reference_cmp*(
    ref1: ptr git_reference,
    ref2: ptr git_reference
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_iterator_new*(
    arg_out: ptr ptr git_reference_iterator,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_iterator_glob_new*(
    arg_out: ptr ptr git_reference_iterator,
    repo:    ptr git_repository,
    glob:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_next*(
    arg_out: ptr ptr git_reference,
    iter:    ptr git_reference_iterator
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_next_name*(
    arg_out: ptr cstring,
    iter:    ptr git_reference_iterator
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_iterator_free*(
    iter: ptr git_reference_iterator
  ): void {.dynlib: libgit2Dl, importc.}


proc git_reference_foreach_glob*(
    repo:     ptr git_repository,
    glob:     cstring,
    callback: git_reference_foreach_name_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_has_log*(
    repo:    ptr git_repository,
    refname: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_ensure_log*(
    repo:    ptr git_repository,
    refname: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_is_branch*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_is_remote*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_is_tag*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_is_note*(
    arg_ref: ptr git_reference
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_normalize_name*(
    buffer_out:  cstring,
    buffer_size: csize_t,
    name:        cstring,
    flags:       cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_peel*(
    arg_out:  ptr ptr git_object,
    arg_ref:  ptr git_reference,
    arg_type: git_object_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_is_valid_name*(
    refname: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_reference_shorthand*(
    arg_ref: ptr git_reference
  ): cstring {.dynlib: libgit2Dl, importc.}


