const
  libgit2LinkMode* {.strdefine.} = "dynlib"
  libgit2Lib* {.strdefine.} = "libgit2.so"

import std/[macros]

macro git2Proc*(a: untyped): untyped =
  result = a
  result.addPragma(ident"importc")
  when libgit2LinkMode == "dynlib":
    result.addPragma(nnkExprColonExpr.newTree(
      ident"dynlib", newLit(libgit2Lib)))

  elif libgit2LinkMode in ["static", "dlink"]:
    # Default dynamic or static linking, handled by user via `{.passl.}`
    # etc.
    discard

  else:
    {.error: "Invalid libgit2 link mode specified" &
      " expected 'dynlib', 'static' or 'dlink', but got " &
      libgit2LinkMode.}

type
  git_iterator* {.importc, incompleteStruct.} = object
