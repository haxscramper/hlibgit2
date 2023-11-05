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
  c_git_fetch_prune_t* {.size: sizeof(cint).} = enum
    c_GIT_FETCH_PRUNE_UNSPECIFIED = 0 shl 0
    c_GIT_FETCH_PRUNE             = 1 shl 0
    c_GIT_FETCH_NO_PRUNE          = 1 shl 1

  c_git_remote_autotag_option_t* {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0
    c_GIT_REMOTE_DOWNLOAD_TAGS_AUTO        = 1
    c_GIT_REMOTE_DOWNLOAD_TAGS_NONE        = 2
    c_GIT_REMOTE_DOWNLOAD_TAGS_ALL         = 3

  c_git_remote_completion_t* {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_COMPLETION_DOWNLOAD = 0 shl 0
    c_GIT_REMOTE_COMPLETION_INDEXING = 1 shl 0
    c_GIT_REMOTE_COMPLETION_ERROR    = 1 shl 1

  c_git_remote_create_flags* {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_CREATE_SKIP_INSTEADOF         = 1 shl 0 ## Ignore the repository apply.insteadOf configuration
    c_GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 1 shl 1 ## Don't build a fetchspec from the name if none is set

  git_fetch_options* {.bycopy, header: "<git2/remote.h>", importc.} = object
    version*:          cint
    callbacks*:        git_remote_callbacks
    prune*:            c_git_fetch_prune_t
    update_fetchhead*: cint
    download_tags*:    c_git_remote_autotag_option_t
    proxy_opts*:       git_proxy_options
    custom_headers*:   git_strarray

  git_fetch_prune_t* {.size: sizeof(cint).} = enum
    GIT_FETCH_PRUNE_UNSPECIFIED
    GIT_FETCH_PRUNE
    GIT_FETCH_NO_PRUNE

  git_push_negotiation* = proc(updates: ptr ptr git_push_update,
                               len:     csize_t,
                               payload: pointer): cint{.cdecl.}

  git_push_options* {.bycopy, header: "<git2/remote.h>", importc.} = object
    version*:        cuint
    pb_parallelism*: cuint
    callbacks*:      git_remote_callbacks
    proxy_opts*:     git_proxy_options
    custom_headers*: git_strarray

  git_push_transfer_progress_cb* = proc(current: cuint,
                                        total:   cuint,
                                        bytes:   csize_t,
                                        payload: pointer): cint{.cdecl.}

  git_push_update* {.bycopy, header: "<git2/remote.h>", importc.} = object
    ## Push network progress notification function
    src_refname*: cstring
    dst_refname*: cstring
    src*:         git_oid
    dst*:         git_oid

  git_push_update_reference_cb* = proc(refname: cstring,
                                       status:  cstring,
                                       data:    pointer): cint{.cdecl.}

  git_remote_autotag_option_t* = enum
    GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED
    GIT_REMOTE_DOWNLOAD_TAGS_AUTO
    GIT_REMOTE_DOWNLOAD_TAGS_NONE
    GIT_REMOTE_DOWNLOAD_TAGS_ALL

  git_remote_callbacks* {.bycopy, header: "<git2/remote.h>", importc.} = object
    version*:                cuint
    sideband_progress*:      git_transport_message_cb                                  ## The version
    completion*:             proc(arg_type: c_git_remote_completion_t,
                                  data:     pointer): cint{.cdecl.}
    credentials*:            git_credential_acquire_cb
    certificate_check*:      git_transport_certificate_check_cb
    transfer_progress*:      git_indexer_progress_cb
    update_tips*:            proc(refname: cstring,
                                  a:       ptr git_oid,
                                  b:       ptr git_oid,
                                  data:    pointer): cint{.cdecl.}
    pack_progress*:          git_packbuilder_progress
    push_transfer_progress*: git_push_transfer_progress_cb
    push_update_reference*:  git_push_update_reference_cb
    push_negotiation*:       git_push_negotiation
    transport*:              git_transport_cb
    remote_ready*:           git_remote_ready_cb
    payload*:                pointer
    resolve_url*:            git_url_resolve_cb

  git_remote_completion_t* {.size: sizeof(cint).} = enum
    GIT_REMOTE_COMPLETION_DOWNLOAD
    GIT_REMOTE_COMPLETION_INDEXING
    GIT_REMOTE_COMPLETION_ERROR

  git_remote_create_flags* {.size: sizeof(cint).} = enum
    GIT_REMOTE_CREATE_SKIP_INSTEADOF         ## Ignore the repository apply.insteadOf configuration
    GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC ## Don't build a fetchspec from the name if none is set

  git_remote_create_options* {.bycopy, header: "<git2/remote.h>", importc.} = object
    version*:    cuint
    repository*: ptr git_repository
    name*:       cstring
    fetchspec*:  cstring            ## The fetchspec the remote should use.
    flags*:      cuint              ## Additional flags for the remote. See git_remote_create_flags.

  git_remote_ready_cb* = proc(remote:    ptr git_remote,
                              direction: cint,
                              payload:   pointer): cint{.cdecl.}

  git_url_resolve_cb* = proc(url_resolved: ptr git_buf,
                             url:          cstring,
                             direction:    cint,
                             payload:      pointer): cint{.cdecl.}


proc git_remote_create*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring,
    url:     cstring
  ): cint {.git2Proc, importc.}



proc to_c_git_remote_create_flags*(
    arg: git_remote_create_flags
  ): c_git_remote_create_flags =
  case arg:
    of GIT_REMOTE_CREATE_SKIP_INSTEADOF:         c_GIT_REMOTE_CREATE_SKIP_INSTEADOF
    of GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC: c_GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC


converter to_git_remote_create_flags*(
    arg: c_git_remote_create_flags
  ): git_remote_create_flags =
  case arg:
    of c_GIT_REMOTE_CREATE_SKIP_INSTEADOF:         GIT_REMOTE_CREATE_SKIP_INSTEADOF
    of c_GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC: GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC


converter toCint*(arg: c_git_remote_create_flags): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_remote_create_flags): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_remote_create_flags(arg)))

func `+`*(
    arg:    c_git_remote_create_flags,
    offset: int
  ): c_git_remote_create_flags =
  cast[c_git_remote_create_flags](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_remote_create_flags
  ): c_git_remote_create_flags =
  cast[c_git_remote_create_flags](ord(arg) + offset)

func `-`*(
    arg:    c_git_remote_create_flags,
    offset: int
  ): c_git_remote_create_flags =
  cast[c_git_remote_create_flags](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_remote_create_flags
  ): c_git_remote_create_flags =
  cast[c_git_remote_create_flags](ord(arg) - offset)


converter toCint*(args: set[git_remote_create_flags]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  cast[cint](args)


proc git_remote_create_options_init*(
    opts:    ptr git_remote_create_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_remote_create_with_opts*(
    arg_out: ptr ptr git_remote,
    url:     cstring,
    opts:    ptr git_remote_create_options
  ): cint {.git2Proc, importc.}



proc git_remote_create_with_fetchspec*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring,
    url:     cstring,
    fetch:   cstring
  ): cint {.git2Proc, importc.}



proc git_remote_create_anonymous*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    url:     cstring
  ): cint {.git2Proc, importc.}



proc git_remote_create_detached*(
    arg_out: ptr ptr git_remote,
    url:     cstring
  ): cint {.git2Proc, importc.}



proc git_remote_lookup*(
    arg_out: ptr ptr git_remote,
    repo:    ptr git_repository,
    name:    cstring
  ): cint {.git2Proc, importc.}



proc git_remote_dup*(
    dest:   ptr ptr git_remote,
    source: ptr git_remote
  ): cint {.git2Proc, importc.}



proc git_remote_owner*(
    remote: ptr git_remote
  ): ptr git_repository {.git2Proc, importc.}



proc git_remote_name*(remote: ptr git_remote): cstring {.git2Proc, importc.}



proc git_remote_url*(remote: ptr git_remote): cstring {.git2Proc, importc.}



proc git_remote_pushurl*(remote: ptr git_remote): cstring {.git2Proc, importc.}



proc git_remote_set_url*(
    repo:   ptr git_repository,
    remote: cstring,
    url:    cstring
  ): cint {.git2Proc, importc.}



proc git_remote_set_pushurl*(
    repo:   ptr git_repository,
    remote: cstring,
    url:    cstring
  ): cint {.git2Proc, importc.}



proc git_remote_set_instance_url*(
    remote: ptr git_remote,
    url:    cstring
  ): cint {.git2Proc, importc.}



proc git_remote_set_instance_pushurl*(
    remote: ptr git_remote,
    url:    cstring
  ): cint {.git2Proc, importc.}



proc git_remote_add_fetch*(
    repo:    ptr git_repository,
    remote:  cstring,
    refspec: cstring
  ): cint {.git2Proc, importc.}



proc git_remote_get_fetch_refspecs*(
    array:  ptr git_strarray,
    remote: ptr git_remote
  ): cint {.git2Proc, importc.}



proc git_remote_add_push*(
    repo:    ptr git_repository,
    remote:  cstring,
    refspec: cstring
  ): cint {.git2Proc, importc.}



proc git_remote_get_push_refspecs*(
    array:  ptr git_strarray,
    remote: ptr git_remote
  ): cint {.git2Proc, importc.}



proc git_remote_refspec_count*(
    remote: ptr git_remote
  ): csize_t {.git2Proc, importc.}



proc git_remote_get_refspec*(
    remote: ptr git_remote,
    n:      csize_t
  ): ptr git_refspec {.git2Proc, importc.}



proc git_remote_connect*(
    remote:         ptr git_remote,
    direction:      c_git_direction,
    callbacks:      ptr git_remote_callbacks,
    proxy_opts:     ptr git_proxy_options,
    custom_headers: ptr git_strarray
  ): cint {.git2Proc, importc.}



proc git_remote_ls*(
    arg_out: ptr ptr ptr git_remote_head,
    size:    ptr csize_t,
    remote:  ptr git_remote
  ): cint {.git2Proc, importc.}



proc git_remote_connected*(remote: ptr git_remote): cint {.git2Proc, importc.}



proc git_remote_stop*(remote: ptr git_remote): cint {.git2Proc, importc.}



proc git_remote_disconnect*(remote: ptr git_remote): cint {.git2Proc, importc.}



proc git_remote_free*(remote: ptr git_remote): void {.git2Proc, importc.}



proc git_remote_list*(
    arg_out: ptr git_strarray,
    repo:    ptr git_repository
  ): cint {.git2Proc, importc.}



proc to_c_git_remote_completion_t*(
    arg: git_remote_completion_t
  ): c_git_remote_completion_t =
  case arg:
    of GIT_REMOTE_COMPLETION_DOWNLOAD: c_GIT_REMOTE_COMPLETION_DOWNLOAD
    of GIT_REMOTE_COMPLETION_INDEXING: c_GIT_REMOTE_COMPLETION_INDEXING
    of GIT_REMOTE_COMPLETION_ERROR:    c_GIT_REMOTE_COMPLETION_ERROR


converter to_git_remote_completion_t*(
    arg: c_git_remote_completion_t
  ): git_remote_completion_t =
  case arg:
    of c_GIT_REMOTE_COMPLETION_DOWNLOAD: GIT_REMOTE_COMPLETION_DOWNLOAD
    of c_GIT_REMOTE_COMPLETION_INDEXING: GIT_REMOTE_COMPLETION_INDEXING
    of c_GIT_REMOTE_COMPLETION_ERROR:    GIT_REMOTE_COMPLETION_ERROR


converter toCint*(arg: c_git_remote_completion_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_remote_completion_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_remote_completion_t(arg)))

func `+`*(
    arg:    c_git_remote_completion_t,
    offset: int
  ): c_git_remote_completion_t =
  cast[c_git_remote_completion_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_remote_completion_t
  ): c_git_remote_completion_t =
  cast[c_git_remote_completion_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_remote_completion_t,
    offset: int
  ): c_git_remote_completion_t =
  cast[c_git_remote_completion_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_remote_completion_t
  ): c_git_remote_completion_t =
  cast[c_git_remote_completion_t](ord(arg) - offset)


converter toCint*(args: set[git_remote_completion_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_REMOTE_COMPLETION_DOWNLOAD: result = cint(result or (0 shl 0))
      of GIT_REMOTE_COMPLETION_INDEXING: result = cint(result or (1 shl 0))
      of GIT_REMOTE_COMPLETION_ERROR:    result = cint(result or (1 shl 1))


proc git_remote_init_callbacks*(
    opts:    ptr git_remote_callbacks,
    version: cuint
  ): cint {.git2Proc, importc.}



proc to_c_git_fetch_prune_t*(arg: git_fetch_prune_t): c_git_fetch_prune_t =
  case arg:
    of GIT_FETCH_PRUNE_UNSPECIFIED: c_GIT_FETCH_PRUNE_UNSPECIFIED
    of GIT_FETCH_PRUNE:             c_GIT_FETCH_PRUNE
    of GIT_FETCH_NO_PRUNE:          c_GIT_FETCH_NO_PRUNE


converter to_git_fetch_prune_t*(arg: c_git_fetch_prune_t): git_fetch_prune_t =
  case arg:
    of c_GIT_FETCH_PRUNE_UNSPECIFIED: GIT_FETCH_PRUNE_UNSPECIFIED
    of c_GIT_FETCH_PRUNE:             GIT_FETCH_PRUNE
    of c_GIT_FETCH_NO_PRUNE:          GIT_FETCH_NO_PRUNE


converter toCint*(arg: c_git_fetch_prune_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_fetch_prune_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_fetch_prune_t(arg)))

func `+`*(arg: c_git_fetch_prune_t, offset: int): c_git_fetch_prune_t =
  cast[c_git_fetch_prune_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_fetch_prune_t): c_git_fetch_prune_t =
  cast[c_git_fetch_prune_t](ord(arg) + offset)

func `-`*(arg: c_git_fetch_prune_t, offset: int): c_git_fetch_prune_t =
  cast[c_git_fetch_prune_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_fetch_prune_t): c_git_fetch_prune_t =
  cast[c_git_fetch_prune_t](ord(arg) - offset)


converter toCint*(args: set[git_fetch_prune_t]): cint =
  ## Convert set of nim enum values into cint that can be passed
  ## to wrapped C procs.
  for value in items(args):
    case value:
      of GIT_FETCH_PRUNE_UNSPECIFIED: result = cint(result or (0 shl 0))
      of GIT_FETCH_PRUNE:             result = cint(result or (1 shl 0))
      of GIT_FETCH_NO_PRUNE:          result = cint(result or (1 shl 1))


proc to_c_git_remote_autotag_option_t*(
    arg: git_remote_autotag_option_t
  ): c_git_remote_autotag_option_t =
  case arg:
    of GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED: c_GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED
    of GIT_REMOTE_DOWNLOAD_TAGS_AUTO:        c_GIT_REMOTE_DOWNLOAD_TAGS_AUTO
    of GIT_REMOTE_DOWNLOAD_TAGS_NONE:        c_GIT_REMOTE_DOWNLOAD_TAGS_NONE
    of GIT_REMOTE_DOWNLOAD_TAGS_ALL:         c_GIT_REMOTE_DOWNLOAD_TAGS_ALL


converter to_git_remote_autotag_option_t*(
    arg: c_git_remote_autotag_option_t
  ): git_remote_autotag_option_t =
  case arg:
    of c_GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED: GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED
    of c_GIT_REMOTE_DOWNLOAD_TAGS_AUTO:        GIT_REMOTE_DOWNLOAD_TAGS_AUTO
    of c_GIT_REMOTE_DOWNLOAD_TAGS_NONE:        GIT_REMOTE_DOWNLOAD_TAGS_NONE
    of c_GIT_REMOTE_DOWNLOAD_TAGS_ALL:         GIT_REMOTE_DOWNLOAD_TAGS_ALL


converter toCint*(arg: c_git_remote_autotag_option_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(arg))

converter toCint*(arg: git_remote_autotag_option_t): cint =
  ## Convert nim enum value into cint that can be passed to wrapped C
  ## procs.
  cint(ord(to_c_git_remote_autotag_option_t(arg)))

func `+`*(
    arg:    c_git_remote_autotag_option_t,
    offset: int
  ): c_git_remote_autotag_option_t =
  cast[c_git_remote_autotag_option_t](ord(arg) + offset)

func `+`*(
    offset: int,
    arg:    c_git_remote_autotag_option_t
  ): c_git_remote_autotag_option_t =
  cast[c_git_remote_autotag_option_t](ord(arg) + offset)

func `-`*(
    arg:    c_git_remote_autotag_option_t,
    offset: int
  ): c_git_remote_autotag_option_t =
  cast[c_git_remote_autotag_option_t](ord(arg) - offset)

func `-`*(
    offset: int,
    arg:    c_git_remote_autotag_option_t
  ): c_git_remote_autotag_option_t =
  cast[c_git_remote_autotag_option_t](ord(arg) - offset)


proc git_fetch_options_init*(
    opts:    ptr git_fetch_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_push_options_init*(
    opts:    ptr git_push_options,
    version: cuint
  ): cint {.git2Proc, importc.}



proc git_remote_download*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_fetch_options
  ): cint {.git2Proc, importc.}



proc git_remote_upload*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_push_options
  ): cint {.git2Proc, importc.}



proc git_remote_update_tips*(
    remote:           ptr git_remote,
    callbacks:        ptr git_remote_callbacks,
    update_fetchhead: cint,
    download_tags:    c_git_remote_autotag_option_t,
    reflog_message:   cstring
  ): cint {.git2Proc, importc.}



proc git_remote_fetch*(
    remote:         ptr git_remote,
    refspecs:       ptr git_strarray,
    opts:           ptr git_fetch_options,
    reflog_message: cstring
  ): cint {.git2Proc, importc.}



proc git_remote_prune*(
    remote:    ptr git_remote,
    callbacks: ptr git_remote_callbacks
  ): cint {.git2Proc, importc.}



proc git_remote_push*(
    remote:   ptr git_remote,
    refspecs: ptr git_strarray,
    opts:     ptr git_push_options
  ): cint {.git2Proc, importc.}



proc git_remote_stats*(
    remote: ptr git_remote
  ): ptr git_indexer_progress {.git2Proc, importc.}



proc git_remote_autotag*(
    remote: ptr git_remote
  ): c_git_remote_autotag_option_t {.git2Proc, importc.}



proc git_remote_set_autotag*(
    repo:   ptr git_repository,
    remote: cstring,
    value:  c_git_remote_autotag_option_t
  ): cint {.git2Proc, importc.}



proc git_remote_prune_refs*(remote: ptr git_remote): cint {.git2Proc, importc.}



proc git_remote_rename*(
    problems: ptr git_strarray,
    repo:     ptr git_repository,
    name:     cstring,
    new_name: cstring
  ): cint {.git2Proc, importc.}



proc git_remote_name_is_valid*(
    valid:       ptr cint,
    remote_name: cstring
  ): cint {.git2Proc, importc.}



proc git_remote_delete*(
    repo: ptr git_repository,
    name: cstring
  ): cint {.git2Proc, importc.}



proc git_remote_default_branch*(
    arg_out: ptr git_buf,
    remote:  ptr git_remote
  ): cint {.git2Proc, importc.}



