{ fetchgit, buildNpmPackage, covert, tap, tape }:

buildNpmPackage rec {
  pname = "minimist";
  version = "1.2.0";
  src = fetchgit {
    url = "https://github.com/substack/minimist.git";
    rev = "4cf45a26b9af5f4ddab63107f4007485e576cfd3";
    sha256 = "0c7zrb4s7x3alx38pp5s844a0v3fy8wb0y1x5lzg5w0b1m3nshlx";
  };

  npmInputs = [ covert tap tape ];

  files = [ "index.js" ];
}
