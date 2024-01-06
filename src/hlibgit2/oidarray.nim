import "./libgit2_config.nim" ## From gen file
import "./oid.nim"

type
  git_oidarray* {.header: "<oidarray.h>", importc, bycopy.} = object
    ids   *: ptr git_oid
    count *: csize_t



proc git_oidarray_dispose*(array: ptr git_oidarray): void {.importc: "git_oidarray_dispose", header: "<oidarray.h>".}