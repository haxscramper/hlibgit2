import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./strarray.nim"
import "./oid.nim"

type
  git_tag_foreach_cb* = proc (a0: cstring, a1: ptr git_oid, a2: pointer): cint



proc git_tag_create_lightweight*(
    oid: ptr git_oid,
    repo: ptr git_repository,
    tag_name: cstring,
    target: ptr git_object,
    force: cint,
): cint {.importc: "git_tag_create_lightweight", header: "<tag.h>".}

proc git_tag_delete*(repo: ptr git_repository, tag_name: cstring): cint {.importc: "git_tag_delete", header: "<tag.h>".}

proc git_tag_list*(tag_names: ptr git_strarray, repo: ptr git_repository): cint {.importc: "git_tag_list", header: "<tag.h>".}

proc git_tag_list_match*(
    tag_names: ptr git_strarray,
    pattern: cstring,
    repo: ptr git_repository,
): cint {.importc: "git_tag_list_match", header: "<tag.h>".}

proc git_tag_foreach*(
    repo: ptr git_repository,
    callback: git_tag_foreach_cb,
    payload: pointer,
): cint {.importc: "git_tag_foreach", header: "<tag.h>".}

proc git_tag_peel*(tag_target_out: ptr ptr git_object, tag: ptr git_tag): cint {.importc: "git_tag_peel", header: "<tag.h>".}

proc git_tag_dup*(`out`: ptr ptr git_tag, source: ptr git_tag): cint {.importc: "git_tag_dup", header: "<tag.h>".}

proc git_tag_name_is_valid*(valid: ptr cint, name: cstring): cint {.importc: "git_tag_name_is_valid", header: "<tag.h>".}

proc git_tag_lookup*(
    `out`: ptr ptr git_tag,
    repo: ptr git_repository,
    id: ptr git_oid,
): cint {.importc: "git_tag_lookup", header: "<tag.h>".}

proc git_tag_lookup_prefix*(
    `out`: ptr ptr git_tag,
    repo: ptr git_repository,
    id: ptr git_oid,
    len: csize_t,
): cint {.importc: "git_tag_lookup_prefix", header: "<tag.h>".}

proc git_tag_free*(tag: ptr git_tag): void {.importc: "git_tag_free", header: "<tag.h>".}

proc git_tag_id*(tag: ptr git_tag): ptr git_oid {.importc: "git_tag_id", header: "<tag.h>".}

proc git_tag_owner*(tag: ptr git_tag): ptr git_repository {.importc: "git_tag_owner", header: "<tag.h>".}

proc git_tag_target*(target_out: ptr ptr git_object, tag: ptr git_tag): cint {.importc: "git_tag_target", header: "<tag.h>".}

proc git_tag_target_id*(tag: ptr git_tag): ptr git_oid {.importc: "git_tag_target_id", header: "<tag.h>".}

proc git_tag_target_type*(tag: ptr git_tag): git_object_t {.importc: "git_tag_target_type", header: "<tag.h>".}

proc git_tag_name*(tag: ptr git_tag): cstring {.importc: "git_tag_name", header: "<tag.h>".}

proc git_tag_tagger*(tag: ptr git_tag): ptr git_signature {.importc: "git_tag_tagger", header: "<tag.h>".}

proc git_tag_message*(tag: ptr git_tag): cstring {.importc: "git_tag_message", header: "<tag.h>".}

proc git_tag_create*(
    oid: ptr git_oid,
    repo: ptr git_repository,
    tag_name: cstring,
    target: ptr git_object,
    tagger: ptr git_signature,
    message: cstring,
    force: cint,
): cint {.importc: "git_tag_create", header: "<tag.h>".}

proc git_tag_annotation_create*(
    oid: ptr git_oid,
    repo: ptr git_repository,
    tag_name: cstring,
    target: ptr git_object,
    tagger: ptr git_signature,
    message: cstring,
): cint {.importc: "git_tag_annotation_create", header: "<tag.h>".}

proc git_tag_create_from_buffer*(
    oid: ptr git_oid,
    repo: ptr git_repository,
    buffer: cstring,
    force: cint,
): cint {.importc: "git_tag_create_from_buffer", header: "<tag.h>".}