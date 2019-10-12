{ fetchurl, buildNpmPackage, brace-expansion, tap }:

buildNpmPackage {
  pname = "minimatch";
  version = "3.0.4";
  src = fetchurl {
    url = "https://github.com/isaacs/minimatch/archive/v3.0.4.tar.gz";
    sha256 = "0wla3cbrnm55nx5x1fgaax8a89pyz5hrb29f4fbw1a11v12mjasd";
  };

  meta = {
    description = "a glob matcher in javascript";
    homepage = "";
    license = "ISC";
  };

  npmInputs = [
    brace-expansion tap
  ];

  jailbreak = true;

}

