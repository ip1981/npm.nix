{ fetchurl, buildNpmPackage, ava, tsd, xo }:

buildNpmPackage {
  pname = "callsites";
  version = "3.1.0";
  src = fetchurl {
    url = "https://github.com/sindresorhus/callsites/archive/v3.1.0.tar.gz";
    sha256 = "0pmxi3420qgxxm6bn1zvql3ig0sky288cml7gcbm9n3p96idd18q";
  };

  meta = {
    description = "Get callsites from the V8 stack trace API";
    homepage = "";
    license = "MIT";
  };

  npmInputs = [
    ava tsd xo
  ];

}

