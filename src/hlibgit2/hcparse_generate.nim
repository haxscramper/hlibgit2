import hcparse
import hmisc/core/all
import hmisc/other/oswrap
startHax()

# For now I don't care, in the future this must be done by reading package
# dependencies.
let ssh2 = AbsDir(relToSource"../../../hlibssh2/src/hlibssh2")

assertExists(ssh2)

let package = "hlibgit2"

let resultGrouped = wrapCSharedLibViaTsWave(
  inDir       = AbsDir"/usr/include/git2",
  outDir      = currentAbsSourceDir(),
  tmpDir      = getAppTempDir() / "v4",
  libName     = "git2",
  packageName = package,
  ignoreIn    = @["stdint"],
  depDirs     = @[ssh2],
  extraTypes  = @{
    cxxName("git_iterator"): cxxLibImport(package, @["libgit2_config"])
  }
)

validateGenerated(resultGrouped)
echo "done"
