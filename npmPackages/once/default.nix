{ fetchurl, buildNpmPackage, tap, wrappy }:

buildNpmPackage {
  pname = "once";
  version = "1.4.0";
  src = fetchurl {
    url = "https://github.com/isaacs/once/archive/v1.4.0.tar.gz";
    sha256 = "1ddb3cr72ad49wr51g9kcahnvcib2pvix9w8cbha2q4lfp8nbkai";
  };

  meta = {
    description = "Run a function exactly one time";
    homepage = "";
    license = "ISC";
  };

  npmInputs = [
    tap wrappy
  ];

}

