{ fetchurl, buildNpmPackage, tap }:

buildNpmPackage {
  pname = "fs.realpath";
  version = "1.0.0";
  src = fetchurl {
    url = "https://github.com/isaacs/fs.realpath/archive/v1.0.0.tar.gz";
    sha256 = "16ybsq9mxm1cwwpx2j3k2pffznsqil13ifkwf6q8q2dpavmsy5k2";
  };

  meta = {
    description = "Use node's fs.realpath, but fall back to the JS implementation if the native one fails";
    homepage = "";
    license = "ISC";
  };

  npmInputs = [
    tap
  ];
}

