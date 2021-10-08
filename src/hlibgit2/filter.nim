
import
  . / config

import
  . /
      apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

export
  apply_attr_blame_blob_buffer_cert_checkout_cherrypick_clone_commit_config_credential_credential_helpers_describe_diff_errors_filter_index_indexer_merge_message_net_notes_odb_odb_backend_oid_oidarray_pack_proxy_rebase_refs_remote_repository_r

proc git_filter_list_load*(filters: ptr ptr git_filter_list;
                           repo: ptr git_repository; blob: ptr git_blob;
                           path: cstring; mode: git_filter_mode_t; flags: uint32): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_contains*(filters: ptr git_filter_list; name: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_data*(arg_out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    arg_in: ptr git_buf): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_file*(arg_out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    repo: ptr git_repository; path: cstring): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_apply_to_blob*(arg_out: ptr git_buf;
                                    filters: ptr git_filter_list;
                                    blob: ptr git_blob): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_data*(filters: ptr git_filter_list;
                                  data: ptr git_buf; target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_file*(filters: ptr git_filter_list;
                                  repo: ptr git_repository; path: cstring;
                                  target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_stream_blob*(filters: ptr git_filter_list;
                                  blob: ptr git_blob;
                                  target: ptr git_writestream): cint {.
    dynlib: libgitDl, importc.}
proc git_filter_list_free*(filters: ptr git_filter_list): void {.
    dynlib: libgitDl, importc.}