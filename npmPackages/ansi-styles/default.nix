{ fetchurl, buildNpmPackage, ava, color-convert, svg-term-cli, xo }:

buildNpmPackage {
  pname = "ansi-styles";
  version = "4.1.0";
  src = fetchurl {
    url = "https://github.com/chalk/ansi-styles/archive/v4.1.0.tar.gz";
    sha256 = "1p3b4agrb73b46lw17c1nrx45pkfpi7jfbwp3xdcz1azcrjhri2c";
  };

  meta = {
    description = "ANSI escape codes for styling strings in the terminal";
    homepage = "";
    license = "MIT";
  };

  npmInputs = [
    ava color-convert svg-term-cli xo
  ];

  jailbreak = true;
}

