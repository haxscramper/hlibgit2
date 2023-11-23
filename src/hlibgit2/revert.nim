import "./checkout.nim"
import "./libgit2_config.nim"
import "./merge.nim"
import "./types.nim"

type
  git_revert_options* {.importc, bycopy.} = object
    version       *: cuint
    mainline      *: cuint
    merge_opts    *: git_merge_options
    checkout_opts *: git_checkout_options



proc git_revert*(repo: `ptr` git_repository, commit: `ptr` git_commit, given_opts: `ptr` git_revert_options): cint {.git2Proc, importc.}

proc git_revert_options_init*(opts: `ptr` git_revert_options, version: cuint): cint {.git2Proc, importc.}

proc git_revert_commit*(`out`: `ptr` git_index, repo: `ptr` git_repository, revert_commit: `ptr` git_commit, our_commit: `ptr` git_commit, mainline: cuint, merge_options: `ptr` git_merge_options): cint {.git2Proc, importc.}