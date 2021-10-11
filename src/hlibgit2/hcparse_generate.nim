import
  hcparse,
  hcparse/hc_grouping,
  hmisc/hasts/graphviz_ast,
  hmisc/types/hgraph

import
  compiler/ast,
  hnimast/[hast_common, pprint]

import
  hmisc/other/[oswrap, hshell],
  hmisc/core/all,
  hmisc/algo/[hstring_algo]

import
  std/[tables, sequtils]

startHax()


let
  outDir = oswrap.currentSourceDir()
  tmpDir = getAppTempDir() / "v2"

mkDir tmpDir
let lib = AbsDir"/usr/include/git2"
var cache = newWaveCache()
var expandMap: Table[AbsFile, AbsFile]

for file in walkDir(lib, AbsFile):
  if file.name() notin [
    "stdint" # Use this header only with Microsoft Visual C++ compilers!
  ]:
    let resFile = (tmpDir /. file.name()) &. "h"
    expandMap[resFile] = file

    if not exists(resFile):
      echov "expanding", file.name(), "to", resFile
      var reader = newWaveReader(file, cache, @[], @[
        "/usr/include/sys",
        "/usr/include",
        "/usr/include/linux"
      ])

      resFile.writeFile(reader.getExpanded())

for file in walkDir(outDir, AbsFile, exts = @["nim"]):
  if file.name() notin ["hcparse_generate", "libgit_config"]:
    rmFile file

var
  resultWrapped: seq[CxxFile]
  fixConf = baseFixConf

fixConf.isIcpp = false
fixConf.libName = "git"

fixConf.onGetBind():
  case entry.kind:
    of cekProc: result = cxxDynlibVar("libgitDl")
    of cekObject:
      let base = expandMap[entry.getLocation.file].string
      let path = base.string.dropPrefix(lib.string)
      result = cxxHeader("<git2" & path & ">")

    else:
      result = cxxNoBind()

  result.imports.add cxxLibImport(
    fixConf.libName, @["libgit_config"])

fixConf.libNameStyle = idsSnake

fixConf.onFixName():
   cache.fixContextedName(name, fixConf.libNameStyle)

fixConf.typeStore = newTypeStore()

var nonEmpty: seq[AbsFile]

for file in walkDir(tmpDir, AbsFile, exts = @["h"]):
  let res = wrapViaTs(file, tmpDir, fixConf)
  resultWrapped.add res

var resList: seq[AbsFile]
let group = regroupFiles(resultWrapped)
let path = getAppTempFile("graph.png")
let g = group.buildTypeGraph()
echov path
g.dotRepr().toPng(path)

for fix in group:
  let res = outDir / fix.getFile().withExt("nim")
  res.writeFile(toNNode[PNode](fix, cCodegenConf).toPString())
  resList.add res

for file in resList:
  echov file
  execShell shellCmd(nim, check, errormax = 3, $file)

echov "done"
