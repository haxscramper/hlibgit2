{.push warning[UnusedImport]:off.}

{.passc: "-I/usr/include".}

import hlibgit2/[
  annotated_commit,
  apply,
  attr,
  blame,
  blob,
  branch,
  buffer,
  cert,
  checkout,
  cherrypick,
  clone,
  commit,
  common,
  config,
  credential_helpers,
  credential,
  deprecated,
  describe,
  diff,
  errors,
  filter,
  global,
  graph,
  ignore,
  indexer,
  index,
  mailmap,
  merge,
  message,
  net,
  notes,
  "object",
  odb,
  oidarray,
  oid,
  pack,
  patch,
  pathspec,
  proxy,
  rebase,
  refdb,
  reflog,
  refs,
  refspec,
  remote,
  repository,
  reset,
  revert,
  revparse,
  revwalk,
  signature,
  stash,
  status,
  strarray,
  submodule,
  tag,
  trace,
  transaction,
  tree,
  types,
  worktree
]

assert git_libgit2_init() == 1

echo "libgit test ok"

if false:
  block:
    var a: git_strarray

  block:
    var c: ptr git_credential
