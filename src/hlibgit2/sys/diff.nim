import "../types.nim"
import "../diff.nim"

type
  git_diff_perfdata* {.bycopy.} = object
    version          *: cuint
    stat_calls       *: csize_t
    oid_calculations *: csize_t



proc git_diff_print_callback_to_buf*(
    delta: ptr git_diff_delta,
    hunk: ptr git_diff_hunk,
    line: ptr git_diff_line,
    payload: pointer,
): cint {.importc: "git_diff_print_callback__to_buf".}

proc git_diff_print_callback_to_file_handle*(
    delta: ptr git_diff_delta,
    hunk: ptr git_diff_hunk,
    line: ptr git_diff_line,
    payload: pointer,
): cint {.importc: "git_diff_print_callback__to_file_handle".}

proc git_diff_get_perfdata*(`out`: ptr git_diff_perfdata, diff: ptr git_diff): cint {.importc: "git_diff_get_perfdata".}

proc git_status_list_get_perfdata*(`out`: ptr git_diff_perfdata, status: ptr git_status_list): cint {.importc: "git_status_list_get_perfdata".}