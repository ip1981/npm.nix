{ fetchurl, buildNpmPackage, once, tap, wrappy }:

buildNpmPackage {
  pname = "inflight";
  version = "1.0.6";
  src = fetchurl {
    url = "https://github.com/npm/inflight/archive/v1.0.6.tar.gz";
    sha256 = "04viwwgwkgmg01n29hz15qf16gdxjvyjaz61ncn7a81pz9laq7bd";
  };

  meta = {
    description = "Add callbacks to requests in flight to avoid async duplication";
    homepage = "https://github.com/isaacs/inflight";
    license = "ISC";
  };

  npmInputs = [
    once tap wrappy
  ];

}

