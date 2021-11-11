{ pkgs ? (import <nixpkgs> {})
, lib ? pkgs.lib
, nodejs ? pkgs.nodejs
}:

let

  set0 = lib.makeExtensible (self:
    let
      callPackage = pkgs.newScope self;
      buildNpmPackageImpl = callPackage ./buildNpmPackage.nix {};
      buildNpmPackage = lib.makeOverridable buildNpmPackageImpl;

    in {
      inherit buildNpmPackage callPackage nodejs;
      npmPackages = self;
    }
  );

  set1 = set0.extend (import ./index.nix);
  set = set1.extend (import ./bootstrap.nix { inherit pkgs; });

in set
