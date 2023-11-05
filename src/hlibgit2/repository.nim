{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./oid,
  ./types

type
  c_git_repository_init_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_REPOSITORY_INIT_BARE              = 1 shl 0
    c_GIT_REPOSITORY_INIT_NO_REINIT         = 1 shl 1
    c_GIT_REPOSITORY_INIT_NO_DOTGIT_DIR     = 1 shl 2
    c_GIT_REPOSITORY_INIT_MKDIR             = 1 shl 3
    c_GIT_REPOSITORY_INIT_MKPATH            = 1 shl 4
    c_GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = 1 shl 5
    c_GIT_REPOSITORY_INIT_RELATIVE_GITLINK  = 1 shl 6

  c_git_repository_init_mode_t* {.size: sizeof(cint).} = enum
    c_GIT_REPOSITORY_INIT_SHARED_UMASK = 0
    c_GIT_REPOSITORY_INIT_SHARED_GROUP = 2775
    c_GIT_REPOSITORY_INIT_SHARED_ALL   = 2777

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

  c_git_repository_open_flag_t* {.size: sizeof(cint).} = enum
    c_GIT_REPOSITORY_OPEN_NO_SEARCH = 1 shl 0
    c_GIT_REPOSITORY_OPEN_CROSS_FS  = 1 shl 1
    c_GIT_REPOSITORY_OPEN_BARE      = 1 shl 2
    c_GIT_REPOSITORY_OPEN_NO_DOTGIT = 1 shl 3
    c_GIT_REPOSITORY_OPEN_FROM_ENV  = 1 shl 4

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

  git_repository_fetchhead_foreach_cb* = proc(ref_name:   cstring,
                                              remote_url: cstring,
                                              oid:        ptr git_oid,
                                              is_merge:   cuint,
                                              payload:    pointer): cint{.cdecl.}

  git_repository_init_flag_t* {.size: sizeof(cint).} = enum
    GIT_REPOSITORY_INIT_BARE
    GIT_REPOSITORY_INIT_NO_REINIT
    GIT_REPOSITORY_INIT_NO_DOTGIT_DIR
    GIT_REPOSITORY_INIT_MKDIR
    GIT_REPOSITORY_INIT_MKPATH
    GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE
    GIT_REPOSITORY_INIT_RELATIVE_GITLINK

  git_repository_init_mode_t* = enum
    GIT_REPOSITORY_INIT_SHARED_UMASK
    GIT_REPOSITORY_INIT_SHARED_GROUP
    GIT_REPOSITORY_INIT_SHARED_ALL

  git_repository_init_options* {.bycopy, header: "<git2/repository.h>", importc.} = object
    version*:       cuint
    flags*:         uint32
    mode*:          uint32
    workdir_path*:  cstring
    description*:   cstring
    template_path*: cstring
    initial_head*:  cstring
    origin_url*:    cstring

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

  git_repository_mergehead_foreach_cb* = proc(oid:     ptr git_oid,
                                              payload: pointer): cint{.cdecl.}

  git_repository_open_flag_t* {.size: sizeof(cint).} = enum
    GIT_REPOSITORY_OPEN_NO_SEARCH
    GIT_REPOSITORY_OPEN_CROSS_FS
    GIT_REPOSITORY_OPEN_BARE
    GIT_REPOSITORY_OPEN_NO_DOTGIT
    GIT_REPOSITORY_OPEN_FROM_ENV

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


proc git_repository_open*(
    arg_out: ptr ptr git_repository,
    path:    cstring
  ): cint {.git2Proc, importc.}



proc git_repository_open_from_worktree*(
    arg_out: ptr ptr git_repository,
    wt:      ptr git_worktree
  ): cint {.git2Proc, importc.}



proc git_repository_wrap_odb*(
    arg_out: ptr ptr git_repository,
    odb:     ptr git_odb
  ): cint {.git2Proc, importc.}



proc git_repository_discover*(
    arg_out:      ptr git_buf,
    start_path:   cstring,
    across_fs:    cint,
    ceiling_dirs: cstring
  ): cint {.git2Proc, importc.}



proc to_c_git_repository_open_flag_t*(
    arg: git_repository_open_flag_t
  ): c_git_repository_open_flag_t =
  case arg:
    of GIT_REPOSITORY_OPEN_NO_SEARCH: c_GIT_REPOSITORY_OPEN_NO_SEARCH
    of GIT_REPOSITORY_OPEN_CROSS_FS:  c_GIT_REPOSITORY_OPEN_CROSS_FS
    of GIT_REPOSITORY_OPEN_BARE:      c_GIT_REPOSITORY_OPEN_BARE
    of GIT_REPOSITORY_OPEN_NO_DOTGIT: c_GIT_REPOSITORY_OPEN_NO_DOTGIT
    of GIT_REPOSITORY_OPEN_FROM_ENV:  c_GIT_REPOSITORY_OPEN_FROM_ENV


converter to_git_repository_open_flag_t*(
    arg: c_git_repository_open_flag_t
  ): git_repository_open_flag_t =
  case arg:
    of c_GIT_REPOSITORY_OPEN_NO_SEARCH: GIT_REPOSITORY_OPEN_NO_SEARCH
    of c_GIT_REPOSITORY_OPEN_CROSS_FS:  GIT_REPOSITORY_OPEN_CROSS_FS
    of c_GIT_REPOSITORY_OPEN_BARE:      GIT_REPOSITORY_OPEN_BARE
    of c_GIT_REPOSITORY_OPEN_NO_DOTGIT: GIT_REPOSITORY_OPEN_NO_DOTGIT
    of c_GIT_REPOSITORY_OPEN_FROM_ENV:  GIT_REPOSITORY_OPEN_FROM_ENV


converter toCint*(arg: c_git_repository_open_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_repository_open_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_repository_open_flag_t(arg)))

func `+`*(
    arg:    c_git_repository_open_flag_t,
    offset: int
  ): c_git_repository_open_flag_t =
  cast[c_git_repository_open_flag_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_repository_open_flag_t
  ): c_git_repository_open_flag_t =
  cast[c_git_repository_open_flag_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_repository_open_flag_t,
    offset: int
  ): c_git_repository_open_flag_t =
  cast[c_git_repository_open_flag_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_repository_open_flag_t
  ): c_git_repository_open_flag_t =
  cast[c_git_repository_open_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_repository_open_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc git_repository_open_ext*(
    arg_out:      ptr ptr git_repository,
    path:         cstring,
    flags:        cuint,
    ceiling_dirs: cstring
  ): cint {.git2Proc, importc.}



proc git_repository_open_bare*(
    arg_out:   ptr ptr git_repository,
    bare_path: cstring
  ): cint {.git2Proc, importc.}



proc git_repository_free*(repo: ptr git_repository): void {.git2Proc, importc.}



proc git_repository_init*(
    arg_out: ptr ptr git_repository,
    path:    cstring,
    is_bare: cuint
  ): cint {.git2Proc, importc.}



proc to_c_git_repository_init_flag_t*(
    arg: git_repository_init_flag_t
  ): c_git_repository_init_flag_t =
  case arg:
    of GIT_REPOSITORY_INIT_BARE:              c_GIT_REPOSITORY_INIT_BARE
    of GIT_REPOSITORY_INIT_NO_REINIT:         c_GIT_REPOSITORY_INIT_NO_REINIT
    of GIT_REPOSITORY_INIT_NO_DOTGIT_DIR:     c_GIT_REPOSITORY_INIT_NO_DOTGIT_DIR
    of GIT_REPOSITORY_INIT_MKDIR:             c_GIT_REPOSITORY_INIT_MKDIR
    of GIT_REPOSITORY_INIT_MKPATH:            c_GIT_REPOSITORY_INIT_MKPATH
    of GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE: c_GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE
    of GIT_REPOSITORY_INIT_RELATIVE_GITLINK:  c_GIT_REPOSITORY_INIT_RELATIVE_GITLINK


converter to_git_repository_init_flag_t*(
    arg: c_git_repository_init_flag_t
  ): git_repository_init_flag_t =
  case arg:
    of c_GIT_REPOSITORY_INIT_BARE:              GIT_REPOSITORY_INIT_BARE
    of c_GIT_REPOSITORY_INIT_NO_REINIT:         GIT_REPOSITORY_INIT_NO_REINIT
    of c_GIT_REPOSITORY_INIT_NO_DOTGIT_DIR:     GIT_REPOSITORY_INIT_NO_DOTGIT_DIR
    of c_GIT_REPOSITORY_INIT_MKDIR:             GIT_REPOSITORY_INIT_MKDIR
    of c_GIT_REPOSITORY_INIT_MKPATH:            GIT_REPOSITORY_INIT_MKPATH
    of c_GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE: GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE
    of c_GIT_REPOSITORY_INIT_RELATIVE_GITLINK:  GIT_REPOSITORY_INIT_RELATIVE_GITLINK


converter toCint*(arg: c_git_repository_init_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_repository_init_flag_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_repository_init_flag_t(arg)))

func `+`*(
    arg:    c_git_repository_init_flag_t,
    offset: int
  ): c_git_repository_init_flag_t =
  cast[c_git_repository_init_flag_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_repository_init_flag_t
  ): c_git_repository_init_flag_t =
  cast[c_git_repository_init_flag_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_repository_init_flag_t,
    offset: int
  ): c_git_repository_init_flag_t =
  cast[c_git_repository_init_flag_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_repository_init_flag_t
  ): c_git_repository_init_flag_t =
  cast[c_git_repository_init_flag_t](ord(arg) - offset)


converter toCint*(args: set[git_repository_init_flag_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc to_c_git_repository_init_mode_t*(
    arg: git_repository_init_mode_t
  ): c_git_repository_init_mode_t =
  case arg:
    of GIT_REPOSITORY_INIT_SHARED_UMASK: c_GIT_REPOSITORY_INIT_SHARED_UMASK
    of GIT_REPOSITORY_INIT_SHARED_GROUP: c_GIT_REPOSITORY_INIT_SHARED_GROUP
    of GIT_REPOSITORY_INIT_SHARED_ALL:   c_GIT_REPOSITORY_INIT_SHARED_ALL


converter to_git_repository_init_mode_t*(
    arg: c_git_repository_init_mode_t
  ): git_repository_init_mode_t =
  case arg:
    of c_GIT_REPOSITORY_INIT_SHARED_UMASK: GIT_REPOSITORY_INIT_SHARED_UMASK
    of c_GIT_REPOSITORY_INIT_SHARED_GROUP: GIT_REPOSITORY_INIT_SHARED_GROUP
    of c_GIT_REPOSITORY_INIT_SHARED_ALL:   GIT_REPOSITORY_INIT_SHARED_ALL


converter toCint*(arg: c_git_repository_init_mode_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_repository_init_mode_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_repository_init_mode_t(arg)))

func `+`*(
    arg:    c_git_repository_init_mode_t,
    offset: int
  ): c_git_repository_init_mode_t =
  cast[c_git_repository_init_mode_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_repository_init_mode_t
  ): c_git_repository_init_mode_t =
  cast[c_git_repository_init_mode_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_repository_init_mode_t,
    offset: int
  ): c_git_repository_init_mode_t =
  cast[c_git_repository_init_mode_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_repository_init_mode_t
  ): c_git_repository_init_mode_t =
  cast[c_git_repository_init_mode_t](ord(arg) - offset)


proc git_repository_init_options_init*(
    opts:    ptr git_repository_init_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_repository_init_ext*(
    arg_out:   ptr ptr git_repository,
    repo_path: cstring,
    opts:      ptr git_repository_init_options
  ): cint {.git2Proc, importc.}



proc git_repository_head*(
    arg_out: ptr ptr git_reference,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_head_for_worktree*(
    arg_out: ptr ptr git_reference,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_repository_head_detached*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_head_detached_for_worktree*(
    repo: ptr git_repository,
    name: cstring
  ): cint {.git2Proc, importc.}



proc git_repository_head_unborn*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_is_empty*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc to_c_git_repository_item_t*(
    arg: git_repository_item_t
  ): c_git_repository_item_t =
  case arg:
    of GIT_REPOSITORY_ITEM_GITDIR:      c_GIT_REPOSITORY_ITEM_GITDIR
    of GIT_REPOSITORY_ITEM_WORKDIR:     c_GIT_REPOSITORY_ITEM_WORKDIR
    of GIT_REPOSITORY_ITEM_COMMONDIR:   c_GIT_REPOSITORY_ITEM_COMMONDIR
    of GIT_REPOSITORY_ITEM_INDEX:       c_GIT_REPOSITORY_ITEM_INDEX
    of GIT_REPOSITORY_ITEM_OBJECTS:     c_GIT_REPOSITORY_ITEM_OBJECTS
    of GIT_REPOSITORY_ITEM_REFS:        c_GIT_REPOSITORY_ITEM_REFS
    of GIT_REPOSITORY_ITEM_PACKED_REFS: c_GIT_REPOSITORY_ITEM_PACKED_REFS
    of GIT_REPOSITORY_ITEM_REMOTES:     c_GIT_REPOSITORY_ITEM_REMOTES
    of GIT_REPOSITORY_ITEM_CONFIG:      c_GIT_REPOSITORY_ITEM_CONFIG
    of GIT_REPOSITORY_ITEM_INFO:        c_GIT_REPOSITORY_ITEM_INFO
    of GIT_REPOSITORY_ITEM_HOOKS:       c_GIT_REPOSITORY_ITEM_HOOKS
    of GIT_REPOSITORY_ITEM_LOGS:        c_GIT_REPOSITORY_ITEM_LOGS
    of GIT_REPOSITORY_ITEM_MODULES:     c_GIT_REPOSITORY_ITEM_MODULES
    of GIT_REPOSITORY_ITEM_WORKTREES:   c_GIT_REPOSITORY_ITEM_WORKTREES
    of GIT_REPOSITORY_ITEM_LAST:        c_GIT_REPOSITORY_ITEM_LAST


converter to_git_repository_item_t*(
    arg: c_git_repository_item_t
  ): git_repository_item_t =
  case arg:
    of c_GIT_REPOSITORY_ITEM_GITDIR:      GIT_REPOSITORY_ITEM_GITDIR
    of c_GIT_REPOSITORY_ITEM_WORKDIR:     GIT_REPOSITORY_ITEM_WORKDIR
    of c_GIT_REPOSITORY_ITEM_COMMONDIR:   GIT_REPOSITORY_ITEM_COMMONDIR
    of c_GIT_REPOSITORY_ITEM_INDEX:       GIT_REPOSITORY_ITEM_INDEX
    of c_GIT_REPOSITORY_ITEM_OBJECTS:     GIT_REPOSITORY_ITEM_OBJECTS
    of c_GIT_REPOSITORY_ITEM_REFS:        GIT_REPOSITORY_ITEM_REFS
    of c_GIT_REPOSITORY_ITEM_PACKED_REFS: GIT_REPOSITORY_ITEM_PACKED_REFS
    of c_GIT_REPOSITORY_ITEM_REMOTES:     GIT_REPOSITORY_ITEM_REMOTES
    of c_GIT_REPOSITORY_ITEM_CONFIG:      GIT_REPOSITORY_ITEM_CONFIG
    of c_GIT_REPOSITORY_ITEM_INFO:        GIT_REPOSITORY_ITEM_INFO
    of c_GIT_REPOSITORY_ITEM_HOOKS:       GIT_REPOSITORY_ITEM_HOOKS
    of c_GIT_REPOSITORY_ITEM_LOGS:        GIT_REPOSITORY_ITEM_LOGS
    of c_GIT_REPOSITORY_ITEM_MODULES:     GIT_REPOSITORY_ITEM_MODULES
    of c_GIT_REPOSITORY_ITEM_WORKTREES:   GIT_REPOSITORY_ITEM_WORKTREES
    of c_GIT_REPOSITORY_ITEM_LAST:        GIT_REPOSITORY_ITEM_LAST


converter toCint*(arg: c_git_repository_item_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_repository_item_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_repository_item_t(arg)))

func `+`*(arg: c_git_repository_item_t, offset: int): c_git_repository_item_t =
  cast[c_git_repository_item_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_repository_item_t): c_git_repository_item_t =
  cast[c_git_repository_item_t](ord(arg) + offset)

func `-`*(arg: c_git_repository_item_t, offset: int): c_git_repository_item_t =
  cast[c_git_repository_item_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_repository_item_t): c_git_repository_item_t =
  cast[c_git_repository_item_t](ord(arg) - offset)


proc git_repository_item_path*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository,
    item:    c_git_repository_item_t
  ): cint {.git2Proc, importc.}



proc git_repository_path*(
    repo: ptr git_repository
  ): cstring {.git2Proc, importc.}



proc git_repository_workdir*(
    repo: ptr git_repository
  ): cstring {.git2Proc, importc.}



proc git_repository_commondir*(
    repo: ptr git_repository
  ): cstring {.git2Proc, importc.}



proc git_repository_set_workdir*(
    repo:           ptr git_repository,
    workdir:        cstring,
    update_gitlink: cint
  ): cint {.git2Proc, importc.}



proc git_repository_is_bare*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_is_worktree*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_config*(
    arg_out: ptr ptr git_config,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_config_snapshot*(
    arg_out: ptr ptr git_config,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_odb*(
    arg_out: ptr ptr git_odb,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_refdb*(
    arg_out: ptr ptr git_refdb,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_index*(
    arg_out: ptr ptr git_index,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_message*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_message_remove*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_state_cleanup*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_fetchhead_foreach*(
    repo:     ptr git_repository,
    callback: git_repository_fetchhead_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_repository_mergehead_foreach*(
    repo:     ptr git_repository,
    callback: git_repository_mergehead_foreach_cb,
    payload:  pointer
  ): cint {.git2Proc, importc.}



proc git_repository_hashfile*(
    arg_out:  ptr git_oid,
    repo:     ptr git_repository,
    path:     cstring,
    arg_type: c_git_object_t,
    as_path:  cstring
  ): cint {.git2Proc, importc.}



proc git_repository_set_head*(
    repo:     ptr git_repository,
    refname1: cstring
  ): cint {.git2Proc, importc.}



proc git_repository_set_head_detached*(
    repo:      ptr git_repository,
    commitish: ptr git_oid
  ): cint {.git2Proc, importc.}



proc git_repository_set_head_detached_from_annotated*(
    repo:      ptr git_repository,
    commitish: ptr git_annotated_commit
  ): cint {.git2Proc, importc.}



proc git_repository_detach_head*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc to_c_git_repository_state_t*(
    arg: git_repository_state_t
  ): c_git_repository_state_t =
  case arg:
    of GIT_REPOSITORY_STATE_NONE:                    c_GIT_REPOSITORY_STATE_NONE
    of GIT_REPOSITORY_STATE_MERGE:                   c_GIT_REPOSITORY_STATE_MERGE
    of GIT_REPOSITORY_STATE_REVERT:                  c_GIT_REPOSITORY_STATE_REVERT
    of GIT_REPOSITORY_STATE_REVERT_SEQUENCE:         c_GIT_REPOSITORY_STATE_REVERT_SEQUENCE
    of GIT_REPOSITORY_STATE_CHERRYPICK:              c_GIT_REPOSITORY_STATE_CHERRYPICK
    of GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE:     c_GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE
    of GIT_REPOSITORY_STATE_BISECT:                  c_GIT_REPOSITORY_STATE_BISECT
    of GIT_REPOSITORY_STATE_REBASE:                  c_GIT_REPOSITORY_STATE_REBASE
    of GIT_REPOSITORY_STATE_REBASE_INTERACTIVE:      c_GIT_REPOSITORY_STATE_REBASE_INTERACTIVE
    of GIT_REPOSITORY_STATE_REBASE_MERGE:            c_GIT_REPOSITORY_STATE_REBASE_MERGE
    of GIT_REPOSITORY_STATE_APPLY_MAILBOX:           c_GIT_REPOSITORY_STATE_APPLY_MAILBOX
    of GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE: c_GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE


converter to_git_repository_state_t*(
    arg: c_git_repository_state_t
  ): git_repository_state_t =
  case arg:
    of c_GIT_REPOSITORY_STATE_NONE:                    GIT_REPOSITORY_STATE_NONE
    of c_GIT_REPOSITORY_STATE_MERGE:                   GIT_REPOSITORY_STATE_MERGE
    of c_GIT_REPOSITORY_STATE_REVERT:                  GIT_REPOSITORY_STATE_REVERT
    of c_GIT_REPOSITORY_STATE_REVERT_SEQUENCE:         GIT_REPOSITORY_STATE_REVERT_SEQUENCE
    of c_GIT_REPOSITORY_STATE_CHERRYPICK:              GIT_REPOSITORY_STATE_CHERRYPICK
    of c_GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE:     GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE
    of c_GIT_REPOSITORY_STATE_BISECT:                  GIT_REPOSITORY_STATE_BISECT
    of c_GIT_REPOSITORY_STATE_REBASE:                  GIT_REPOSITORY_STATE_REBASE
    of c_GIT_REPOSITORY_STATE_REBASE_INTERACTIVE:      GIT_REPOSITORY_STATE_REBASE_INTERACTIVE
    of c_GIT_REPOSITORY_STATE_REBASE_MERGE:            GIT_REPOSITORY_STATE_REBASE_MERGE
    of c_GIT_REPOSITORY_STATE_APPLY_MAILBOX:           GIT_REPOSITORY_STATE_APPLY_MAILBOX
    of c_GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE: GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE


converter toCint*(arg: c_git_repository_state_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_repository_state_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_repository_state_t(arg)))

func `+`*(
    arg:    c_git_repository_state_t,
    offset: int
  ): c_git_repository_state_t =
  cast[c_git_repository_state_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_repository_state_t
  ): c_git_repository_state_t =
  cast[c_git_repository_state_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_repository_state_t,
    offset: int
  ): c_git_repository_state_t =
  cast[c_git_repository_state_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_repository_state_t
  ): c_git_repository_state_t =
  cast[c_git_repository_state_t](ord(arg) - offset)


proc git_repository_state*(repo: ptr git_repository): cint {.git2Proc, importc.}



proc git_repository_set_namespace*(
    repo:    ptr git_repository,
    nmspace: cstring
  ): cint {.git2Proc, importc.}



proc git_repository_get_namespace*(
    repo: ptr git_repository
  ): cstring {.git2Proc, importc.}



proc git_repository_is_shallow*(
    repo: ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_ident*(
    name:  ptr cstring,
    email: ptr cstring,
    repo:  ptr git_repository
  ): cint {.git2Proc, importc.}



proc git_repository_set_ident*(
    repo:  ptr git_repository,
    name:  cstring,
    email: cstring
  ): cint {.git2Proc, importc.}



