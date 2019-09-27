{ fetchgit, buildNpmPackage, minimist, mock-fs, tap }:

buildNpmPackage rec {
  pname = "mkdirp";
  version = "0.5.1";
  src = fetchgit {
    url = "https://github.com/substack/node-mkdirp.git";
    rev = "f2003bbcffa80f8c9744579fabab1212fc84545a";
    sha256 = "0qc3l6571aknhlmzcyaah3plmf852cl160jihy3l4b05j25qv45a";
  };

  npmInputs = [
    minimist # only for bin/cmd.js
    mock-fs
    tap
  ];

  jailbreak = true;

  files = [
    "bin"
    "index.js"
  ];
}
