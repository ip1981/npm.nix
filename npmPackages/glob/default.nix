{ fetchurl, buildNpmPackage, fs-realpath, inflight, inherits, minimatch, mkdirp, once
, rimraf, tap, tick }:

buildNpmPackage {
  pname = "glob";
  version = "7.1.4";
  src = fetchurl {
    url = "https://github.com/isaacs/node-glob/archive/v7.1.4.tar.gz";
    sha256 = "0bl0hcxcwhq9jj47ig6212ws0nhpwbm6666jf9jvzfr7f43ab94k";
  };

  meta = {
    description = "a little globber";
    homepage = "";
    license = "ISC";
  };

  npmInputs = [
    fs-realpath inflight inherits minimatch mkdirp once rimraf tap
    tick
  ];


  patches = [
    ./path-is-absolute.patch
  ];
}

