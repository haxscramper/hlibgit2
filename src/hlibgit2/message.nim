{.push warning[UnusedImport]:off.}

import
  ./libgit_config

import
  ./buffer

type
  git_message_trailer* {.bycopy, header: "<git2/message.h>", importc.} = object
    key*: cstring
    value*: cstring
   
  git_message_trailer_array* {.bycopy, header: "<git2/message.h>", importc.} = object
    trailers*: ptr git_message_trailer
    count*: csize_t
    trailer_block* {.importc: "_trailer_block".}: cstring ## private 
   

proc git_message_prettify*(
    arg_out:        ptr git_buf,
    message:        cstring,
    strip_comments: cint,
    comment_char:   char
  ): cint {.dynlib: libgitDl, importc.}


proc git_message_trailers*(
    arr:     ptr git_message_trailer_array,
    message: cstring
  ): cint {.dynlib: libgitDl, importc.}


proc git_message_trailer_array_free*(
    arr: ptr git_message_trailer_array
  ): void {.dynlib: libgitDl, importc.}


