import "./libgit2_config.nim" ## From gen file

type
  git_strarray* {.bycopy.} = object
    strings *: cstringArray
    count   *: csize_t



proc git_strarray_dispose*(array: ptr git_strarray): void {.git2Proc, importc: "git_strarray_dispose".}