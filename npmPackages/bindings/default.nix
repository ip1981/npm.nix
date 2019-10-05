{ fetchurl, buildNpmPackage, file-uri-to-path }:

buildNpmPackage {
  pname = "bindings";
  version = "1.5.0";
  src = fetchurl {
    url = "https://github.com/TooTallNate/node-bindings/archive/1.5.0.tar.gz";
    sha256 = "1l4581b6284fgjixq7ji9km9mzrqq13knz3g4a9a0s2z40lrwpwk";
  };

  meta = {
    description = "Helper module for loading your native module's .node file";
    homepage = "https://github.com/TooTallNate/node-bindings";
    license = "MIT";
  };

  npmInputs = [
    file-uri-to-path
  ];

  files = [
    "bindings.js"
  ];
}

