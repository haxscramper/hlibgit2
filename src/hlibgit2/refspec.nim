{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./types

import
  ./buffer

import
  ./net

proc git_refspec_parse*(
    refspec:  ptr ptr git_refspec,
    input:    cstring,
    is_fetch: cint
  ): cint {.dynlib: libgitDl, importc.}


proc git_refspec_free*(
    refspec: ptr git_refspec
  ): void {.dynlib: libgitDl, importc.}


proc git_refspec_src*(
    refspec: ptr git_refspec
  ): cstring {.dynlib: libgitDl, importc.}


proc git_refspec_dst*(
    refspec: ptr git_refspec
  ): cstring {.dynlib: libgitDl, importc.}


proc git_refspec_string*(
    refspec: ptr git_refspec
  ): cstring {.dynlib: libgitDl, importc.}


proc git_refspec_force*(
    refspec: ptr git_refspec
  ): cint {.dynlib: libgitDl, importc.}


proc git_refspec_direction*(
    spec: ptr git_refspec
  ): git_direction {.dynlib: libgitDl, importc.}


proc git_refspec_src_matches*(
    refspec: ptr git_refspec,
    refname: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_refspec_dst_matches*(
    refspec: ptr git_refspec,
    refname: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_refspec_transform*(
    arg_out: ptr git_buf,
    spec:    ptr git_refspec,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_refspec_rtransform*(
    arg_out: ptr git_buf,
    spec:    ptr git_refspec,
    name:    cstring
  ): cint {.dynlib: libgitDl, importc.}


