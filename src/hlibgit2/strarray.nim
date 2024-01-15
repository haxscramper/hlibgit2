type
  git_strarray* {.importc, bycopy.} = object
    strings *: cstringArray
    count   *: csize_t



proc git_strarray_dispose*(array: ptr git_strarray): void {.importc: "git_strarray_dispose".}