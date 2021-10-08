
import
  . / diff

import
  . / buffer

import
  . / config

type
  git_patch* {.bycopy, incompleteStruct, importc.} = object
  
proc git_patch_from_diff*(arg_out: ptr ptr git_patch; diff: ptr git_diff;
                          idx: size_t): cint {.dynlib: libgitDl, importc.}
proc git_patch_from_blobs*(arg_out: ptr ptr git_patch; old_blob: ptr git_blob;
                           old_as_path: cstring; new_blob: ptr git_blob;
                           new_as_path: cstring; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_blob_and_buffer*(arg_out: ptr ptr git_patch;
                                     old_blob: ptr git_blob;
                                     old_as_path: cstring; buffer: pointer;
                                     buffer_len: size_t;
                                     buffer_as_path: cstring;
                                     opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_from_buffers*(arg_out: ptr ptr git_patch; old_buffer: pointer;
                             old_len: size_t; old_as_path: cstring;
                             new_buffer: pointer; new_len: size_t;
                             new_as_path: cstring; opts: ptr git_diff_options): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_free*(patch: ptr git_patch): void {.dynlib: libgitDl, importc.}
proc git_patch_get_delta*(patch: ptr git_patch): ptr git_diff_delta {.
    dynlib: libgitDl, importc.}
proc git_patch_num_hunks*(patch: ptr git_patch): size_t {.dynlib: libgitDl,
    importc.}
proc git_patch_line_stats*(total_context: ptr size_t;
                           total_additions: ptr size_t;
                           total_deletions: ptr size_t; patch: ptr git_patch): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_get_hunk*(arg_out: ptr ptr git_diff_hunk;
                         lines_in_hunk: ptr size_t; patch: ptr git_patch;
                         hunk_idx: size_t): cint {.dynlib: libgitDl, importc.}
proc git_patch_num_lines_in_hunk*(patch: ptr git_patch; hunk_idx: size_t): cint {.
    dynlib: libgitDl, importc.}
proc git_patch_get_line_in_hunk*(arg_out: ptr ptr git_diff_line;
                                 patch: ptr git_patch; hunk_idx: size_t;
                                 line_of_hunk: size_t): cint {.dynlib: libgitDl,
    importc.}
proc git_patch_size*(patch: ptr git_patch; include_context: cint;
                     include_hunk_headers: cint; include_file_headers: cint): size_t {.
    dynlib: libgitDl, importc.}
proc git_patch_print*(patch: ptr git_patch; print_cb: git_diff_line_cb;
                      payload: pointer): cint {.dynlib: libgitDl, importc.}
proc git_patch_to_buf*(arg_out: ptr git_buf; patch: ptr git_patch): cint {.
    dynlib: libgitDl, importc.}