
import
  . / oid

import
  . / types

import
  . / buffer

proc git_object_lookup*(object: ptr ptr git_object; repo: ptr git_repository;
                        id: ptr git_oid; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_lookup_prefix*(object_out: ptr ptr git_object;
                               repo: ptr git_repository; id: ptr git_oid;
                               len: size_t; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_lookup_bypath*(out: ptr ptr git_object; treeish: ptr git_object;
                               path: cstring; type: git_object_t): cint {.
    dynlib: libgitDl, importc.}
proc git_object_id*(obj: ptr git_object): ptr git_oid {.dynlib: libgitDl,
    importc.}
proc git_object_short_id*(out: ptr git_buf; obj: ptr git_object): cint {.
    dynlib: libgitDl, importc.}
proc git_object_type*(obj: ptr git_object): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_object_owner*(obj: ptr git_object): ptr git_repository {.
    dynlib: libgitDl, importc.}
proc git_object_free*(object: ptr git_object): void {.dynlib: libgitDl, importc.}
proc git_object_type2string*(type: git_object_t): cstring {.dynlib: libgitDl,
    importc.}
proc git_object_string2type*(str: cstring): git_object_t {.dynlib: libgitDl,
    importc.}
proc git_object_typeisloose*(type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_object_peel*(peeled: ptr ptr git_object; object: ptr git_object;
                      target_type: git_object_t): cint {.dynlib: libgitDl,
    importc.}
proc git_object_dup*(dest: ptr ptr git_object; source: ptr git_object): cint {.
    dynlib: libgitDl, importc.}