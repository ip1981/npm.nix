{ pkgs }:

self: super:
  let
    _mkDummy = name: version: pkgs.runCommand "${name}-${version}-dummy" {} ''
      mkdir -p $out
      cat <<PKG > $out/package.json
        {
          "name": "${name}",
          "version": "${version}-dummy",
          "description": "A dummy package to ease bootstrapping",
          "main": "index.js",
          "license": "PUBLIC DOMAIN",
          "files": ["index.js"]
        }
      PKG

      cat <<SRC > $out/index.js
      SRC
    '';

    inherit (import ./lib.nix) dontCheck;
    inherit (super) callPackage;

    # XXX dummy package are to help bootstrapping.
    # XXX Usually these are devDependencies needed to run tests.

    _dummy_ava = _mkDummy "ava" "2.4.0";
    _dummy_chalk = _mkDummy "chalk" "2.4.2";
    _dummy_covert = _mkDummy "covert" "1.1.1";
    _dummy_mock-fs = _mkDummy "mock-fs" "4.10.1";
    _dummy_svg-term-cli = _mkDummy "svg-term-cli" "2.1.1";
    _dummy_tap = _mkDummy "tap" "14.6.5";
    _dummy_tape = _mkDummy "tape" "4.11.0";
    _dummy_xo = _mkDummy "xo" "0.25.3";

in rec {


  # XXX packages with underscore are "incomplete".
  # XXX Should only be used to resolve circular dependencies.

  _ansi-styles = dontCheck (callPackage ./ansi-styles {
    ava = _dummy_ava;
    color-convert = _color-convert;
    svg-term-cli = _dummy_svg-term-cli;
    xo = _dummy_xo;
  });

  _color-convert = dontCheck (callPackage ./color-convert {
    chalk = _dummy_chalk;
    xo = _dummy_xo;
  });

  _fs-realpath = dontCheck(callPackage ./fs.realpath {
    tap = _dummy_tap;
  });

  _minimist = dontCheck (callPackage ./minimist {
    covert = _dummy_covert;
    tap = _dummy_tap;
    tape = _dummy_tape;
  });

  _mkdirp = dontCheck (callPackage ./mkdirp {
    minimist = _minimist;
    mock-fs = _dummy_mock-fs;
    tap = _dummy_tap;
  });

  _semver = dontCheck (callPackage ./semver {
    tap = _dummy_tap;
  });

  _wrappy = dontCheck (callPackage ./wrappy {
    tap = _dummy_tap;
  });
}
