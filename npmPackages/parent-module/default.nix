{ fetchurl, buildNpmPackage, ava, callsites, execa, tsd, xo }:

buildNpmPackage {
  pname = "parent-module";
  version = "2.0.0";
  src = fetchurl {
    url = "https://github.com/sindresorhus/parent-module/archive/v2.0.0.tar.gz";
    sha256 = "17d4mr95yi1gicbfgrdijwqryrr9ss3sjarbycwx8rrl7jryf20j";
  };

  meta = {
    description = "Get the path of the parent module";
    homepage = "";
    license = "MIT";
  };

  npmInputs = [
    ava callsites execa tsd xo
  ];

  jailbreak = true;
}

