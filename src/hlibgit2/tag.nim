import "./libgit2_config.nim"
import "./oid.nim"
import "./strarray.nim"
import "./types.nim"

type
  git_tag_foreach_cb* = proc (a0: cstring, a1: `ptr` git_oid, a2: pointer): cint



proc git_tag_lookup*(`out`: `ptr` git_tag, repo: `ptr` git_repository, id: `ptr` git_oid): cint {.git2Proc, importc.}

proc git_tag_lookup_prefix*(`out`: `ptr` git_tag, repo: `ptr` git_repository, id: `ptr` git_oid, len: csize_t): cint {.git2Proc, importc.}

proc git_tag_free*(tag: `ptr` git_tag): void {.git2Proc, importc.}

proc git_tag_id*(tag: `ptr` git_tag): `ptr` git_oid {.git2Proc, importc.}

proc git_tag_owner*(tag: `ptr` git_tag): `ptr` git_repository {.git2Proc, importc.}

proc git_tag_target*(target_out: `ptr` git_object, tag: `ptr` git_tag): cint {.git2Proc, importc.}

proc git_tag_target_id*(tag: `ptr` git_tag): `ptr` git_oid {.git2Proc, importc.}

proc git_tag_target_type*(tag: `ptr` git_tag): git_object_t {.git2Proc, importc.}

proc git_tag_name*(tag: `ptr` git_tag): cstring {.git2Proc, importc.}

proc git_tag_tagger*(tag: `ptr` git_tag): `ptr` git_signature {.git2Proc, importc.}

proc git_tag_message*(tag: `ptr` git_tag): cstring {.git2Proc, importc.}

proc git_tag_create*(oid: `ptr` git_oid, repo: `ptr` git_repository, tag_name: cstring, target: `ptr` git_object, tagger: `ptr` git_signature, message: cstring, force: cint): cint {.git2Proc, importc.}

proc git_tag_annotation_create*(oid: `ptr` git_oid, repo: `ptr` git_repository, tag_name: cstring, target: `ptr` git_object, tagger: `ptr` git_signature, message: cstring): cint {.git2Proc, importc.}

proc git_tag_create_from_buffer*(oid: `ptr` git_oid, repo: `ptr` git_repository, buffer: cstring, force: cint): cint {.git2Proc, importc.}

proc git_tag_create_lightweight*(oid: `ptr` git_oid, repo: `ptr` git_repository, tag_name: cstring, target: `ptr` git_object, force: cint): cint {.git2Proc, importc.}

proc git_tag_delete*(repo: `ptr` git_repository, tag_name: cstring): cint {.git2Proc, importc.}

proc git_tag_list*(tag_names: `ptr` git_strarray, repo: `ptr` git_repository): cint {.git2Proc, importc.}

proc git_tag_list_match*(tag_names: `ptr` git_strarray, pattern: cstring, repo: `ptr` git_repository): cint {.git2Proc, importc.}

proc git_tag_foreach*(repo: `ptr` git_repository, callback: git_tag_foreach_cb, payload: pointer): cint {.git2Proc, importc.}

proc git_tag_peel*(tag_target_out: `ptr` git_object, tag: `ptr` git_tag): cint {.git2Proc, importc.}

proc git_tag_dup*(`out`: `ptr` git_tag, source: `ptr` git_tag): cint {.git2Proc, importc.}

proc git_tag_name_is_valid*(valid: `ptr` cint, name: cstring): cint {.git2Proc, importc.}