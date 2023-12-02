import "./libgit2_config.nim" ## From gen file
import "./buffer.nim"

type
  git_message_trailer* {.importc, bycopy.} = object
    key   *: cstring
    value *: cstring

  git_message_trailer_array* {.importc, bycopy.} = object
    trailers      *: `ptr` git_message_trailer
    count         *: csize_t
    trailer_block * {.importc: "_trailer_block".}: `ptr` char



proc git_message_prettify*(`out`: `ptr` git_buf, message: cstring, strip_comments: cint, comment_char: char): cint {.git2Proc, importc: "git_message_prettify".}

proc git_message_trailers*(arr: `ptr` git_message_trailer_array, message: cstring): cint {.git2Proc, importc: "git_message_trailers".}

proc git_message_trailer_array_free*(arr: `ptr` git_message_trailer_array): void {.git2Proc, importc: "git_message_trailer_array_free".}