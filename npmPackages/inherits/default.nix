{ fetchurl, buildNpmPackage, tap }:

buildNpmPackage {
  pname = "inherits";
  version = "2.0.4";
  src = fetchurl {
    url = "https://github.com/isaacs/inherits/archive/v2.0.4.tar.gz";
    sha256 = "0qbilb4qal96a5qi9a9pqw8gxjj72g4yxzjf7a1sphv3qbmr9ix6";
  };

  meta = {
    description = "Browser-friendly inheritance fully compatible with standard node.js inherits()";
    homepage = "";
    license = "ISC";
  };

  npmInputs = [
    tap
  ];

  jailbreak = true;
}

