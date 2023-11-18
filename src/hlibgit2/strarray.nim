type

  git_strarray* {.importc, bycopy.} = object
    strings *: ptr char
    count   *: csize_t



proc `git_strarray_dispose`*(array: ptr git_strarray): void {.git2Proc, importc.}