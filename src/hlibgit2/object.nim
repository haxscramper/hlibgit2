import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./buffer.nim"
import "./types.nim"
proc git_object_type2string*(`type`: git_object_t): cstring {.git2Proc, importc: "git_object_type2string".}

proc git_object_string2type*(str: cstring): git_object_t {.git2Proc, importc: "git_object_string2type".}

proc git_object_typeisloose*(`type`: git_object_t): cint {.git2Proc, importc: "git_object_typeisloose".}

proc git_object_peel*(peeled: `ptr` git_object, `object`: `ptr` git_object, target_type: git_object_t): cint {.git2Proc, importc: "git_object_peel".}

proc git_object_dup*(dest: `ptr` git_object, source: `ptr` git_object): cint {.git2Proc, importc: "git_object_dup".}

proc git_object_rawcontent_is_valid*(valid: `ptr` cint, buf: cstring, len: csize_t, object_type: git_object_t): cint {.git2Proc, importc: "git_object_rawcontent_is_valid".}

proc git_object_lookup*(`object`: `ptr` git_object, repo: `ptr` git_repository, id: `ptr` git_oid, `type`: git_object_t): cint {.git2Proc, importc: "git_object_lookup".}

proc git_object_lookup_prefix*(object_out: `ptr` git_object, repo: `ptr` git_repository, id: `ptr` git_oid, len: csize_t, `type`: git_object_t): cint {.git2Proc, importc: "git_object_lookup_prefix".}

proc git_object_lookup_bypath*(`out`: `ptr` git_object, treeish: `ptr` git_object, path: cstring, `type`: git_object_t): cint {.git2Proc, importc: "git_object_lookup_bypath".}

proc git_object_id*(obj: `ptr` git_object): `ptr` git_oid {.git2Proc, importc: "git_object_id".}

proc git_object_short_id*(`out`: `ptr` git_buf, obj: `ptr` git_object): cint {.git2Proc, importc: "git_object_short_id".}

proc git_object_type*(obj: `ptr` git_object): git_object_t {.git2Proc, importc: "git_object_type".}

proc git_object_owner*(obj: `ptr` git_object): `ptr` git_repository {.git2Proc, importc: "git_object_owner".}

proc git_object_free*(`object`: `ptr` git_object): void {.git2Proc, importc: "git_object_free".}