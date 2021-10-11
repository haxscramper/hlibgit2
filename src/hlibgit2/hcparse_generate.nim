import hcparse

import
  hmisc/other/[oswrap, hshell],
  hmisc/core/all

startHax()


let
  outDir = oswrap.currentSourceDir()
  tmpDir = getAppTempDir() / "v3"

let lib = AbsDir"/usr/include/git2"
var expandMap = expandViaWave(
  listFiles(lib, ignoreNames = @["stdint"]),
  tmpDir, baseCParseConf
)

rmFiles(outDir, @["nim"], @["hcparse_generate", "libgit2_config"])

let
  fixConf = initCSharedLibFixConf(
    "git2", false, lib, expandMap)

  resultWrapped = tmpDir.wrapViaTs(fixConf)
  resultGrouped = writeFiles(outDir, resultWrapped, cCodegenConf)

for file in resultGrouped:
  echov file
  try:
    execShell shellCmd(nim, check, errormax = 3, $file)
    echov "file ok"

  except ShellError:
    echov "file fail"

echov "done"
