import "./libgit2_config.nim" ## From gen file

type
  git_buf* {.importc, bycopy.} = object
    `ptr`    *: ptr char
    reserved *: csize_t
    size     *: csize_t



proc git_buf_dispose*(buffer: ptr git_buf): void {.git2Proc, importc: "git_buf_dispose".}