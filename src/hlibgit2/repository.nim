{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./libgit2_config,
  ./oid,
  ./types

type
  git_repository_fetchhead_foreach_cb* = proc(ref_name: cstring, remote_url: cstring, oid: ptr git_oid, is_merge: cuint, payload: pointer): cint{.cdecl.}
   
  git_repository_fetchhead_foreach_cbNim* = proc(ref_name: cstring, remote_url: cstring, oid: ptr git_oid, is_merge: cuint): cint
   
  git_repository_init_flag_t* = enum
    GIT_REPOSITORY_INIT_BARE = 1
    GIT_REPOSITORY_INIT_NO_REINIT = 2
    GIT_REPOSITORY_INIT_NO_DOTGIT_DIR = 4
    GIT_REPOSITORY_INIT_MKDIR = 8
    GIT_REPOSITORY_INIT_MKPATH = 16
    GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = 32
    GIT_REPOSITORY_INIT_RELATIVE_GITLINK = 64
   
  git_repository_init_mode_t* = enum
    GIT_REPOSITORY_INIT_SHARED_UMASK = 0
    GIT_REPOSITORY_INIT_SHARED_GROUP = 2775
    GIT_REPOSITORY_INIT_SHARED_ALL = 2777
   
  git_repository_init_options* {.bycopy, header: "<git2/repository.h>", importc.} = object
    version*: cuint
    flags*: uint32
    mode*: uint32
    workdir_path*: cstring
    description*: cstring
    template_path*: cstring
    initial_head*: cstring
    origin_url*: cstring
   
  git_repository_item_t* = enum
    GIT_REPOSITORY_ITEM_GITDIR = 0
    GIT_REPOSITORY_ITEM_WORKDIR = 1
    GIT_REPOSITORY_ITEM_COMMONDIR = 2
    GIT_REPOSITORY_ITEM_INDEX = 3
    GIT_REPOSITORY_ITEM_OBJECTS = 4
    GIT_REPOSITORY_ITEM_REFS = 5
    GIT_REPOSITORY_ITEM_PACKED_REFS = 6
    GIT_REPOSITORY_ITEM_REMOTES = 7
    GIT_REPOSITORY_ITEM_CONFIG = 8
    GIT_REPOSITORY_ITEM_INFO = 9
    GIT_REPOSITORY_ITEM_HOOKS = 10
    GIT_REPOSITORY_ITEM_LOGS = 11
    GIT_REPOSITORY_ITEM_MODULES = 12
    GIT_REPOSITORY_ITEM_WORKTREES = 13
    GIT_REPOSITORY_ITEM_LAST = 14
   
  git_repository_mergehead_foreach_cb* = proc(oid: ptr git_oid, payload: pointer): cint{.cdecl.}
   
  git_repository_mergehead_foreach_cbNim* = proc(oid: ptr git_oid): cint
   
  git_repository_open_flag_t* = enum
    GIT_REPOSITORY_OPEN_NO_SEARCH = 1
    GIT_REPOSITORY_OPEN_CROSS_FS = 2
    GIT_REPOSITORY_OPEN_BARE = 4
    GIT_REPOSITORY_OPEN_NO_DOTGIT = 8
    GIT_REPOSITORY_OPEN_FROM_ENV = 16
   
  git_repository_state_t* = enum
    GIT_REPOSITORY_STATE_NONE = 0
    GIT_REPOSITORY_STATE_MERGE = 1
    GIT_REPOSITORY_STATE_REVERT = 2
    GIT_REPOSITORY_STATE_REVERT_SEQUENCE = 3
    GIT_REPOSITORY_STATE_CHERRYPICK = 4
    GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE = 5
    GIT_REPOSITORY_STATE_BISECT = 6
    GIT_REPOSITORY_STATE_REBASE = 7
    GIT_REPOSITORY_STATE_REBASE_INTERACTIVE = 8
    GIT_REPOSITORY_STATE_REBASE_MERGE = 9
    GIT_REPOSITORY_STATE_APPLY_MAILBOX = 10
    GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE = 11
   

proc git_repository_open*(
    arg_out: ptr ptr git_repository,
    path:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_open_from_worktree*(
    arg_out: ptr ptr git_repository,
    wt:      ptr git_worktree
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_wrap_odb*(
    arg_out: ptr ptr git_repository,
    odb:     ptr git_odb
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_discover*(
    arg_out:      ptr git_buf,
    start_path:   cstring,
    across_fs:    cint,
    ceiling_dirs: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_open_ext*(
    arg_out:      ptr ptr git_repository,
    path:         cstring,
    flags:        cuint,
    ceiling_dirs: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_open_bare*(
    arg_out:   ptr ptr git_repository,
    bare_path: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_free*(
    repo: ptr git_repository
  ): void {.dynlib: libgit2Dl, importc.}


proc git_repository_init*(
    arg_out: ptr ptr git_repository,
    path:    cstring,
    is_bare: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_init_options_init*(
    opts:    ptr git_repository_init_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_init_ext*(
    arg_out:   ptr ptr git_repository,
    repo_path: cstring,
    opts:      ptr git_repository_init_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_head*(
    arg_out: ptr ptr git_reference,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_head_for_worktree*(
    arg_out: ptr ptr git_reference,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_head_detached*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_head_detached_for_worktree*(
    repo: ptr git_repository,
    name: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_head_unborn*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_is_empty*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_item_path*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository,
    item:    git_repository_item_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_path*(
    repo: ptr git_repository
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_repository_workdir*(
    repo: ptr git_repository
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_repository_commondir*(
    repo: ptr git_repository
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_repository_set_workdir*(
    repo:           ptr git_repository,
    workdir:        cstring,
    update_gitlink: cint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_is_bare*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_is_worktree*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_config*(
    arg_out: ptr ptr git_config,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_config_snapshot*(
    arg_out: ptr ptr git_config,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_odb*(
    arg_out: ptr ptr git_odb,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_refdb*(
    arg_out: ptr ptr git_refdb,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_index*(
    arg_out: ptr ptr git_index,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_message*(
    arg_out: ptr git_buf,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_message_remove*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_state_cleanup*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_fetchhead_foreach*(
    repo:     ptr git_repository,
    callback: git_repository_fetchhead_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_mergehead_foreach*(
    repo:     ptr git_repository,
    callback: git_repository_mergehead_foreach_cb,
    payload:  pointer
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_hashfile*(
    arg_out:  ptr git_oid,
    repo:     ptr git_repository,
    path:     cstring,
    arg_type: git_object_t,
    as_path:  cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_set_head*(
    repo:    ptr git_repository,
    refname: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_set_head_detached*(
    repo:      ptr git_repository,
    commitish: ptr git_oid
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_set_head_detached_from_annotated*(
    repo:      ptr git_repository,
    commitish: ptr git_annotated_commit
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_detach_head*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_state*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_set_namespace*(
    repo:    ptr git_repository,
    nmspace: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_get_namespace*(
    repo: ptr git_repository
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_repository_is_shallow*(
    repo: ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_ident*(
    name:  ptr cstring,
    email: ptr cstring,
    repo:  ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_repository_set_ident*(
    repo:  ptr git_repository,
    name:  cstring,
    email: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


