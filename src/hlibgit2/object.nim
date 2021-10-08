
import
  . / oid.h

import
  . / types.h

import
  . / buffer.h

proc git_object_lookup*(object: ptr ptr git_object; repo: ptr git_repository;
                        id: ptr git_oid; type: git_object_t): cint {.
    dynlib: libgitDl, importc: "git_object_lookup".}
proc git_object_lookup_prefix*(object_out: ptr ptr git_object;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t; type: git_object_t): cint {.
    dynlib: libgitDl, importc: "git_object_lookup_prefix".}
proc git_object_lookup_bypath*(out: ptr ptr git_object; treeish: ptr git_object;
                               path: cstring; type: git_object_t): cint {.
    dynlib: libgitDl, importc: "git_object_lookup_bypath".}
proc git_object_id*(obj: ptr git_object): ptr git_oid {.dynlib: libgitDl,
    importc: "git_object_id".}
proc git_object_short_id*(out: ptr git_buf; obj: ptr git_object): cint {.
    dynlib: libgitDl, importc: "git_object_short_id".}
proc git_object_type*(obj: ptr git_object): git_object_t {.dynlib: libgitDl,
    importc: "git_object_type".}
proc git_object_owner*(obj: ptr git_object): ptr git_repository {.
    dynlib: libgitDl, importc: "git_object_owner".}
proc git_object_free*(object: ptr git_object): void {.dynlib: libgitDl,
    importc: "git_object_free".}
proc git_object_type2string*(type: git_object_t): cstring {.dynlib: libgitDl,
    importc: "git_object_type2string".}
proc git_object_string2type*(str: cstring): git_object_t {.dynlib: libgitDl,
    importc: "git_object_string2type".}
proc git_object_typeisloose*(type: git_object_t): cint {.dynlib: libgitDl,
    importc: "git_object_typeisloose".}
proc git_object_peel*(peeled: ptr ptr git_object; object: ptr git_object;
                      target_type: git_object_t): cint {.dynlib: libgitDl,
    importc: "git_object_peel".}
proc git_object_dup*(dest: ptr ptr git_object; source: ptr git_object): cint {.
    dynlib: libgitDl, importc: "git_object_dup".}