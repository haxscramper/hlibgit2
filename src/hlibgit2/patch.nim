import "./libgit2_config.nim" ## From gen file
import "./types.nim"
import "./diff.nim"
import "./buffer.nim"

type
  git_patch* {.header: "<patch.h>", importc, incompleteStruct.} = object




proc git_patch_owner*(patch: ptr git_patch): ptr git_repository {.importc: "git_patch_owner", header: "<patch.h>".}

proc git_patch_from_diff*(
    `out`: ptr ptr git_patch,
    diff: ptr git_diff,
    idx: csize_t,
): cint {.importc: "git_patch_from_diff", header: "<patch.h>".}

proc git_patch_from_blobs*(
    `out`: ptr ptr git_patch,
    old_blob: ptr git_blob,
    old_as_path: cstring,
    new_blob: ptr git_blob,
    new_as_path: cstring,
    opts: ptr git_diff_options,
): cint {.importc: "git_patch_from_blobs", header: "<patch.h>".}

proc git_patch_from_blob_and_buffer*(
    `out`: ptr ptr git_patch,
    old_blob: ptr git_blob,
    old_as_path: cstring,
    buffer: pointer,
    buffer_len: csize_t,
    buffer_as_path: cstring,
    opts: ptr git_diff_options,
): cint {.importc: "git_patch_from_blob_and_buffer", header: "<patch.h>".}

proc git_patch_from_buffers*(
    `out`: ptr ptr git_patch,
    old_buffer: pointer,
    old_len: csize_t,
    old_as_path: cstring,
    new_buffer: pointer,
    new_len: csize_t,
    new_as_path: cstring,
    opts: ptr git_diff_options,
): cint {.importc: "git_patch_from_buffers", header: "<patch.h>".}

proc git_patch_free*(patch: ptr git_patch): void {.importc: "git_patch_free", header: "<patch.h>".}

proc git_patch_get_delta*(patch: ptr git_patch): ptr git_diff_delta {.importc: "git_patch_get_delta", header: "<patch.h>".}

proc git_patch_num_hunks*(patch: ptr git_patch): csize_t {.importc: "git_patch_num_hunks", header: "<patch.h>".}

proc git_patch_line_stats*(
    total_context: ptr csize_t,
    total_additions: ptr csize_t,
    total_deletions: ptr csize_t,
    patch: ptr git_patch,
): cint {.importc: "git_patch_line_stats", header: "<patch.h>".}

proc git_patch_get_hunk*(
    `out`: ptr ptr git_diff_hunk,
    lines_in_hunk: ptr csize_t,
    patch: ptr git_patch,
    hunk_idx: csize_t,
): cint {.importc: "git_patch_get_hunk", header: "<patch.h>".}

proc git_patch_num_lines_in_hunk*(patch: ptr git_patch, hunk_idx: csize_t): cint {.importc: "git_patch_num_lines_in_hunk", header: "<patch.h>".}

proc git_patch_get_line_in_hunk*(
    `out`: ptr ptr git_diff_line,
    patch: ptr git_patch,
    hunk_idx: csize_t,
    line_of_hunk: csize_t,
): cint {.importc: "git_patch_get_line_in_hunk", header: "<patch.h>".}

proc git_patch_size*(
    patch: ptr git_patch,
    include_context: cint,
    include_hunk_headers: cint,
    include_file_headers: cint,
): csize_t {.importc: "git_patch_size", header: "<patch.h>".}

proc git_patch_print*(
    patch: ptr git_patch,
    print_cb: git_diff_line_cb,
    payload: pointer,
): cint {.importc: "git_patch_print", header: "<patch.h>".}

proc git_patch_to_buf*(`out`: ptr git_buf, patch: ptr git_patch): cint {.importc: "git_patch_to_buf", header: "<patch.h>".}