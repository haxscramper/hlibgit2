import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./oid.nim"
import "./buffer.nim"
proc git_object_lookup*(
    `object`: ptr ptr git_object,
    repo: ptr git_repository,
    id: ptr git_oid,
    `type`: git_object_t,
): cint {.importc: "git_object_lookup", header: "<object.h>".}

proc git_object_lookup_prefix*(
    object_out: ptr ptr git_object,
    repo: ptr git_repository,
    id: ptr git_oid,
    len: csize_t,
    `type`: git_object_t,
): cint {.importc: "git_object_lookup_prefix", header: "<object.h>".}

proc git_object_lookup_bypath*(
    `out`: ptr ptr git_object,
    treeish: ptr git_object,
    path: cstring,
    `type`: git_object_t,
): cint {.importc: "git_object_lookup_bypath", header: "<object.h>".}

proc git_object_id*(obj: ptr git_object): ptr git_oid {.importc: "git_object_id", header: "<object.h>".}

proc git_object_short_id*(`out`: ptr git_buf, obj: ptr git_object): cint {.importc: "git_object_short_id", header: "<object.h>".}

proc git_object_type*(obj: ptr git_object): git_object_t {.importc: "git_object_type", header: "<object.h>".}

proc git_object_owner*(obj: ptr git_object): ptr git_repository {.importc: "git_object_owner", header: "<object.h>".}

proc git_object_free*(`object`: ptr git_object): void {.importc: "git_object_free", header: "<object.h>".}

proc git_object_type2string*(`type`: git_object_t): cstring {.importc: "git_object_type2string", header: "<object.h>".}

proc git_object_string2type*(str: cstring): git_object_t {.importc: "git_object_string2type", header: "<object.h>".}

proc git_object_typeisloose*(`type`: git_object_t): cint {.importc: "git_object_typeisloose", header: "<object.h>".}

proc git_object_peel*(
    peeled: ptr ptr git_object,
    `object`: ptr git_object,
    target_type: git_object_t,
): cint {.importc: "git_object_peel", header: "<object.h>".}

proc git_object_dup*(dest: ptr ptr git_object, source: ptr git_object): cint {.importc: "git_object_dup", header: "<object.h>".}

proc git_object_rawcontent_is_valid*(
    valid: ptr cint,
    buf: cstring,
    len: csize_t,
    object_type: git_object_t,
): cint {.importc: "git_object_rawcontent_is_valid", header: "<object.h>".}