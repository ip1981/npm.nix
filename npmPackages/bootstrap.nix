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
    _dummy_execa = _mkDummy "execa" "2.0.5";
    _dummy_matcha = _mkDummy "matcha" "0.7.0";
    _dummy_mocha = _mkDummy "mocha" "6.2.1";
    _dummy_mock-fs = _mkDummy "mock-fs" "4.10.1";
    _dummy_rimraf = _mkDummy "rimraf" "3.0.0";
    _dummy_svg-term-cli = _mkDummy "svg-term-cli" "2.1.1";
    _dummy_tap = _mkDummy "tap" "14.6.5";
    _dummy_tape = _mkDummy "tape" "4.11.0";
    _dummy_tick = _mkDummy "tick" "0.1.1";
    _dummy_tsd = _mkDummy "tsd" "0.9.0";
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

  _bindings = dontCheck (callPackage ./bindings {
    file-uri-to-path = _file-uri-to-path;
  });

  _balanced-match = dontCheck (callPackage ./balanced-match {
    matcha = _dummy_matcha;
    tape = _dummy_tape;
  });

  _brace-expansion = dontCheck (callPackage ./brace-expansion {
    balanced-match = _balanced-match;
    concat-map = _concat-map;
    matcha = _dummy_matcha;
    tape = _dummy_tape;
  });

  _callsites = dontCheck (callPackage ./callsites {
    ava = _dummy_ava;
    xo = _dummy_xo;
    tsd = _dummy_tsd;
  });

  _color-convert = dontCheck (callPackage ./color-convert {
    chalk = _dummy_chalk;
    xo = _dummy_xo;
  });

  _concat-map = dontCheck (callPackage ./concat-map {
    tape = _dummy_tape;
  });

  _escape-string-regexp = dontCheck (callPackage ./escape-string-regexp {
    ava = _dummy_ava;
    xo = _dummy_xo;
    tsd = _dummy_tsd;
  });

  _file-uri-to-path = dontCheck(callPackage ./file-uri-to-path {
    mocha = _dummy_mocha;
  });

  _fs-realpath = dontCheck(callPackage ./fs.realpath {
    tap = _dummy_tap;
  });

  _glob = dontCheck(callPackage ./glob {
    fs-realpath = _fs-realpath;
    inflight = _inflight;
    inherits = _inherits;
    minimatch = _minimatch;
    mkdirp = _mkdirp;
    once = _once;
    rimraf = _dummy_rimraf;
    tap = _dummy_tap;
    tick = _dummy_tick;
  });

  _has-flag = dontCheck (callPackage ./has-flag {
    ava = _dummy_ava;
    xo = _dummy_xo;
    tsd = _dummy_tsd;
  });

  _inflight = dontCheck (callPackage ./inflight {
    once = _once;
    tap = _dummy_tap;
    wrappy = _wrappy;
  });

  _inherits = dontCheck (callPackage ./inherits {
    tap = _dummy_tap;
  });

  _minimatch = dontCheck (callPackage ./minimatch {
    brace-expansion = _brace-expansion;
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

  _once = dontCheck (callPackage ./once {
    tap = _dummy_tap;
    wrappy = _wrappy;
  });

  _parent-module = dontCheck (callPackage ./parent-module {
    ava = _dummy_ava;
    callsites = _callsites;
    execa = _dummy_execa;
    tsd = _dummy_tsd;
    xo = _dummy_xo;
  });

  _resolve-from = dontCheck (callPackage ./resolve-from {
    ava = _dummy_ava;
    xo = _dummy_xo;
    tsd = _dummy_tsd;
  });

  _semver = dontCheck (callPackage ./semver {
    tap = _dummy_tap;
  });

  _wrappy = dontCheck (callPackage ./wrappy {
    tap = _dummy_tap;
  });
}
