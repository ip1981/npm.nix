{ fetchurl, buildNpmPackage }:

buildNpmPackage rec {
  pname = "async-foreach";
  version = "0.1.3";
  src = fetchurl {
    url = "https://github.com/cowboy/javascript-sync-async-foreach/archive/v${version}.tar.gz";
    sha256 = "1b7h2fgj6rndkviyx1hl0mh72d60a2b2f1sl86ndk8vdvr6mxmj3";
  };

  files = [
    "lib"
  ];
}
