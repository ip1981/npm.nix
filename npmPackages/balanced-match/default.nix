{ fetchurl, buildNpmPackage, matcha, tape }:

buildNpmPackage {
  pname = "balanced-match";
  version = "1.0.0";
  src = fetchurl {
    url = "https://github.com/juliangruber/balanced-match/archive/v1.0.0.tar.gz";
    sha256 = "0sqzdfnjqyw0kbwf459jwn7yds5gyf4b3jnr7779f79pqkngk86j";
  };

  meta = {
    description = "Match balanced character pairs, like \"{\" and \"}\"";
    homepage = "https://github.com/juliangruber/balanced-match";
    license = "MIT";
  };

  npmInputs = [
    matcha tape
  ];


  files = [
    "index.js"
  ];
}

