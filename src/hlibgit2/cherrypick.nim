import "./types.nim"
import "./merge.nim"
import "./checkout.nim"

type
  git_cherrypick_options* {.bycopy.} = object
    version       *: cuint
    mainline      *: cuint
    merge_opts    *: git_cherrypick_options_merge_opts_field
    checkout_opts *: git_checkout_options

  git_cherrypick_options_merge_opts_field* {.bycopy.} = object




proc git_cherrypick_options_init*(opts: ptr git_cherrypick_options, version: cuint): cint {.importc: "git_cherrypick_options_init".}

proc git_cherrypick_commit*(
    `out`: ptr ptr git_index,
    repo: ptr git_repository,
    cherrypick_commit: ptr git_commit,
    our_commit: ptr git_commit,
    mainline: cuint,
    merge_options: ptr git_merge_options,
): cint {.importc: "git_cherrypick_commit".}

proc git_cherrypick*(
    repo: ptr git_repository,
    commit: ptr git_commit,
    cherrypick_options: ptr git_cherrypick_options,
): cint {.importc: "git_cherrypick".}