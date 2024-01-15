type
  git_buf* {.bycopy.} = object
    `ptr`    *: ptr char
    reserved *: csize_t
    size     *: csize_t



proc git_buf_dispose*(buffer: ptr git_buf): void {.importc: "git_buf_dispose".}