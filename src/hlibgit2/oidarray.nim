import "../oid.nim"

type
  git_oidarray* {.importc, bycopy.} = object
    ids   *: ptr git_oid
    count *: csize_t



proc git_oidarray_dispose*(array: ptr git_oidarray): void {.git2Proc, importc.}