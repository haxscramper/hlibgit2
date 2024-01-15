import "./pack.nim"
import "./credential.nim"
import "./cert.nim"
import "./oidarray.nim"
import "./proxy.nim"
import "./indexer.nim"
import "./types.nim"
import "./strarray.nim"
import "./net.nim"
import "./oid.nim"
import "./buffer.nim"

type
  git_remote_create_options* {.importc, bycopy.} = object
    version    *: cuint
    repository *: ptr git_repository
    name       *: cstring
    fetchspec  *: cstring
    flags      *: cuint

  git_push_update* {.importc, bycopy.} = object
    src_refname *: ptr char
    dst_refname *: ptr char
    src         *: git_oid
    dst         *: git_oid

  git_fetch_options* {.importc, bycopy.} = object
    version          *: cint
    callbacks        *: git_remote_callbacks
    prune            *: git_fetch_prune_t
    update_flags     *: cuint
    download_tags    *: git_remote_autotag_option_t
    proxy_opts       *: git_proxy_options
    depth            *: cint
    follow_redirects *: git_remote_redirect_t
    custom_headers   *: git_strarray

  git_push_options* {.importc, bycopy.} = object
    version          *: cuint
    pb_parallelism   *: cuint
    callbacks        *: git_remote_callbacks
    proxy_opts       *: git_proxy_options
    follow_redirects *: git_remote_redirect_t
    custom_headers   *: git_strarray

  git_remote_connect_options* {.importc, bycopy.} = object
    version          *: cuint
    callbacks        *: git_remote_callbacks
    proxy_opts       *: git_proxy_options
    follow_redirects *: git_remote_redirect_t
    custom_headers   *: git_strarray

  c_git_remote_redirect_t* {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_REDIRECT_NONE    = 1 shl 0
    c_GIT_REMOTE_REDIRECT_INITIAL = 1 shl 1
    c_GIT_REMOTE_REDIRECT_ALL     = 1 shl 2

  git_remote_redirect_t* = enum
    GIT_REMOTE_REDIRECT_NONE    = 0
    GIT_REMOTE_REDIRECT_INITIAL = 1
    GIT_REMOTE_REDIRECT_ALL     = 2

  c_git_remote_create_flags* {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_CREATE_SKIP_INSTEADOF         = 1 shl 0
    c_GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 1 shl 1

  git_remote_create_flags* = enum
    GIT_REMOTE_CREATE_SKIP_INSTEADOF         = 0
    GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 1

  c_git_remote_update_flags* {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_UPDATE_FETCHHEAD        = 1 shl 0
    c_GIT_REMOTE_UPDATE_REPORT_UNCHANGED = 1 shl 1

  git_remote_update_flags* = enum
    GIT_REMOTE_UPDATE_FETCHHEAD        = 0
    GIT_REMOTE_UPDATE_REPORT_UNCHANGED = 1

  c_git_remote_completion_t* {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_COMPLETION_DOWNLOAD = 0
    c_GIT_REMOTE_COMPLETION_INDEXING = 1
    c_GIT_REMOTE_COMPLETION_ERROR    = 2

  git_remote_completion_t* = enum
    GIT_REMOTE_COMPLETION_DOWNLOAD = 0
    GIT_REMOTE_COMPLETION_INDEXING = 1
    GIT_REMOTE_COMPLETION_ERROR    = 2

  c_git_fetch_prune_t* {.size: sizeof(cint).} = enum
    c_GIT_FETCH_PRUNE_UNSPECIFIED = 0
    c_GIT_FETCH_PRUNE             = 1
    c_GIT_FETCH_NO_PRUNE          = 2

  git_fetch_prune_t* = enum
    GIT_FETCH_PRUNE_UNSPECIFIED = 0
    GIT_FETCH_PRUNE             = 1
    GIT_FETCH_NO_PRUNE          = 2

  c_git_remote_autotag_option_t* {.size: sizeof(cint).} = enum
    c_GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0
    c_GIT_REMOTE_DOWNLOAD_TAGS_AUTO        = 1
    c_GIT_REMOTE_DOWNLOAD_TAGS_NONE        = 2
    c_GIT_REMOTE_DOWNLOAD_TAGS_ALL         = 3

  git_remote_autotag_option_t* = enum
    GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0
    GIT_REMOTE_DOWNLOAD_TAGS_AUTO        = 1
    GIT_REMOTE_DOWNLOAD_TAGS_NONE        = 2
    GIT_REMOTE_DOWNLOAD_TAGS_ALL         = 3

  c_git_fetch_depth_t* {.size: sizeof(cint).} = enum
    c_GIT_FETCH_DEPTH_FULL      = 0
    c_GIT_FETCH_DEPTH_UNSHALLOW = 2147483647

  git_fetch_depth_t* = enum
    GIT_FETCH_DEPTH_FULL      = 0
    GIT_FETCH_DEPTH_UNSHALLOW = 1

  git_push_transfer_progress_cb* = proc (a0: cuint, a1: cuint, a2: csize_t, a3: pointer): cint

  git_push_negotiation* = proc (a0: ptr ptr git_push_update, a1: csize_t, a2: pointer): cint

  git_push_update_reference_cb* = proc (a0: cstring, a1: cstring, a2: pointer): cint

  git_url_resolve_cb* = proc (a0: ptr git_buf, a1: cstring, a2: cint, a3: pointer): cint

  git_remote_ready_cb* = proc (a0: ptr git_remote, a1: cint, a2: pointer): cint

  git_transport_message_cb* = proc (a0: cstring, a1: cint, a2: pointer): cint

  git_transport_cb* = proc (a0: ptr ptr git_transport, a1: ptr git_remote, a2: pointer): cint

  git_fetch_negotiation* {.importc, bycopy.} = object
    refs              *: ptr ptr git_remote_head
    refs_len          *: csize_t
    shallow_roots     *: ptr git_oid
    shallow_roots_len *: csize_t
    depth             *: cint

  git_smart_subtransport* {.importc, bycopy.} = object
    action *: proc (a0: ptr ptr git_smart_subtransport_stream, a1: ptr git_smart_subtransport, a2: cstring, a3: git_smart_service_t): cint
    close  *: proc (a0: ptr git_smart_subtransport): cint
    free   *: proc (a0: ptr git_smart_subtransport): void

  git_smart_subtransport_stream* {.importc, bycopy.} = object
    subtransport *: ptr git_smart_subtransport
    read         *: proc (a0: ptr git_smart_subtransport_stream, a1: ptr char, a2: csize_t, a3: ptr csize_t): cint
    write        *: proc (a0: ptr git_smart_subtransport_stream, a1: cstring, a2: csize_t): cint
    free         *: proc (a0: ptr git_smart_subtransport_stream): void

  git_smart_subtransport_definition* {.importc, bycopy.} = object
    callback *: git_smart_subtransport_cb
    rpc      *: cuint
    param    *: pointer

  c_git_smart_service_t* {.size: sizeof(cint).} = enum
    c_GIT_SERVICE_UPLOADPACK_LS  = 1 shl 0
    c_GIT_SERVICE_UPLOADPACK     = 1 shl 1
    c_GIT_SERVICE_RECEIVEPACK_LS = 3
    c_GIT_SERVICE_RECEIVEPACK    = 1 shl 2

  git_smart_service_t* = enum
    GIT_SERVICE_UPLOADPACK_LS  = 0
    GIT_SERVICE_UPLOADPACK     = 1
    GIT_SERVICE_RECEIVEPACK_LS = 2
    GIT_SERVICE_RECEIVEPACK    = 3

  git_smart_subtransport_cb* = proc (a0: ptr ptr git_smart_subtransport, a1: ptr git_transport, a2: pointer): cint

  git_transport* {.importc, bycopy.} = object
    version          *: cuint
    connect          *: proc (a0: ptr git_transport, a1: cstring, a2: cint, a3: ptr git_remote_connect_options): cint
    set_connect_opts *: proc (a0: ptr git_transport, a1: ptr git_remote_connect_options): cint
    capabilities     *: proc (a0: ptr cuint, a1: ptr git_transport): cint
    ls               *: proc (a0: ptr ptr ptr git_remote_head, a1: ptr csize_t, a2: ptr git_transport): cint
    push             *: proc (a0: ptr git_transport, a1: ptr git_push): cint
    negotiate_fetch  *: proc (a0: ptr git_transport, a1: ptr git_repository, a2: ptr git_fetch_negotiation): cint
    shallow_roots    *: proc (a0: ptr git_oidarray, a1: ptr git_transport): cint
    download_pack    *: proc (a0: ptr git_transport, a1: ptr git_repository, a2: ptr git_indexer_progress): cint
    is_connected     *: proc (a0: ptr git_transport): cint
    cancel           *: proc (a0: ptr git_transport): void
    close            *: proc (a0: ptr git_transport): cint
    free             *: proc (a0: ptr git_transport): void

  git_remote_callbacks* {.importc, bycopy.} = object
    version                *: cuint
    sideband_progress      *: git_transport_message_cb
    completion             *: proc (a0: git_remote_completion_t, a1: pointer): cint
    credentials            *: git_credential_acquire_cb
    certificate_check      *: git_transport_certificate_check_cb
    transfer_progress      *: git_indexer_progress_cb
    update_tips            *: proc (a0: cstring, a1: ptr git_oid, a2: ptr git_oid, a3: pointer): cint
    pack_progress          *: git_packbuilder_progress
    push_transfer_progress *: git_push_transfer_progress_cb
    push_update_reference  *: git_push_update_reference_cb
    push_negotiation       *: git_push_negotiation
    transport              *: git_transport_cb
    remote_ready           *: git_remote_ready_cb
    payload                *: pointer
    resolve_url            *: git_url_resolve_cb



converter to_git_remote_redirect_t*(arg: c_git_remote_redirect_t): git_remote_redirect_t =
  case arg:
    of c_GIT_REMOTE_REDIRECT_NONE   : GIT_REMOTE_REDIRECT_NONE
    of c_GIT_REMOTE_REDIRECT_INITIAL: GIT_REMOTE_REDIRECT_INITIAL
    of c_GIT_REMOTE_REDIRECT_ALL    : GIT_REMOTE_REDIRECT_ALL

proc to_c_git_remote_redirect_t*(arg: git_remote_redirect_t): c_git_remote_redirect_t =
  case arg:
    of GIT_REMOTE_REDIRECT_NONE   : c_GIT_REMOTE_REDIRECT_NONE
    of GIT_REMOTE_REDIRECT_INITIAL: c_GIT_REMOTE_REDIRECT_INITIAL
    of GIT_REMOTE_REDIRECT_ALL    : c_GIT_REMOTE_REDIRECT_ALL

converter toCInt*(arg: c_git_remote_redirect_t): cint = cint(ord(arg))

converter toCInt*(arg: git_remote_redirect_t): cint = cint(ord(to_c_git_remote_redirect_t(arg)))

converter toCInt*(args: set[git_remote_redirect_t]): cint =
  for value in items(args):
    case value:
      of GIT_REMOTE_REDIRECT_NONE   : result = cint(result or 1)
      of GIT_REMOTE_REDIRECT_INITIAL: result = cint(result or 2)
      of GIT_REMOTE_REDIRECT_ALL    : result = cint(result or 4)

func `-`*(arg: c_git_remote_redirect_t, offset: int): cint = cast[c_git_remote_redirect_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_remote_redirect_t): cint = cast[c_git_remote_redirect_t](ord(arg) - offset)

func `+`*(arg: c_git_remote_redirect_t, offset: int): cint = cast[c_git_remote_redirect_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_remote_redirect_t): cint = cast[c_git_remote_redirect_t](ord(arg) + offset)

converter to_git_remote_create_flags*(arg: c_git_remote_create_flags): git_remote_create_flags =
  case arg:
    of c_GIT_REMOTE_CREATE_SKIP_INSTEADOF        : GIT_REMOTE_CREATE_SKIP_INSTEADOF
    of c_GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC: GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC

proc to_c_git_remote_create_flags*(arg: git_remote_create_flags): c_git_remote_create_flags =
  case arg:
    of GIT_REMOTE_CREATE_SKIP_INSTEADOF        : c_GIT_REMOTE_CREATE_SKIP_INSTEADOF
    of GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC: c_GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC

converter toCInt*(arg: c_git_remote_create_flags): cint = cint(ord(arg))

converter toCInt*(arg: git_remote_create_flags): cint = cint(ord(to_c_git_remote_create_flags(arg)))

converter toCInt*(args: set[git_remote_create_flags]): cint =
  for value in items(args):
    case value:
      of GIT_REMOTE_CREATE_SKIP_INSTEADOF        : result = cint(result or 1)
      of GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC: result = cint(result or 2)

func `-`*(arg: c_git_remote_create_flags, offset: int): cint = cast[c_git_remote_create_flags](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_remote_create_flags): cint = cast[c_git_remote_create_flags](ord(arg) - offset)

func `+`*(arg: c_git_remote_create_flags, offset: int): cint = cast[c_git_remote_create_flags](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_remote_create_flags): cint = cast[c_git_remote_create_flags](ord(arg) + offset)

converter to_git_remote_update_flags*(arg: c_git_remote_update_flags): git_remote_update_flags =
  case arg:
    of c_GIT_REMOTE_UPDATE_FETCHHEAD       : GIT_REMOTE_UPDATE_FETCHHEAD
    of c_GIT_REMOTE_UPDATE_REPORT_UNCHANGED: GIT_REMOTE_UPDATE_REPORT_UNCHANGED

proc to_c_git_remote_update_flags*(arg: git_remote_update_flags): c_git_remote_update_flags =
  case arg:
    of GIT_REMOTE_UPDATE_FETCHHEAD       : c_GIT_REMOTE_UPDATE_FETCHHEAD
    of GIT_REMOTE_UPDATE_REPORT_UNCHANGED: c_GIT_REMOTE_UPDATE_REPORT_UNCHANGED

converter toCInt*(arg: c_git_remote_update_flags): cint = cint(ord(arg))

converter toCInt*(arg: git_remote_update_flags): cint = cint(ord(to_c_git_remote_update_flags(arg)))

converter toCInt*(args: set[git_remote_update_flags]): cint =
  for value in items(args):
    case value:
      of GIT_REMOTE_UPDATE_FETCHHEAD       : result = cint(result or 1)
      of GIT_REMOTE_UPDATE_REPORT_UNCHANGED: result = cint(result or 2)

func `-`*(arg: c_git_remote_update_flags, offset: int): cint = cast[c_git_remote_update_flags](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_remote_update_flags): cint = cast[c_git_remote_update_flags](ord(arg) - offset)

func `+`*(arg: c_git_remote_update_flags, offset: int): cint = cast[c_git_remote_update_flags](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_remote_update_flags): cint = cast[c_git_remote_update_flags](ord(arg) + offset)

converter to_git_remote_completion_t*(arg: c_git_remote_completion_t): git_remote_completion_t =
  case arg:
    of c_GIT_REMOTE_COMPLETION_DOWNLOAD: GIT_REMOTE_COMPLETION_DOWNLOAD
    of c_GIT_REMOTE_COMPLETION_INDEXING: GIT_REMOTE_COMPLETION_INDEXING
    of c_GIT_REMOTE_COMPLETION_ERROR   : GIT_REMOTE_COMPLETION_ERROR

proc to_c_git_remote_completion_t*(arg: git_remote_completion_t): c_git_remote_completion_t =
  case arg:
    of GIT_REMOTE_COMPLETION_DOWNLOAD: c_GIT_REMOTE_COMPLETION_DOWNLOAD
    of GIT_REMOTE_COMPLETION_INDEXING: c_GIT_REMOTE_COMPLETION_INDEXING
    of GIT_REMOTE_COMPLETION_ERROR   : c_GIT_REMOTE_COMPLETION_ERROR

converter toCInt*(arg: c_git_remote_completion_t): cint = cint(ord(arg))

converter toCInt*(arg: git_remote_completion_t): cint = cint(ord(to_c_git_remote_completion_t(arg)))

converter toCInt*(args: set[git_remote_completion_t]): cint =
  for value in items(args):
    case value:
      of GIT_REMOTE_COMPLETION_DOWNLOAD: result = cint(result or 0)
      of GIT_REMOTE_COMPLETION_INDEXING: result = cint(result or 1)
      of GIT_REMOTE_COMPLETION_ERROR   : result = cint(result or 2)

func `-`*(arg: c_git_remote_completion_t, offset: int): cint = cast[c_git_remote_completion_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_remote_completion_t): cint = cast[c_git_remote_completion_t](ord(arg) - offset)

func `+`*(arg: c_git_remote_completion_t, offset: int): cint = cast[c_git_remote_completion_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_remote_completion_t): cint = cast[c_git_remote_completion_t](ord(arg) + offset)

converter to_git_fetch_prune_t*(arg: c_git_fetch_prune_t): git_fetch_prune_t =
  case arg:
    of c_GIT_FETCH_PRUNE_UNSPECIFIED: GIT_FETCH_PRUNE_UNSPECIFIED
    of c_GIT_FETCH_PRUNE            : GIT_FETCH_PRUNE
    of c_GIT_FETCH_NO_PRUNE         : GIT_FETCH_NO_PRUNE

proc to_c_git_fetch_prune_t*(arg: git_fetch_prune_t): c_git_fetch_prune_t =
  case arg:
    of GIT_FETCH_PRUNE_UNSPECIFIED: c_GIT_FETCH_PRUNE_UNSPECIFIED
    of GIT_FETCH_PRUNE            : c_GIT_FETCH_PRUNE
    of GIT_FETCH_NO_PRUNE         : c_GIT_FETCH_NO_PRUNE

converter toCInt*(arg: c_git_fetch_prune_t): cint = cint(ord(arg))

converter toCInt*(arg: git_fetch_prune_t): cint = cint(ord(to_c_git_fetch_prune_t(arg)))

converter toCInt*(args: set[git_fetch_prune_t]): cint =
  for value in items(args):
    case value:
      of GIT_FETCH_PRUNE_UNSPECIFIED: result = cint(result or 0)
      of GIT_FETCH_PRUNE            : result = cint(result or 1)
      of GIT_FETCH_NO_PRUNE         : result = cint(result or 2)

func `-`*(arg: c_git_fetch_prune_t, offset: int): cint = cast[c_git_fetch_prune_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_fetch_prune_t): cint = cast[c_git_fetch_prune_t](ord(arg) - offset)

func `+`*(arg: c_git_fetch_prune_t, offset: int): cint = cast[c_git_fetch_prune_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_fetch_prune_t): cint = cast[c_git_fetch_prune_t](ord(arg) + offset)

converter to_git_remote_autotag_option_t*(arg: c_git_remote_autotag_option_t): git_remote_autotag_option_t =
  case arg:
    of c_GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED: GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED
    of c_GIT_REMOTE_DOWNLOAD_TAGS_AUTO       : GIT_REMOTE_DOWNLOAD_TAGS_AUTO
    of c_GIT_REMOTE_DOWNLOAD_TAGS_NONE       : GIT_REMOTE_DOWNLOAD_TAGS_NONE
    of c_GIT_REMOTE_DOWNLOAD_TAGS_ALL        : GIT_REMOTE_DOWNLOAD_TAGS_ALL

proc to_c_git_remote_autotag_option_t*(arg: git_remote_autotag_option_t): c_git_remote_autotag_option_t =
  case arg:
    of GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED: c_GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED
    of GIT_REMOTE_DOWNLOAD_TAGS_AUTO       : c_GIT_REMOTE_DOWNLOAD_TAGS_AUTO
    of GIT_REMOTE_DOWNLOAD_TAGS_NONE       : c_GIT_REMOTE_DOWNLOAD_TAGS_NONE
    of GIT_REMOTE_DOWNLOAD_TAGS_ALL        : c_GIT_REMOTE_DOWNLOAD_TAGS_ALL

converter toCInt*(arg: c_git_remote_autotag_option_t): cint = cint(ord(arg))

converter toCInt*(arg: git_remote_autotag_option_t): cint = cint(ord(to_c_git_remote_autotag_option_t(arg)))

converter toCInt*(args: set[git_remote_autotag_option_t]): cint =
  for value in items(args):
    case value:
      of GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED: result = cint(result or 0)
      of GIT_REMOTE_DOWNLOAD_TAGS_AUTO       : result = cint(result or 1)
      of GIT_REMOTE_DOWNLOAD_TAGS_NONE       : result = cint(result or 2)
      of GIT_REMOTE_DOWNLOAD_TAGS_ALL        : result = cint(result or 3)

func `-`*(arg: c_git_remote_autotag_option_t, offset: int): cint = cast[c_git_remote_autotag_option_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_remote_autotag_option_t): cint = cast[c_git_remote_autotag_option_t](ord(arg) - offset)

func `+`*(arg: c_git_remote_autotag_option_t, offset: int): cint = cast[c_git_remote_autotag_option_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_remote_autotag_option_t): cint = cast[c_git_remote_autotag_option_t](ord(arg) + offset)

converter to_git_fetch_depth_t*(arg: c_git_fetch_depth_t): git_fetch_depth_t =
  case arg:
    of c_GIT_FETCH_DEPTH_FULL     : GIT_FETCH_DEPTH_FULL
    of c_GIT_FETCH_DEPTH_UNSHALLOW: GIT_FETCH_DEPTH_UNSHALLOW

proc to_c_git_fetch_depth_t*(arg: git_fetch_depth_t): c_git_fetch_depth_t =
  case arg:
    of GIT_FETCH_DEPTH_FULL     : c_GIT_FETCH_DEPTH_FULL
    of GIT_FETCH_DEPTH_UNSHALLOW: c_GIT_FETCH_DEPTH_UNSHALLOW

converter toCInt*(arg: c_git_fetch_depth_t): cint = cint(ord(arg))

converter toCInt*(arg: git_fetch_depth_t): cint = cint(ord(to_c_git_fetch_depth_t(arg)))

converter toCInt*(args: set[git_fetch_depth_t]): cint =
  for value in items(args):
    case value:
      of GIT_FETCH_DEPTH_FULL     : result = cint(result or 0)
      of GIT_FETCH_DEPTH_UNSHALLOW: result = cint(result or 2147483647)

func `-`*(arg: c_git_fetch_depth_t, offset: int): cint = cast[c_git_fetch_depth_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_fetch_depth_t): cint = cast[c_git_fetch_depth_t](ord(arg) - offset)

func `+`*(arg: c_git_fetch_depth_t, offset: int): cint = cast[c_git_fetch_depth_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_fetch_depth_t): cint = cast[c_git_fetch_depth_t](ord(arg) + offset)

proc git_remote_create*(
    `out`: ptr ptr git_remote,
    repo: ptr git_repository,
    name: cstring,
    url: cstring,
): cint {.importc: "git_remote_create".}

proc git_remote_create_options_init*(opts: ptr git_remote_create_options, version: cuint): cint {.importc: "git_remote_create_options_init".}

proc git_remote_create_with_opts*(
    `out`: ptr ptr git_remote,
    url: cstring,
    opts: ptr git_remote_create_options,
): cint {.importc: "git_remote_create_with_opts".}

proc git_remote_create_with_fetchspec*(
    `out`: ptr ptr git_remote,
    repo: ptr git_repository,
    name: cstring,
    url: cstring,
    fetch: cstring,
): cint {.importc: "git_remote_create_with_fetchspec".}

proc git_remote_create_anonymous*(
    `out`: ptr ptr git_remote,
    repo: ptr git_repository,
    url: cstring,
): cint {.importc: "git_remote_create_anonymous".}

proc git_remote_create_detached*(`out`: ptr ptr git_remote, url: cstring): cint {.importc: "git_remote_create_detached".}

proc git_remote_lookup*(
    `out`: ptr ptr git_remote,
    repo: ptr git_repository,
    name: cstring,
): cint {.importc: "git_remote_lookup".}

proc git_remote_dup*(dest: ptr ptr git_remote, source: ptr git_remote): cint {.importc: "git_remote_dup".}

proc git_remote_owner*(remote: ptr git_remote): ptr git_repository {.importc: "git_remote_owner".}

proc git_remote_name*(remote: ptr git_remote): cstring {.importc: "git_remote_name".}

proc git_remote_url*(remote: ptr git_remote): cstring {.importc: "git_remote_url".}

proc git_remote_pushurl*(remote: ptr git_remote): cstring {.importc: "git_remote_pushurl".}

proc git_remote_set_url*(
    repo: ptr git_repository,
    remote: cstring,
    url: cstring,
): cint {.importc: "git_remote_set_url".}

proc git_remote_set_pushurl*(
    repo: ptr git_repository,
    remote: cstring,
    url: cstring,
): cint {.importc: "git_remote_set_pushurl".}

proc git_remote_set_instance_url*(remote: ptr git_remote, url: cstring): cint {.importc: "git_remote_set_instance_url".}

proc git_remote_set_instance_pushurl*(remote: ptr git_remote, url: cstring): cint {.importc: "git_remote_set_instance_pushurl".}

proc git_remote_add_fetch*(
    repo: ptr git_repository,
    remote: cstring,
    refspec: cstring,
): cint {.importc: "git_remote_add_fetch".}

proc git_remote_get_fetch_refspecs*(array: ptr git_strarray, remote: ptr git_remote): cint {.importc: "git_remote_get_fetch_refspecs".}

proc git_remote_add_push*(
    repo: ptr git_repository,
    remote: cstring,
    refspec: cstring,
): cint {.importc: "git_remote_add_push".}

proc git_remote_get_push_refspecs*(array: ptr git_strarray, remote: ptr git_remote): cint {.importc: "git_remote_get_push_refspecs".}

proc git_remote_refspec_count*(remote: ptr git_remote): csize_t {.importc: "git_remote_refspec_count".}

proc git_remote_get_refspec*(remote: ptr git_remote, n: csize_t): ptr git_refspec {.importc: "git_remote_get_refspec".}

proc git_remote_ls*(
    `out`: ptr ptr ptr git_remote_head,
    size: ptr csize_t,
    remote: ptr git_remote,
): cint {.importc: "git_remote_ls".}

proc git_remote_connected*(remote: ptr git_remote): cint {.importc: "git_remote_connected".}

proc git_remote_stop*(remote: ptr git_remote): cint {.importc: "git_remote_stop".}

proc git_remote_disconnect*(remote: ptr git_remote): cint {.importc: "git_remote_disconnect".}

proc git_remote_free*(remote: ptr git_remote): void {.importc: "git_remote_free".}

proc git_remote_list*(`out`: ptr git_strarray, repo: ptr git_repository): cint {.importc: "git_remote_list".}

proc git_remote_init_callbacks*(opts: ptr git_remote_callbacks, version: cuint): cint {.importc: "git_remote_init_callbacks".}

proc git_fetch_options_init*(opts: ptr git_fetch_options, version: cuint): cint {.importc: "git_fetch_options_init".}

proc git_push_options_init*(opts: ptr git_push_options, version: cuint): cint {.importc: "git_push_options_init".}

proc git_remote_connect_options_init*(opts: ptr git_remote_connect_options, version: cuint): cint {.importc: "git_remote_connect_options_init".}

proc git_remote_connect*(
    remote: ptr git_remote,
    direction: git_direction,
    callbacks: ptr git_remote_callbacks,
    proxy_opts: ptr git_proxy_options,
    custom_headers: ptr git_strarray,
): cint {.importc: "git_remote_connect".}

proc git_remote_connect_ext*(
    remote: ptr git_remote,
    direction: git_direction,
    opts: ptr git_remote_connect_options,
): cint {.importc: "git_remote_connect_ext".}

proc git_remote_download*(
    remote: ptr git_remote,
    refspecs: ptr git_strarray,
    opts: ptr git_fetch_options,
): cint {.importc: "git_remote_download".}

proc git_remote_upload*(
    remote: ptr git_remote,
    refspecs: ptr git_strarray,
    opts: ptr git_push_options,
): cint {.importc: "git_remote_upload".}

proc git_remote_update_tips*(
    remote: ptr git_remote,
    callbacks: ptr git_remote_callbacks,
    update_flags: cuint,
    download_tags: git_remote_autotag_option_t,
    reflog_message: cstring,
): cint {.importc: "git_remote_update_tips".}

proc git_remote_fetch*(
    remote: ptr git_remote,
    refspecs: ptr git_strarray,
    opts: ptr git_fetch_options,
    reflog_message: cstring,
): cint {.importc: "git_remote_fetch".}

proc git_remote_prune*(remote: ptr git_remote, callbacks: ptr git_remote_callbacks): cint {.importc: "git_remote_prune".}

proc git_remote_push*(
    remote: ptr git_remote,
    refspecs: ptr git_strarray,
    opts: ptr git_push_options,
): cint {.importc: "git_remote_push".}

proc git_remote_stats*(remote: ptr git_remote): ptr git_indexer_progress {.importc: "git_remote_stats".}

proc git_remote_autotag*(remote: ptr git_remote): git_remote_autotag_option_t {.importc: "git_remote_autotag".}

proc git_remote_set_autotag*(
    repo: ptr git_repository,
    remote: cstring,
    value: git_remote_autotag_option_t,
): cint {.importc: "git_remote_set_autotag".}

proc git_remote_prune_refs*(remote: ptr git_remote): cint {.importc: "git_remote_prune_refs".}

proc git_remote_rename*(
    problems: ptr git_strarray,
    repo: ptr git_repository,
    name: cstring,
    new_name: cstring,
): cint {.importc: "git_remote_rename".}

proc git_remote_name_is_valid*(valid: ptr cint, remote_name: cstring): cint {.importc: "git_remote_name_is_valid".}

proc git_remote_delete*(repo: ptr git_repository, name: cstring): cint {.importc: "git_remote_delete".}

proc git_remote_default_branch*(`out`: ptr git_buf, remote: ptr git_remote): cint {.importc: "git_remote_default_branch".}

converter to_git_smart_service_t*(arg: c_git_smart_service_t): git_smart_service_t =
  case arg:
    of c_GIT_SERVICE_UPLOADPACK_LS : GIT_SERVICE_UPLOADPACK_LS
    of c_GIT_SERVICE_UPLOADPACK    : GIT_SERVICE_UPLOADPACK
    of c_GIT_SERVICE_RECEIVEPACK_LS: GIT_SERVICE_RECEIVEPACK_LS
    of c_GIT_SERVICE_RECEIVEPACK   : GIT_SERVICE_RECEIVEPACK

proc to_c_git_smart_service_t*(arg: git_smart_service_t): c_git_smart_service_t =
  case arg:
    of GIT_SERVICE_UPLOADPACK_LS : c_GIT_SERVICE_UPLOADPACK_LS
    of GIT_SERVICE_UPLOADPACK    : c_GIT_SERVICE_UPLOADPACK
    of GIT_SERVICE_RECEIVEPACK_LS: c_GIT_SERVICE_RECEIVEPACK_LS
    of GIT_SERVICE_RECEIVEPACK   : c_GIT_SERVICE_RECEIVEPACK

converter toCInt*(arg: c_git_smart_service_t): cint = cint(ord(arg))

converter toCInt*(arg: git_smart_service_t): cint = cint(ord(to_c_git_smart_service_t(arg)))

converter toCInt*(args: set[git_smart_service_t]): cint =
  for value in items(args):
    case value:
      of GIT_SERVICE_UPLOADPACK_LS : result = cint(result or 1)
      of GIT_SERVICE_UPLOADPACK    : result = cint(result or 2)
      of GIT_SERVICE_RECEIVEPACK_LS: result = cint(result or 3)
      of GIT_SERVICE_RECEIVEPACK   : result = cint(result or 4)

func `-`*(arg: c_git_smart_service_t, offset: int): cint = cast[c_git_smart_service_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_smart_service_t): cint = cast[c_git_smart_service_t](ord(arg) - offset)

func `+`*(arg: c_git_smart_service_t, offset: int): cint = cast[c_git_smart_service_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_smart_service_t): cint = cast[c_git_smart_service_t](ord(arg) + offset)

proc git_transport_init*(opts: ptr git_transport, version: cuint): cint {.importc: "git_transport_init".}

proc git_transport_new*(
    `out`: ptr ptr git_transport,
    owner: ptr git_remote,
    url: cstring,
): cint {.importc: "git_transport_new".}

proc git_transport_ssh_with_paths*(
    `out`: ptr ptr git_transport,
    owner: ptr git_remote,
    payload: pointer,
): cint {.importc: "git_transport_ssh_with_paths".}

proc git_transport_register*(
    prefix: cstring,
    cb: git_transport_cb,
    param: pointer,
): cint {.importc: "git_transport_register".}

proc git_transport_unregister*(prefix: cstring): cint {.importc: "git_transport_unregister".}

proc git_transport_dummy*(
    `out`: ptr ptr git_transport,
    owner: ptr git_remote,
    payload: pointer,
): cint {.importc: "git_transport_dummy".}

proc git_transport_local*(
    `out`: ptr ptr git_transport,
    owner: ptr git_remote,
    payload: pointer,
): cint {.importc: "git_transport_local".}

proc git_transport_smart*(
    `out`: ptr ptr git_transport,
    owner: ptr git_remote,
    payload: pointer,
): cint {.importc: "git_transport_smart".}

proc git_transport_smart_certificate_check*(
    transport: ptr git_transport,
    cert: ptr git_cert,
    valid: cint,
    hostname: cstring,
): cint {.importc: "git_transport_smart_certificate_check".}

proc git_transport_smart_credentials*(
    `out`: ptr ptr git_credential,
    transport: ptr git_transport,
    user: cstring,
    methods: cint,
): cint {.importc: "git_transport_smart_credentials".}

proc git_transport_remote_connect_options*(`out`: ptr git_remote_connect_options, transport: ptr git_transport): cint {.importc: "git_transport_remote_connect_options".}

proc git_smart_subtransport_http*(
    `out`: ptr ptr git_smart_subtransport,
    owner: ptr git_transport,
    param: pointer,
): cint {.importc: "git_smart_subtransport_http".}

proc git_smart_subtransport_git*(
    `out`: ptr ptr git_smart_subtransport,
    owner: ptr git_transport,
    param: pointer,
): cint {.importc: "git_smart_subtransport_git".}

proc git_smart_subtransport_ssh*(
    `out`: ptr ptr git_smart_subtransport,
    owner: ptr git_transport,
    param: pointer,
): cint {.importc: "git_smart_subtransport_ssh".}