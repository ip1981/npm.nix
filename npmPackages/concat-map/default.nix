{ fetchurl, buildNpmPackage, tape }:

buildNpmPackage {
  pname = "concat-map";
  version = "0.0.1";
  src = fetchurl {
    url = "https://github.com/substack/node-concat-map/archive/0.0.1.tar.gz";
    sha256 = "0vr53dsjbdr5x9ywcrgjxj08dp5z3c4hkhv9rsppmd66ibpq0rlk";
  };

  meta = {
    description = "concatenative mapdashery";
    homepage = "";
    license = "MIT";
  };

  npmInputs = [
    tape
  ];

  jailbreak = true;

  files = [
    "index.js"
  ];
}

