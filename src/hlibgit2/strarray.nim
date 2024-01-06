import "./libgit2_config.nim" ## From gen file

type
  git_strarray* {.header: "<strarray.h>", importc, bycopy.} = object
    strings *: cstringArray
    count   *: csize_t



proc git_strarray_dispose*(array: ptr git_strarray): void {.importc: "git_strarray_dispose", header: "<strarray.h>".}