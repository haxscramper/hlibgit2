import
  hcparse

import
  compiler/ast,
  hnimast/hast_common

import
  hmisc/other/oswrap,
  hmisc/core/all,
  hmisc/algo/[hstring_algo]

startHax()

var fixConf = baseFixConf

fixConf.isIcpp = false
fixConf.libName = "git"

fixConf.onGetBind():
  case entry.kind:
    of cekProc: result = cxxDynlibVar("libgitDl")
    else: result = cxxNoBind()

  result.imports.add cxxLibImport(
    fixConf.libName, @["config"])

fixConf.libNameStyle = idsSnake

fixConf.onFixName():
   cache.fixContextedName(name, fixConf.libNameStyle)

fixConf.typeStore = newTypeStore()

let
  outDir = oswrap.currentSourceDir()
  tmpDir = getAppTempDir()

mkDir tmpDir
let lib = AbsDir"/usr/include/git2"
var cache = newWaveCache()
for file in walkDir(lib, AbsFile):
  if file.name() notin [
    "stdint" # Use this header only with Microsoft Visual C++ compilers!
  ]:
    let resFile = (tmpDir /. file.name()) &. "h"

    if not exists(resFile):
      echov resFile
      var reader = newWaveReader(file, cache, @[], @[
        "/usr/include/sys",
        "/usr/include",
        "/usr/include/linux"
      ])


      resFile.writeFile(reader.getExpanded())


for file in walkDir(outDir, AbsFile, exts = @["nim"]):
  if file.name() notin ["hcparse_generate", "config"]:
    rmFile file

var resultWrapped: seq[CxxFile]

let onefile = false

for file in walkDir(tmpDir, AbsFile, exts = @["h"]):
  resultWrapped.add wrapViaTs(file, tmpDir, fixConf)

for fix in regroupFiles(resultWrapped):
  let res = outDir / fix.getFile().withExt("nim")
  res.writeFile($toNNode[PNode](fix, cCodegenConf))
  echov res

echov "done"
