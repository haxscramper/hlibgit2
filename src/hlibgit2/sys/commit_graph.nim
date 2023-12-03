import "../libgit2_config.nim" ## From gen file
import "../buffer.nim"
import "../types.nim"

type
  git_commit_graph_writer_options* {.bycopy.} = object
    version        *: cuint
    split_strategy *: git_commit_graph_split_strategy_t
    size_multiple  *: cfloat
    max_commits    *: csize_t

  c_git_commit_graph_split_strategy_t* {.size: sizeof(cint).} = enum
    c_GIT_COMMIT_GRAPH_SPLIT_STRATEGY_SINGLE_FILE = 0

  git_commit_graph_split_strategy_t* = enum
    GIT_COMMIT_GRAPH_SPLIT_STRATEGY_SINGLE_FILE



converter toCInt*(arg: c_git_commit_graph_split_strategy_t): cint = cint(ord(arg))

converter toCInt*(args: set[git_commit_graph_split_strategy_t]): cint =
  for value in items(args):
    case value:
      of GIT_COMMIT_GRAPH_SPLIT_STRATEGY_SINGLE_FILE: result = cint(result or 0)

func `-`*(arg: c_git_commit_graph_split_strategy_t, offset: int): cint = cast[c_git_commit_graph_split_strategy_t](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_commit_graph_split_strategy_t): cint = cast[c_git_commit_graph_split_strategy_t](ord(arg) - offset)

func `+`*(arg: c_git_commit_graph_split_strategy_t, offset: int): cint = cast[c_git_commit_graph_split_strategy_t](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_commit_graph_split_strategy_t): cint = cast[c_git_commit_graph_split_strategy_t](ord(arg) + offset)

proc git_commit_graph_open*(cgraph_out: ptr ptr git_commit_graph, objects_dir: cstring): cint {.git2Proc, importc: "git_commit_graph_open".}

proc git_commit_graph_free*(cgraph: ptr git_commit_graph): void {.git2Proc, importc: "git_commit_graph_free".}

proc git_commit_graph_writer_new*(`out`: ptr ptr git_commit_graph_writer, objects_info_dir: cstring): cint {.git2Proc, importc: "git_commit_graph_writer_new".}

proc git_commit_graph_writer_free*(w: ptr git_commit_graph_writer): void {.git2Proc, importc: "git_commit_graph_writer_free".}

proc git_commit_graph_writer_add_index_file*(
    w: ptr git_commit_graph_writer,
    repo: ptr git_repository,
    idx_path: cstring,
): cint {.git2Proc, importc: "git_commit_graph_writer_add_index_file".}

proc git_commit_graph_writer_add_revwalk*(w: ptr git_commit_graph_writer, walk: ptr git_revwalk): cint {.git2Proc, importc: "git_commit_graph_writer_add_revwalk".}

proc git_commit_graph_writer_options_init*(opts: ptr git_commit_graph_writer_options, version: cuint): cint {.git2Proc, importc: "git_commit_graph_writer_options_init".}

proc git_commit_graph_writer_commit*(w: ptr git_commit_graph_writer, opts: ptr git_commit_graph_writer_options): cint {.git2Proc, importc: "git_commit_graph_writer_commit".}

proc git_commit_graph_writer_dump*(
    buffer: ptr git_buf,
    w: ptr git_commit_graph_writer,
    opts: ptr git_commit_graph_writer_options,
): cint {.git2Proc, importc: "git_commit_graph_writer_dump".}