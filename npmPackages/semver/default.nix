{ fetchurl, buildNpmPackage, tap }:

buildNpmPackage rec {
  pname = "semver";
  version = "5.7.1";
  src = fetchurl {
    url = "https://github.com/npm/node-semver/archive/v${version}.tar.gz";
    sha256 = "19x7ngr273pbbiar0vzpqqjl9lsrdpmddwaw1sca2w9a36q744f5";
  };

  npmInputs = [
    tap
  ];


}
