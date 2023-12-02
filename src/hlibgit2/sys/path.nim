import "../libgit2_config.nim" ## From gen file

type
  c_git_path_gitfile* {.size: sizeof(cint).} = enum
    c_GIT_PATH_GITFILE_GITIGNORE     = 0
    c_GIT_PATH_GITFILE_GITMODULES    = 1
    c_GIT_PATH_GITFILE_GITATTRIBUTES = 2

  git_path_gitfile* = enum
    GIT_PATH_GITFILE_GITIGNORE
    GIT_PATH_GITFILE_GITMODULES
    GIT_PATH_GITFILE_GITATTRIBUTES

  c_git_path_fs* {.size: sizeof(cint).} = enum
    c_GIT_PATH_FS_GENERIC = 0
    c_GIT_PATH_FS_NTFS    = 1
    c_GIT_PATH_FS_HFS     = 2

  git_path_fs* = enum
    GIT_PATH_FS_GENERIC
    GIT_PATH_FS_NTFS
    GIT_PATH_FS_HFS



converter toCInt*(arg: c_git_path_gitfile): cint = cint(ord(arg))

converter toCInt*(args: set[git_path_gitfile]): cint =
  for value in items(args):
    case value:
      of GIT_PATH_GITFILE_GITIGNORE    : result = cint(result or 0)
      of GIT_PATH_GITFILE_GITMODULES   : result = cint(result or 1)
      of GIT_PATH_GITFILE_GITATTRIBUTES: result = cint(result or 2)

func `-`*(arg: c_git_path_gitfile, offset: int): cint = cast[c_git_path_gitfile](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_path_gitfile): cint = cast[c_git_path_gitfile](ord(arg) - offset)

func `+`*(arg: c_git_path_gitfile, offset: int): cint = cast[c_git_path_gitfile](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_path_gitfile): cint = cast[c_git_path_gitfile](ord(arg) + offset)

converter toCInt*(arg: c_git_path_fs): cint = cint(ord(arg))

converter toCInt*(args: set[git_path_fs]): cint =
  for value in items(args):
    case value:
      of GIT_PATH_FS_GENERIC: result = cint(result or 0)
      of GIT_PATH_FS_NTFS   : result = cint(result or 1)
      of GIT_PATH_FS_HFS    : result = cint(result or 2)

func `-`*(arg: c_git_path_fs, offset: int): cint = cast[c_git_path_fs](ord(arg) - offset)

func `-`*(offset: int, arg: c_git_path_fs): cint = cast[c_git_path_fs](ord(arg) - offset)

func `+`*(arg: c_git_path_fs, offset: int): cint = cast[c_git_path_fs](ord(arg) + offset)

func `+`*(offset: int, arg: c_git_path_fs): cint = cast[c_git_path_fs](ord(arg) + offset)

proc git_path_is_gitfile*(path: cstring, pathlen: csize_t, gitfile: git_path_gitfile, fs: git_path_fs): cint {.git2Proc, importc: "git_path_is_gitfile".}