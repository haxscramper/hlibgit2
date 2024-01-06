import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./merge.nim"
import "./checkout.nim"

type
  git_cherrypick_options* {.header: "<cherrypick.h>", importc, bycopy.} = object
    version       *: cuint
    mainline      *: cuint
    merge_opts    *: git_merge_options
    checkout_opts *: git_checkout_options



proc git_cherrypick_options_init*(opts: ptr git_cherrypick_options, version: cuint): cint {.importc: "git_cherrypick_options_init", header: "<cherrypick.h>".}

proc git_cherrypick_commit*(
    `out`: ptr ptr git_index,
    repo: ptr git_repository,
    cherrypick_commit: ptr git_commit,
    our_commit: ptr git_commit,
    mainline: cuint,
    merge_options: ptr git_merge_options,
): cint {.importc: "git_cherrypick_commit", header: "<cherrypick.h>".}

proc git_cherrypick*(
    repo: ptr git_repository,
    commit: ptr git_commit,
    cherrypick_options: ptr git_cherrypick_options,
): cint {.importc: "git_cherrypick", header: "<cherrypick.h>".}