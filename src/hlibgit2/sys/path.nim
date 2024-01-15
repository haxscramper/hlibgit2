type
  c_git_path_gitfile* {.size: sizeof(cint).} = enum
    c_GIT_PATH_GITFILE_GITIGNORE     = 0
    c_GIT_PATH_GITFILE_GITMODULES    = 1
    c_GIT_PATH_GITFILE_GITATTRIBUTES = 2

  git_path_gitfile* = enum
    GIT_PATH_GITFILE_GITIGNORE     = 0
    GIT_PATH_GITFILE_GITMODULES    = 1
    GIT_PATH_GITFILE_GITATTRIBUTES = 2

  c_git_path_fs* {.size: sizeof(cint).} = enum
    c_GIT_PATH_FS_GENERIC = 0
    c_GIT_PATH_FS_NTFS    = 1
    c_GIT_PATH_FS_HFS     = 2

  git_path_fs* = enum
    GIT_PATH_FS_GENERIC = 0
    GIT_PATH_FS_NTFS    = 1
    GIT_PATH_FS_HFS     = 2



converter to_git_path_gitfile*(arg: c_git_path_gitfile): git_path_gitfile =
  case arg:
    of c_GIT_PATH_GITFILE_GITIGNORE    : GIT_PATH_GITFILE_GITIGNORE
    of c_GIT_PATH_GITFILE_GITMODULES   : GIT_PATH_GITFILE_GITMODULES
    of c_GIT_PATH_GITFILE_GITATTRIBUTES: GIT_PATH_GITFILE_GITATTRIBUTES

proc to_c_git_path_gitfile*(arg: git_path_gitfile): c_git_path_gitfile =
  case arg:
    of GIT_PATH_GITFILE_GITIGNORE    : c_GIT_PATH_GITFILE_GITIGNORE
    of GIT_PATH_GITFILE_GITMODULES   : c_GIT_PATH_GITFILE_GITMODULES
    of GIT_PATH_GITFILE_GITATTRIBUTES: c_GIT_PATH_GITFILE_GITATTRIBUTES

converter toCInt*(arg: c_git_path_gitfile): cint = cint(ord(arg))

converter toCInt*(arg: git_path_gitfile): cint = cint(ord(to_c_git_path_gitfile(arg)))

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

converter to_git_path_fs*(arg: c_git_path_fs): git_path_fs =
  case arg:
    of c_GIT_PATH_FS_GENERIC: GIT_PATH_FS_GENERIC
    of c_GIT_PATH_FS_NTFS   : GIT_PATH_FS_NTFS
    of c_GIT_PATH_FS_HFS    : GIT_PATH_FS_HFS

proc to_c_git_path_fs*(arg: git_path_fs): c_git_path_fs =
  case arg:
    of GIT_PATH_FS_GENERIC: c_GIT_PATH_FS_GENERIC
    of GIT_PATH_FS_NTFS   : c_GIT_PATH_FS_NTFS
    of GIT_PATH_FS_HFS    : c_GIT_PATH_FS_HFS

converter toCInt*(arg: c_git_path_fs): cint = cint(ord(arg))

converter toCInt*(arg: git_path_fs): cint = cint(ord(to_c_git_path_fs(arg)))

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

proc git_path_is_gitfile*(
    path: cstring,
    pathlen: csize_t,
    gitfile: git_path_gitfile,
    fs: git_path_fs,
): cint {.importc: "git_path_is_gitfile".}