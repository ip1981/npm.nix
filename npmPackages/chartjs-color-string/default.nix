{ fetchurl, buildNpmPackage, color-name }:

buildNpmPackage rec {
  pname = "chartjs-color-string";
  version = "0.6.0";
  src = fetchurl {
    url = "https://github.com/chartjs/chartjs-color-string/archive/v${version}.tar.gz";
    sha256 = "0rfdrr3a6pvb49k30m9gqfpac0j0zvnabz1gvd8mhif5cn4r6c2x";
  };

  npmInputs = [
    color-name
  ];

  files = [
    "color-string.js"
  ];

}
