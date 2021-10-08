
import
  . / types.h

proc git_signature_new*(out: ptr ptr git_signature; name: cstring;
                        email: cstring; time: git_time_t; offset: cint): cint {.
    dynlib: libgitDl, importc: "git_signature_new".}
proc git_signature_now*(out: ptr ptr git_signature; name: cstring;
                        email: cstring): cint {.dynlib: libgitDl,
    importc: "git_signature_now".}
proc git_signature_default*(out: ptr ptr git_signature; repo: ptr git_repository): cint {.
    dynlib: libgitDl, importc: "git_signature_default".}
proc git_signature_from_buffer*(out: ptr ptr git_signature; buf: cstring): cint {.
    dynlib: libgitDl, importc: "git_signature_from_buffer".}
proc git_signature_dup*(dest: ptr ptr git_signature; sig: ptr git_signature): cint {.
    dynlib: libgitDl, importc: "git_signature_dup".}
proc git_signature_free*(sig: ptr git_signature): void {.dynlib: libgitDl,
    importc: "git_signature_free".}