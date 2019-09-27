{ fetchgit, buildNpmPackage }:

buildNpmPackage rec {
  pname = "color-name";
  version = "1.1.4";
  src = fetchgit {
    url = "https://github.com/colorjs/color-name.git";
    rev = "4536ce5944f56659a2dfb2198eaf81b5ad5f2ad9";
    sha256 = "1m9paib6kj7hy49aapv2h0mi8a77r0rqdyj8xnp34lkkwpz7qasi";
  };

  npmInputs = [
  ];
}

