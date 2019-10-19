{ fetchurl, buildNpmPackage, balanced-match, concat-map, matcha, tape }:

buildNpmPackage {
  pname = "brace-expansion";
  version = "1.1.11";
  src = fetchurl {
    url = "https://github.com/juliangruber/brace-expansion/archive/1.1.11.tar.gz";
    sha256 = "01ndknwgnb4mga5kzm55vv2nxgd88439h4asz7irdgshsqqp2gmz";
  };

  meta = {
    description = "Brace expansion as known from sh/bash";
    homepage = "https://github.com/juliangruber/brace-expansion";
    license = "MIT";
  };

  npmInputs = [
    balanced-match concat-map matcha tape
  ];


  files = [
    "index.js"
  ];
}

