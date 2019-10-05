{ fetchurl, buildNpmPackage, ava, tsd, xo }:

buildNpmPackage {
  pname = "escape-string-regexp";
  version = "2.0.0";
  src = fetchurl {
    url = "https://github.com/sindresorhus/escape-string-regexp/archive/v2.0.0.tar.gz";
    sha256 = "0vvh2byyfh0k2wh6zgnqkr2vnyhxfmnirwn5dfvcga5j3kn9zlrl";
  };

  meta = {
    description = "Escape RegExp special characters";
    homepage = "";
    license = "MIT";
  };

  npmInputs = [
    ava tsd xo
  ];

  jailbreak = true;
}

