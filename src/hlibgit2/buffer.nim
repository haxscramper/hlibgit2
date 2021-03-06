{.push warning[UnusedImport]:off.}

import
  ./libgit2_config

type
  git_buf* {.bycopy, header: "<git2/buffer.h>", importc.} = object
    ptr_f* {.importc: "ptr".}: cstring
    asize*:                    csize_t
    size*:                     csize_t


proc git_buf_dispose*(buffer: ptr git_buf): void {.git2Proc, importc.}



proc git_buf_grow*(
    buffer:      ptr git_buf,
    target_size: csize_t
  ): cint {.git2Proc, importc.}



proc git_buf_set*(
    buffer:  ptr git_buf,
    data:    pointer,
    datalen: csize_t
  ): cint {.git2Proc, importc.}



proc git_buf_is_binary*(buf: ptr git_buf): cint {.git2Proc, importc.}



proc git_buf_contains_nul*(buf: ptr git_buf): cint {.git2Proc, importc.}



