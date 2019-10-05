{ fetchgit, buildNpmPackage, python }:

buildNpmPackage {
  pname = "fibers";
  version = "4.0.1";
  src = fetchgit {
    url = "https://github.com/laverdet/node-fibers.git";
    rev = "5c24f960bc8d2a5a4e1aaf5de5ded3587566a86f";
    sha256 = "16mdy2i04zhi6qb775iq1izwn839235k59hpqyp1b5qmxd7h3gnp";
  };

  meta = {
    description = "Cooperative multi-tasking for Javascript";
    homepage = "https://github.com/laverdet/node-fibers";
    license = "MIT";
  };

  buildInputs = [ python ];

  patches = [ ./nix.patch ];

  npmInputs = [
  ];
}

