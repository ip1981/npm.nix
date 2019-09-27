{ fetchgit, buildNpmPackage }:

buildNpmPackage rec {
  pname = "posix-getopt";
  version = "1.2.0";
  src = fetchgit {
    url = "https://github.com/joyent/node-getopt.git";
    rev = "e90fa0e92b35ea9150428de29ae3ff56a716ca85";
    sha256 = "1hvmcdj7v1bqcfmjm5pxvby3kql0b9arbqfb8pj0i2zrk7h1diw7";
  };

  files = [ "lib" ];
}
