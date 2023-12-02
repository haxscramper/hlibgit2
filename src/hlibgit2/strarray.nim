import "./libgit2_config.nim" ## From gen file

type
  git_strarray* {.importc, bycopy.} = object
    strings *: `ptr` char
    count   *: csize_t



proc git_strarray_dispose*(array: `ptr` git_strarray): void {.git2Proc, importc: "git_strarray_dispose".}