import hcparse

let resultGrouped = wrapCSharedLibViaTsWave(
  inDir = AbsDir"/usr/include/git2",
  outDir = currentAbsSourceDir(),
  tmpDir = getAppTempDir() / "v4",
  libName = "git2",
  ignoreIn = @["stdint"]
)

validateGenerated(resultGrouped)
echo "done"
