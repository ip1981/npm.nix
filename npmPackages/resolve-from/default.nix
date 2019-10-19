{ fetchurl, buildNpmPackage, ava, tsd, xo }:

buildNpmPackage {
  pname = "resolve-from";
  version = "5.0.0";
  src = fetchurl {
    url = "https://github.com/sindresorhus/resolve-from/archive/v5.0.0.tar.gz";
    sha256 = "1ynbq4077lsbyxbc96nxalcj885lpcp0vahi65ziir8lzkya6qvq";
  };

  meta = {
    description = "Resolve the path of a module like `require.resolve()` but from a given path";
    homepage = "";
    license = "MIT";
  };

  npmInputs = [
    ava tsd xo
  ];

}

