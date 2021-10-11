{.push warning[UnusedImport]:off.}

import
  ./buffer,
  ./cert,
  ./credential,
  ./indexer,
  ./libgit2_config,
  ./net,
  ./oid,
  ./pack,
  ./proxy,
  ./strarray,
  ./transport,
  ./types

type
  git_fetch_options* {.bycopy, header: "<git2/remote.h>", importc.} = object
    version*: cint
    callbacks*: git_remote_callbacks
    prune*: git_fetch_prune_t
    update_fetchhead*: cint
    download_tags*: git_remote_autotag_option_t
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray
   
  git_fetch_prune_t* = enum
    GIT_FETCH_PRUNE_UNSPECIFIED = 0
    GIT_FETCH_PRUNE = 1
    GIT_FETCH_NO_PRUNE = 2
   
  git_push_negotiation* = proc(updates: ptr ptr git_push_update, len: csize_t, payload: pointer): cint{.cdecl.}
   
  git_push_negotiationNim* = proc(updates: ptr ptr git_push_update, len: csize_t): cint
   
  git_push_options* {.bycopy, header: "<git2/remote.h>", importc.} = object
    version*: cuint
    pb_parallelism*: cuint
    callbacks*: git_remote_callbacks
    proxy_opts*: git_proxy_options
    custom_headers*: git_strarray
   
  git_push_transfer_progress_cb* = proc(current: cuint, total: cuint, bytes: csize_t, payload: pointer): cint{.cdecl.}
   
  git_push_transfer_progress_cbNim* = proc(current: cuint, total: cuint, bytes: csize_t): cint
   
  git_push_update* {.bycopy, header: "<git2/remote.h>", importc.} = object
    ## Push network progress notification function 
    src_refname*: cstring
    dst_refname*: cstring
    src*: git_oid
    dst*: git_oid
   
  git_push_update_reference_cb* = proc(refname: cstring, status: cstring, data: pointer): cint{.cdecl.}
   
  git_push_update_reference_cbNim* = proc(refname: cstring, status: cstring): cint
   
  git_remote_autotag_option_t* = enum
    GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0
    GIT_REMOTE_DOWNLOAD_TAGS_AUTO = 1
    GIT_REMOTE_DOWNLOAD_TAGS_NONE = 2
    GIT_REMOTE_DOWNLOAD_TAGS_ALL = 3
   
  git_remote_callbacks* {.bycopy, header: "<git2/remote.h>", importc.} = object
    version*: cuint
    sideband_progress*: git_transport_message_cb ## The version 
    completion*: proc(arg_type: git_remote_completion_t, data: pointer): cint{.cdecl.}
    credentials*: git_credential_acquire_cb
    certificate_check*: git_transport_certificate_check_cb
    transfer_progress*: git_indexer_progress_cb
    update_tips*: proc(refname: cstring, a: ptr git_oid, b: ptr git_oid, data: pointer): cint{.cdecl.}
    pack_progress*: git_packbuilder_progress
    push_transfer_progress*: git_push_transfer_progress_cb
    push_update_reference*: git_push_update_reference_cb
    push_negotiation*: git_push_negotiation
    transport*: git_transport_cb
    payload*: pointer
    resolve_url*: git_url_resolve_cb
   
  git_remote_completion_t* = enum
    GIT_REMOTE_COMPLETION_DOWNLOAD = 0
    GIT_REMOTE_COMPLETION_INDEXING = 1
    GIT_REMOTE_COMPLETION_ERROR = 2
   
  git_remote_create_flags* = enum
    GIT_REMOTE_CREATE_SKIP_INSTEADOF = 1 ## Ignore the repository apply.insteadOf configuration 
    GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 2 ## Don't build a fetchspec from the name if none is set 
   
  git_remote_create_options* {.bycopy, header: "<git2/remote.h>", importc.} = object
    version*: cuint
    repository*: ptr git_repository
    name*: cstring
    fetchspec*: cstring ## The fetchspec the remote should use. 
    flags*: cuint ## Additional flags for the remote. See git_remote_create_flags. 
   
  git_url_resolve_cb* = proc(url_resolved: ptr git_buf, url: cstring, direction: cint, payload: pointer): cint{.cdecl.}
   
  git_url_resolve_cbNim* = proc(url_resolved: ptr git_buf, url: cstring, direction: cint): cint
   

proc git_remote_create*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring,
    url:     cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_create_options_init*(
    opts:    ptr git_remote_create_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_create_with_opts*(
    arg_out: ptr ptr git_remote,
    url:     cstring,
    opts:    ptr git_remote_create_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_create_with_fetchspec*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring,
    url:     cstring,
    fetch:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_create_anonymous*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    url:     cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_create_detached*(
    arg_out: ptr ptr git_remote,
    url:     cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_lookup*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_dup*(
    dest:   ptr ptr git_remote,
    source: ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_owner*(
    remote: ptr git_remote
  ): ptr git_repository {.dynlib: libgit2Dl, importc.}


proc git_remote_name*(
    remote: ptr git_remote
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_remote_url*(
    remote: ptr git_remote
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_remote_pushurl*(
    remote: ptr git_remote
  ): cstring {.dynlib: libgit2Dl, importc.}


proc git_remote_set_url*(
    repo:   ptr git_repository,
    remote: cstring,
    url:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_set_pushurl*(
    repo:   ptr git_repository,
    remote: cstring,
    url:    cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_add_fetch*(
    repo:    ptr git_repository,
    remote:  cstring,
    refspec: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_get_fetch_refspecs*(
    array:  ptr git_strarray,
    remote: ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_add_push*(
    repo:    ptr git_repository,
    remote:  cstring,
    refspec: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_get_push_refspecs*(
    array:  ptr git_strarray,
    remote: ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_refspec_count*(
    remote: ptr git_remote
  ): csize_t {.dynlib: libgit2Dl, importc.}


proc git_remote_get_refspec*(
    remote: ptr git_remote,
    n:      csize_t
  ): ptr git_refspec {.dynlib: libgit2Dl, importc.}


proc git_remote_connect*(
    remote:         ptr git_remote,
    direction:      git_direction,
    callbacks:      ptr git_remote_callbacks,
    proxy_opts:     ptr git_proxy_options,
    custom_headers: ptr git_strarray
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_ls*(
    arg_out: ptr ptr ptr git_remote_head,
    size:    ptr csize_t,
    remote:  ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_connected*(
    remote: ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_stop*(
    remote: ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_disconnect*(
    remote: ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_free*(
    remote: ptr git_remote
  ): void {.dynlib: libgit2Dl, importc.}


proc git_remote_list*(
    arg_out: ptr git_strarray,
    repo:    ptr git_repository
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_init_callbacks*(
    opts:    ptr git_remote_callbacks,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_fetch_options_init*(
    opts:    ptr git_fetch_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_push_options_init*(
    opts:    ptr git_push_options,
    version: cuint
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_download*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_fetch_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_upload*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_push_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_update_tips*(
    remote:           ptr git_remote,
    callbacks:        ptr git_remote_callbacks,
    update_fetchhead: cint,
    download_tags:    git_remote_autotag_option_t,
    reflog_message:   cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_fetch*(
    remote:         ptr git_remote,
    refspecs:       ptr git_strarray,
    opts:           ptr git_fetch_options,
    reflog_message: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_prune*(
    remote:    ptr git_remote,
    callbacks: ptr git_remote_callbacks
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_push*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_push_options
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_stats*(
    remote: ptr git_remote
  ): ptr git_indexer_progress {.dynlib: libgit2Dl, importc.}


proc git_remote_autotag*(
    remote: ptr git_remote
  ): git_remote_autotag_option_t {.dynlib: libgit2Dl, importc.}


proc git_remote_set_autotag*(
    repo:   ptr git_repository,
    remote: cstring,
    value:  git_remote_autotag_option_t
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_prune_refs*(
    remote: ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_rename*(
    problems: ptr git_strarray,
    repo:     ptr git_repository,
    name:     cstring,
    new_name: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_is_valid_name*(
    remote_name: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_delete*(
    repo: ptr git_repository,
    name: cstring
  ): cint {.dynlib: libgit2Dl, importc.}


proc git_remote_default_branch*(
    arg_out: ptr git_buf,
    remote:  ptr git_remote
  ): cint {.dynlib: libgit2Dl, importc.}


