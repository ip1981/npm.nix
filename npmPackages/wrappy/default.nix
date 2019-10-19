{ fetchurl, buildNpmPackage, tap }:

buildNpmPackage rec {
  pname = "wrappy";
  version = "1.0.2";
  src = fetchurl {
    url = "https://github.com/npm/${pname}/archive/v${version}.tar.gz";
    sha256 = "036c0mmn46zkdwxh2vq14fywqch93rgbcakpn1sjg1mw5f1q44xq";
  };

  npmInputs = [ tap ];
}
