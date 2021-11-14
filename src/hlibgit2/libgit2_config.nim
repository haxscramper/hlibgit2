import std/[macros]

const libgit2Static* {.booldefine.}: bool = false
const libgit2DynLib* {.strdefine.}: string = "libgit2.so"

macro git2Proc*(a: untyped): untyped =
  result = a
  result.addPragma(ident"importc")
  when not libgit2Static:
    result.addPragma(nnkExprColonExpr.newTree(
      ident"dynlib", newLit(libgit2DynLib)))

    echo result.repr()

type
  git_iterator* {.importc, incompleteStruct.} = object
