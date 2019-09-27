{ fetchurl, buildNpmPackage, chalk, color-name, xo }:

buildNpmPackage rec {
  pname = "color-convert";
  version = "2.0.1";
  src = fetchurl {
    url = "https://github.com/Qix-/color-convert/archive/${version}.tar.gz";
    sha256 = "1l5cm7m654dbi3x5y3rfd0v0dw9n3sy5a6mnn6lh1dixpc2xgyww";
  };

  npmInputs = [
    chalk
    color-name
    xo
  ];

  jailbreak = true;

}
