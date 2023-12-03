import "./libgit2_config.nim" ## From gen file
import "./oid.nim"
import "./buffer.nim"
import "./types.nim"

type
  git_repository_init_options* {.bycopy.} = object
    version       *: cuint
    flags         *: uint32
    mode          *: uint32
    workdir_path  *: cstring
    description   *: cstring
    template_path *: cstring
    initial_head  *: cstring
    origin_url    *: cstring

  c_git_repository_open_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_REPOSITORY_OPEN_NO_SEARCH = 1 shl 0
    c_GIT_REPOSITORY_OPEN_CROSS_FS  = 1 shl 1
    c_GIT_REPOSITORY_OPEN_BARE      = 1 shl 2
    c_GIT_REPOSITORY_OPEN_NO_DOTGIT = 1 shl 3
    c_GIT_REPOSITORY_OPEN_FROM_ENV  = 1 shl 4

  git_repository_open_flag_t* = enum
    GIT_REPOSITORY_OPEN_NO_SEARCH
    GIT_REPOSITORY_OPEN_CROSS_FS
    GIT_REPOSITORY_OPEN_BARE
    GIT_REPOSITORY_OPEN_NO_DOTGIT
    GIT_REPOSITORY_OPEN_FROM_ENV

  c_git_repository_init_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_REPOSITORY_INIT_BARE              = 1 shl 0
    c_GIT_REPOSITORY_INIT_NO_REINIT         = 1 shl 1
    c_GIT_REPOSITORY_INIT_NO_DOTGIT_DIR     = 1 shl 2
    c_GIT_REPOSITORY_INIT_MKDIR             = 1 shl 3
    c_GIT_REPOSITORY_INIT_MKPATH            = 1 shl 4
    c_GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = 1 shl 5
    c_GIT_REPOSITORY_INIT_RELATIVE_GITLINK  = 1 shl 6

  git_repository_init_flag_t* = enum
    GIT_REPOSITORY_INIT_BARE
    GIT_REPOSITORY_INIT_NO_REINIT
    GIT_REPOSITORY_INIT_NO_DOTGIT_DIR
    GIT_REPOSITORY_INIT_MKDIR
    GIT_REPOSITORY_INIT_MKPATH
    GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE
    GIT_REPOSITORY_INIT_RELATIVE_GITLINK

  c_git_repository_init_mode_t* {.size: sizeof(cint).} = enum
    c_GIT_REPOSITORY_INIT_SHARED_UMASK = 0
    c_GIT_REPOSITORY_INIT_SHARED_GROUP = 1533
    c_GIT_REPOSITORY_INIT_SHARED_ALL   = 1535

  git_repository_init_mode_t* = enum
    GIT_REPOSITORY_INIT_SHARED_UMASK
    GIT_REPOSITORY_INIT_SHARED_GROUP
    GIT_REPOSITORY_INIT_SHARED_ALL

  c_git_repository_item_t* {.size: sizeof(cint).} = enum
    c_GIT_REPOSITORY_ITEM_GITDIR      = 0
    c_GIT_REPOSITORY_ITEM_WORKDIR     = 1
    c_GIT_REPOSITORY_ITEM_COMMONDIR   = 2
    c_GIT_REPOSITORY_ITEM_INDEX       = 3
    c_GIT_REPOSITORY_ITEM_OBJECTS     = 4
    c_GIT_REPOSITORY_ITEM_REFS        = 5
    c_GIT_REPOSITORY_ITEM_PACKED_REFS = 6
    c_GIT_REPOSITORY_ITEM_REMOTES     = 7
    c_GIT_REPOSITORY_ITEM_CONFIG      = 8
    c_GIT_REPOSITORY_ITEM_INFO        = 9
    c_GIT_REPOSITORY_ITEM_HOOKS       = 10
    c_GIT_REPOSITORY_ITEM_LOGS        = 11
    c_GIT_REPOSITORY_ITEM_MODULES     = 12
    c_GIT_REPOSITORY_ITEM_WORKTREES   = 13
    c_GIT_REPOSITORY_ITEM_LAST        = 14

  git_repository_item_t* = enum
    GIT_REPOSITORY_ITEM_GITDIR
    GIT_REPOSITORY_ITEM_WORKDIR
    GIT_REPOSITORY_ITEM_COMMONDIR
    GIT_REPOSITORY_ITEM_INDEX
    GIT_REPOSITORY_ITEM_OBJECTS
    GIT_REPOSITORY_ITEM_REFS
    GIT_REPOSITORY_ITEM_PACKED_REFS
    GIT_REPOSITORY_ITEM_REMOTES
    GIT_REPOSITORY_ITEM_CONFIG
    GIT_REPOSITORY_ITEM_INFO
    GIT_REPOSITORY_ITEM_HOOKS
    GIT_REPOSITORY_ITEM_LOGS
    GIT_REPOSITORY_ITEM_MODULES
    GIT_REPOSITORY_ITEM_WORKTREES
    GIT_REPOSITORY_ITEM_LAST

  c_git_repository_state_t* {.size: sizeof(cint).} = enum
    c_GIT_REPOSITORY_STATE_NONE                    = 0
    c_GIT_REPOSITORY_STATE_MERGE                   = 1
    c_GIT_REPOSITORY_STATE_REVERT                  = 2
    c_GIT_REPOSITORY_STATE_REVERT_SEQUENCE         = 3
    c_GIT_REPOSITORY_STATE_CHERRYPICK              = 4
    c_GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE     = 5
    c_GIT_REPOSITORY_STATE_BISECT                  = 6
    c_GIT_REPOSITORY_STATE_REBASE                  = 7
    c_GIT_REPOSITORY_STATE_REBASE_INTERACTIVE      = 8
    c_GIT_REPOSITORY_STATE_REBASE_MERGE            = 9
    c_GIT_REPOSITORY_STATE_APPLY_MAILBOX           = 10
    c_GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE = 11

  git_repository_state_t* = enum
    GIT_REPOSITORY_STATE_NONE
    GIT_REPOSITORY_STATE_MERGE
    GIT_REPOSITORY_STATE_REVERT
    GIT_REPOSITORY_STATE_REVERT_SEQUENCE
    GIT_REPOSITORY_STATE_CHERRYPICK
    GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE
    GIT_REPOSITORY_STATE_BISECT
    GIT_REPOSITORY_STATE_REBASE
    GIT_REPOSITORY_STATE_REBASE_INTERACTIVE
    GIT_REPOSITORY_STATE_REBASE_MERGE
    GIT_REPOSITORY_STATE_APPLY_MAILBOX
    GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE

  git_repository_fetchhead_foreach_cb* = proc (a0: cstring, a1: cstring, a2: ptr git_oid, a3: cuint, a4: pointer): cint

  git_repository_mergehead_foreach_cb* = proc (a0: ptr git_oid, a1: pointer): cint



proc git_repository_set_head_detached_from_annotated*(repo: ptr git_repository, committish: ptr git_annotated_commit): cint {.git2Proc, importc: "git_repository_set_head_detached_from_annotated".}

proc git_repository_detach_head*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_detach_head".}

proc git_repository_state*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_state".}

proc git_repository_set_namespace*(repo: ptr git_repository, nmspace: cstring): cint {.git2Proc, importc: "git_repository_set_namespace".}

proc git_repository_get_namespace*(repo: ptr git_repository): cstring {.git2Proc, importc: "git_repository_get_namespace".}

proc git_repository_is_shallow*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_is_shallow".}

proc git_repository_ident*(
    name: cstringArray,
    email: cstringArray,
    repo: ptr git_repository,
): cint {.git2Proc, importc: "git_repository_ident".}

proc git_repository_set_ident*(
    repo: ptr git_repository,
    name: cstring,
    email: cstring,
): cint {.git2Proc, importc: "git_repository_set_ident".}

proc git_repository_oid_type*(repo: ptr git_repository): git_oid_t {.git2Proc, importc: "git_repository_oid_type".}

converter toCInt*(arg: c_git_repository_open_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_repository_open_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_REPOSITORY_OPEN_NO_SEARCH: result = cint(result or 1)
      of GIT_REPOSITORY_OPEN_CROSS_FS : result = cint(result or 2)
      of GIT_REPOSITORY_OPEN_BARE     : result = cint(result or 4)
      of GIT_REPOSITORY_OPEN_NO_DOTGIT: result = cint(result or 8)
      of GIT_REPOSITORY_OPEN_FROM_ENV : result = cint(result or 16)

func `-`*(arg: c_git_repository_open_flag_t, offset: int): cint = cast[c_git_repository_open_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_repository_open_flag_t): cint = cast[c_git_repository_open_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_repository_open_flag_t, offset: int): cint = cast[c_git_repository_open_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_repository_open_flag_t): cint = cast[c_git_repository_open_flag_t](ord(arg) + offset)

converter toCInt*(arg: c_git_repository_init_flag_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_repository_init_flag_t]): cint =
  for value in items(args):
    case value:
      of GIT_REPOSITORY_INIT_BARE             : result = cint(result or 1)
      of GIT_REPOSITORY_INIT_NO_REINIT        : result = cint(result or 2)
      of GIT_REPOSITORY_INIT_NO_DOTGIT_DIR    : result = cint(result or 4)
      of GIT_REPOSITORY_INIT_MKDIR            : result = cint(result or 8)
      of GIT_REPOSITORY_INIT_MKPATH           : result = cint(result or 16)
      of GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE: result = cint(result or 32)
      of GIT_REPOSITORY_INIT_RELATIVE_GITLINK : result = cint(result or 64)

func `-`*(arg: c_git_repository_init_flag_t, offset: int): cint = cast[c_git_repository_init_flag_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_repository_init_flag_t): cint = cast[c_git_repository_init_flag_t](ord(arg) - offset)

func `+`*(arg: c_git_repository_init_flag_t, offset: int): cint = cast[c_git_repository_init_flag_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_repository_init_flag_t): cint = cast[c_git_repository_init_flag_t](ord(arg) + offset)

converter toCInt*(arg: c_git_repository_init_mode_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_repository_init_mode_t]): cint =
  for value in items(args):
    case value:
      of GIT_REPOSITORY_INIT_SHARED_UMASK: result = cint(result or 0)
      of GIT_REPOSITORY_INIT_SHARED_GROUP: result = cint(result or 1533)
      of GIT_REPOSITORY_INIT_SHARED_ALL  : result = cint(result or 1535)

func `-`*(arg: c_git_repository_init_mode_t, offset: int): cint = cast[c_git_repository_init_mode_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_repository_init_mode_t): cint = cast[c_git_repository_init_mode_t](ord(arg) - offset)

func `+`*(arg: c_git_repository_init_mode_t, offset: int): cint = cast[c_git_repository_init_mode_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_repository_init_mode_t): cint = cast[c_git_repository_init_mode_t](ord(arg) + offset)

converter toCInt*(arg: c_git_repository_item_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_repository_item_t]): cint =
  for value in items(args):
    case value:
      of GIT_REPOSITORY_ITEM_GITDIR     : result = cint(result or 0)
      of GIT_REPOSITORY_ITEM_WORKDIR    : result = cint(result or 1)
      of GIT_REPOSITORY_ITEM_COMMONDIR  : result = cint(result or 2)
      of GIT_REPOSITORY_ITEM_INDEX      : result = cint(result or 3)
      of GIT_REPOSITORY_ITEM_OBJECTS    : result = cint(result or 4)
      of GIT_REPOSITORY_ITEM_REFS       : result = cint(result or 5)
      of GIT_REPOSITORY_ITEM_PACKED_REFS: result = cint(result or 6)
      of GIT_REPOSITORY_ITEM_REMOTES    : result = cint(result or 7)
      of GIT_REPOSITORY_ITEM_CONFIG     : result = cint(result or 8)
      of GIT_REPOSITORY_ITEM_INFO       : result = cint(result or 9)
      of GIT_REPOSITORY_ITEM_HOOKS      : result = cint(result or 10)
      of GIT_REPOSITORY_ITEM_LOGS       : result = cint(result or 11)
      of GIT_REPOSITORY_ITEM_MODULES    : result = cint(result or 12)
      of GIT_REPOSITORY_ITEM_WORKTREES  : result = cint(result or 13)
      of GIT_REPOSITORY_ITEM_LAST       : result = cint(result or 14)

func `-`*(arg: c_git_repository_item_t, offset: int): cint = cast[c_git_repository_item_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_repository_item_t): cint = cast[c_git_repository_item_t](ord(arg) - offset)

func `+`*(arg: c_git_repository_item_t, offset: int): cint = cast[c_git_repository_item_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_repository_item_t): cint = cast[c_git_repository_item_t](ord(arg) + offset)

converter toCInt*(arg: c_git_repository_state_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_repository_state_t]): cint =
  for value in items(args):
    case value:
      of GIT_REPOSITORY_STATE_NONE                   : result = cint(result or 0)
      of GIT_REPOSITORY_STATE_MERGE                  : result = cint(result or 1)
      of GIT_REPOSITORY_STATE_REVERT                 : result = cint(result or 2)
      of GIT_REPOSITORY_STATE_REVERT_SEQUENCE        : result = cint(result or 3)
      of GIT_REPOSITORY_STATE_CHERRYPICK             : result = cint(result or 4)
      of GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE    : result = cint(result or 5)
      of GIT_REPOSITORY_STATE_BISECT                 : result = cint(result or 6)
      of GIT_REPOSITORY_STATE_REBASE                 : result = cint(result or 7)
      of GIT_REPOSITORY_STATE_REBASE_INTERACTIVE     : result = cint(result or 8)
      of GIT_REPOSITORY_STATE_REBASE_MERGE           : result = cint(result or 9)
      of GIT_REPOSITORY_STATE_APPLY_MAILBOX          : result = cint(result or 10)
      of GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE: result = cint(result or 11)

func `-`*(arg: c_git_repository_state_t, offset: int): cint = cast[c_git_repository_state_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_repository_state_t): cint = cast[c_git_repository_state_t](ord(arg) - offset)

func `+`*(arg: c_git_repository_state_t, offset: int): cint = cast[c_git_repository_state_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_repository_state_t): cint = cast[c_git_repository_state_t](ord(arg) + offset)

proc git_repository_open*(`out`: ptr ptr git_repository, path: cstring): cint {.git2Proc, importc: "git_repository_open".}

proc git_repository_open_from_worktree*(`out`: ptr ptr git_repository, wt: ptr git_worktree): cint {.git2Proc, importc: "git_repository_open_from_worktree".}

proc git_repository_wrap_odb*(`out`: ptr ptr git_repository, odb: ptr git_odb): cint {.git2Proc, importc: "git_repository_wrap_odb".}

proc git_repository_discover*(
    `out`: ptr git_buf,
    start_path: cstring,
    across_fs: cint,
    ceiling_dirs: cstring,
): cint {.git2Proc, importc: "git_repository_discover".}

proc git_repository_open_ext*(
    `out`: ptr ptr git_repository,
    path: cstring,
    flags: cuint,
    ceiling_dirs: cstring,
): cint {.git2Proc, importc: "git_repository_open_ext".}

proc git_repository_open_bare*(`out`: ptr ptr git_repository, bare_path: cstring): cint {.git2Proc, importc: "git_repository_open_bare".}

proc git_repository_free*(repo: ptr git_repository): void {.git2Proc, importc: "git_repository_free".}

proc git_repository_init*(
    `out`: ptr ptr git_repository,
    path: cstring,
    is_bare: cuint,
): cint {.git2Proc, importc: "git_repository_init".}

proc git_repository_init_options_init*(opts: ptr git_repository_init_options, version: cuint): cint {.git2Proc, importc: "git_repository_init_options_init".}

proc git_repository_init_ext*(
    `out`: ptr ptr git_repository,
    repo_path: cstring,
    opts: ptr git_repository_init_options,
): cint {.git2Proc, importc: "git_repository_init_ext".}

proc git_repository_head*(`out`: ptr ptr git_reference, repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_head".}

proc git_repository_head_for_worktree*(
    `out`: ptr ptr git_reference,
    repo: ptr git_repository,
    name: cstring,
): cint {.git2Proc, importc: "git_repository_head_for_worktree".}

proc git_repository_head_detached*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_head_detached".}

proc git_repository_head_detached_for_worktree*(repo: ptr git_repository, name: cstring): cint {.git2Proc, importc: "git_repository_head_detached_for_worktree".}

proc git_repository_head_unborn*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_head_unborn".}

proc git_repository_is_empty*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_is_empty".}

proc git_repository_item_path*(
    `out`: ptr git_buf,
    repo: ptr git_repository,
    item: git_repository_item_t,
): cint {.git2Proc, importc: "git_repository_item_path".}

proc git_repository_path*(repo: ptr git_repository): cstring {.git2Proc, importc: "git_repository_path".}

proc git_repository_workdir*(repo: ptr git_repository): cstring {.git2Proc, importc: "git_repository_workdir".}

proc git_repository_commondir*(repo: ptr git_repository): cstring {.git2Proc, importc: "git_repository_commondir".}

proc git_repository_set_workdir*(
    repo: ptr git_repository,
    workdir: cstring,
    update_gitlink: cint,
): cint {.git2Proc, importc: "git_repository_set_workdir".}

proc git_repository_is_bare*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_is_bare".}

proc git_repository_is_worktree*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_is_worktree".}

proc git_repository_config*(`out`: ptr ptr git_config, repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_config".}

proc git_repository_config_snapshot*(`out`: ptr ptr git_config, repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_config_snapshot".}

proc git_repository_odb*(`out`: ptr ptr git_odb, repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_odb".}

proc git_repository_refdb*(`out`: ptr ptr git_refdb, repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_refdb".}

proc git_repository_index*(`out`: ptr ptr git_index, repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_index".}

proc git_repository_message*(`out`: ptr git_buf, repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_message".}

proc git_repository_message_remove*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_message_remove".}

proc git_repository_state_cleanup*(repo: ptr git_repository): cint {.git2Proc, importc: "git_repository_state_cleanup".}

proc git_repository_fetchhead_foreach*(
    repo: ptr git_repository,
    callback: git_repository_fetchhead_foreach_cb,
    payload: pointer,
): cint {.git2Proc, importc: "git_repository_fetchhead_foreach".}

proc git_repository_mergehead_foreach*(
    repo: ptr git_repository,
    callback: git_repository_mergehead_foreach_cb,
    payload: pointer,
): cint {.git2Proc, importc: "git_repository_mergehead_foreach".}

proc git_repository_hashfile*(
    `out`: ptr git_oid,
    repo: ptr git_repository,
    path: cstring,
    `type`: git_object_t,
    as_path: cstring,
): cint {.git2Proc, importc: "git_repository_hashfile".}

proc git_repository_set_head*(repo: ptr git_repository, refname: cstring): cint {.git2Proc, importc: "git_repository_set_head".}

proc git_repository_set_head_detached*(repo: ptr git_repository, committish: ptr git_oid): cint {.git2Proc, importc: "git_repository_set_head_detached".}