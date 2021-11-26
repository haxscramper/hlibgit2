import hcparse
import hmisc/core/all
import hmisc/other/[oswrap, hpprint]
import hmisc/scripts/nim_test
startHax()

# For now I don't care, in the future this must be done by reading package
# dependencies.
let package = "hlibgit2"
let state = getCwdNimDump()
let l = newTermLogger()

let resultGrouped = wrapCSharedLibViaTsWave(
  inDir       = AbsDir"/usr/include/git2",
  outDir      = currentAbsSourceDir(),
  tmpDir      = getAppTempDir() / "v4",
  libName     = "git2",
  packageName = package,
  ignoreIn    = @["stdint"],
  typeMaps    = state.paths.findImportMaps(cwd()),
  extraTypes  = @{
    cxxName("git_iterator"): cxxLibImport(package, @["libgit2_config"])
  }
)

l.info "Generation done"

validateGenerated(
  resultGrouped,
  some AbsDir(relToSource"../../tests"),
  some state
)

l.info "Tests ok"
