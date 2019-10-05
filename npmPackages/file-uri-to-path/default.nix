{ fetchurl, buildNpmPackage, mocha }:

buildNpmPackage {
  pname = "file-uri-to-path";
  version = "1.0.0";
  src = fetchurl {
    url = "https://github.com/TooTallNate/file-uri-to-path/archive/1.0.0.tar.gz";
    sha256 = "0jqdcichbcb73d7bwjng9grycwhqiaz9777nm4bxska4qbrvxx2f";
  };

  meta = {
    description = "Convert a file: URI to a file path";
    homepage = "https://github.com/TooTallNate/file-uri-to-path";
    license = "MIT";
  };

  npmInputs = [
    mocha
  ];

  files = [
    "index.d.ts"
    "index.ts"
  ];

  jailbreak = true;
}

