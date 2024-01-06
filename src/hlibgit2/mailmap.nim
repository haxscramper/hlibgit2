import "./libgit2_config.nim" ## From gen file
import "./types.nim"
proc git_mailmap_resolve_signature*(
    `out`: ptr ptr git_signature,
    mm: ptr git_mailmap,
    sig: ptr git_signature,
): cint {.importc: "git_mailmap_resolve_signature", header: "<mailmap.h>".}

proc git_mailmap_new*(`out`: ptr ptr git_mailmap): cint {.importc: "git_mailmap_new", header: "<mailmap.h>".}

proc git_mailmap_free*(mm: ptr git_mailmap): void {.importc: "git_mailmap_free", header: "<mailmap.h>".}

proc git_mailmap_add_entry*(
    mm: ptr git_mailmap,
    real_name: cstring,
    real_email: cstring,
    replace_name: cstring,
    replace_email: cstring,
): cint {.importc: "git_mailmap_add_entry", header: "<mailmap.h>".}

proc git_mailmap_from_buffer*(
    `out`: ptr ptr git_mailmap,
    buf: cstring,
    len: csize_t,
): cint {.importc: "git_mailmap_from_buffer", header: "<mailmap.h>".}

proc git_mailmap_from_repository*(`out`: ptr ptr git_mailmap, repo: ptr git_repository): cint {.importc: "git_mailmap_from_repository", header: "<mailmap.h>".}

proc git_mailmap_resolve*(
    real_name: cstringArray,
    real_email: cstringArray,
    mm: ptr git_mailmap,
    name: cstring,
    email: cstring,
): cint {.importc: "git_mailmap_resolve", header: "<mailmap.h>".}