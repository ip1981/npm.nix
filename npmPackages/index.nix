# XXX this file is automatically generated.
self: super:
let
  inherit (super) callPackage;
in {
  async-foreach = callPackage ./async-foreach {};
  chartjs-color-string = callPackage ./chartjs-color-string {};
  color-convert = callPackage ./color-convert {};
  color-name = callPackage ./color-name {};
  fibers = callPackage ./fibers {};
  minimist = callPackage ./minimist {};
  mkdirp = callPackage ./mkdirp {};
  npm4nix = callPackage ./npm4nix {};
  posix-getopt = callPackage ./posix-getopt {};
  semver = callPackage ./semver {};
  wrappy = callPackage ./wrappy {};
}