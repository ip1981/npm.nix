{ fetchurl, buildNpmPackage, ava, tsd, xo }:

buildNpmPackage {
  pname = "has-flag";
  version = "4.0.0";
  src = fetchurl {
    url = "https://github.com/sindresorhus/has-flag/archive/v4.0.0.tar.gz";
    sha256 = "0cc7wzqfmg9msk825zv95bzwp861psfz8gd9qiiy7sc7rjzvpnpz";
  };

  meta = {
    description = "Check if argv has a specific flag";
    homepage = "";
    license = "MIT";
  };

  npmInputs = [
    ava tsd xo
  ];

}

